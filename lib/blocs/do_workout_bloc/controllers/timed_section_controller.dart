import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// [EMOM], [Tabata] and [HIITCircuit].
/// These section types check the workoutSet.duration value to know when to move onto the next set. Reps are ignored in HIITCircuit and Tabata types so they should not be displayed on the UI.
class TimedSectionController extends WorkoutSectionController {
  /// 2D List of values representing the set change checkpoints.
  /// /// i.e. the time at which user should move onto the next set.
  /// Values are [seconds] and accumlative.
  /// Where the index represents:
  /// 1D = the section round number
  /// 2D = the set.duration (seconds)

  /// Eg A section with 1 round and 3 x 1 minute sets would be
  /// [[60, 120, 180]]
  /// A section with 3 rounds and 2 x 1 minute sets would be
  /// [[60, 120], [180, 240], [300, 360]]
  late List<List<int>> _setChangeTimes;
  late StreamSubscription _timerStreamSubscription;

  late int _totalRounds;
  late int totalDurationSeconds;

  TimedSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required VoidCallback onCompleteSection})
      : super(
            stopWatchTimer: stopWatchTimer,
            workoutSection: workoutSection,
            onCompleteSection: onCompleteSection) {
    _totalRounds = workoutSection.rounds;

    int _acumTime = 0;
    _setChangeTimes = List.generate(
        workoutSection.rounds,
        (index) => workoutSection.workoutSets
                // wSet.duration is in seconds in the DB.
                .map((wSet) {
              return _acumTime += wSet.duration;
            }).toList());

    totalDurationSeconds = _setChangeTimes.last.last;

    /// Initialise the first checkpoint in the state.
    state.secondsToNextCheckpoint = _setChangeTimes[0][0];
    progressStateController.add(state);

    _timerStreamSubscription =
        stopWatchTimer.secondTime.listen(timerStreamListener);
  }

  Future<void> timerStreamListener(int secondsElapsed) async {
    if (!sectionComplete) {
      /// If need to. Update the progressState;
      if (_hasSetChangeTimePassed(secondsElapsed)) {
        state.moveToNextSetOrSection(secondsElapsed);

        /// Check for the end of the section.
        if (state.currentRoundIndex == _totalRounds) {
          sectionComplete = true;
          onCompleteSection();
        }
      }

      /// Update time to next checkpoint / set change - if not finished the section.
      if (state.currentRoundIndex < _totalRounds) {
        state.secondsToNextCheckpoint = _setChangeTimes[state.currentRoundIndex]
                [state.currentSetIndex] -
            secondsElapsed;
      }

      /// Update percentage complete.
      state.percentComplete = secondsElapsed / totalDurationSeconds;

      /// Broadcast new state.
      progressStateController.add(state);
    }
  }

  bool _hasSetChangeTimePassed(int secondsElapsed) {
    return _setChangeTimes[state.currentRoundIndex][state.currentSetIndex] <=
        secondsElapsed;
  }

  /// Not used during timed sections as sets progress based on elapsed time.
  /// i.e. No user input.
  @override
  void markCurrentWorkoutSetAsComplete() => {};

  @override
  Future<void> dispose() async {
    super.dispose();
    await _timerStreamSubscription.cancel();
  }
}
