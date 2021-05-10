import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/number_picker.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_instructions.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class LoggedWorkoutCreatorSection extends StatelessWidget {
  final WorkoutSection workoutSection;
  LoggedWorkoutCreatorSection(this.workoutSection);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WorkoutSectionTypeTag(
              workoutSection.workoutSectionType.name,
              timecap: workoutSection.timecap,
            ),
            if (workoutSection.workoutSectionType.name == kForTimeName)
              MyText('Enter your time'),
            if (workoutSection.workoutSectionType.name == kFreeSessionName)
              MyText('How long did you workout for?'),
            if ([kEMOMName, kHIITCircuitName, kTabataName]
                .contains(workoutSection.workoutSectionType.name))
              MyText('Auto calced'),
          ],
        ),
        if ([kAMRAPName, kLastStandingName]
            .contains(workoutSection.workoutSectionType.name))
          AMRAPScoreEntry(),
        WorkoutSectionInstructions(
          typeName: workoutSection.workoutSectionType.name,
          rounds: workoutSection.rounds,
          timecap: workoutSection.timecap,
        ),
        Flexible(
            child: ListView.builder(
                itemCount: workoutSection.workoutSets.length,
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: WorkoutSetDisplay(
                        workoutSet: workoutSection.workoutSets[i],
                        workoutSectionType: workoutSection.workoutSectionType),
                  );
                })),
      ],
    );
  }
}

/// Used for AMRAP and Last Standing Workouts as both are scored by reps.
class AMRAPScoreEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyText('Enter your score...'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  MyText(
                    'Full rounds',
                    size: FONTSIZE.SMALL,
                    weight: FontWeight.bold,
                  ),
                  NumberPickerInt(
                    number: 999,
                    saveValue: (int value) {
                      print(value);
                    },
                  )
                ],
              ),
              Column(
                children: [
                  MyText(
                    'Reps from last round',
                    size: FONTSIZE.SMALL,
                    weight: FontWeight.bold,
                  ),
                  NumberPickerInt(
                    number: 999,
                    saveValue: (int value) {
                      print(value);
                    },
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
