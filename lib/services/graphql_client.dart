import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/env_config.dart';
import "package:gql/ast.dart";

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

  /// For use when creating an object that requires a custom update handler.
  /// For example if one or more queries need to be written to cache in response.
  static Future<QueryResult> createWithQueryUpdate(
      {required GraphQLClient client,
      required DocumentNode mutationDocument,
      required String mutationOperationName,
      required Map<String, dynamic> mutationVariables,

      /// The query that you want to run to update the cache.
      /// Only needed if not providing a custom [updateCacheHandler].
      DocumentNode? queryDocument,
      String? queryOperationName,
      void Function(GraphQLDataProxy cache, QueryResult result)?
          updateCachehandler,
      FutureOr<void> Function(dynamic)? onCompleted}) async {
    assert(updateCachehandler != null ||
        (queryDocument != null && queryOperationName != null));

    final result = await client.mutate(MutationOptions(
      document: mutationDocument,
      variables: mutationVariables,
      update: (cache, result) {
        if (result!.hasException) {
          throw new Exception(result.exception);
        } else {
          if (updateCachehandler != null) {
            updateCachehandler(cache, result);
          } else {
            /// For standard updates where a returned object goes into a list with key of [queryOperationName]
            final prev = cache.readQuery(
                Request(operation: Operation(document: queryDocument!)));
            if (prev == null) {
              throw AssertionError(
                  'Unable to read from cache - cache update failed.');
            }
            if (prev[queryOperationName] == null) {
              throw AssertionError(
                  'There is no data in the cache under key: "$queryOperationName".');
            }
            if (!(prev[queryOperationName] is List)) {
              throw AssertionError(
                  'Data in the cache under key: "$queryOperationName" is not a list as is required for standard cache updates - use a custom [updateCacheHandler] function instead.');
            }
            cache.writeQuery(
              Request(operation: Operation(document: queryDocument)),
              data: {
                queryOperationName!: [
                  ...prev[queryOperationName],
                  result.data![mutationOperationName],
                ]
              },
            );
          }
        }
      },
      onError: (e) => throw new Exception(e),
      onCompleted: onCompleted,
    ));
    return result;
  }

  /// Wrapper around client.mutate().
  /// First writes a fragment to cache 'optimistically'.
  /// Then run network mutate
  /// Finally write to cache again with the result from the network.
  /// For single object updates only - does not work with creates as it does not update the cache at the root query.
  static Future<QueryResult> updateObjectWithOptimisticFragment(
      {required GraphQLClient client,
      required DocumentNode document,
      required String operationName,
      required Map<String, dynamic> variables,
      required String objectId,
      required String objectType,
      required String fragment,
      Map<String, dynamic>? optimisticData,

      /// Runs after a successful optimistic update.
      void Function()? onCompleteOptimistic,

      /// Runs after a successful network update.
      FutureOr<void> Function(dynamic)? onCompleted}) async {
    final FragmentRequest request = Fragment(
        document: gql(
      fragment,
    )).asRequest(idFields: {
      '__typename': objectType,
      'id': objectId,
    });

    if (optimisticData != null) {
      // Write optimistic fragment and rebroadcast.
      // This calls seems to be required but I am not sure why...
      client.cache.writeFragment(request, data: optimisticData);
      client.queryManager.maybeRebroadcastQueries();
      if (onCompleteOptimistic != null) {
        onCompleteOptimistic();
      }
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

  static Future<QueryResult> deleteObjectByIdOptimistic(
      {required GraphQLClient client,
      required DocumentNode mutationDocument,
      required String mutationOperationName,
      required DocumentNode queryDocument,
      required String queryOperationName,
      required String objectId,
      required String objectType,

      /// Runs after a successful optimistic delete.
      void Function()? onCompleteOptimistic,

      /// Runs after a successful network update.
      FutureOr<void> Function(dynamic)? onCompleted}) async {
    final Map<String, dynamic>? prevData = client.cache
        .readQuery(Request(operation: Operation(document: queryDocument)));

    if (prevData == null) {
      throw AssertionError('Unable to read from cache - cache update failed.');
    }
    if (prevData[queryOperationName] == null) {
      throw AssertionError(
          'There is no data in the cache under key: "$queryOperationName".');
    }
    if (!(prevData[queryOperationName] is List)) {
      throw AssertionError(
          'Data in the cache under key: "$queryOperationName" is not a list as is required for standard deleteById updates.');
    }

    // Filter old data - removing the deleted object and any null objects.
    final updated = prevData[queryOperationName]
        .where((e) => e != null && e['id'] != objectId)
        .toList();

    // Write the updated data.
    client.cache.writeQuery(
      Request(operation: Operation(document: queryDocument)),
      data: {queryOperationName: updated},
    );

    client.cache.store.delete('$objectType:$objectId');

    if (onCompleteOptimistic != null) {
      onCompleteOptimistic();
    }

    final result = await client.mutate(MutationOptions(
      document: mutationDocument,
      variables: {'id': objectId},
      update: (cache, result) {
        if (result!.hasException) {
          throw new Exception(result.exception);
        } else {
          // Check that the expected result has been returned.
          // Object deletions should always return the object ID.
          // If this has been returned as expected then just cleanup to do.
          if (result.data == null ||
              result.data?[mutationOperationName] != objectId) {
            // The response was not as expected. Roll back the changes and throw an exception.
            client.cache.writeQuery(
              Request(operation: Operation(document: queryDocument)),
              data: {queryOperationName: prevData},
            );
            throw new Exception(
                'There was an problem. We were not able to delete $objectType with id $objectId. Changes have been rolled back. Please try again.');
          } else {
            // TODO: Run cleanup? Or mark the cache as 'cleanup required'?
            // Cleanup could be periodic as this is not urgent
            // - as long as graphql client ignores null $refs...
            // Remove any dangling references created by this deletion.
            // Could use normalize.isDanglingReference
          }
        }
      },
      onError: (e) => throw new Exception(e),
      onCompleted: onCompleted,
    ));
    return result;
  }
}
