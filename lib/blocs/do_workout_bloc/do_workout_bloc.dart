import 'dart:async';

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
  late List<WorkoutSection> _sortedWorkoutSections;
  late LoggedWorkout loggedWorkout;

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
  bool allSectionsComplete = false;

  /// If false then an intro modal will show over the section page letting the user start the workout with countdown.
  late List<bool> startedSections;

  DoWorkoutBloc({required BuildContext context, required Workout workout}) {
    _context = context;
    loggedWorkout = DefaultObjectfactory.defaultLoggedWorkout(workout: workout);

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

  //// Methods for user inputs - Public ////
  void startSection(int sectionIndex) {
    startedSections[sectionIndex] = true;
    _stopWatchTimers[sectionIndex].onExecute.add(StopWatchExecute.start);
    notifyListeners();
  }

  void resetSection(int sectionIndex) {
    startedSections[sectionIndex] = false;
    _stopWatchTimers[sectionIndex].onExecute.add(StopWatchExecute.reset);
    completedSections[sectionIndex] = null;
    controllers[sectionIndex].reset();
    loggedWorkout.loggedWorkoutSections = loggedWorkout.loggedWorkoutSections
        .where((lws) => lws.sortPosition != sectionIndex)
        .toList();
    allSectionsComplete = false;
    notifyListeners();
  }

  void resetWorkout() {
    _sortedWorkoutSections.forEach((ws) {
      final i = ws.sortPosition;
      startedSections[i] = false;
      _stopWatchTimers[i].onExecute.add(StopWatchExecute.reset);
      completedSections[i] = null;
      controllers[i].reset();
    });
    allSectionsComplete = false;
    loggedWorkout.loggedWorkoutSections = [];
    notifyListeners();
  }
  /////

  //// State progress updates and logged workout section generators ////
  /// Generate the log from the section state.
  /// Then add it to completedSections and loggedWorkout.loggedWorkoutSections.
  void _markSectionComplete(int sectionIndex) {
    final sectionLog = _genLoggedWorkoutSection(sectionIndex);
    completedSections = completedSections
        .mapIndexed((index, nullableLog) =>
            index == sectionIndex ? sectionLog : nullableLog)
        .toList();

    loggedWorkout.loggedWorkoutSections.add(sectionLog);

    if (completedSections.whereType<LoggedWorkoutSection>().length ==
        _sortedWorkoutSections.length) {
      allSectionsComplete = true;
    }
    notifyListeners();
  }

  LoggedWorkoutSection _genLoggedWorkoutSection(int sectionIndex) {
    final LoggedWorkoutSection sectionLog =
        workoutSectionToLoggedWorkoutSection(
            _sortedWorkoutSections[sectionIndex]);
    sectionLog.timeTakenMs = _stopWatchTimers[sectionIndex].rawTime.value;
    sectionLog.lapTimesMs = controllers[sectionIndex].state.lapTimesMs;
    return sectionLog;
  }

  void addNoteToLoggedWorkoutSection(int sectionIndex, String note) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex].toJson();
    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson({...prev, 'note': note});
    notifyListeners();
  }

  ////////

  //// Timer Related ////
  /// Pause all timers.
  void pauseWorkout() {
    _stopWatchTimers.forEach((timer) {
      timer.onExecute.add(StopWatchExecute.stop);
    });
  }

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
      case kHIITCircuitName:
        return TimedSectionController(
            workoutSection: workoutSection,
            stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
            markSectionComplete: () =>
                _markSectionComplete(workoutSection.sortPosition),
            updateLog: (sectionIndex, updatedSectionLog) {
              print('passing log to DoWorkoutBloc');
              print(updatedSectionLog);
            });

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

  void reset();

  void dispose();
}

class WorkoutSectionProgressState {
  late int _numberSets;

  /// Add a lapTime at the [currentSectionRound] and [currentSetIndex]
  void addSetLapTime(int lapTimeMs) {
    final prevSectionData = lapTimesMs[currentSectionRound.toString()] ?? {};
    final prevSetData = prevSectionData['setLapTimesMs'] ?? {};

    lapTimesMs = {
      ...lapTimesMs,
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
    final prevSectionData = lapTimesMs[currentSectionRound.toString()] ?? {};
    lapTimesMs = {
      ...lapTimesMs,
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
  Map<String, Map<String, dynamic>> lapTimesMs = {};

  /// Used for timed workouts or timecaps.
  int? setTimeRemainingMs;

  /// Must be a double between 0.0 and 1.0 inclusive.
  /// How this is calculated will depend on the type of workout / workout controller.
  /// For example timed workouts are just curTime / totalTime.
  /// ForTime and Free Session workouts are based on rounds and sets complete vs total rounds and set in the workout.
  double percentComplete = 0.0;

  WorkoutSectionProgressState(WorkoutSection workoutSection) {
    _numberSets = workoutSection.workoutSets.length;
  }

  /// This is invoked each time a new state is generated.
  /// So make sure if you add any fields that they also get added to this copy method!
  WorkoutSectionProgressState.copy(WorkoutSectionProgressState o)
      : currentSectionRound = o.currentSectionRound,
        currentSetIndex = o.currentSetIndex,
        lapTimesMs = o.lapTimesMs,
        percentComplete = o.percentComplete,
        setTimeRemainingMs = o.setTimeRemainingMs;
}
