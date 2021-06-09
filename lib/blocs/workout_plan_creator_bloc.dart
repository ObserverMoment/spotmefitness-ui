import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// All updates to workout plan or descendants follow this pattern.
/// 1: Update local data
/// 2. Notify listeners so UI rebuilds optimistically
/// 3. Call API mutation (if not a create op).
/// 4. Check response is what was expected.
/// 5. If not then roll back local state changes and display error message.
/// 6: If ok then action is complete.
class WorkoutPlanCreatorBloc extends ChangeNotifier {
  /// Run this before constructing the bloc
  static Future<WorkoutPlan> initialize(
      BuildContext context, WorkoutPlan? prevWorkoutPlan) async {
    try {
      if (prevWorkoutPlan != null) {
        // User is editing a previous workout plan - return a copy.
        // First ensure that all child lists are sorted by sort position.
        /// Reordering ops in this bloc use [list.remove] and [list.insert] whch requires that the initial sort order is correct.
        return prevWorkoutPlan.copyAndSortAllChildren;
      } else {
        // User is creating - make an empty workout plan in the db and return.
        final variables = CreateWorkoutPlanArguments(
          data: CreateWorkoutPlanInput(
              name: 'Workout Plan ${DateTime.now().dateString}',
              difficultyLevel: DifficultyLevel.challenging,
              contentAccessScope: ContentAccessScope.private),
        );

        final result = await context.graphQLStore
            .mutate<CreateWorkoutPlan$Mutation, CreateWorkoutPlanArguments>(
                mutation: CreateWorkoutPlanMutation(variables: variables),
                writeToStore: false);

        if (result.hasErrors || result.data == null) {
          throw Exception(
              'There was a problem creating a new workout plan in the database.');
        }

        final newWorkoutPlan = WorkoutPlan.fromJson({
          ...result.data!.createWorkoutPlan.toJson(),
          'WorkoutPlanDays': []
        });

        context.showToast(message: 'Workout Plan Created');
        return newWorkoutPlan;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
