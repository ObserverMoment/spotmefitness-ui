import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display_header.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';

/// Details of a workout set in a compact a format as possible.
class WorkoutSetMinimalDisplay extends StatelessWidget {
  final WorkoutSet workoutSet;
  final WorkoutSectionType workoutSectionType;
  final Color? backgroundColor;
  const WorkoutSetMinimalDisplay(
      {Key? key,
      required this.workoutSet,
      required this.workoutSectionType,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              WorkoutSetDisplayHeader(
                workoutSectionType: workoutSectionType,
                workoutSet: workoutSet,
              ),
            ],
          ),
          ...workoutSet.workoutMoves
              .map((wm) => MyText(
                    generateWorkoutMoveString(wm, workoutSectionType),
                  ))
              .toList()
        ],
      ),
    );
  }
}
