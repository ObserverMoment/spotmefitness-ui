import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_times.dart';
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
import 'package:collection/collection.dart';

class LoggedWorkoutCreatorSection extends StatelessWidget {
  final int sectionIndex;

  /// In the LoggedWorkoutCreator (create from a workout) you need to show this button on the section screen. When in the editable logged workout details component you do not need to show this because each section has its own tab called 'Laptimes' where this detail can be viewed / edited.
  final bool showLapTimesButton;
  LoggedWorkoutCreatorSection(this.sectionIndex,
      {this.showLapTimesButton = false});

  void _addLoggedWorkoutSet(BuildContext context) {
    context.read<LoggedWorkoutCreatorBloc>().addLoggedWorkoutSet(
          sectionIndex,
        );
  }

  Future<void> _openLapTimes(BuildContext context) async {
    final bloc = context.read<LoggedWorkoutCreatorBloc>();
    context.showBottomSheet(
        child: ChangeNotifierProvider.value(
            value: bloc, child: LoggedWorkoutSectionTimes(sectionIndex)));
  }

  Widget _buildSectionRepeats(
      BuildContext context, LoggedWorkoutSection loggedWorkoutSection) {
    final roundsCompleted = context.select<LoggedWorkoutCreatorBloc, int>((b) =>
        b.loggedWorkout.loggedWorkoutSections[sectionIndex].roundsCompleted);

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
                  text: '$roundsCompleted ${once ? "time" : "times"}',
                  onPressed: () => context.showBottomSheet<int>(
                          child: NumberInputModalInt(
                        value: roundsCompleted,
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

    final sectionTimeTakenMs = context.select<LoggedWorkoutCreatorBloc, int?>(
        (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex].timeTakenMs);

    final repScore = context.select<LoggedWorkoutCreatorBloc, int?>(
        (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex].repScore);

    final loggedWorkoutSets = context
        .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSet>>((b) => b
            .loggedWorkout
            .loggedWorkoutSections[sectionIndex]
            .loggedWorkoutSets)
        .sortedBy<num>((s) => s.sortPosition);

    return Column(
      children: [
        Wrap(
          spacing: 4,
          runSpacing: 3,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            WorkoutSectionTypeTag(
              loggedWorkoutSection.workoutSectionType.name,
              timecap: loggedWorkoutSection.timecap,
            ),
            if ([kFreeSessionName, kForTimeName]
                .contains(loggedWorkoutSection.workoutSectionType.name))
              DurationPickerDisplay(
                duration: sectionTimeTakenMs != null
                    ? Duration(milliseconds: sectionTimeTakenMs)
                    : null,
                updateDuration: (duration) => context
                    .read<LoggedWorkoutCreatorBloc>()
                    .updateSectionTimeTakenMs(loggedWorkoutSection.sortPosition,
                        duration.inMilliseconds),
              ),
            if ([kEMOMName, kHIITCircuitName, kTabataName]
                .contains(loggedWorkoutSection.workoutSectionType.name))
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 4),
                child: ContentBox(
                  padding: kDefaultTagPadding,
                  child: MyText(
                    'Duration: ${DataUtils.calculateTimedLoggedSectionDuration(loggedWorkoutSection).compactDisplay()}',
                    lineHeight: 1,
                  ),
                ),
              ),
            if ([kAMRAPName, kLastStandingName]
                .contains(loggedWorkoutSection.workoutSectionType.name))
              RepsScoreDisplay(
                  score: repScore,
                  section: loggedWorkoutSection,
                  updateScore: (int score) => context
                      .read<LoggedWorkoutCreatorBloc>()
                      .updateSectionRepsScore(
                          loggedWorkoutSection.sortPosition, score)),
            if (showLapTimesButton &&
                !([kEMOMName, kHIITCircuitName, kTabataName]
                    .contains(loggedWorkoutSection.workoutSectionType.name)))
              BorderButton(
                  text: 'Times',
                  prefix: Icon(
                    CupertinoIcons.timer,
                    size: 14,
                  ),
                  onPressed: () => _openLapTimes(context),
                  mini: true)
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
                            onPressed: () => _addLoggedWorkoutSet(context),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: LoggedWorkoutCreatorSet(
                        sectionIndex: loggedWorkoutSection.sortPosition,
                        setIndex: i,
                      ),
                    );
                  }
                })),
      ],
    );
  }
}
