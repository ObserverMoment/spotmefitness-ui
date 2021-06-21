import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

class DoWorkoutMovesList extends StatelessWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutMovesList({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: workoutSection.workoutSets
          .sortedBy<num>((wSet) => wSet.sortPosition)
          .map((workoutSet) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: WorkoutSetDisplay(
                    workoutSet: workoutSet,
                    workoutSectionType: workoutSection.workoutSectionType),
              ))
          .toList(),
    );
  }
}
