import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/timed_workout_controller.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Delegates to the correct sub bloc types for each workout section
/// As required by the workoutSectionType
class DoWorkoutBloc extends ChangeNotifier {
  late BuildContext _context;
  late LoggedWorkout _loggedWorkout;
  late Workout _originalWorkout;
  WorkoutProgressState _progressState = WorkoutProgressState();

  /// List of timers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  late List<StopWatchTimer> _stopWatchTimers;

  /// List of controllers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  /// Each section type has a sub controller that extends [WorkoutSectionController]
  /// Need to ensure that one only at a time is playing.
  late List<WorkoutSectionController> _controllers;

  /// At completed LoggedWorkoutSection at index [workoutSection.sortPosition] when completed.
  late List<LoggedWorkoutSection?> completedSections;

  /// If false then an intro modal will show over the section page letting the user start the workout with countdown.
  late List<bool> startedSections;

  DoWorkoutBloc({required BuildContext context, required Workout workout}) {
    _context = context;
    _originalWorkout = workout;
    _loggedWorkout =
        DefaultObjectfactory.defaultLoggedWorkout(workout: workout);

    final sortedSections = workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition);

    completedSections = sortedSections.map((wSection) => null).toList();
    startedSections = sortedSections.map((wSection) => false).toList();

    /// One per section.
    _stopWatchTimers =
        sortedSections.map((wSection) => StopWatchTimer()).toList();

    /// One per section.
    _controllers = sortedSections
        .map((wSection) => _mapSectionTypeToControllerType(wSection))
        .toList();
  }

  /// Can't be a getter as needs to be passed to controllers as a function.
  WorkoutProgressState getProgressState() => _progressState;

  /// Get the log with all completed sections added to it.
  LoggedWorkout get loggedWorkout {
    final logCopy = LoggedWorkout.fromJson(_loggedWorkout.toJson());
    final loggedSections = completedSections.where((s) => s != null).toList()
        as List<LoggedWorkoutSection>;

    logCopy.loggedWorkoutSections =
        loggedSections.isNotEmpty ? loggedSections : [];
    return logCopy;
  }

  //// State progress updates and logged workout section generators ////
  void _updateProgressState(WorkoutProgressState updated) {
    _progressState = WorkoutProgressState.copy(updated);
    notifyListeners();
  }

  void _markSectionComplete(int sectionIndex) {
    completedSections[sectionIndex] = _genLoggedWorkoutSection(sectionIndex);
    notifyListeners();
  }

  LoggedWorkoutSection _genLoggedWorkoutSection(int sectionIndex) {
    final sectionProgressState = _progressState.progress[sectionIndex];
    return LoggedWorkoutSection();
  }
  ////////

  //// Timer Related ////
  StopWatchTimer getStopWatchTimerForSection(int index) =>
      _stopWatchTimers[index];

  void pauseStopWatchTimerForSection(int index) {
    if (_stopWatchTimers[index].isRunning) {
      _stopWatchTimers[index].onExecute.add(StopWatchExecute.stop);
      _context.showToast(message: 'Timer Paused');
    }
  }
  //// Timer Related ////

  //// Generate controllers for all sections in the workout using this mapping ////
  WorkoutSectionController _mapSectionTypeToControllerType(
      WorkoutSection workoutSection) {
    final typeName = workoutSection.workoutSectionType.name;
    switch (typeName) {
      case kEMOMName:
        return TimedSectionController(
            workoutSection: workoutSection,
            stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
            getProgressState: getProgressState,
            updateProgressState: _updateProgressState,
            markSectionComplete: () =>
                _markSectionComplete(workoutSection.sortPosition));
      default:
        throw Exception(
            'No mapping exists for workout section type $typeName.');
    }
  }
  ////////

  @override
  void dispose() async {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final t in _stopWatchTimers) {
      await t.dispose();
    }
    super.dispose();
  }
}

abstract class WorkoutSectionController {
  void dispose();
}

class WorkoutProgressState {
  /// Updates the 4D progress array data by inserting [milliseconds] at the current point of progress as determined by currentSectionIndex etc.
  void addLapTime(int lapTimeMsMs) {
    if (progress[currentSectionIndex] == null) {
      progress[currentSectionIndex] =
          SplayTreeMap<int, SplayTreeMap<int, int>>();
    }

    if (progress[currentSectionIndex]![currentSectionRound] == null) {
      progress[currentSectionIndex]![currentSectionRound] =
          SplayTreeMap<int, int>();
    }

    progress[currentSectionIndex]![currentSectionRound]![currentSetIndex] =
        lapTimeMsMs;
  }

  int currentSectionIndex = 0;
  int currentSectionRound = 0;
  int currentSetIndex = 0;
  int currentSetRound = 0;

  /// 4 dimensional array for tracking user progress through the workout.
  /// Where the index in the array at the various levels represents.
  /// 1D = section.sortPosition
  /// 2D = section.roundNumber
  /// 3D = set.sortPosition
  /// 4D = set.roundNumber.
  /// Leaf indexes at the 4th dimension are nullable int, where the int is the lap time (time taken to complete this round of the set) in milliseconds.
  // List<List<List<int?>>> progress = [];
  SplayTreeMap<int, SplayTreeMap<int, SplayTreeMap<int, int>>> progress =
      SplayTreeMap<int, SplayTreeMap<int, SplayTreeMap<int, int>>>();

  WorkoutProgressState();

  WorkoutProgressState.copy(WorkoutProgressState o)
      : currentSectionIndex = o.currentSectionIndex,
        currentSectionRound = o.currentSectionRound,
        currentSetIndex = o.currentSetIndex,
        currentSetRound = o.currentSetRound,
        progress = o.progress;
}
