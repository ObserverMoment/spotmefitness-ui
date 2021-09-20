import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/animated/animated_submit_button_V2.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/section_video_player_screen.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/start_resume_button.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

/// Wrapper around the three section pages for providing a common UI layout.
/// 1. Moves list.
/// 2. Timer page.
/// 3. Video if present.
class DoSectionTemplateLayout extends StatelessWidget {
  final Widget movesList;
  final Widget timer;
  final Widget videoOverlay;
  final int activePageIndex;
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  const DoSectionTemplateLayout({
    Key? key,
    required this.movesList,
    required this.timer,
    required this.videoOverlay,
    required this.activePageIndex,
    required this.workoutSection,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRunning = context.select<DoWorkoutBloc, bool>((b) =>
        b.getStopWatchTimerForSection(workoutSection.sortPosition).isRunning);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: activePageIndex,
                children: [
                  SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
                      child: movesList,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
                      child: timer,
                    ),
                  ),
                  if (Utils.textNotNull(workoutSection.classVideoUri))
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: SectionVideoPlayerScreen(
                                workoutSection: workoutSection)),
                        SafeArea(
                            bottom: false,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 56.0, right: 12, left: 12, bottom: 6),
                              child: videoOverlay,
                            )),
                      ],
                    ),
                ],
              ),
            ),
            if ([kAMRAPName, kForTimeName]
                .contains(workoutSection.workoutSectionType.name))
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
        ),
        if (workoutSection.isTimed && !isRunning)
          Row(
            children: [
              Expanded(
                child: StartResumeButton(
                  height: 64,
                  sectionIndex: workoutSection.sortPosition,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
