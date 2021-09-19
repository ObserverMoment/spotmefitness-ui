import 'dart:async';

import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class AMRAPSectionController extends WorkoutSectionController {
  late int _timecapSeconds;
  late StreamSubscription _timerStreamSubscription;
  int repsCompleted = 0;

  AMRAPSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() onCompleteSection})
      : super(
            stopWatchTimer: stopWatchTimer,
            workoutSection: workoutSection,
            onCompleteSection: onCompleteSection) {
    /// [workoutSection.timecap] must not be null for an AMRAP.
    _timecapSeconds = workoutSection.timecap;

    /// Time till the AMRAP timecap at the end of the section.
    state.secondsToNextCheckpoint = _timecapSeconds;
    progressStateController.add(state);

    _timerStreamSubscription =
        stopWatchTimer.secondTime.listen(timerStreamListener);
  }

  void timerStreamListener(int secondsElapsed) async {
    if (sectionComplete) {
      return;
    } else {
      /// Check for the end of the workout
      if (secondsElapsed >= _timecapSeconds) {
        sectionComplete = true;
        stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        onCompleteSection();
      }

      /// Update time left till timecap and percent complete.
      state.secondsToNextCheckpoint = _timecapSeconds - secondsElapsed;

      state.percentComplete = secondsElapsed / _timecapSeconds;

      progressStateController.add(state);
    }
  }

  /// Public method for the user to progress to the next set (or section if this is the last set).
  void markCurrentWorkoutSetAsComplete() {
    /// Update reps completed.
    repsCompleted += DataUtils.totalRepsInSet(
        workoutSection.workoutSets[state.currentSetIndex]);

    final secondsElapsed = stopWatchTimer.secondTime.value;
    state.moveToNextSetOrSection(stopWatchTimer.secondTime.value);

    /// Update percentage complete.
    state.percentComplete = secondsElapsed / _timecapSeconds;

    /// Broadcast new state.
    progressStateController.add(state);
  }

  @override
  void dispose() async {
    await _timerStreamSubscription.cancel();
    super.dispose();
  }
}
