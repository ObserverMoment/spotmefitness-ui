import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Delegates to the correct sub bloc types for each workout section
/// As required by the workoutSectionType
class DoWorkoutBloc {
  late BuildContext _context;
  WorkoutProgressState _progressState = WorkoutProgressState();

  /// List of timers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  late List<StopWatchTimer> _stopWatchTimers;

  /// List of controllers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  /// Each section type has a sub controller that extends [WorkoutSectionController]
  /// Need to ensure that one only at a time is playing.
  late List<WorkoutSectionController> _controllers;

  DoWorkoutBloc({required BuildContext context, required Workout workout}) {
    _context = context;
    _progressStateController.sink.add(WorkoutProgressState());

    /// One per section.
    _stopWatchTimers = workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition)
        .map((wSection) => StopWatchTimer(
            onChangeRawSecond: (seconds) =>
                print('section ${wSection.sortPosition}')))
        .toList();

    /// One per section.
    _controllers = workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition)
        .map((wSection) => _mapSectionTypeToControllerType(wSection))
        .toList();
  }

  WorkoutProgressState getProgressState() => _progressState;

  void _updateProgressState(WorkoutProgressState updated) {
    _progressState = WorkoutProgressState.copy(updated);
    _progressStateController.sink.add(_progressState);
  }

  StopWatchTimer getStopWatchTimerForSection(int index) =>
      _stopWatchTimers[index];

  void pauseStopWatchTimerForSection(int index) {
    if (_stopWatchTimers[index].isRunning) {
      _stopWatchTimers[index].onExecute.add(StopWatchExecute.stop);
      _context.showToast(message: 'Timer Paused');
    }
  }

  StreamController<WorkoutProgressState> _progressStateController =
      StreamController<WorkoutProgressState>.broadcast();
  Stream<WorkoutProgressState> get progressStateStream =>
      _progressStateController.stream;

  WorkoutSectionController _mapSectionTypeToControllerType(
      WorkoutSection workoutSection) {
    final typeName = workoutSection.workoutSectionType.name;
    switch (typeName) {
      case kEMOMName:
        return EMOMSectionController(
            workoutSection: workoutSection,
            stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
            getProgressState: getProgressState,
            updateProgressState: _updateProgressState);
      default:
        throw Exception(
            'No mapping exists for workout section type $typeName.');
    }
  }

  void dispose() async {
    /// The order of these dispose ops probably matters.
    for (final c in _controllers) {
      c.dispose();
    }
    for (final t in _stopWatchTimers) {
      await t.dispose();
    }
    await _progressStateController.close();
  }
}

abstract class WorkoutSectionController {
  void dispose();
}

/// EMOM sections check the workoutSet.duration value to know when to move onto the next set.
/// The user should try and complete the moves in the set [workoutSet.rounds] times within that time.
class EMOMSectionController extends WorkoutSectionController {
  /// 2D List of values representing the set change checkpoints.
  /// /// i.e. the time at which user should move onto the next set.
  /// Values are [milliseconds] and accumlative.
  /// Where the index represents:
  /// 1D = the section round number
  /// 2D = the set.duration (seconds) converted into ms

  /// Eg A section with 1 round and 3 x 1 minute sets would be
  /// [[60000, 120000, 180000]]
  /// A section with 3 rounds and 2 x 1 minute sets would be
  /// [[60000, 120000], [180000, 240000], [30000, 36000]]
  late List<List<int>> _setChangeTimes;
  late StreamSubscription _timerStreamSub;

  late int _totalRounds;

  /// Used to know when to move forward one set and when to move to the next section round.
  late int _numberSetsPerSection;

  int _latestSplitTimeMs = 0;

  bool _sectionComplete = false;

  EMOMSectionController(
      {required WorkoutSection workoutSection,
      required void Function(WorkoutProgressState updated) updateProgressState,
      required WorkoutProgressState Function() getProgressState,
      required StopWatchTimer stopWatchTimer}) {
    _totalRounds = workoutSection.rounds;
    _numberSetsPerSection = workoutSection.workoutSets.length;

    int _acumTime = 0;
    _setChangeTimes = List.generate(
        workoutSection.rounds,
        (index) => workoutSection.workoutSets
                // wSet.duration is in seconds in the DB. Convert it to ms.
                .map((wSet) {
              _acumTime += wSet.duration! * 1000;
              return _acumTime;
            }).toList());

    print('_setChangeTimes index ${workoutSection.sortPosition}');
    print(_setChangeTimes);

    _timerStreamSub = stopWatchTimer.secondTime.listen((seconds) async {
      print('section index ${workoutSection.sortPosition}');
      print('$seconds seconds');
      if (_sectionComplete) {
        return;
      } else {
        final prevState = getProgressState();

        /// If need to. Update the progressState;
        if (_hasSetChangeTimePassed(prevState, seconds)) {
          final updated = _updateProgressState(prevState, seconds);
          updateProgressState(updated);

          /// Check for the end of the section
          if (updated.currentSectionRound == _totalRounds) {
            _sectionComplete = true;

            /// End of the section
            print('end of section');
            stopWatchTimer.onExecute.add(StopWatchExecute.stop);
          }
        }
      }
    });
  }

  bool _hasSetChangeTimePassed(WorkoutProgressState state, int secondsElapsed) {
    return _setChangeTimes[state.currentSectionRound][state.currentSetIndex] <=
        secondsElapsed * 1000;
  }

  WorkoutProgressState _updateProgressState(
      WorkoutProgressState state, int secondsElapsed) {
    final elapsedMs = secondsElapsed * 1000;
    final lapTimeMs = elapsedMs - _latestSplitTimeMs;

    if (state.currentSetIndex + 1 >= _numberSetsPerSection) {
      /// Move to the next section round.
      final updated = WorkoutProgressState.copy(state);

      /// Add the latest lap time.
      updated.addLapTime(lapTimeMs);
      updated.currentSectionRound += 1;
      updated.currentSetIndex = 0;

      return updated;
    } else {
      /// Move to the next set.
      final updated = WorkoutProgressState.copy(state);

      /// Add the latest lap time.
      updated.addLapTime(lapTimeMs);
      updated.currentSetIndex += 1;

      return updated;
    }
  }

  @override
  void dispose() async {
    await _timerStreamSub.cancel();
  }
}

/// For Time. Free Session.
// class FixedMovesWorkoutBloc extends WorkoutSectionController {
//   WorkoutProgressState progressState = WorkoutProgressState();
//   FixedMovesWorkoutBloc({required Workout workout}) {
//     /// Set up stopwatch listener.
//     /// initialise [progressState]
//   }
// }

// /// AMRAP. Last Standing with timecap.
// class FixedTimeWorkoutBloc extends WorkoutSectionController {
//   WorkoutProgressState progressState = WorkoutProgressState();
//   FixedTimeWorkoutBloc({required Workout workout}) {
//     /// Set up stopwatch listener.
//     /// initialise [progressState]
//   }
// }

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
