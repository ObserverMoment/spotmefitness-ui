import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

/// Class which provides easy getters for the gql operation names.
/// Useful for managing store state - store mutations and QueryObserver updates.
class GQLOps {
  static String get userLoggedWorkoutsQuery =>
      UserLoggedWorkoutsQuery(variables: UserLoggedWorkoutsArguments())
          .operationName;
}
