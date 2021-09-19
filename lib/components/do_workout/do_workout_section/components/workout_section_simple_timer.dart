import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/timers/timer_components.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

/// Simple text display of the time elapsed so far.
class WorkoutSectionSimpleTimer extends StatelessWidget {
  final WorkoutSection workoutSection;
  final bool showElapsedLabel;
  final FONTSIZE fontSize;
  const WorkoutSectionSimpleTimer(
      {Key? key,
      required this.workoutSection,
      this.showElapsedLabel = true,
      this.fontSize = FONTSIZE.DISPLAY})
      : super(key: key);

  final kNavbarIconSize = 34.0;

  @override
  Widget build(BuildContext context) {
    final getStopWatchTimerForSection =
        context.read<DoWorkoutBloc>().getStopWatchTimerForSection;

    return StreamBuilder<int>(
        initialData: 0,
        stream:
            getStopWatchTimerForSection(workoutSection.sortPosition).secondTime,
        builder: (context, AsyncSnapshot<int> snapshot) {
          final seconds = snapshot.data ?? 0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showElapsedLabel)
                MyText(
                  'Elapsed',
                  size: FONTSIZE.TINY,
                  subtext: true,
                ),
              TimerDisplayText(
                milliseconds: seconds * 1000,
                fontSize: fontSize,
                showHours: seconds > 3600,
              ),
            ],
          );
        });
  }
}
