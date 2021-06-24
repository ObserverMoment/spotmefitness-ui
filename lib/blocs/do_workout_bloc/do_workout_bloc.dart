import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/timed_workout_controller.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
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
  late List<WorkoutSection> _sortedWorkoutSections;

  /// List of timers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  late List<StopWatchTimer> _stopWatchTimers;

  /// List of controllers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  /// Each section type has a sub controller that extends [WorkoutSectionController]
  /// Need to ensure that one only at a time is playing.
  late List<WorkoutSectionController> controllers;

  /// At completed LoggedWorkoutSection at index [workoutSection.sortPosition] when completed.
  late List<LoggedWorkoutSection?> completedSections;

  /// If false then an intro modal will show over the section page letting the user start the workout with countdown.
  late List<bool> startedSections;

  DoWorkoutBloc({required BuildContext context, required Workout workout}) {
    _context = context;
    _originalWorkout = workout;
    _loggedWorkout =
        DefaultObjectfactory.defaultLoggedWorkout(workout: workout);

    _sortedWorkoutSections = workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition);

    completedSections = _sortedWorkoutSections.map((wSection) => null).toList();
    startedSections = _sortedWorkoutSections.map((wSection) => false).toList();

    /// One per section.
    _stopWatchTimers =
        _sortedWorkoutSections.map((wSection) => StopWatchTimer()).toList();

    /// One per section.
    controllers = _sortedWorkoutSections
        .map((wSection) => _mapSectionTypeToControllerType(wSection))
        .toList();
  }

  /// Get the log with all completed sections added to it.
  LoggedWorkout get loggedWorkout {
    final logCopy = LoggedWorkout.fromJson(_loggedWorkout.toJson());
    final loggedSections = completedSections.where((s) => s != null).toList()
        as List<LoggedWorkoutSection>;

    logCopy.loggedWorkoutSections =
        loggedSections.isNotEmpty ? loggedSections : [];
    return logCopy;
  }

  //// Methods for user inputs - Public ////
  void startSection(int sectionIndex) {
    startedSections[sectionIndex] = true;
    _stopWatchTimers[sectionIndex].onExecute.add(StopWatchExecute.start);
    notifyListeners();
  }
  /////

  //// State progress updates and logged workout section generators ////
  void _markSectionComplete(int sectionIndex) {
    final newLog = _genLoggedWorkoutSection(sectionIndex);
    completedSections = completedSections
        .mapIndexed((index, nullableLog) =>
            index == sectionIndex ? newLog : nullableLog)
        .toList();
    notifyListeners();
  }

  LoggedWorkoutSection _genLoggedWorkoutSection(int sectionIndex) {
    final LoggedWorkoutSection sectionLog =
        workoutSectionToLoggedWorkoutSection(
            _sortedWorkoutSections[sectionIndex]);
    return sectionLog;
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
    for (final c in controllers) {
      c.dispose();
    }
    for (final t in _stopWatchTimers) {
      await t.dispose();
    }
    super.dispose();
  }
}

abstract class WorkoutSectionController {
  /// Broadcast changes to the progress state.
  StreamController<WorkoutSectionProgressState> progressStateController =
      StreamController<WorkoutSectionProgressState>.broadcast();

  Stream<WorkoutSectionProgressState> get progressStream =>
      progressStateController.stream;

  late WorkoutSectionProgressState state;

  WorkoutSectionController(WorkoutSection workoutSection) {
    state = WorkoutSectionProgressState(workoutSection);
    progressStateController.add(state);
  }

  void dispose();
}

class WorkoutSectionProgressState {
  late int _numberSets;

  /// Add a lapTime at the [currentSectionRound] and [currentSetIndex]
  void addSetLapTime(int lapTimeMs) {
    final prevSectionData = lapTimes[currentSectionRound.toString()] ?? {};
    final prevSetData = prevSectionData['setLapTimesMs'] ?? {};

    lapTimes = {
      ...lapTimes,
      currentSectionRound.toString(): {
        ...prevSectionData,
        'setLapTimesMs': {
          ...prevSetData,
          currentSetIndex.toString(): lapTimeMs
        },
      }
    };
  }

  void addSectionRoundLapTime(int lapTimeMs) {
    final prevSectionData = lapTimes[currentSectionRound.toString()] ?? {};
    lapTimes = {
      ...lapTimes,
      currentSectionRound.toString(): {
        ...prevSectionData,
        'lapTimeMs': lapTimeMs,
      }
    };
  }

  void moveToNextSet() {
    if (currentSetIndex == _numberSets - 1) {
      currentSectionRound++;
      currentSetIndex = 0;
    } else {
      currentSetIndex++;
    }
  }

  void moveToNextSection() {
    currentSectionRound++;
    currentSetIndex = 0;
  }

  int currentSectionRound = 0;
  int currentSetIndex = 0;

  /// Shape of this map matches the shape required by the Joi validation that runs before JSON blob is saved to the DB.
  /// {
  ///   [sectionRoundNumber.toString()]: {
  ///     lapTimeMs: int, (lap time for section round)
  ///     setLapTimesMs: {
  ///       [currentSetIndex.toString()]: int (lap time for set at sortPosition [currentSetIndex] within round)
  ///     }
  ///   }
  /// }
  Map<String, Map<String, dynamic>> lapTimes = {};

  WorkoutSectionProgressState(WorkoutSection workoutSection) {
    _numberSets = workoutSection.workoutSets.length;
  }

  WorkoutSectionProgressState.copy(WorkoutSectionProgressState o)
      : currentSectionRound = o.currentSectionRound,
        currentSetIndex = o.currentSetIndex,
        lapTimes = o.lapTimes;
}
