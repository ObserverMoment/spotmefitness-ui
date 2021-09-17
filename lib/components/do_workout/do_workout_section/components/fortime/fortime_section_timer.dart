import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/fortime_rep_score.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// A minute based timer like iOS timer. The outer circles fills over a one minute period.
class ForTimeSectionTimer extends StatelessWidget {
  final WorkoutSectionProgressState state;
  final WorkoutSection workoutSection;
  const ForTimeSectionTimer(
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

    final sortedWorkoutSets =
        workoutSection.workoutSets.sortedBy<num>((wSet) => wSet.sortPosition);

    final currentSet = sortedWorkoutSets[state.currentSetIndex];

    final nextSet = state.currentSetIndex == sortedWorkoutSets.length - 1
        ? sortedWorkoutSets[0]
        : sortedWorkoutSets[state.currentSetIndex + 1];

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
                        SizedBox(height: 26),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            CircularPercentIndicator(
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(
                                      'Elapsed',
                                      subtext: true,
                                      size: FONTSIZE.SMALL,
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
                                radius: constraints.maxWidth / 1.6),
                            Positioned(
                                top: 0,
                                right: -(constraints.maxWidth * 0.13),
                                child: ForTimeRepsScore(
                                  sectionIndex: workoutSection.sortPosition,
                                )),
                            Positioned(
                                top: 0,
                                left: -(constraints.maxWidth * 0.13),
                                child: MyHeaderText('FOR TIME'))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyHeaderText('Now:'),
                              SizedBox(height: 6),
                              SizeFadeIn(
                                key: Key(currentSet.id),
                                child: WorkoutSetDisplay(
                                    workoutSet: currentSet,
                                    workoutSectionType:
                                        workoutSection.workoutSectionType),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyHeaderText('Next:'),
                              SizedBox(height: 6),
                              SizeFadeIn(
                                key: Key(nextSet.id),
                                child: WorkoutSetDisplay(
                                    workoutSet: nextSet,
                                    workoutSectionType:
                                        workoutSection.workoutSectionType),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}
