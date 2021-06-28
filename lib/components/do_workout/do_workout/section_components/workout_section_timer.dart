import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutSectionTimer extends StatelessWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSectionTimer({Key? key, required this.workoutSection})
      : super(key: key);

  final kNavbarIconSize = 38.0;

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
        StreamBuilder<int>(
            initialData: 0,
            stream: getStopWatchTimerForSection(workoutSection.sortPosition)
                .rawTime,
            builder: (context, AsyncSnapshot<int> snapshot) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      'Elapsed',
                      textAlign: TextAlign.right,
                      size: FONTSIZE.TINY,
                      subtext: true,
                      lineHeight: 0.4,
                    ),
                    Text(
                        StopWatchTimer.getDisplayTime(snapshot.data ?? 0,
                            milliSecond: false),
                        style: GoogleFonts.courierPrime(
                            letterSpacing: -3,
                            textStyle: TextStyle(
                              color: context.theme.primary,
                              fontSize: 44,
                            ))),
                  ],
                )),
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
                      color: Styles.peachRed,
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
                                        onPressed: () =>
                                            getStopWatchTimerForSection(
                                                    workoutSection.sortPosition)
                                                .onExecute
                                                .add(StopWatchExecute.stop),
                                        child: Icon(
                                          CupertinoIcons.pause_fill,
                                          size: kNavbarIconSize,
                                        ),
                                      )
                                    : CupertinoButton(
                                        onPressed: () =>
                                            getStopWatchTimerForSection(
                                                    workoutSection.sortPosition)
                                                .onExecute
                                                .add(StopWatchExecute.start),
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
