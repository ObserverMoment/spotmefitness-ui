import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/active_workout_set_display.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/fortime_rep_score.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class ForTimeVideoOverlay extends StatelessWidget {
  final int sectionIndex;
  const ForTimeVideoOverlay({Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// [WorkoutSetDisplay] is only checking the name, not the ID or description.
    final type = WorkoutSectionType()
      ..id = ''
      ..name = kForTimeName
      ..description = '';

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: 0,
            right: 10,
            child: Container(
                padding: kDefaultTagPadding,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: context.theme.cardBackground.withOpacity(0.4)),
                child: ForTimeRepsScore(sectionIndex: sectionIndex))),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0, bottom: 2),
                child: MyText('Now'),
              ),
              ActiveSetDisplay(
                offset: 0,
                sectionIndex: sectionIndex,
                workoutSectionType: type,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 3.0, bottom: 2),
                child: MyText('Next'),
              ),
              ActiveSetDisplay(
                offset: 1,
                sectionIndex: sectionIndex,
                workoutSectionType: type,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
