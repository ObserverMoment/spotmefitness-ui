import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/name_and_repscore.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/now_and_next_moves.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/radial_countdown_timer.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Counts up from zero. The circle fills as the time approaches the end of the current set / interval.
/// Outer circle fills as percentage of the total workout complete.
class IntervalTimer extends StatelessWidget {
  final WorkoutSectionProgressState state;
  final WorkoutSection workoutSection;
  const IntervalTimer(
      {Key? key, required this.state, required this.workoutSection})
      : super(key: key);

  void _handlePlayPause(BuildContext context, bool isRunning) {
    if (isRunning) {
      context.read<DoWorkoutBloc>().pauseSection(workoutSection.sortPosition);
    } else {
      context.read<DoWorkoutBloc>().playSection(workoutSection.sortPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = context.select<DoWorkoutBloc, bool>((b) =>
        b.getStopWatchTimerForSection(workoutSection.sortPosition).isRunning);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handlePlayPause(context, isRunning),
      child: StreamBuilder<int>(
        initialData: 0,
        stream: context
            .read<DoWorkoutBloc>()
            .getStopWatchTimerForSection(workoutSection.sortPosition)
            .secondTime,
        builder: (context, AsyncSnapshot<int> snapshot) {
          final secondsElapsed = snapshot.data!;

          /// Get the display time.
          final overAnHour = secondsElapsed > 3600;
          final totalElapsed = StopWatchTimer.getDisplayTime(
              secondsElapsed * 1000,
              milliSecond: false,
              hours: overAnHour);

          final remainingIntervalTime = StopWatchTimer.getDisplayTime(
              state.secondsToNextCheckpoint! * 1000,
              milliSecond: false,
              hours: overAnHour);

          final intervalDuration =
              workoutSection.workoutSets[state.currentSetIndex].duration;

          final remainingPercentCurrentInterval =
              ((intervalDuration - state.secondsToNextCheckpoint!) /
                      intervalDuration)
                  .clamp(0.0, 1.0);

          return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NameAndRepScore(workoutSection: workoutSection),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(
                                    'Elapsed',
                                    subtext: true,
                                    size: FONTSIZE.TINY,
                                  ),
                                  MyText(
                                    totalElapsed,
                                    size: FONTSIZE.DISPLAYSMALL,
                                    lineHeight: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularPercentIndicator(
                                backgroundColor:
                                    context.theme.primary.withOpacity(0.15),
                                linearGradient: Styles.neonBlueGradient,
                                circularStrokeCap: CircularStrokeCap.round,
                                percent: state.percentComplete,
                                radius: constraints.maxWidth / 1.5),
                            RadialCountdownTimer(
                              size: constraints.maxWidth / 1.5,
                              value: remainingPercentCurrentInterval,
                              progressColor: Styles.neonBlueOne,
                              hideOutline: true,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  remainingIntervalTime,
                                  size: FONTSIZE.DISPLAY,
                                ),
                                SizedBox(height: 8),
                                MyText(
                                  'Tap to ${isRunning ? "pause" : "play"}',
                                  size: FONTSIZE.SMALL,
                                  lineHeight: 1,
                                  subtext: true,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        NowAndNextMoves(workoutSection: workoutSection),
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}
