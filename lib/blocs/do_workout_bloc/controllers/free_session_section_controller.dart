import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// Although it extends [WorkoutSectionController] it is not very similar...
/// Allows updating of sets (rounds) and moves (load and reps for moves) by updating the main [activeWorkout] object in the [DoWorkoutBloc].
/// The controller maintains a list of completed workoutSet Ids.
class FreeSessionSectionController extends WorkoutSectionController
    with ChangeNotifier {
  List<String> completedWorkoutSetIds = [];

  FreeSessionSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() onCompleteSection})
      : super(
            workoutSection: workoutSection,
            stopWatchTimer: stopWatchTimer,
            onCompleteSection: onCompleteSection);

  void markWorkoutSetComplete(WorkoutSet workoutSet) {
    completedWorkoutSetIds.add(workoutSet.id);
    state.updateSectionRoundSetDataFromCompletedSets(workoutSection.workoutSets
        .where((wSet) => completedWorkoutSetIds.contains(wSet.id))
        .toList());
    notifyListeners();
  }

  void markWorkoutSetIncomplete(WorkoutSet workoutSet) {
    completedWorkoutSetIds.remove(workoutSet.id);
    state.updateSectionRoundSetDataFromCompletedSets(workoutSection.workoutSets
        .where((wSet) => completedWorkoutSetIds.contains(wSet.id))
        .toList());
    notifyListeners();
  }

  void updateWorkoutSetRepeats(int setSortPosition, int rounds) {
    final setToUpdate = workoutSection.workoutSets
        .firstWhere((wSet) => wSet.sortPosition == setSortPosition);
    setToUpdate.rounds = rounds;

    workoutSection.workoutSets = workoutSection.workoutSets
        .map((o) => setSortPosition == o.sortPosition ? setToUpdate : o)
        .toList();

    notifyListeners();
  }

  void addNewWorkoutSet() {}

  void updateWorkoutMove(int setSortPosition, WorkoutMove workoutMove) {
    final setToUpdate = workoutSection.workoutSets
        .firstWhere((wSet) => wSet.sortPosition == setSortPosition);

    setToUpdate.workoutMoves = setToUpdate.workoutMoves
        .map((o) => o.id == workoutMove.id ? workoutMove : o)
        .toList();

    workoutSection.workoutSets = workoutSection.workoutSets
        .map((o) => setSortPosition == o.sortPosition ? setToUpdate : o)
        .toList();
    notifyListeners();
  }

  @override
  void markCurrentWorkoutSetAsComplete() {
    /// Noop. use [markWorkoutSetComplete].
  }
}
