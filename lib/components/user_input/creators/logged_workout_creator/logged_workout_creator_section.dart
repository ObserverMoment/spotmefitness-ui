import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/logging/reps_score_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_set.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class LoggedWorkoutCreatorSection extends StatelessWidget {
  final int sectionIndex;
  LoggedWorkoutCreatorSection(this.sectionIndex);

  void _addLoggedWorkoutSet(
      BuildContext context, LoggedWorkoutSet templateSet) {
    context
        .read<LoggedWorkoutCreatorBloc>()
        .addLoggedWorkoutSet(sectionIndex, laptimesMs: templateSet.laptimesMs);
  }

  Widget _buildSectionRepeats(
      BuildContext context, LoggedWorkoutSection loggedWorkoutSection) {
    switch (loggedWorkoutSection.workoutSectionType.name) {
      case kAMRAPName:
        return MyText(
            'Repeated the below for ${loggedWorkoutSection.timecap!.secondsToTimeDisplay()}.');
      case kLastStandingName:
        return MyText('Repeated the below for as long as possible.');
      default:
        final once = loggedWorkoutSection.roundsCompleted == 1;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText('Repeated everything'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: BorderButton(
                  mini: true,
                  text:
                      '${loggedWorkoutSection.roundsCompleted} ${once ? "time" : "times"}',
                  onPressed: () => context.showBottomSheet<int>(
                          child: NumberInputModalInt(
                        value: loggedWorkoutSection.roundsCompleted,
                        saveValue: (r) => context
                            .read<LoggedWorkoutCreatorBloc>()
                            .updateSectionRoundsCompleted(sectionIndex, r),
                        title: 'How many repeats?',
                      ))),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex]);

    final loggedWorkoutSets = context
        .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSet>>((b) => b
            .loggedWorkout
            .loggedWorkoutSections[sectionIndex]
            .loggedWorkoutSets);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WorkoutSectionTypeTag(loggedWorkoutSection.workoutSectionType.name),
            if ([kFreeSessionName, kForTimeName]
                .contains(loggedWorkoutSection.workoutSectionType.name))
              DurationPickerDisplay(
                duration: loggedWorkoutSection.timeTakenMs != null
                    ? Duration(milliseconds: loggedWorkoutSection.timeTakenMs!)
                    : null,
                updateDuration: (duration) => context
                    .read<LoggedWorkoutCreatorBloc>()
                    .updateSectionTimeTakenMs(loggedWorkoutSection.sectionIndex,
                        duration.inMilliseconds),
              ),
            if ([kEMOMName, kHIITCircuitName, kTabataName]
                .contains(loggedWorkoutSection.workoutSectionType.name))
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 4),
                child: ContentBox(
                  child: MyText(
                      'Duration: ${DataUtils.calculateTimedLoggedSectionDuration(loggedWorkoutSection).compactDisplay()}'),
                ),
              ),
            if ([kAMRAPName, kLastStandingName]
                .contains(loggedWorkoutSection.workoutSectionType.name))
              Row(
                children: [
                  MyText(
                    'Score: ',
                    weight: FontWeight.bold,
                  ),
                  RepsScoreDisplay(
                      score: loggedWorkoutSection.repScore,
                      section: loggedWorkoutSection,
                      updateScore: (int score) => context
                          .read<LoggedWorkoutCreatorBloc>()
                          .updateSectionRepsScore(
                              loggedWorkoutSection.sectionIndex, score)),
                ],
              )
          ],
        ),
        SizedBox(height: 6),
        _buildSectionRepeats(context, loggedWorkoutSection),
        SizedBox(height: 12),
        Flexible(
            child: ListView.builder(
                itemCount: loggedWorkoutSets.length + 1,
                itemBuilder: (c, i) {
                  if (i == loggedWorkoutSets.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CreateTextIconButton(
                            text: 'Add Set',
                            onPressed: () => _addLoggedWorkoutSet(
                                context, loggedWorkoutSets.last),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: LoggedWorkoutCreatorSet(
                        sectionIndex: loggedWorkoutSection.sectionIndex,
                        setIndex: i,
                      ),
                    );
                  }
                })),
      ],
    );
  }
}
