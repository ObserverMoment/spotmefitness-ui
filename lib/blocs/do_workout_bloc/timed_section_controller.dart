import 'dart:async';

import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// [EMOM], [Tabata] and [HIITCircuit].
/// These section types check the workoutSet.duration value to know when to move onto the next set. Reps are ignored in HIITCircuit and Tabata types so they should not be displayed on the UI.
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
  late StreamSubscription _timerStreamSubscription;

  late int _totalRounds;
  late int _totalDurationMs;

  TimedSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete})
      : super(
            stopWatchTimer: stopWatchTimer,
            workoutSection: workoutSection,
            markSectionComplete: markSectionComplete) {
    _totalRounds = workoutSection.rounds;

    int _acumTime = 0;
    _setChangeTimes = List.generate(
        workoutSection.rounds,
        (index) => sortedWorkoutSets
                // wSet.duration is in seconds in the DB. Convert it to ms.
                .map((wSet) {
              _acumTime += wSet.duration! * 1000;
              return _acumTime;
            }).toList());

    _totalDurationMs =
        _setChangeTimes[_totalRounds - 1][numberSetsPerSection - 1];

    /// Initialise the first checkpoint in the state.
    state.timeToNextCheckpointMs = _setChangeTimes[0][0];
    progressStateController.add(state);

    _timerStreamSubscription =
        stopWatchTimer.secondTime.listen(timerStreamListener);
  }

  void timerStreamListener(int secondsElapsed) async {
    if (sectionComplete) {
      stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      return;
    } else {
      /// If need to. Update the progressState;
      if (_hasSetChangeTimePassed(secondsElapsed)) {
        /// Update the [loggedWorkoutSection]
        loggedWorkoutSection.loggedWorkoutSets.add(workoutSetToLoggedWorkoutSet(
            sortedWorkoutSets[state.currentSetIndex],
            state.currentSectionRound));

        state.moveToNextSetOrSection(secondsElapsed);

        /// Check for the end of the section.
        if (state.currentSectionRound == _totalRounds) {
          stopWatchTimer.onExecute.add(StopWatchExecute.stop);
          sectionComplete = true;
          markSectionComplete();
        }
      }

      /// Update time to next checkpoint / set change - only if not passed the last checkpoint.
      if (state.currentSectionRound < _totalRounds) {
        state.timeToNextCheckpointMs =
            _setChangeTimes[state.currentSectionRound][state.currentSetIndex] -
                (secondsElapsed * 1000);
      }

      /// Update percentage complete.
      state.percentComplete = (secondsElapsed * 1000) / _totalDurationMs;

      /// Broadcast new state.
      progressStateController.add(state);
    }
  }

  bool _hasSetChangeTimePassed(int secondsElapsed) {
    return _setChangeTimes[state.currentSectionRound][state.currentSetIndex] <=
        secondsElapsed * 1000;
  }

  /// Not used during timed sections as sets progress based on elapsed time.
  /// i.e. No user input.
  void markCurrentWorkoutSetAsComplete() => null;

  @override
  void dispose() async {
    await _timerStreamSubscription.cancel();
  }
}
