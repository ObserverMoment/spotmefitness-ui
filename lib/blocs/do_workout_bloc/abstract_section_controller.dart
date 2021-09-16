import 'dart:async';

import 'package:meta/meta.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc_archived.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// Abstract parent for all workout section type sub controllers.
abstract class WorkoutSectionController {
  /// Broadcast changes to the progress state.
  StreamController<WorkoutSectionProgressState> progressStateController =
      StreamController<WorkoutSectionProgressState>.broadcast();

  Stream<WorkoutSectionProgressState> get progressStream =>
      progressStateController.stream;

  late WorkoutSectionProgressState state;

  /// The log that will be generated incrementally as the workout progresses.
  /// Can be retrieved by the [DoWorkoutBloc] at any stage to be added to the main [LoggedWorkout.loggedWorkoutSections] list.
  late LoggedWorkoutSection loggedWorkoutSection;

  /// The sorted sets from the WorkoutSection.
  late List<WorkoutSet> sortedWorkoutSets;

  /// Used to know when to move forward one set and when to move to the next section round.
  late int numberSetsPerSection;

  final void Function() markSectionComplete;

  final WorkoutSection workoutSection;
  final StopWatchTimer stopWatchTimer;

  bool sectionComplete = false;

  WorkoutSectionController(
      {required void Function() this.markSectionComplete,
      required WorkoutSection this.workoutSection,
      required this.stopWatchTimer}) {
    sortedWorkoutSets = workoutSection.workoutSets;
    numberSetsPerSection = sortedWorkoutSets.length;

    state = WorkoutSectionProgressState(workoutSection);
    progressStateController.add(state);
  }

  /// Public method for the user to progress to the next set (or section if this is the last set).
  /// Noop in Timed workouts and Free Session
  void markCurrentWorkoutSetAsComplete();

  @mustCallSuper
  void reset() {
    sectionComplete = false;
    state = WorkoutSectionProgressState(workoutSection);
    progressStateController.add(state);
  }

  @mustCallSuper
  void dispose() {
    progressStateController.close();
    stopWatchTimer.dispose();
  }
}
