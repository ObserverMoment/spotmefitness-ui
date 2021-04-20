import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class Converters {
  static WorkoutSummary fromWorkoutDataToWorkoutSummary(
      WorkoutData workoutData) {
    return WorkoutSummary.fromJson({
      ...workoutData.toJson(),
      'WorkoutSummarySections': workoutData.workoutSections
          .map((section) => {
                ...section.toJson(),
                'WorkoutSummarySets': section.workoutSets
                    .map((ws) => {
                          ...ws.toJson(),
                          'WorkoutSummaryWorkoutMoves': ws.workoutMoves
                              .map((wm) =>
                                  {...wm.toJson(), 'Move': wm.move.toJson()})
                              .toList()
                        })
                    .toList()
              })
          .toList()
    });
  }
}
