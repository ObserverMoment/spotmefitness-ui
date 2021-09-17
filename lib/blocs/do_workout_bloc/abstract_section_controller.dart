import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// Abstract parent for all workout section type sub controllers.
abstract class WorkoutSectionController {
  final WorkoutSection workoutSection;

  final StopWatchTimer stopWatchTimer;

  /// Broadcast changes to the progress state.
  StreamController<WorkoutSectionProgressState> progressStateController =
      StreamController<WorkoutSectionProgressState>.broadcast();

  Stream<WorkoutSectionProgressState> get progressStream =>
      progressStateController.stream;

  late WorkoutSectionProgressState state;

  bool sectionHasStarted = false;
  bool sectionComplete = false;

  final VoidCallback onCompleteSection;

  WorkoutSectionController(
      {required VoidCallback this.onCompleteSection,
      required WorkoutSection this.workoutSection,
      required this.stopWatchTimer}) {
    state = WorkoutSectionProgressState(workoutSection);
    progressStateController.add(state);
  }

  /// Public method for the user to progress to the next set (or section if this is the last set).
  /// Noop in Timed workouts and Free Session
  void markCurrentWorkoutSetAsComplete();

  @mustCallSuper
  void reset() {
    sectionHasStarted = false;
    sectionComplete = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    state = WorkoutSectionProgressState(workoutSection);
    progressStateController.add(state);
  }

  @mustCallSuper
  void dispose() {
    progressStateController.close();
    stopWatchTimer.dispose();
  }
}
