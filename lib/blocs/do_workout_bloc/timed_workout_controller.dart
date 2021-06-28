import 'dart:async';

import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// EMOM and HIITCircuit sections check the workoutSet.duration value to know when to move onto the next set.
/// The user should try and complete the moves in the set [workoutSet.rounds] times within that time.
class TimedSectionController extends WorkoutSectionController {
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
  late int _totalDurationMs;

  /// Used to know when to move forward one set and when to move to the next section round.
  late int _numberSetsPerSection;

  int _latestSectionSplitTimeMs = 0;
  int _latestSetSplitTimeMs = 0;

  bool _sectionComplete = false;

  TimedSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete})
      : super(workoutSection) {
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

    _totalDurationMs =
        _setChangeTimes[_totalRounds - 1][_numberSetsPerSection - 1];

    /// Initialise the first checkpoint in the state.
    state.setTimeRemainingMs = _setChangeTimes[0][0];

    final updated = WorkoutSectionProgressState.copy(state);
    progressStateController.add(updated);

    _timerStreamSub = stopWatchTimer.secondTime.listen((secondsElapsed) async {
      if (_sectionComplete) {
        stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        return;
      } else {
        /// If need to. Update the progressState;
        if (_hasSetChangeTimePassed(secondsElapsed)) {
          state = _updateProgressState(secondsElapsed);

          /// Check for the end of the section.
          if (state.currentSectionRound == _totalRounds) {
            stopWatchTimer.onExecute.add(StopWatchExecute.stop);
            _sectionComplete = true;
            markSectionComplete();
          }
        }

        /// Update time to next checkpoint / set change - if not passed the last checkpoint.
        if (state.currentSectionRound < _totalRounds) {
          state.setTimeRemainingMs = _setChangeTimes[state.currentSectionRound]
                  [state.currentSetIndex] -
              (secondsElapsed * 1000);
        }

        /// Update percentage complete.
        state.percentComplete = (secondsElapsed * 1000) / _totalDurationMs;

        /// Broadcast new state.
        final updated = WorkoutSectionProgressState.copy(state);
        progressStateController.add(updated);
      }
    });
  }

  bool _hasSetChangeTimePassed(int secondsElapsed) {
    return _setChangeTimes[state.currentSectionRound][state.currentSetIndex] <=
        secondsElapsed * 1000;
  }

  WorkoutSectionProgressState _updateProgressState(int secondsElapsed) {
    final elapsedMs = secondsElapsed * 1000;
    final sectionLapTimeTimeMs = elapsedMs - _latestSectionSplitTimeMs;
    final setLapTimeTimeMs = elapsedMs - _latestSetSplitTimeMs;

    if (state.currentSetIndex >= _numberSetsPerSection - 1) {
      /// Move to the next section round.
      final updated = WorkoutSectionProgressState.copy(state);

      /// Add the latest lap times.
      updated.addSectionRoundLapTime(sectionLapTimeTimeMs);
      _latestSectionSplitTimeMs = elapsedMs;

      updated.addSetLapTime(setLapTimeTimeMs);
      _latestSetSplitTimeMs = elapsedMs;

      updated.currentSectionRound += 1;
      updated.currentSetIndex = 0;

      return updated;
    } else {
      /// Move to the next set.
      final updated = WorkoutSectionProgressState.copy(state);

      /// Add the latest lap time.
      updated.addSetLapTime(setLapTimeTimeMs);
      _latestSetSplitTimeMs = elapsedMs;

      updated.currentSetIndex += 1;

      return updated;
    }
  }

  @override
  void dispose() async {
    await _timerStreamSub.cancel();
  }
}
