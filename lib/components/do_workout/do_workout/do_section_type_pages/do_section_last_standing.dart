import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_submit_button.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/last_standing/last_standing_countdown_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/last_standing/last_standing_moves_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class DoWorkoutSectionLastStanding extends StatelessWidget {
  final PageController pageController;
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState progressState;
  final int activePageIndex;
  const DoWorkoutSectionLastStanding(
      {Key? key,
      required this.pageController,
      required this.workoutSection,
      required this.progressState,
      required this.activePageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remainingSeconds =
        (progressState.timeToNextCheckpointMs! ~/ 1000).toString();

    final loggedWorkoutSection =
        context.select<DoWorkoutBloc, LoggedWorkoutSection>((b) =>
            b.getLoggedWorkoutSectionForSection(workoutSection.sortPosition));

    return Column(
      children: [
        if (workoutSection.timecap != null)
          LinearPercentIndicator(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            lineHeight: 6,
            percent: progressState.percentComplete,
            backgroundColor: context.theme.primary.withOpacity(0.07),
            linearGradient: Styles.pinkGradient,
            linearStrokeCap: LinearStrokeCap.roundAll,
          ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H3(
                        'Last One Standing',
                      ),
                      MyText(
                        'Finsh after ${Duration(seconds: workoutSection.timecap).compactDisplay()}',
                        color: Styles.infoBlue,
                        lineHeight: 1.3,
                      ),
                    ],
                  ),
                  InfoPopupButton(
                      infoWidget: MyText(
                          'Info about the wokout type ${workoutSection.workoutSectionType.name}'))
                ],
              ),
              _RepScore(sectionIndex: workoutSection.sortPosition),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: AnimatedSwitcher(
                duration: kStandardAnimationDuration,
                child: !progressState.userShouldBeResting
                    ? AnimatedSubmitButton(
                        text: 'set Complete',
                        onSubmit: () => context
                            .read<DoWorkoutBloc>()
                            .markCurrentWorkoutSetAsComplete(
                                workoutSection.sortPosition),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText('Rest Up! Next set starts in'),
                          SizedBox(width: 6),
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: SizeFadeIn(
                                key: Key(remainingSeconds),
                                child: MyText(
                                  remainingSeconds,
                                  size: FONTSIZE.DISPLAY,
                                  lineHeight: 1,
                                  color: Styles.infoBlue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              LastStandingSectionMovesList(
                  workoutSection: workoutSection, state: progressState),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoggedWorkoutSectionSummaryCard(
                    loggedWorkoutSection: loggedWorkoutSection),
              ),
              LastStandingCountdownTimer(
                  workoutSection: workoutSection, state: progressState),
            ],
          ),
        ),
      ],
    );
  }
}

class _RepScore extends StatelessWidget {
  final int sectionIndex;
  const _RepScore({Key? key, required this.sectionIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final score =
        context.select<DoWorkoutBloc, int>((b) => b.totalReps[sectionIndex]);
    final display = 'Reps: $score';
    return Container(
      child: SizeFadeIn(key: Key(display), child: H3(display)),
    );
  }
}
