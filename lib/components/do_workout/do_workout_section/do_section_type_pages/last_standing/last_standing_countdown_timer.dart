import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/timer_components.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_minimal_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// Almost identical to the [AMRAPCountdownTimer].
/// The Circular progress indicator here indicates time remaining to complete the current set, not time remaining until the section timecap like in [AMRAPCountdownTimer].
class LastStandingCountdownTimer extends StatelessWidget {
  final WorkoutSectionProgressState state;
  final WorkoutSection workoutSection;
  const LastStandingCountdownTimer(
      {Key? key, required this.state, required this.workoutSection})
      : super(key: key);

  void _handlePlayPause(BuildContext context) {
    final timer = context
        .read<DoWorkoutBloc>()
        .getStopWatchTimerForSection(workoutSection.sortPosition);
    final isRunning = timer.isRunning;

    timer.onExecute
        .add(isRunning ? StopWatchExecute.stop : StopWatchExecute.start);
  }

  /// currentWorkoutSet.duration should never be null for last standing sets.
  int get _currentSetDuration => workoutSection.workoutSets
      .sortedBy<num>((wSet) => wSet.sortPosition)[state.currentSetIndex]
      .duration;

  double get _currentSetTimeRemaining =>
      1 - (state.timeToNextCheckpointMs! / (_currentSetDuration * 1000));

  Widget _buildWorkoutSetDisplay(WorkoutSet workoutSet) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 6,
          children: workoutSet.workoutMoves
              .map((workoutMove) => ContentBox(
                    child: WorkoutMoveMinimalDisplay(
                      workoutMove: workoutMove,
                      showReps: ![kTabataName, kHIITCircuitName]
                          .contains(workoutSection.workoutSectionType.name),
                    ),
                  ))
              .toList(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final remainingMs = state.timeToNextCheckpointMs!;

    final sortedWorkoutSets =
        workoutSection.workoutSets.sortedBy<num>((wSet) => wSet.sortPosition);

    final currentSet = sortedWorkoutSets[state.currentSetIndex];

    final nextSet = state.currentSetIndex == sortedWorkoutSets.length - 1
        ? sortedWorkoutSets[0]
        : sortedWorkoutSets[state.currentSetIndex + 1];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: EnvironmentConfig.bottomNavBarHeight),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _handlePlayPause(context),
          child: LayoutBuilder(
              builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircularPercentIndicator(
                          header: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                H3('Now: '),
                                _buildWorkoutSetDisplay(currentSet),
                              ],
                            ),
                          ),
                          center: TimerDisplayText(
                            milliseconds: remainingMs,
                            size: 50,
                          ),
                          footer: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    H3('Next: '),
                                    _buildWorkoutSetDisplay(nextSet),
                                  ],
                                ),
                                MyText(
                                  'Tap screen to start / pause',
                                  size: FONTSIZE.SMALL,
                                  subtext: true,
                                )
                              ],
                            ),
                          ),
                          backgroundColor:
                              context.theme.primary.withOpacity(0.1),
                          linearGradient: Styles.pinkGradient,
                          circularStrokeCap: CircularStrokeCap.round,
                          percent: _currentSetTimeRemaining,
                          radius: constraints.maxWidth / 1.8),
                    ],
                  )),
        ),
      ),
    );
  }
}
