import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_editable_display.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_move_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

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
            setIndex: bloc.workoutData.workoutSections[sectionIndex].workoutSets
                    .length -
                1,
            workoutMoveIndex: 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutSets = context.select<WorkoutCreatorBloc, List<WorkoutSet>>(
        (bloc) => bloc.workoutData.workoutSections[sectionIndex].workoutSets);

    final List<WorkoutSet> _sortedSets =
        workoutSets.sortedBy<num>((ws) => ws.sortPosition);

    return Expanded(
      child: ListView(shrinkWrap: true, children: [
        ..._sortedSets
            .map((ws) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: WorkoutSetEditableDisplay(
                    sectionIndex: sectionIndex,
                    setIndex: ws.sortPosition,
                  ),
                ))
            .toList(),
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
      ]),
    );
  }
}
