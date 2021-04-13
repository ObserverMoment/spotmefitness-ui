import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_move_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class FreeSessionCreator extends StatelessWidget {
  final int sectionIndex;
  FreeSessionCreator(this.sectionIndex);

  void _createSet(BuildContext context) {
    final bloc = context.read<WorkoutCreatorBloc>();
    // Create default set.
    bloc.createSet(sectionIndex);
    // Open workout move creator to add first move.
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: bloc,
          child: WorkoutMoveCreator(
            sectionIndex: sectionIndex,
            setIndex: bloc
                .workoutData.workoutSections[sectionIndex].workoutSets.length,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutSets = context.select<WorkoutCreatorBloc, List<WorkoutSet>>(
        (bloc) => bloc.workoutData.workoutSections[sectionIndex].workoutSets);

    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: workoutSets.length,
            itemBuilder: (context, index) =>
                MyText(workoutSets[index].sortPosition.toString())),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateTextIconButton(
                text: 'Add Set',
                onPressed: () => _createSet(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
