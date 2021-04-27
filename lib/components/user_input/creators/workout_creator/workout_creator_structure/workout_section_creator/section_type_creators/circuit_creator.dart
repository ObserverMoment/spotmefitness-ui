import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_station_set_creator.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';

class CircuitCreator extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final void Function(Map<String, dynamic> defaults) createWorkoutSet;
  final void Function(Move move, Duration duration) createRestSet;
  CircuitCreator({
    required this.sortedWorkoutSets,
    required this.sectionIndex,
    required this.createWorkoutSet,
    required this.createRestSet,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: QueryResponseBuilder(
            options: QueryOptions(
                fetchPolicy: FetchPolicy.cacheFirst,
                document: StandardMovesQuery().document),
            builder: (result, {fetchMore, refetch}) {
              /// Need to get the Move [Rest] for use when user taps [+ Add Rest]
              final moves =
                  StandardMoves$Query.fromJson(result.data ?? {}).standardMoves;
              final rest = moves.firstWhere((m) => m.id == kRestMoveId);

              return ListView(shrinkWrap: true, children: [
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6),
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
                            createWorkoutSet({'duration': 60}), // Seconds
                      ),
                      if (sortedWorkoutSets.isNotEmpty)
                        FadeIn(
                          child: CreateTextIconButton(
                            text: 'Add Rest',
                            onPressed: () =>
                                createRestSet(rest, Duration(seconds: 30)),
                          ),
                        ),
                    ],
                  ),
                ),
              ]);
            }));
  }
}
