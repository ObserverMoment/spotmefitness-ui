import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DoWorkoutProgressSummary extends StatelessWidget {
  const DoWorkoutProgressSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressState = context.select<DoWorkoutBloc, WorkoutProgressState>(
        (b) => b.getProgressState());

    return Column(
      children: [
        MyText('Progress grid'),
        MyText('section index'),
        MyText(progressState.currentSectionIndex.toString()),
        MyText('section round'),
        MyText(progressState.currentSectionRound.toString()),
        MyText('set index'),
        MyText(progressState.currentSetIndex.toString()),
        MyText('set round'),
        MyText(progressState.currentSetRound.toString()),
      ],
    );
  }
}
