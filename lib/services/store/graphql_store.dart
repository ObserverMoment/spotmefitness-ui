import 'package:artemis/artemis.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
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
  final _queryKey = 'Query';

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
          GraphQLQuery<TData, TVars> query) {
    if (query.operationName == null) {
      throw Exception(
          '[query.operationName] cannot be null when registering an observable query.');
    } else {
      final String id = query.operationName!;
      if (!observableQueries.containsKey(id)) {
        /// No one is listening to this id - create a new stream.
        observableQueries[id] = ObservableQuery<TData, TVars>(
            subject: BehaviorSubject<GraphQLResponse>(), query: query);
      } else {
        // A stream with this id already has one or more listeners.
        // Increment the observer count.
        observableQueries[id]!.observers++;
      }

      return observableQueries[id]! as ObservableQuery<TData, TVars>;
    }
  }

  void unregisterObserver(String id) {
    if (!observableQueries.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      if (observableQueries[id]!.observers == 1) {
        // There is only one observer. Close the stream.
        observableQueries[id]!.dispose();
        // Remove it from the map.
        observableQueries.remove(id);
      } else {
        // Reduce the number of active listeners by one.
        observableQueries[id]!.observers--;
      }
    }
  }

  void fetchInitialQuery(
      {required String id,
      required QueryFetchPolicy fetchPolicy,
      bool garbageCollectAfterFetch = false}) async {
    if (!observableQueries.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      switch (fetchPolicy) {
        case QueryFetchPolicy.storeAndNetwork:
          queryStore(id);
          await queryNetwork(id);
          break;
        case QueryFetchPolicy.storeFirst:
          final success = queryStore(id);
          if (!success) {
            await queryNetwork(id);
          }
          break;
        case QueryFetchPolicy.storeOnly:
          queryStore(id);
          break;
        case QueryFetchPolicy.networkOnly:
          await queryNetwork(id);
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

  bool queryStore(String id) {
    if (!observableQueries.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      try {
        final observableQuery = getQuerybyId(id);
        final GraphQLQuery query = observableQuery.query;
        // Denormalize the data
        final data = denormalizeOperation(
            document: query.document, read: (dataId) => readNormalized(dataId));
        // Add to the stream to broadcast to all listeners.
        observableQuery.subject
            .add(GraphQLResponse(data: query.parse(data ?? {})));
        broadcast([id]);
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }
  }

  /// Get data from the network, normalize it, add it to the store, broadcast to the observable query.
  Future<bool> queryNetwork(String id) async {
    if (!observableQueries.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      final observableQuery = getQuerybyId(id);
      final GraphQLQuery query = observableQuery.query;

      final response = await execute(query);

      if (response.errors != null && response.errors!.isNotEmpty) {
        // Broadcast the error. Do not update the store.
        observableQuery.subject.add(GraphQLResponse(
            data: query.parse(response.data ?? {}), errors: response.errors));
        return false;
      } else {
        try {
          // Normalize the result and deep merge with current store data.
          normalizeOperation(
            data: Map<String, dynamic>.from(response.data!),
            document: query.document,
            operationName: query.operationName,
            write: (dataId, value) => writeNormalized(dataId, value),
            read: (dataId) => readNormalized(dataId),
          );
          // Broadcast the updated data.
          broadcast([id]);
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      }
    }
  }

  void broadcast(List<String> ids) {
    ids.forEach((id) {
      if (!observableQueries.containsKey(id)) {
        print(
            'No observable query registered for id $id. Broadcast request ignored.');
      } else {
        // Query the cache based on.
        // observableQueries[id].queryDocument.
        final observableQuery = getQuerybyId(id);
        final GraphQLQuery query = observableQuery.query;
        // Denormalize the data.
        final data = denormalizeOperation(
            document: query.document, read: (dataId) => readNormalized(dataId));
        // Add to the stream to broadcast to all listeners.
        observableQuery.subject
            .add(GraphQLResponse(data: query.parse(data ?? {})));
      }
    });
  }

  /////////////////////////////////////
  ////// Request executions ///////////
  /////////////////////////////////////
  /// Standard execution that returns unparsed graphql response.
  /// Can parse with [query.parse(data)] if needed.
  Future<Response> execute(GraphQLQuery query) async {
    final request = Request(
      operation: Operation(
        document: query.document,
        operationName: query.operationName,
      ),
      variables: query.getVariablesMap(),
    );

    final response = await _link.request(request).first;
    return response;
  }

  /// Network mutation with optional optimism.
  /// Wrap execute function - add cache writing and broadcasting.
  /// Update the store with returned (after normalizing) data, then broadcast (broadcast is really a store read follwed by a broadcast) to specified ids.
  Future<MutationResult<TData>> mutate<TData,
          TVars extends json.JsonSerializable>(
      {required GraphQLQuery<TData, TVars> mutation,
      List<String> broadcastQueryIds = const [],
      // Should [optimisticData] be typed data rather than a map? [TData] as type arg?
      Map<String, dynamic>? optimisticData}) async {
    if (optimisticData != null && broadcastQueryIds.isNotEmpty) {
      /// Immediately write to store and broadcast.
    }

    final response = await execute(mutation);

    final result = MutationResult<TData>(
        data: mutation.parse(response.data ?? {}), errors: response.errors);

    if (optimisticData != null && result.hasErrors) {
      // If has network errors then need to rollback any optimistic updates.
    }

    return result;
  }

  /// [objectId] must be in the format [type:id] as a string.
  /// If [_box.get(_queryKey)] is null then this key will be created.
  void addRefToQueries(
      {required String objectId, required List<String> queryIds}) {
    final allQueries = _box.get(_queryKey);

    for (final queryId in queryIds) {
      final prevList = allQueries[queryId];

      if (prevList != null && !(prevList is List)) {
        throw AssertionError(
            'There is data under Query[$queryId], but it is not a list. You cannot add a ref to a non list object.');
      }

      final newRef = {_refKey: objectId};

      final updatedList = [if (prevList != null) ...(prevList as List), newRef];

      // Rewrite to box.
      _box.put(_queryKey, {...allQueries, queryId: updatedList});

      broadcast([queryId]);
    }
  }

  /// [objectId] must be in the format [type:id] as a string.
  /// If [_box.get(_queryKey)] is null then this key will be created.
  void removeRefFromQueries(
      {required String objectId, required List<String> queryIds}) {
    final allQueries = _box.get(_queryKey);

    for (final queryId in queryIds) {
      final prevList = allQueries[queryId];

      if (prevList != null && !(prevList is List)) {
        throw AssertionError(
            'There is data under Query[$queryId], but it is not a list. You cannot remove a ref from a non list object.');
      }

      final updatedList = prevList != null
          ? (prevList as List).where((e) => e[_refKey] != objectId)
          : [];

      // Rewrite to box.
      _box.put(_queryKey, {...allQueries, queryId: updatedList});

      broadcast([queryId]);
    }
  }

  /// Write data for a single (new) object query directly to the store and then rebroadcast.
  /// Normalize, then write, then broadcast.
  void writeObjectQuery<TData, TVars extends json.JsonSerializable>({
    required GraphQLQuery<TData, TVars> query,
    required Map<String, dynamic> data,
    List<QueryUpdate> additionalUpdates = const [],
  }) {
    normalizeOperation(
      data: {query.operationName!: data},
      document: query.document,
      operationName: query.operationName,
      write: (dataId, value) => writeNormalized(dataId, value),
      read: (dataId) => readNormalized(dataId),
    );

    for (final update in additionalUpdates) {
      if (update.type == QueryUpdateType.add) {
        addRefToQueries(objectId: update.objectId, queryIds: update.queryIds);
      } else if (update.type == QueryUpdateType.remove) {
        removeRefFromQueries(
            objectId: update.objectId, queryIds: update.queryIds);
      } else if (update.type == QueryUpdateType.broadcast) {
        broadcast(update.queryIds);
      }
    }

    broadcast([query.operationName!]);
  }

  void writeFragment() {
    // normalizeFragment(
    //     // provided from cache
    //     write: (dataId, value) => writeNormalized(dataId, value),
    //     read: (dataId) => readNormalized(dataId),
    //     typePolicies: typePolicies,
    //     dataIdFromObject: dataIdFromObject,
    //     acceptPartialData: acceptPartialData,
    //     addTypename: addTypename,
    //     // provided from request
    //     document: request.fragment.document,
    //     idFields: request.idFields,
    //     fragmentName: request.fragment.fragmentName,
    //     variables: sanitizeVariables(request.variables)!,
    //     // data
    //     data: data,
    //   );
  }

  /////////////////////////////////////
  ///// Hive box reads and writes /////
  /////////////////////////////////////
  Future<void> writeNormalized(String key, dynamic value) async {
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

  Map<String, dynamic> readNormalized(String key) {
    return Map<String, dynamic>.from(_box.get(key) ?? {});
  }

  /// Removes all entities that cannot be reached from the Query root key.
  Set<String> gc() {
    final queryRoot = 'Query';
    final reachable = reachableIdsFromDataId(
      dataId: queryRoot,
      read: (dataId) => readNormalized(dataId),
    );

    final keysToRemove = _box.keys
        .where(
          (key) => key != queryRoot && !reachable.contains(key),
        )
        .map((k) => k.toString())
        .toSet();
    _box.deleteAll(keysToRemove);

    return keysToRemove;
  }

  void clear() {
    _box.clear();
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
  final GraphQLQuery<TData, TVars> query;

  /// The last result passed into the stream. Useful for initialising stream data in the instance where a [QueryObserver] is listening to an already running stream.
  final GraphQLResponse? latest;

  /// Tracks how many [QueryObserver]s are listening to the stream.
  int observers = 1;

  ObservableQuery({required this.subject, required this.query, this.latest});

  void dispose() {
    subject.close();
  }
}

class MutationResult<TData> {
  final TData data;
  final List<Object>? errors;
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  MutationResult({required this.data, this.errors});
}

/// [add] and [remove] will both also broadcast their updates once complete.
/// [broadcast] would be used if objects have been updated only - not created or removed.
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
