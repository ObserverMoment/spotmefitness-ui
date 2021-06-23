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

  /// Used to know when to move forward one set and when to move to the next section round.
  late int _numberSetsPerSection;

  int _latestSplitTimeMs = 0;

  bool _sectionComplete = false;

  TimedSectionController(
      {required WorkoutSection workoutSection,
      required void Function(WorkoutProgressState updated) updateProgressState,
      required WorkoutProgressState Function() getProgressState,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete}) {
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

    _timerStreamSub = stopWatchTimer.secondTime.listen((seconds) async {
      if (_sectionComplete) {
        return;
      } else {
        final prevState = getProgressState();

        /// If need to. Update the progressState;
        if (_hasSetChangeTimePassed(prevState, seconds)) {
          final updated = _updateProgressState(prevState, seconds);
          updateProgressState(updated);

          /// Check for the end of the section.
          if (updated.currentSectionRound == _totalRounds) {
            _sectionComplete = true;
            markSectionComplete();
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
