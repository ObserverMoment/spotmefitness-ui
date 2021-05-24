import 'dart:convert';
import 'package:artemis/artemis.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:normalize/normalize.dart';

class GraphQLStore {
  static const String boxName = 'graphql-cache';
  late ArtemisClient _artemisClient;
  late HttpLink _httpLink;
  late AuthLink _authLink;
  late Link _link;
  late Box _box;

  final _refKey = '\$ref';
  final _queryRootKey = 'Query';

  /// See [normalize -> Policies -> TypePolicy]
  /// These objects will NOT be normalized as root objects and will instead sit inside their parent as raw json data.
  /// Generate the policy object from the list of excluded typenames at [kExcludeFromNormalization]
  final Map<String, TypePolicy> _typePolicies = kExcludeFromNormalization
      .fold<Map<String, TypePolicy>>({}, (policyObj, typename) {
    policyObj[typename] = TypePolicy(keyFields: {});
    return policyObj;
  });

  GraphQLStore() {
    _httpLink = HttpLink(
      EnvironmentConfig.graphqlEndpoint,
    );

    _authLink = AuthLink(
        getToken: () async =>
            'Bearer ${await GetIt.I<AuthBloc>().getIdToken()}');

    _link = _authLink.concat(_httpLink);

    /// This must already have been opened (in main.dart probably).
    _box = Hive.box(boxName);

    /// Run a clean up of the data on init.
    gc();
  }

  Map<String, ObservableQuery> observableQueries =
      Map<String, ObservableQuery>();

  ObservableQuery<TData, TVars>
      getQuerybyId<TData, TVars extends json.JsonSerializable>(String id) =>
          observableQueries[id] as ObservableQuery<TData, TVars>;

  /// [T] is query type. [U] is variables / args type.
  ObservableQuery<TData, TVars>
      registerObserver<TData, TVars extends json.JsonSerializable>(
          GraphQLQuery<TData, TVars> query,
          {bool parameterizeQuery = false}) {
    if (query.operationName == null) {
      throw Exception(
          '[query.operationName] cannot be null when registering an observable query.');
    } else {
      final String id = query.variables == null
          ? query.operationName!
          : parameterizeQuery

              /// If we want to split instances of the query when the variables change then we set [parameterizeQuery] to true.
              /// [workoutById({"id":736373-837737-39383})]
              /// Each time we query a new workoutById (i.e. the [id] variable changes) a new key under the [Query] root will be created. Each workout will be stored and accessible separately.
              ? getParameterizedQueryId(
                  query.operationName!, query.getVariablesMap())

              /// For non parametized queries, all instances of the same query should be saved under a single key - regardless of variable changes. Mainly for list type queries which we want to just overwrite with new data when it comes in.
              /// We need to set all vars to in the varsMap to null like this
              /// [userLoggedWorkouts({"first":null})]
              : getParameterizedQueryId(
                  query.operationName!,
                  query.getVariablesMap().keys.fold<Map<String, dynamic>>({},
                      (nulledVars, next) {
                    nulledVars[next] = null;
                    return nulledVars;
                  }));

      if (!observableQueries.containsKey(id)) {
        /// No one is listening to this id - create a new stream.
        /// TODO: Do we need to set a max number of observable queries? Or close some streams if we have too many. What if the user opens up 50 workout details pages in a row - they will have 50 streams open...
        observableQueries[id] = ObservableQuery<TData, TVars>(
            id: id,
            subject: BehaviorSubject<GraphQLResponse>(),
            query: query,
            parameterize: parameterizeQuery);
      } else {
        // A stream with this id already has one or more listeners.
        // Increment the observer count.
        observableQueries[id]!.observers++;
        // Overwrite the old query with the most recent one.
        // This allows for queries which have variables, but which are not being parameterized by them, to get new data and broadcast to a single query.
        observableQueries[id]!.query = query;
      }

      return observableQueries[id]! as ObservableQuery<TData, TVars>;
    }
  }

  void unregisterObserver(String id) {
    if (!observableQueries.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      if (observableQueries[id]!.observers == 1) {
        // There was only one observer. Close the stream.
        observableQueries[id]!.dispose();
        // Remove it from the map.
        observableQueries.remove(id);
      } else {
        // Reduce the number of active listeners by one.
        observableQueries[id]!.observers--;
      }
    }
  }

  /// Determines how to fetch the intial data when the widget mounts.
  void fetchInitialQuery(
      {required String id,
      required QueryFetchPolicy fetchPolicy,
      bool garbageCollectAfterFetch = false}) async {
    if (!observableQueries.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      switch (fetchPolicy) {
        case QueryFetchPolicy.storeAndNetwork:
          _queryStore(id);
          await _queryNetwork(id);
          break;
        case QueryFetchPolicy.storeFirst:
          final success = _queryStore(id);
          if (!success) {
            await _queryNetwork(id);
          }
          break;
        case QueryFetchPolicy.storeOnly:
          _queryStore(id);
          break;
        case QueryFetchPolicy.networkOnly:
          await _queryNetwork(id);
          break;
        default:
          throw Exception('$fetchPolicy is not valid.');
      }

      /// Useful for queries which can be different each time they are queried.
      /// i.e. anything with filter variables or from the discover / recommendation type queries.
      if (garbageCollectAfterFetch) {
        gc();
      }
    }
  }

  /// Fetches data requested by a graphql query selection set from the normalized store.
  /// Broadcasts data if query is successful.
  bool _queryStore(String id) {
    if (!observableQueries.containsKey(id)) {
      print(
          '_queryStore: QueryNotFoundOrNotInitialized: There is no ObservableQuery with id: $id');
      return false;
    } else {
      try {
        final observableQuery = getQuerybyId(id);
        final GraphQLQuery query = observableQuery.query;
        // Does a key exist in the store?
        if (!_hasQueryDataInStore(observableQuery.id)) {
          return false;
        }

        // Denormalize the data
        final data = denormalizeOperation(
            variables: observableQuery.parameterize
                ? query.variables?.toJson() ?? const {}
                : const {},
            typePolicies: _typePolicies,
            document: query.document,
            read: (dataId) => readNormalized(dataId));

        if (data == null) {
          return false;
        }

        // Add to the stream to _broadcast to all listeners.
        observableQuery.subject.add(GraphQLResponse(data: query.parse(data)));
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }
  }

  /// Get data from the network, normalize it, add it to the store, _broadcast to the observable query.
  Future<bool> _queryNetwork(String id) async {
    if (!observableQueries.containsKey(id)) {
      print(
          '_queryNetwork: QueryNotFoundOrNotInitialized: There is no ObservableQuery with id: $id');
      return false;
    } else {
      final observableQuery = getQuerybyId(id);
      final GraphQLQuery query = observableQuery.query;

      final response = await execute(query);

      if (response.errors != null && response.errors!.isNotEmpty) {
        // Broadcast the error. Do not update the store.
        observableQuery.subject
            .add(GraphQLResponse(data: response.data, errors: response.errors));
        return false;
      } else {
        try {
          normalizeOperation(
              data: response.data ?? {},
              document: query.document,
              variables: observableQuery.parameterize
                  ? query.variables?.toJson() ?? const {}
                  : const {},
              typePolicies: _typePolicies,
              read: readNormalized,
              write: mergeWriteNormalized);

          // Broadcast the updated data.
          _broadcast([id]);
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      }
    }
  }

  void _broadcast(List<String> ids) {
    ids.forEach((id) {
      _queryStore(id);
    });
  }

  /////////////////////////////////////
  ////// Request executions ///////////
  /////////////////////////////////////
  /// Standard execution that returns unparsed graphql response.
  /// Can parse with [query.parse(data)] if needed.
  /// If you want to pass an incomplete input object as the variables. i.e. just one field needs to be updated. Pass this Map as [variables]. Otherwise the full input object will be sent as a map, null values included.
  Future<Response> execute(GraphQLQuery query,
      {Map<String, dynamic>? customVariablesMap}) async {
    final request = Request(
      operation: Operation(
        document: query.document,
        operationName: query.operationName,
      ),
      variables: customVariablesMap ?? query.getVariablesMap(),
    );

    final response = await _link.request(request).first;
    return response;
  }

  Future<MutationResult<TData>>
      create<TData, TVars extends json.JsonSerializable>(
          {required GraphQLQuery<TData, TVars> mutation,
          List<String> addRefToQueries = const [],
          Map<String, dynamic>? optimisticData,
          void Function()? onOptimisticUpdate}) async {
    if (optimisticData != null && addRefToQueries.isNotEmpty) {
      /// Immediately write to store and _broadcast.
      if (resolveDataId(optimisticData) == null) {
        print(
            'Optimistic creation was not possible because you did not provide [__typename} and [id] fields in [optimisticData] object.');
      } else {
        normalizeToStore(
            data: optimisticData,
            write: mergeWriteNormalized,
            read: readNormalized);

        _addRefToQueries(data: optimisticData, queryIds: addRefToQueries);
        if (onOptimisticUpdate != null) {
          onOptimisticUpdate();
        }
      }
    }

    final response = await execute(mutation);

    final result = MutationResult<TData>(
        data: mutation.parse(response.data ?? {}), errors: response.errors);

    if (result.hasErrors &&
        optimisticData != null &&
        resolveDataId(optimisticData) != null) {
      // If has network errors, and correct normalizable optimistic data provided, then need to rollback any optimistic updates.
      final objectId = resolveDataId(optimisticData)!;
      _box.delete(objectId);
      _removeRefFromQueries(data: optimisticData, queryIds: addRefToQueries);
    }

    if (!result.hasErrors) {
      /// Check for a top level field alias - these are needed sometimes due to the way Artemis generates return types for operations.
      final alias = extractRootFieldAliasFromOperation(mutation);
      final data = response.data?[alias ?? mutation.operationName] ?? {};

      normalizeToStore(
          data: data, write: mergeWriteNormalized, read: readNormalized);

      _addRefToQueries(data: data, queryIds: addRefToQueries);
    }

    return result;
  }

  /// Network mutation with optional optimism.
  /// Wrap execute function - add cache writing and _broadcasting.
  /// Update the store with returned (after normalizing) data, then _broadcast (_broadcast is really a store read follwed by a _broadcast) to specified ids.

  Future<MutationResult<TData>> mutate<TData,
          TVars extends json.JsonSerializable>(
      {required GraphQLQuery<TData, TVars> mutation,

      /// When false this operation is network only with no client store writes.
      bool writeToStore = true,
      List<String> broadcastQueryIds = const [],

      /// If you want to add / remove ref to / from queries the you have to provide [id] and [__typename] in the optimistic data and it must also be being returned by the api in the result object.
      List<String> addRefToQueries = const [],
      List<String> removeRefFromQueries = const [],

      /// [customVariablesMap] - if you do not want to pass all the fields of the object to the API. If you pass null fields then those fields will be set null in the DB.
      Map<String, dynamic>? customVariablesMap,
      Map<String, dynamic>? optimisticData,
      void Function()? onOptimisticUpdate}) async {
    /// If doing an optimistic update, take a backup of the object you are mutating.
    Map<String, dynamic>? backupData = optimisticData == null
        ? null
        : Map<String, dynamic>.from(
            _box.get(resolveDataId(optimisticData), defaultValue: {}));

    if (writeToStore && optimisticData != null) {
      /// Immediately write to store, add refs to queries and _broadcast.
      normalizeToStore(
          data: optimisticData,
          write: mergeWriteNormalized,
          read: readNormalized);

      if (addRefToQueries.isNotEmpty) {
        _addRefToQueries(data: optimisticData, queryIds: addRefToQueries);
      }

      if (removeRefFromQueries.isNotEmpty) {
        _removeRefFromQueries(
            data: optimisticData, queryIds: removeRefFromQueries);
      }

      _broadcast(broadcastQueryIds);

      if (onOptimisticUpdate != null) {
        onOptimisticUpdate();
      }
    }

    final response =
        await execute(mutation, customVariablesMap: customVariablesMap);

    final result = MutationResult<TData>(
        data: response.data != null ? mutation.parse(response.data!) : null,
        errors: response.errors);

    /// If has network errors then need to rollback any optimistic updates.
    if (writeToStore && optimisticData != null && result.hasErrors) {
      _box.put(resolveDataId(optimisticData), backupData);

      if (addRefToQueries.isNotEmpty) {
        _removeRefFromQueries(data: optimisticData, queryIds: addRefToQueries);
      }

      if (removeRefFromQueries.isNotEmpty) {
        _addRefToQueries(data: optimisticData, queryIds: removeRefFromQueries);
      }
      _broadcast(broadcastQueryIds);
    }

    if (writeToStore && !result.hasErrors) {
      /// Check for a top level field alias - these are needed sometimes due to the way Artemis generates return types for operations.
      final alias = extractRootFieldAliasFromOperation(mutation);

      final data = response.data?[alias ?? mutation.operationName] ?? {};

      normalizeToStore(
          data: data, write: mergeWriteNormalized, read: readNormalized);

      if (addRefToQueries.isNotEmpty) {
        _addRefToQueries(data: data, queryIds: addRefToQueries);
      }

      if (removeRefFromQueries.isNotEmpty) {
        _removeRefFromQueries(data: data, queryIds: removeRefFromQueries);
      }

      _broadcast(broadcastQueryIds);
    }

    return result;
  }

  /// Delete ops should always return the ID of the deleted item.
  /// [objectId] as standard - [type:id]
  /// Runs [_deleteRootObject()] so (currently) should only be used to delete objects that are being normalized. If the object is not a top level $ref in a query but rather a ref nested inside of another object within queries - you can set [removeAllRefsToId] to true. This may be expensive as it searches the entire store for refs to this ID and removes them so use sparingly.
  Future<MutationResult<TData>>
      delete<TData, TVars extends json.JsonSerializable>(
          {required GraphQLQuery<TData, TVars> mutation,
          required String objectId,
          required String typename,
          bool removeAllRefsToId = false,
          List<String> removeRefFromQueries = const [],
          List<String> broadcastQueryIds = const []}) async {
    final response = await execute(mutation);

    final result = MutationResult<TData>(
        data: mutation.parse(response.data ?? {}), errors: response.errors);

    if (!result.hasErrors &&
        response.data?[mutation.operationName] == objectId) {
      final id = '$typename:$objectId';
      await _deleteRootObject(id);

      if (removeAllRefsToId) {
        _removeAllRefsToId(id);
      }

      if (removeRefFromQueries.isNotEmpty) {
        _removeRefFromQueries(
            data: {'id': objectId, '__typename': typename},
            queryIds: removeRefFromQueries);
      }

      _broadcast(broadcastQueryIds);
    }

    return result;
  }

  /// No action on the client side store.
  Future<MutationResult<TData>>
      networkOnlyDelete<TData, TVars extends json.JsonSerializable>({
    required GraphQLQuery<TData, TVars> mutation,
    List<String> removeRefFromQueries = const [],
  }) async {
    final response = await execute(mutation);

    final result = MutationResult<TData>(
        data: mutation.parse(response.data ?? {}), errors: response.errors);

    return result;
  }

  /// Client side (Store) write.
  /// Will merge / overwrite with previous data, or creating it if not present.
  bool writeDataToStore(
      {required Map<String, dynamic> data,
      List<String> broadcastQueryIds = const [],

      /// Only queries whose data is a list of refs can accept refs like this.
      List<String> addRefToQueries = const []}) {
    try {
      normalizeToStore(
          data: data, write: mergeWriteNormalized, read: readNormalized);

      if (addRefToQueries.isNotEmpty) {
        _addRefToQueries(data: data, queryIds: addRefToQueries);
      }

      _broadcast(broadcastQueryIds);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// [objectId] must be in the format [type:id] as a string.
  /// If [_box.get(_queryRootKey)] is null then this key will be created.
  bool _addRefToQueries(
      {required Map<String, dynamic> data, required List<String> queryIds}) {
    final objectId = resolveDataId(data);
    if (objectId == null) {
      print(
          'Warning: Could not resolveDataId in [data]. If you want to add a ref to queries then you need to provide [id] and [__typename] in the data.');
      return false;
    }
    final allQueries = _box.get(_queryRootKey);

    for (final queryId in queryIds) {
      final prevList = allQueries[queryId];

      if (prevList != null && !(prevList is List)) {
        throw AssertionError(
            'There is data under [$_queryRootKey][$queryId], but it is not a list. You cannot add a ref to a non list object.');
      }

      final newRef = {_refKey: objectId};

      final updatedList = [if (prevList != null) ...(prevList as List), newRef];

      // Rewrite to box.
      _box.put(_queryRootKey, {...allQueries, queryId: updatedList});

      _broadcast([queryId]);
    }
    return true;
  }

  /// [objectId] must be in the format [type:id] as a string.
  /// If [_box.get(_queryRootKey)] is null then this key will be created.
  bool _removeRefFromQueries(
      {required Map<String, dynamic> data, required List<String> queryIds}) {
    final objectId = resolveDataId(data);
    if (objectId == null) {
      print(
          'Warning: Could not resolveDataId in [data]. If you want to remove a ref from queries then you need to provide [id] and [__typename] in the data.');
      return false;
    }
    final allQueries = _box.get(_queryRootKey);

    for (final queryId in queryIds) {
      final prevList = allQueries[queryId];

      if (prevList != null && !(prevList is List)) {
        throw AssertionError(
            'There is data under [$_queryRootKey][$queryId], but it is not a list. You cannot remove a ref from a non list object.');
      }

      final updatedList = prevList != null
          ? (prevList as List).where((e) => e[_refKey] != objectId).toList()
          : [];

      // Rewrite to box.
      _box.put(_queryRootKey, {...allQueries, queryId: updatedList});

      _broadcast([queryId]);
    }
    return true;
  }

  /////////////////////////////////////
  ///// Hive box reads and writes /////
  /////////////////////////////////////
  /// Merges / overwrites [value] with existing data at [key].
  Future<void> mergeWriteNormalized(String key, dynamic value) async {
    if (value is Map<String, Object>) {
      final existing = _box.get(key);
      _box.put(
        key,
        existing != null ? deeplyMergeLeft([existing, value]) : value,
      );
    } else {
      _box.put(key, value);
    }
  }

  /// Retrieves data from a key and then recursively retrieves all of its children.
  /// Children can be scalar or [$ref] objects and plain json Map is returned.
  Map<String, dynamic> readDenomalized(String key) {
    return readFromStoreDenormalized(key, _box);
  }

  /// Retrieves the raw normalized data.
  /// Normalized children will be [$ref] objects. Not plain json maps.
  Map<String, dynamic> readNormalized(String key) {
    return Map<String, dynamic>.from(_box.get(key) ?? {});
  }

  Future<void> _deleteRootObject(String key) async {
    await _box.delete(key);
  }

  /// Within the root query key - does data for this query exist.
  bool _hasQueryDataInStore(String queryKey) {
    return _box.get(_queryRootKey, defaultValue: {})[queryKey] != null;
  }

  void _clearQueryDataAtKey(String key) {
    final Map<String, dynamic> queriesData = _box.get(_queryRootKey);
    queriesData.remove(key);
    _box.put(_queryRootKey, queriesData);
  }

  /// [id] should be [type:id] as standard.
  /// Will remove all objects in the store which = {_refKey: key}
  void _removeAllRefsToId(String id) {
    _box.keys.forEach((rootKey) {
      final data = _box.get(rootKey);
      _box.put(rootKey, recursiveRemoveRefsToId(data: data, id: id));
    });
  }

  /// Removes all entities that cannot be reached from the Query root key.
  Set<String> gc() {
    final reachable = reachableIdsFromDataId(
      dataId: _queryRootKey,
      read: (dataId) => readNormalized(dataId),
    );

    final keysToRemove = _box.keys
        .where(
          (key) => key != _queryRootKey && !reachable.contains(key),
        )
        .map((k) => k.toString())
        .toSet();
    _box.deleteAll(keysToRemove);

    return keysToRemove;
  }

  Future<void> clear() async {
    await _box.clear();
  }

  /// An observable query can either have:
  /// 1. No variables - the id is the [operationName]
  /// 2. Has variables, but we do not want to store new data each time the variables change - this id has the variables string included but it is set to null. [workoutById({"id":null})]
  /// 3. Has variables, and we want a new query key for each new variables combination, so each query / variables combination is saved into the store. [workoutById({"id": Workout:9262436-7399290})]
  String _getObservableQueryId(ObservableQuery observableQuery) {
    final query = observableQuery.query;
    return query.variables != null
        ? getParameterizedQueryId(query.operationName!,
            observableQuery.parameterize ? query.getVariablesMap() : {})
        : observableQuery.query.operationName!;
  }

  /// For example [workoutById({"id": id})]
  /// Same as the [normalize] package does this.
  String getParameterizedQueryId(
      String queryName, Map<String, dynamic> variables) {
    return '$queryName(${jsonEncode(variables)})';
  }

  void dispose() {
    _httpLink.dispose();
    _artemisClient.dispose();
    observableQueries.forEach((k, v) {
      v.dispose();
    });
    _box.close();
  }
}

/// A single stream for a single executable [GraphQLQuery].
class ObservableQuery<TData, TVars extends json.JsonSerializable> {
  final BehaviorSubject<GraphQLResponse> subject;
  late GraphQLQuery<TData, TVars> query;

  /// If true then data is saved under a key ([id]) which includes the parameters of the query (if they exist).
  /// Example:
  /// [workoutById({"id":null})] when false
  /// [workoutById({"id": Workout:9262436-7399290})] when true
  /// Defaults to false.
  final bool parameterize;
  final String id;

  /// The last result passed into the stream. Useful for initialising stream data in the instance where a [QueryObserver] is listening to an already running stream.
  final GraphQLResponse? latest;

  /// Tracks how many [QueryObserver]s are listening to the stream.
  int observers = 1;

  ObservableQuery(
      {required this.id,
      required this.subject,
      required this.query,
      this.latest,
      this.parameterize = false});

  void dispose() {
    subject.close();
  }
}

class MutationResult<TData> {
  final TData? data;
  final List<Object>? errors;
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  MutationResult({this.data, this.errors});
}

/// [add] and [remove] will both also _broadcast their updates once complete.
/// [_broadcast] would be used if objects have been updated only - not created or removed.
enum QueryUpdateType { add, remove, broadcast }

class QueryUpdate {
  final QueryUpdateType type;
  final String objectId;
  final List<String> queryIds;
  QueryUpdate(
      {required this.type, required this.objectId, required this.queryIds});
}

class QueryNotFoundException implements Exception {
  final String id;
  const QueryNotFoundException(this.id);
  String toString() =>
      'QueryNotFoundException: There is no ObservableQuery with this id: $id';
}

/// [From flutter-graphql] package.
/// [FetchPolicy] determines where the client may return a result from.
///
/// * [cacheFirst]: return result from cache. Only fetch from network if cached result is not available.
/// * [cacheAndNetwork]: return result from cache first (if it exists), then return network result once it's available.
/// * [cacheOnly]: return result from cache if available, fail otherwise.
/// * [noCache]: return result from network, fail if network call doesn't succeed, don't save to cache.
/// * [networkOnly]: return result from network, fail if network call doesn't succeed, save to cache.
enum QueryFetchPolicy {
  /// Return result from cache. Only fetch from network if cached result is not available.
  storeFirst,

  /// Return result from cache first (if it exists), then return network result once it's available.
  storeAndNetwork,

  /// Return result from cache if available, fail otherwise.
  storeOnly,

  /// Return result from network, fail if network call doesn't succeed, save to cache.
  networkOnly,
}
