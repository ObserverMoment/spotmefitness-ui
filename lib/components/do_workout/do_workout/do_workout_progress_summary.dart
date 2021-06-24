import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class DoWorkoutProgressSummary extends StatelessWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  const DoWorkoutProgressSummary(
      {Key? key, required this.workoutSection, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyText('Progress grid'),
        MyText('section round'),
        MyText(state.currentSectionRound.toString()),
        MyText('set index'),
        MyText(state.currentSetIndex.toString()),
      ],
    );
  }
}
