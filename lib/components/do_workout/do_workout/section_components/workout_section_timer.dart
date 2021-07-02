import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/timers/timer_components.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class DoWorkoutSectionTimer extends StatelessWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSectionTimer({Key? key, required this.workoutSection})
      : super(key: key);

  final kNavbarIconSize = 34.0;

  @override
  Widget build(BuildContext context) {
    final getStopWatchTimerForSection =
        context.read<DoWorkoutBloc>().getStopWatchTimerForSection;

    final sectionIsComplete =
        context.select<DoWorkoutBloc, LoggedWorkoutSection?>(
            (b) => b.completedSections[workoutSection.sortPosition]);

    final sectionHasStarted = context.select<DoWorkoutBloc, bool>(
        (b) => b.startedSections[workoutSection.sortPosition]);

    return Stack(
      alignment: Alignment.center,
      children: [
        /// Timer will run during a free session but there is no need to show a display.
        workoutSection.workoutSectionType.name != kFreeSessionName
            ? StreamBuilder<int>(
                initialData: 0,
                stream: getStopWatchTimerForSection(workoutSection.sortPosition)
                    .rawTime,
                builder: (context, AsyncSnapshot<int> snapshot) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          'Elapsed',
                          size: FONTSIZE.TINY,
                          subtext: true,
                          lineHeight: 0.8,
                        ),
                        TimerDisplayText(
                          milliseconds: snapshot.data ?? 0,
                          size: 32,
                          showHours: true,
                        ),
                      ],
                    ))
            : NavBarTitle('Free Session'),
        Positioned(
          right: 0,
          child: AnimatedSwitcher(
            duration: kStandardAnimationDuration,
            child: sectionIsComplete != null
                ? SizeFadeIn(
                    child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      size: kNavbarIconSize,
                      color: Styles.pink,
                    ),
                  ))
                : StreamBuilder<StopWatchExecute>(
                    initialData: StopWatchExecute.stop,
                    stream:
                        getStopWatchTimerForSection(workoutSection.sortPosition)
                            .execute,
                    builder: (context,
                            AsyncSnapshot<StopWatchExecute> snapshot) =>
                        AnimatedSwitcher(
                            duration: kStandardAnimationDuration,
                            child: sectionHasStarted
                                ? snapshot.data == StopWatchExecute.start
                                    ? CupertinoButton(
                                        onPressed: () => context
                                            .read<DoWorkoutBloc>()
                                            .pauseSection(
                                                workoutSection.sortPosition),
                                        child: Icon(
                                          CupertinoIcons.pause_fill,
                                          size: kNavbarIconSize,
                                        ),
                                      )
                                    : CupertinoButton(
                                        onPressed: () => context
                                            .read<DoWorkoutBloc>()
                                            .playSection(
                                                workoutSection.sortPosition),
                                        child: Icon(
                                          CupertinoIcons.play_arrow_solid,
                                          size: kNavbarIconSize,
                                        ),
                                      )
                                : Container())),
          ),
        )
      ],
    );
  }
}
