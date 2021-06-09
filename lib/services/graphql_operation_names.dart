import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';

/// Class which provides easy getters for the gql operation names in cases where there are variables being requires by the generated types.
/// Useful for managing store state - store mutations and QueryObserver updates.
/// Variables / args are ignored - just the operation name is returned.
class GQLOpNames {
  static String get progressJournalByIdQuery =>
      ProgressJournalByIdQuery(variables: ProgressJournalByIdArguments(id: ''))
          .operationName;

  static String get userBenchmarksQuery =>
      UserBenchmarksQuery(variables: UserBenchmarksArguments()).operationName;

  static String get userLoggedWorkoutsQuery =>
      UserLoggedWorkoutsQuery(variables: UserLoggedWorkoutsArguments())
          .operationName;

  static String get userProgressJournalsQuery =>
      UserProgressJournalsQuery().operationName;

  static String get userScheduledWorkoutsQuery =>
      UserScheduledWorkoutsQuery().operationName;
}

/// Observable queries whose operations can accept variables, but whose keys are being stored with the variables nulled.
/// /// For example [workoutById({"id": null})]
class GQLNullVarsKeys {
  static String get userBenchmarksQuery => getNulledVarsQueryId(
      UserBenchmarksQuery(variables: UserBenchmarksArguments()));

  static String get userLoggedWorkoutsQuery => getNulledVarsQueryId(
      UserLoggedWorkoutsQuery(variables: UserLoggedWorkoutsArguments()));
}

/// Observable queries whose operations accept variables and whose keys are being generated based on the variables being passed.
/// /// For example [workoutById({"id": 1234})]
class GQLVarParamKeys {
  static String progressJournalByIdQuery(String id) =>
      getParameterizedQueryId(ProgressJournalByIdQuery(
          variables: ProgressJournalByIdArguments(id: id)));

  static String userBenchmarkByIdQuery(String id) => getParameterizedQueryId(
      UserBenchmarkByIdQuery(variables: UserBenchmarkByIdArguments(id: id)));

  static String workoutByIdQuery(String id) => getParameterizedQueryId(
      WorkoutByIdQuery(variables: WorkoutByIdArguments(id: id)));

  static String workoutPlanByIdQuery(String id) => getParameterizedQueryId(
      WorkoutPlanByIdQuery(variables: WorkoutPlanByIdArguments(id: id)));
}
