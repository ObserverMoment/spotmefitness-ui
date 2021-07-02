import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Although it extends [WorkoutSectionController] it is not very similar...
/// Allows updating of sets and moves (just load and reps for moves) of the [WorkoutSection] during the workout. Hence why the [ChangeNotfier] mixin is being used.
/// When they are ready the user can move sets across from the workout section and into the log. [loggedWorkoutSection.loggedWorkoutSets] is emptied in the [WorkoutSectionController] constructor.
class FreeSessionSectionController extends WorkoutSectionController
    with ChangeNotifier {
  FreeSessionSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete})
      : super(
            workoutSection: workoutSection,
            stopWatchTimer: stopWatchTimer,
            markSectionComplete: markSectionComplete);

  void markWorkoutSetComplete(BuildContext context, WorkoutSet workoutSet) {
    loggedWorkoutSection.loggedWorkoutSets
        .add(workoutSetToLoggedWorkoutSet(workoutSet, 0));
    notifyListeners();
    context.showToast(message: 'Set Completed!');
  }

  void markWorkoutSetIncomplete(WorkoutSet workoutSet) {
    loggedWorkoutSection.loggedWorkoutSets
        .removeWhere((lwSet) => lwSet.sortPosition == workoutSet.sortPosition);
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
