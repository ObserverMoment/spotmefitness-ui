import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/env_config.dart';

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

  static Future<QueryResult> mutateOptimisticFragment(
      {required GraphQLClient client,
      required MutationOptions options,
      required FragmentRequest request,
      required Map<String, dynamic> data}) async {
    // Write optimistic fragment and broadcast.
    client.cache.writeFragment(request, data: data);
    client.queryManager.maybeRebroadcastQueries();

    // Run network mutation.
    final result = await client.mutate(options);
    return result;
  }
}
