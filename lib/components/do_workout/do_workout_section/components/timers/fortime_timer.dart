import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/name_and_repscore.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/now_and_next_moves.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// A minute based timer like iOS timer. The outer circles fills over a one minute period.
/// Counts up from zero.
class ForTimeTimer extends StatelessWidget {
  final WorkoutSectionProgressState state;
  final WorkoutSection workoutSection;
  const ForTimeTimer(
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
          final seconds = snapshot.data!;

          /// Get the remaining seconds in the minute.
          final remainingOfCurrentMinute = (seconds % 60) / 60;

          /// Get the display time.
          final overAnHour = seconds > 3600;
          final displayTime = StopWatchTimer.getDisplayTime(seconds * 1000,
              milliSecond: false, hours: overAnHour);

          return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              NameAndRepScore(workoutSection: workoutSection)
                            ],
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, bottom: 10),
                              child: CircularPercentIndicator(
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyText(
                                        'Elapsed',
                                        subtext: true,
                                        size: FONTSIZE.TINY,
                                      ),
                                      SizedBox(height: 4),
                                      MyText(
                                        displayTime,
                                        size: FONTSIZE.DISPLAY,
                                        lineHeight: 1,
                                      ),
                                      SizedBox(height: 4),
                                      MyText(
                                        'Tap to ${isRunning ? "pause" : "play"}',
                                        size: FONTSIZE.TINY,
                                        lineHeight: 1,
                                        subtext: true,
                                      ),
                                    ],
                                  ),
                                  backgroundColor:
                                      context.theme.primary.withOpacity(0.15),
                                  linearGradient: Styles.neonBlueGradient,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  percent: remainingOfCurrentMinute,
                                  radius: constraints.maxWidth / 1.5),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        NowAndNextMoves(workoutSection: workoutSection),
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}
