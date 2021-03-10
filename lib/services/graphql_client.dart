import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/services/auth.dart';

class GraphQL {
  late GraphQLClient _client;

  GraphQL() {
    final HttpLink _httpLink = HttpLink(
      EnvironmentConfig.apiEndpoint,
    );

    final AuthLink _authLink =
        AuthLink(getToken: GetIt.I<AuthService>().getIdToken);

    final Link _link = _authLink.concat(_httpLink);

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  ValueNotifier<GraphQLClient> get client => ValueNotifier(_client);
}
