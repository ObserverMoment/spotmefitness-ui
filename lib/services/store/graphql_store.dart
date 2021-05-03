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

  GraphQLStore() {
    _httpLink = HttpLink(
      EnvironmentConfig.graphqlEndpoint,
    );

    _authLink = AuthLink(
        getToken: () async =>
            'Bearer ${await GetIt.I<AuthBloc>().getIdToken()}');

    _link = _authLink.concat(_httpLink);

    _box = Hive.box(boxName);
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

  void fetchQuery(String id, QueryFetchPolicy fetchPolicy) async {
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
      // Query the cache based on
      // observableQueries[id].queryDocument
      final observableQuery = getQuerybyId(id);
      final GraphQLQuery query = observableQuery.query;
      // Denormalize the data
      final data = denormalizeOperation(
          document: query.document, read: (dataId) => readNormalized(dataId));
      // Add to the stream to broadcast to all listeners.
      observableQuery.subject
          .add(GraphQLResponse(data: query.parse(data ?? {})));
    });
  }

  //// Request executions ////
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

  /// TODO: Mutation with optional optimism.
  /// Wrapp execute function - add cache writing and broadcasting.
  /// Update the store with the returned data then read + broadcast data to specified ids.
  Future<void> mutate(
      {required GraphQLQuery mutation,
      required List<String> broadcastQueryIds,

      /// Should [optimisticData] be typed data rather than a map? [TData] as type arg?
      Map<String, dynamic>? optimisticData}) {}

  /// Hive box reads and writes
  Future<void> writeNormalized(String key, dynamic value) async {
    if (value is Map<String, Object>) {
      final existing = _box.get(key);
      _box.put(
        key,
        existing != null
            ? StoreUtils.deeplyMergeLeft([existing, value])
            : value,
      );
    } else {
      _box.put(key, value);
    }
  }

  Map<String, dynamic> readNormalized(String key) {
    return Map<String, dynamic>.from(_box.get(key) ?? {});
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
