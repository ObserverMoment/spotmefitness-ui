import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/env_config.dart';
import "package:gql/ast.dart";
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';

class GraphQL {
  late GraphQLClient _client;

  GraphQL() {
    final HttpLink _httpLink = HttpLink(
      EnvironmentConfig.graphqlEndpoint,
    );

    final AuthLink _authLink = AuthLink(
        getToken: () async =>
            'Bearer ${await GetIt.I<AuthBloc>().getIdToken()}');

    final Link _link = _authLink.concat(_httpLink);

    _client = GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: _link,
        defaultPolicies: DefaultPolicies(
            watchQuery: Policies(
                fetch: FetchPolicy.cacheAndNetwork,
                cacheReread: CacheRereadPolicy.mergeOptimistic)));
  }
  // Use for direct access. i.e. for one off mutations.
  GraphQLClient get client => _client;
  // Used for provider / consumer pattern
  ValueNotifier<GraphQLClient> get clientNotifier => ValueNotifier(_client);

  /// For use when creating objects that require a custom update handler.
  /// For example if one or more queries need to be written to cache in response.
  static Future<QueryResult> createWithQueryUpdate(
      {required GraphQLClient client,
      required DocumentNode document,
      required String operationName,
      required Map<String, dynamic> variables,
      required String fragment,
      FutureOr<void> Function(dynamic)? onCompleted}) async {
    // Run network mutation.
    final result = await client.mutate(MutationOptions(
      document: document,
      variables: variables,
      update: (cache, result) {
        if (result!.hasException) {
          throw new Exception(result.exception);
        } else {
          // updateCachehandler(cache, result) == pass in from caller
          final res = cache.readQuery(Request(
              operation: Operation(document: GymProfilesQuery().document)));
          final prevGymProfiles =
              GymProfiles$Query.fromJson(res ?? {}).gymProfiles;
          cache.writeQuery(
            Request(
                operation: Operation(document: GymProfilesQuery().document)),
            data: {
              'gymProfiles': [
                ...prevGymProfiles.map((p) => p.toJson()),
                result.data![operationName]
              ]
            },
          );
          // updateCachehandler(cache, result) == pass in from caller
        }
      },
      onError: (e) => throw new Exception(e),
      onCompleted: onCompleted,
    ));
    return result;
  }

  /// Wrapper around client.mutate().
  /// First writes a fragment to cache 'optimistically' and manually broadcast queries.
  /// Then run network mutate
  /// Finally write to cache again with the result from the network.
  /// For single object updates only - does not work with creates as it does not update the cache at the root query.
  static Future<QueryResult> updateWithOptimisticFragmentUpdate(
      {required GraphQLClient client,
      required DocumentNode document,
      required String operationName,
      required Map<String, dynamic> variables,
      required String objectId,
      required String objectType,
      required String fragment,
      Map<String, dynamic>? optimisticData,
      FutureOr<void> Function(dynamic)? onCompleted}) async {
    final FragmentRequest request = Fragment(
        document: gql(
      fragment,
    )).asRequest(idFields: {
      '__typename': objectType,
      'id': objectId,
    });

    if (optimisticData != null) {
      // Write optimistic fragment and broadcast.
      client.cache.writeFragment(request, data: optimisticData);
      client.queryManager.maybeRebroadcastQueries();
    }

    // Run network mutation.
    final result = await client.mutate(MutationOptions(
      document: document,
      variables: variables,
      update: (cache, result) {
        if (result!.hasException) {
          throw new Exception(result.exception);
        } else {
          cache.writeFragment(
            request,
            data: result.data![operationName],
          );
        }
      },
      onError: (e) => throw new Exception(e),
      onCompleted: onCompleted,
    ));
    return result;
  }
}
