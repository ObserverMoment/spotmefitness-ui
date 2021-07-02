import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_circuit_set_creator.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_instructions.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class CircuitCreator extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final int totalRounds;
  final void Function(Map<String, dynamic> defaults) createWorkoutSet;
  final void Function(Move move, Duration duration) createRestSet;

  CircuitCreator({
    required this.sortedWorkoutSets,
    required this.sectionIndex,
    required this.totalRounds,
    required this.createWorkoutSet,
    required this.createRestSet,
  });

  @override
  Widget build(BuildContext context) {
    final creatingSet =
        context.select<WorkoutCreatorBloc, bool>((b) => b.creatingSet);

    return Flexible(
        child: QueryObserver<StandardMoves$Query, json.JsonSerializable>(
            key: Key('CircuitCreator - ${StandardMovesQuery().operationName}'),
            query: StandardMovesQuery(),
            fetchPolicy: QueryFetchPolicy.storeFirst,
            builder: (data) {
              /// Need to get the Move [Rest] for use when user taps [+ Add Rest]
              final rest =
                  data.standardMoves.firstWhere((m) => m.id == kRestMoveId);

              return ListView(shrinkWrap: true, children: [
                if (sortedWorkoutSets.isNotEmpty)
                  FadeIn(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 24, right: 24),
                      child: WorkoutSectionInstructions(
                          typeName: kHIITCircuitName, rounds: totalRounds),
                    ),
                  ),
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
                        child: WorkoutCircuitSetCreator(
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
                        loading: creatingSet,
                        onPressed: () =>
                            createWorkoutSet({'duration': 60}), // Seconds
                      ),
                      if (sortedWorkoutSets.isNotEmpty)
                        FadeIn(
                          child: CreateTextIconButton(
                            text: 'Add Rest',
                            loading: creatingSet,
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
