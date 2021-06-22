import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_progress_summary.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_instructions.dart';
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
          child: StreamBuilder<StopWatchExecute>(
              initialData: StopWatchExecute.stop,
              stream: getStopWatchTimerForSection(workoutSection.sortPosition)
                  .execute,
              builder: (context, AsyncSnapshot<StopWatchExecute> snapshot) =>
                  AnimatedSwitcher(
                      duration: kStandardAnimationDuration,
                      child: snapshot.data == StopWatchExecute.start
                          ? CupertinoButton(
                              onPressed: () => getStopWatchTimerForSection(
                                      workoutSection.sortPosition)
                                  .onExecute
                                  .add(StopWatchExecute.stop),
                              child: Icon(
                                CupertinoIcons.pause_fill,
                                size: kNavbarIconSize,
                              ),
                            )
                          : CupertinoButton(
                              onPressed: () => getStopWatchTimerForSection(
                                      workoutSection.sortPosition)
                                  .onExecute
                                  .add(StopWatchExecute.start),
                              child: Icon(
                                CupertinoIcons.play_arrow_solid,
                                size: kNavbarIconSize,
                              ),
                            ))),
        )
      ],
    );
  }
}

class DoWorkoutSection extends StatefulWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSection({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  _DoWorkoutSectionState createState() => _DoWorkoutSectionState();
}

class _DoWorkoutSectionState extends State<DoWorkoutSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WorkoutSectionInstructions(
            typeName: widget.workoutSection.workoutSectionType.name,
            rounds: widget.workoutSection.rounds,
            timecap: widget.workoutSection.timecap,
          ),
        ),
        Expanded(
          child: PageView(
            children: [
              DoWorkoutMovesList(workoutSection: widget.workoutSection),
              DoWorkoutProgressSummary(),
              MyText('Timer + lap times for sets and sections'),
            ],
          ),
        )
      ],
    );
  }
}
