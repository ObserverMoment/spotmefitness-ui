import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/name_and_repscore.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/now_and_next_moves.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/workout_section_simple_timer.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/radial_countdown_timer.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MainVideoOverlay extends StatelessWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  const MainVideoOverlay(
      {Key? key, required this.workoutSection, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutSectionTypeName = workoutSection.workoutSectionType.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _VideoOverlayContainer(
              child: NameAndRepScore(workoutSection: workoutSection),
            ),
            workoutSectionTypeName == kForTimeName
                ? _VideoOverlayContainer(
                    child: WorkoutSectionSimpleTimer(
                        workoutSection: workoutSection,
                        fontSize: FONTSIZE.HUGE,
                        showElapsedLabel: true))
                : _CircleTimerDisplay(
                    workoutSection: workoutSection,
                    state: state,
                  ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: NowAndNextMoves(workoutSection: workoutSection),
        ),
      ],
    );
  }
}

/// Use for timed sections and for AMRAPs only.
/// For timed sections the checkpoint is the set the user is on.
/// For AMRAP the checkpoint is the timecap.
class _CircleTimerDisplay extends StatelessWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  const _CircleTimerDisplay(
      {Key? key, required this.workoutSection, required this.state})
      : super(key: key);

  /// Set.duration if timed workout or section timecap if AMRAP.
  int get _currentCheckpointLength => workoutSection.isTimed
      ? workoutSection.workoutSets[state.currentSetIndex].duration
      : workoutSection.timecap;

  @override
  Widget build(BuildContext context) {
    final secondsToNextCheckpoint = context.select<DoWorkoutBloc, int>((b) => b
        .getControllerForSection(workoutSection.sortPosition)
        .state
        .secondsToNextCheckpoint!);

    /// Get the display time.
    final overAnHour = secondsToNextCheckpoint > 3600;
    final displayTime = StopWatchTimer.getDisplayTime(
        secondsToNextCheckpoint * 1000,
        milliSecond: false,
        hours: overAnHour);

    return Stack(
      alignment: Alignment.center,
      children: [
        RadialCountdownTimer(
            size: 70,
            value: (1 - (secondsToNextCheckpoint / _currentCheckpointLength))
                .clamp(0.0, 1.0),
            fullBackground: true,
            progressColor: Styles.neonBlueOne,
            backgroundColor: Styles.neonBlueOne.withOpacity(0.3)),
        MyText(
          displayTime,
          size: FONTSIZE.BIG,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}

/// A semi opaque background so that text etc can be seen against a video background.
class _VideoOverlayContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _VideoOverlayContainer(
      {Key? key, required this.child, this.padding = kDefaultTagPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: context.theme.cardBackground.withOpacity(0.4)),
      child: child,
    );
  }
}
