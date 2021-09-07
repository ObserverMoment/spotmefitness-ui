import 'dart:async';

import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class AMRAPSectionController extends WorkoutSectionController {
  late int _sectionTimecapSeconds;
  late StreamSubscription _timerStreamSubscription;

  AMRAPSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete})
      : super(
            stopWatchTimer: stopWatchTimer,
            workoutSection: workoutSection,
            markSectionComplete: markSectionComplete) {
    /// [workoutSection.timecap] must not be null for an AMRAP.
    _sectionTimecapSeconds = workoutSection.timecap;

    /// Time till the AMRAP timecap at the end of the section.
    state.timeToNextCheckpointMs = _sectionTimecapSeconds * 1000;
    progressStateController.add(state);

    _timerStreamSubscription =
        stopWatchTimer.secondTime.listen(timerStreamListener);
  }

  void timerStreamListener(int secondsElapsed) async {
    if (sectionComplete) {
      return;
    } else {
      /// Check for the end of the workout
      if (secondsElapsed >= _sectionTimecapSeconds) {
        sectionComplete = true;
        stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        markSectionComplete();
      }

      /// Update time left till timecap and percent complete.
      state.timeToNextCheckpointMs =
          (_sectionTimecapSeconds - secondsElapsed) * 1000;

      state.percentComplete = secondsElapsed / _sectionTimecapSeconds;

      progressStateController.add(state);
    }
  }

  /// Public method for the user to progress to the next set (or section if this is the last set)
  void markCurrentWorkoutSetAsComplete() {
    /// Update the [loggedWorkoutSection]
    loggedWorkoutSection.loggedWorkoutSets.add(workoutSetToLoggedWorkoutSet(
        sortedWorkoutSets[state.currentSetIndex], state.currentSectionRound));

    final secondsElapsed = stopWatchTimer.secondTime.value;
    state.moveToNextSetOrSection(secondsElapsed);

    /// Update percentage complete.
    state.percentComplete = (secondsElapsed) / _sectionTimecapSeconds;

    /// Broadcast new state.
    progressStateController.add(state);
  }

  @override
  void dispose() async {
    await _timerStreamSubscription.cancel();
    super.dispose();
  }
}
