import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DoWorkoutProgressSummary extends StatelessWidget {
  const DoWorkoutProgressSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WorkoutProgressState>(
        initialData: context.read<DoWorkoutBloc>().getProgressState(),
        stream: context.read<DoWorkoutBloc>().progressStateStream,
        builder: (context, AsyncSnapshot<WorkoutProgressState> snapshot) {
          return Column(
            children: [
              MyText('Progress grid'),
              MyText('section index'),
              MyText(snapshot.data!.currentSectionIndex.toString()),
              MyText('section round'),
              MyText(snapshot.data!.currentSectionRound.toString()),
              MyText('set index'),
              MyText(snapshot.data!.currentSetIndex.toString()),
              MyText('set round'),
              MyText(snapshot.data!.currentSetRound.toString()),
            ],
          );
        });
  }
}
