import 'package:artemis/artemis.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/env_config.dart';

class GraphQLStore {
  static const String boxName = 'graphql-cache';
  late ArtemisClient _artemisClient;
  late HttpLink _httpLink;
  late AuthLink _authLink;
  late Link _link;
  late Box hiveBox;
  late StoreManager _storeManager;
  late QueryManager _queryManager;

  GraphQLStore() {
    _httpLink = HttpLink(
      EnvironmentConfig.graphqlEndpoint,
    );

    _authLink = AuthLink(
        getToken: () async =>
            'Bearer ${await GetIt.I<AuthBloc>().getIdToken()}');

    _link = _authLink.concat(_httpLink);

    _artemisClient = ArtemisClient.fromLink(_link);

    _storeManager = StoreManager(boxName);
    _queryManager = QueryManager(_artemisClient);
  }

  ObservableQuery registerObservableQuery(GraphQLQuery query) {
    return _queryManager.registerObservableQuery(query);
  }

  String unregisterObservableQuery(String id) {
    _queryManager.unregisterObservableQuery(id);
    return id;
  }

  void fetchQuery(String id, QueryFetchPolicy fetchPolicy) {
    _queryManager.fetchQuery(id, fetchPolicy);
  }

  void dispose() {
    _httpLink.dispose();
    _storeManager.dispose();
    _queryManager.dispose();
    _artemisClient.dispose();
  }
}

/// Manages data in and out of store [Hive box].
class StoreManager {
  final String boxName;
  Box? _box;
  StoreManager(this.boxName);

  Future<Box> get box async {
    if (_box == null) {
      _box = await Hive.openBox(boxName);
      return _box!;
    } else {
      return _box!;
    }
  }

  void putNormalized() {}
  void retrieveNormalized() {}

  void normalize() {}
  void denormalize() {}

  void clearCache() => _box?.clear();

  void dispose() {
    _box?.close();
  }
}

/// Tracks and manages all [ObservableQuery] listeners.
class QueryManager {
  final ArtemisClient _artemisClient;
  QueryManager(this._artemisClient);

  Map<String, ObservableQuery> queryBuilders = {};

  ObservableQuery registerObservableQuery(GraphQLQuery query) {
    print('registerObservableQuery');
    if (query.operationName == null) {
      throw Exception(
          '[query.operationName] cannot be null when registering an observale query.');
    } else {
      final String id = query.operationName!;
      if (!queryBuilders.containsKey(query.operationName)) {
        /// No one is listening to this id - create a new stream.
        queryBuilders[id] = ObservableQuery(
            id: id,
            subject: BehaviorSubject<ObservableQueryResult>(),
            query: query);
      } else {
        // A stream with this id already has one or more listeners.
        // Increment the observer count.
        queryBuilders[id]!.observers++;
      }

      return queryBuilders[id]!;
    }
  }

  void unregisterObservableQuery(String id) {
    if (!queryBuilders.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      if (queryBuilders[id]!.observers == 1) {
        // There is only one observer. Close the stream.
        queryBuilders[id]!.dispose();
        // Remove it from the map.
        queryBuilders.remove(id);
      } else {
        // Reduce the number of active listeners by one.
        queryBuilders[id]!.observers--;
      }
    }
  }

  void fetchQuery(String id, QueryFetchPolicy fetchPolicy) async {
    print('fetchQuery');
    if (!queryBuilders.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      switch (fetchPolicy) {
        case QueryFetchPolicy.storeAndNetwork:
          queryCache(id);
          await queryNetwork(id);
          break;
        case QueryFetchPolicy.storeFirst:
          final success = queryCache(id);
          if (!success) {
            await queryNetwork(id);
          }
          break;
        case QueryFetchPolicy.storeOnly:
          queryCache(id);
          break;
        case QueryFetchPolicy.networkOnly:
          await queryNetwork(id);
          break;
        default:
          throw Exception('$fetchPolicy is not valid.');
      }
    }
  }

  bool queryCache(String id) {
    if (!queryBuilders.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      // If the cache does not have a key for this query.
      // return false;
      // final result = _cacheClient.execute(queryBuilders[id]!.query);
      // Denormalize the result.
      // Broadcast the query.
      broadcast([id]);
      return true;
    }
  }

  Future<bool> queryNetwork(String id) async {
    print('queryNetwork');
    print(id);
    if (!queryBuilders.containsKey(id)) {
      throw QueryNotFoundException(id);
    } else {
      final result = await _artemisClient.execute(queryBuilders[id]!.query);
      print('network result.data');
      print(result.data);
      // Normalize the result
      // Add it do the stores
      // Broadcast the query
      print('queryBuilders[id]');
      print(queryBuilders[id]);
      queryBuilders[id]!.subject.sink.add(ObservableQueryResult(
          state: QueryResultState.complete,
          data: result,
          exception: Exception('Hello?')));
      broadcast([id]);
      return true;
    }
  }

  void broadcast(List<String> ids) {
    ids.forEach((id) {
      // Query the cache based on
      // queryBuilders[id].queryDocument
      // denormalize the data
      // Add to the stream to broadcast to all listeners.
      queryBuilders[id]!.subject.sink.add(ObservableQueryResult.loading());
    });
  }

  void dispose() {
    queryBuilders.forEach((k, v) {
      v.dispose();
    });
  }
}

/// A single stream for a single executable [GraphQLQuery].
class ObservableQuery {
  final String id;
  final BehaviorSubject<ObservableQueryResult> subject;
  final GraphQLQuery query;

  /// The last result passed into the stream. Useful for initialising stream data in the instance where a [QueryBuilder] is listening to an already running stream.
  final ObservableQueryResult? latest;

  /// Tracks how many [QueryBuilders are listening to the stream].
  int observers = 1;

  ObservableQuery(
      {required this.id,
      required this.subject,
      required this.query,
      this.latest});

  void dispose() {
    subject.close();
  }
}

enum QueryResultState { loading, exception, complete }

class ObservableQueryResult {
  final QueryResultState state;
  final Exception? exception;
  final GraphQLResponse? data;
  ObservableQueryResult({required this.state, this.exception, this.data});

  factory ObservableQueryResult.loading() =>
      ObservableQueryResult(state: QueryResultState.loading);

  bool get isLoading => state == QueryResultState.loading;
  bool get hasException => exception != null;
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
