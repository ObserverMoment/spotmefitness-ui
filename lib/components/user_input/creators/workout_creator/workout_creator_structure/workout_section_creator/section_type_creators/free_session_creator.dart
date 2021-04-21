import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_set_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

class FreeSessionCreator extends StatefulWidget {
  final int sectionIndex;
  FreeSessionCreator(this.sectionIndex);

  @override
  _FreeSessionCreatorState createState() => _FreeSessionCreatorState();
}

class _FreeSessionCreatorState extends State<FreeSessionCreator> {
  late List<WorkoutSet> _sortedWorkoutSets;
  late WorkoutCreatorBloc _bloc;

  void _checkForNewData() {
    if (_bloc.workout.workoutSections.length > widget.sectionIndex) {
      final updated =
          _bloc.workout.workoutSections[widget.sectionIndex].workoutSets;

      if (!_sortedWorkoutSets.equals(updated)) {
        setState(() {
          _sortedWorkoutSets = updated.sortedBy<num>((ws) => ws.sortPosition);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutCreatorBloc>();
    _sortedWorkoutSets = _bloc
        .workout.workoutSections[widget.sectionIndex].workoutSets
        .sortedBy<num>((ws) => ws.sortPosition);
    _bloc.addListener(_checkForNewData);
  }

  @override
  void dispose() {
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  void _createSet() {
    // Create default set.
    _bloc.createWorkoutSet(widget.sectionIndex);
    // Open workout move creator to add first move.
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: _bloc,
          child: WorkoutMoveCreator(
            pageTitle: 'Add Set',
            sectionIndex: widget.sectionIndex,
            setIndex: _sortedWorkoutSets.length - 1,
            workoutMoveIndex: 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(shrinkWrap: true, children: [
        ImplicitlyAnimatedList<WorkoutSet>(
          items: _sortedWorkoutSets,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          areItemsTheSame: (a, b) => a.id == b.id,
          itemBuilder: (context, animation, item, index) {
            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: animation,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: WorkoutSetCreator(
                    key: Key(
                        'session_creator-${widget.sectionIndex}-${item.sortPosition}'),
                    sectionIndex: widget.sectionIndex,
                    setIndex: item.sortPosition,
                    allowReorder: _sortedWorkoutSets.length > 1),
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
                onPressed: _createSet,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
