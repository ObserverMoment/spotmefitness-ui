import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/timers/timer_components.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

class DoWorkoutSectionTimer extends StatelessWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSectionTimer({Key? key, required this.workoutSection})
      : super(key: key);

  final kNavbarIconSize = 34.0;

  @override
  Widget build(BuildContext context) {
    final getStopWatchTimerForSection =
        context.read<DoWorkoutBloc>().getStopWatchTimerForSection;

    return StreamBuilder<int>(
        initialData: 0,
        stream:
            getStopWatchTimerForSection(workoutSection.sortPosition).rawTime,
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
            ));
  }
}
