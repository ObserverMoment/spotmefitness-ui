import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

class DoWorkoutMovesList extends StatelessWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutMovesList({Key? key, required this.workoutSection})
      : super(key: key);

  List<Widget> _singleSectionMovesList(int round) => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyText('Round ${round + 1}'),
        ),
        ...workoutSection.workoutSets
            .sortedBy<num>((wSet) => wSet.sortPosition)
            .map((workoutSet) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: WorkoutSetDisplay(
                      workoutSet: workoutSet,
                      workoutSectionType: workoutSection.workoutSectionType),
                ))
            .toList(),
      ];

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(workoutSection.workoutSectionType.name,
              weight: FontWeight.bold),
          InfoPopupButton(
              infoWidget: MyText(
                  'Info about the wokout type ${workoutSection.workoutSectionType.name}'))
        ],
      ),
      ...List.generate(
              workoutSection.rounds, (index) => _singleSectionMovesList(index))
          .expand((x) => x)
          .toList()
    ]);
  }
}
