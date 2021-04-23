import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_station_set_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class CircuitCreator extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final void Function(Map<String, dynamic> defaults)
      createWorkoutSetWithDuration;
  CircuitCreator(
      {required this.sortedWorkoutSets,
      required this.sectionIndex,
      required this.createWorkoutSetWithDuration});

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
                child: WorkoutStationSetCreator(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CreateTextIconButton(
                text: 'Add Station',
                onPressed: () =>
                    createWorkoutSetWithDuration({'duration': 60}), // Seconds
              ),
              if (sortedWorkoutSets.isNotEmpty)
                FadeIn(
                  child: CreateTextIconButton(
                    text: 'Add Rest',
                    onPressed: () => print('add rest'),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
