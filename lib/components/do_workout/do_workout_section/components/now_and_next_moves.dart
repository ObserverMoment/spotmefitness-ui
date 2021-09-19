import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/active_workout_set_display.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class NowAndNextMoves extends StatelessWidget {
  final WorkoutSection workoutSection;
  const NowAndNextMoves({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0, bottom: 6),
              child: MyText('Now'),
            ),
            ActiveSetDisplay(
              offset: 0,
              sectionIndex: workoutSection.sortPosition,
              workoutSectionType: workoutSection.workoutSectionType,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0, bottom: 6),
              child: MyText('Next'),
            ),
            ActiveSetDisplay(
              offset: 1,
              sectionIndex: workoutSection.sortPosition,
              workoutSectionType: workoutSection.workoutSectionType,
            ),
          ],
        )
      ],
    );
  }
}
