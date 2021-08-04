import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_submit_button.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_section_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/fortime/fortime_section_progress_summary.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/fortime/fortime_timer.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class DoWorkoutSectionForTime extends StatelessWidget {
  final PageController pageController;
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState progressState;
  final int activePageIndex;
  const DoWorkoutSectionForTime(
      {Key? key,
      required this.pageController,
      required this.workoutSection,
      required this.progressState,
      required this.activePageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSubmitButton(
          text: 'set Complete',
          onSubmit: () => context
              .read<DoWorkoutBloc>()
              .markCurrentWorkoutSetAsComplete(workoutSection.sortPosition),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  H3(
                    'For Time',
                  ),
                  InfoPopupButton(
                      infoWidget: MyText(
                          'Info about the wokout type ${workoutSection.workoutSectionType.name}'))
                ],
              ),
              RepsScore(sectionIndex: workoutSection.sortPosition),
            ],
          ),
        ),
        LinearPercentIndicator(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          lineHeight: 6,
          percent: progressState.percentComplete,
          backgroundColor: context.theme.primary.withOpacity(0.07),
          linearGradient: Styles.pinkGradient,
          linearStrokeCap: LinearStrokeCap.roundAll,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                AMRAPSectionMovesList(
                    workoutSection: workoutSection, state: progressState),
                ForTimeSectionProgressSummary(
                    workoutSection: workoutSection, state: progressState),
                ForTimeTimer(
                    workoutSection: workoutSection, state: progressState),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RepsScore extends StatelessWidget {
  final int sectionIndex;
  const RepsScore({Key? key, required this.sectionIndex}) : super(key: key);

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
