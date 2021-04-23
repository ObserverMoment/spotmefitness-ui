import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_set_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class FreeSessionCreator extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final void Function() createSet;
  FreeSessionCreator(
      {required this.sortedWorkoutSets,
      required this.sectionIndex,
      required this.createSet});

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
                child: WorkoutSetCreator(
                    key: Key(
                        'session_creator-$sectionIndex-${item.sortPosition}'),
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
              CreateTextIconButton(
                text: 'Add Set',
                onPressed: createSet,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
