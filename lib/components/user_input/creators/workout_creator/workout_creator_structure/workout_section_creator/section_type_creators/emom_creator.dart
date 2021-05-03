import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_emom_set_creator.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_instructions.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

/// [emom] section has rounds but no timecap (it is a non competitive timed workout)
/// [lastOneStanding]  section has timecap but no rounds (it is a competitive, potentially open ended workout - i.e. the timecap is optional).
/// Used for creating [EMOM], [Last One Standing].
class EMOMCreator extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final int totalRounds;
  final int? timecap;
  final void Function(Map<String, dynamic> defaults) createSet;
  final WorkoutSectionType workoutSectionType;

  EMOMCreator(
      {required this.sortedWorkoutSets,
      required this.totalRounds,
      required this.sectionIndex,
      this.timecap,
      required this.workoutSectionType,
      required this.createSet})
      : assert([kEMOMName, kLastStandingName].contains(workoutSectionType.name),
            'EMOMCreator can only be used for EMOMs and Last One Standing Workouts, not ${workoutSectionType.name}.');

  @override
  Widget build(BuildContext context) {
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
                child: WorkoutEMOMSetCreator(
                    key: Key('emom_creator-$sectionIndex-${item.sortPosition}'),
                    sectionIndex: sectionIndex,
                    setIndex: item.sortPosition,
                    allowReorder: sortedWorkoutSets.length > 1),
              ),
            );
          },
        ),
        if (sortedWorkoutSets.isNotEmpty)
          FadeIn(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WorkoutSectionInstructions(
                typeName: workoutSectionType.name,
                rounds: totalRounds,
                timecap: timecap,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateTextIconButton(
                text: 'Add Period',
                loading: context
                    .select<WorkoutCreatorBloc, bool>((b) => b.creatingSet),
                onPressed: () => createSet({'duration': 60}),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
