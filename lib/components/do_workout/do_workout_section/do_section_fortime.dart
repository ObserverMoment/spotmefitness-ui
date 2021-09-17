import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/animated/animated_submit_button_V2.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/fortime/fortime_section_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/fortime/fortime_section_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/fortime/fortime_video_overlay.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/section_video_player_screen.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/start_resume_button.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class DoWorkoutSectionForTime extends StatelessWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState progressState;
  final int activePageIndex;
  const DoWorkoutSectionForTime(
      {Key? key,
      required this.workoutSection,
      required this.progressState,
      required this.activePageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRunning = context.select<DoWorkoutBloc, bool>((b) =>
        b.getStopWatchTimerForSection(workoutSection.sortPosition).isRunning);

    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: activePageIndex,
            children: [
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
                  child: ForTimeMovesList(
                      workoutSection: workoutSection, state: progressState),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
                  child: ForTimeSectionTimer(
                      workoutSection: workoutSection, state: progressState),
                ),
              ),
              // SectionVideoPlayerScreen(workoutSection: workoutSection),
              if (Utils.textNotNull(workoutSection.classVideoUri))
                Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SectionVideoPlayerScreen(
                            workoutSection: workoutSection)),
                    SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: ForTimeVideoOverlay(
                              sectionIndex: workoutSection.sortPosition),
                        )),
                  ],
                ),
            ],
          ),
        ),
        AnimatedSwitcher(
            duration: kStandardAnimationDuration,
            child: isRunning
                ? AnimatedSubmitButtonV2(
                    height: 64,
                    text: 'set Complete',
                    onSubmit: () => context
                        .read<DoWorkoutBloc>()
                        .markCurrentWorkoutSetAsComplete(
                            workoutSection.sortPosition),
                    borderRadius: 2,
                  )
                : StartResumeButton(
                    height: 64,
                    sectionIndex: workoutSection.sortPosition,
                  )),
      ],
    );
  }
}
