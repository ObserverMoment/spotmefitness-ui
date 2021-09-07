import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/animated/animated_submit_button.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_countdown_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_section_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_section_progress_summary.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:provider/provider.dart';

class DoWorkoutSectionAMRAP extends StatelessWidget {
  final PageController pageController;
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState progressState;
  final int activePageIndex;
  const DoWorkoutSectionAMRAP(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  H3(
                    'AMRAP in ${Duration(seconds: workoutSection.timecap).compactDisplay()}',
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: AnimatedSubmitButton(
            text: 'set Complete',
            onSubmit: () => context
                .read<DoWorkoutBloc>()
                .markCurrentWorkoutSetAsComplete(workoutSection.sortPosition),
          ),
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              AMRAPSectionMovesList(
                  workoutSection: workoutSection, state: progressState),
              AMRAPSectionProgressSummary(
                  workoutSection: workoutSection, state: progressState),
              AMRAPCountdownTimer(
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
