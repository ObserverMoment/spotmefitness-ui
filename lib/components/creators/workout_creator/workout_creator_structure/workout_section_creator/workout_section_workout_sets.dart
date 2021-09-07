import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_creator/workout_set_creator.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutSectionWorkoutSets extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final WorkoutSectionType workoutSectionType;

  const WorkoutSectionWorkoutSets({
    required this.sortedWorkoutSets,
    required this.sectionIndex,
    required this.workoutSectionType,
  });

  Future<void> _createWorkoutSet(BuildContext context) async {
    await context.read<WorkoutCreatorBloc>().createWorkoutSet(sectionIndex);
    await _openWorkoutMoveCreator(context);
  }

  Future<void> _openWorkoutMoveCreator(BuildContext context) async {
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    await context.push(
        child: WorkoutMoveCreator(
      pageTitle: 'Add Set',
      saveWorkoutMove: (workoutMove) => _saveWorkoutMove(context, workoutMove),
      workoutMoveIndex: 0,
    ));
  }

  Future<void> _saveWorkoutMove(
      BuildContext context, WorkoutMove workoutMove) async {
    context
        .read<WorkoutCreatorBloc>()
        .createWorkoutMove(sectionIndex, sortedWorkoutSets.length, workoutMove);
  }

  @override
  Widget build(BuildContext context) {
    final creatingSet =
        context.select<WorkoutCreatorBloc, bool>((b) => b.creatingSet);

    return Flexible(
      child: ListView(shrinkWrap: true, children: [
        ImplicitlyAnimatedList<WorkoutSet>(
          items: sortedWorkoutSets,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          areItemsTheSame: (a, b) => a.id == b.id,
          itemBuilder: (context, animation, item, index) {
            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: animation,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                child: WorkoutSetCreator(
                    key: Key(
                        'WorkoutSectionWorkoutSets-$sectionIndex-${item.sortPosition}'),
                    sectionIndex: sectionIndex,
                    setIndex: item.sortPosition,
                    allowReorder: sortedWorkoutSets.length > 1),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if ([kFreeSessionName, kAMRAPName, kForTimeName]
                  .contains(workoutSectionType.name))
                CreateTextIconButton(
                  text: 'Add Set',
                  loading: creatingSet,
                  onPressed: () => _createWorkoutSet(context),
                ),
              if (kHIITCircuitName == workoutSectionType.name)
                CreateTextIconButton(
                  text: 'Add Station',
                  loading: creatingSet,
                  onPressed: () => print('create set with 60 seconds'),
                ),
              if (kHIITCircuitName == workoutSectionType.name)
                CreateTextIconButton(
                  text: 'Add Rest',
                  loading: creatingSet,
                  onPressed: () => print('create rest with 30 seconds'),
                ),
              if ([kEMOMName, kLastStandingName]
                  .contains(workoutSectionType.name))
                CreateTextIconButton(
                  text: 'Add Period',
                  loading: creatingSet,
                  onPressed: () => print('create set with 60 seconds'),
                ),
              if (kTabataName == workoutSectionType.name)
                CreateTextIconButton(
                  text: 'Add Set',
                  loading: creatingSet,
                  onPressed: () => print('create set with 20 seconds'),
                ),
              if (kTabataName == workoutSectionType.name)
                CreateTextIconButton(
                  text: 'Add Rest',
                  loading: creatingSet,
                  onPressed: () => print('create rest with 10 seconds'),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
