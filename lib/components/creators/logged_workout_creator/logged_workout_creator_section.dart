import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/logged_workout_creator_set.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_times.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/logging/reps_score_picker.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex]);

    final sectionTimeTakenMs = context.select<LoggedWorkoutCreatorBloc, int?>(
        (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex].timeTakenMs);

    final repScore = context.select<LoggedWorkoutCreatorBloc, int?>(
        (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex].repScore);

    /// Only FreeSession allows you to add extra sets onto the workout.
    /// Doesn't make sense for other types.
    final isFreeSession =
        loggedWorkoutSection.workoutSectionType.name == kFreeSessionName;

    return Column(
      children: [
        Wrap(
          spacing: 4,
          runSpacing: 3,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if ([kFreeSessionName, kForTimeName]
                .contains(loggedWorkoutSection.workoutSectionType.name))
              DurationPickerDisplay(
                duration: sectionTimeTakenMs != null
                    ? Duration(milliseconds: sectionTimeTakenMs)
                    : null,
                updateDuration: (duration) => context
                    .read<LoggedWorkoutCreatorBloc>()
                    .editLoggedWorkoutSection(loggedWorkoutSection.sortPosition,
                        {'timeTakenMs': duration.inMilliseconds}),
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
            if (kAMRAPName == loggedWorkoutSection.workoutSectionType.name)
              RepsScoreDisplay(
                  score: repScore,
                  section: loggedWorkoutSection,
                  updateScore: (repScore) => context
                      .read<LoggedWorkoutCreatorBloc>()
                      .editLoggedWorkoutSection(
                          loggedWorkoutSection.sortPosition,
                          {'repScore': repScore})),
            if (showLapTimesButton &&
                !([kEMOMName, kHIITCircuitName, kTabataName]
                    .contains(loggedWorkoutSection.workoutSectionType.name)))
              BorderButton(
                  text: 'Lap Times',
                  prefix: Icon(
                    CupertinoIcons.timer,
                    size: 14,
                  ),
                  onPressed: () => _openLapTimes(context),
                  mini: true)
          ],
        ),
        SizedBox(height: 6),
        Flexible(
            child: ListView.builder(
                itemCount: loggedWorkoutSection.loggedWorkoutSets.length + 1,
                itemBuilder: (c, i) {
                  if (i == loggedWorkoutSection.loggedWorkoutSets.length) {
                    return isFreeSession
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CreateTextIconButton(
                                  text: 'Add Set',
                                  onPressed: () =>
                                      _addLoggedWorkoutSet(context),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 3),
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
