import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

/// Class which provides easy getters for the gql operation names in cases where there are variables being requires by the generated types.
/// Useful for managing store state - store mutations and QueryObserver updates.
/// Variables / args are ignored - just the operation name is returned.
class GQLOpNames {
  static String get userLoggedWorkoutsQuery =>
      UserLoggedWorkoutsQuery(variables: UserLoggedWorkoutsArguments())
          .operationName;

  static String get userBenchmarksQuery =>
      UserBenchmarksQuery(variables: UserBenchmarksArguments()).operationName;

  static String get progressJournalByIdQuery =>
      ProgressJournalByIdQuery(variables: ProgressJournalByIdArguments(id: ''))
          .operationName;
}
