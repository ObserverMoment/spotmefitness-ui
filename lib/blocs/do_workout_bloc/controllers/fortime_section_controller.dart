import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ForTimeSectionController extends WorkoutSectionController {
  late int totalRepsToComplete;
  int repsCompleted = 0;

  ForTimeSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete})
      : super(
            stopWatchTimer: stopWatchTimer,
            workoutSection: workoutSection,
            markSectionComplete: markSectionComplete) {
    totalRepsToComplete =
        DataUtils.totalRepsInSection(workoutSection) * workoutSection.rounds;
  }

  /// Public method for the user to progress to the next set (or section if this is the last set in that section).
  void markCurrentWorkoutSetAsComplete() {
    if (!sectionComplete) {
      /// Update reps completed.
      repsCompleted += DataUtils.totalRepsInSet(
          workoutSection.workoutSets[state.currentSetIndex]);

      /// Update percentage complete.
      state.percentComplete = repsCompleted / totalRepsToComplete;

      /// Move to the next set.
      state.moveToNextSetOrSection(stopWatchTimer.secondTime.value);

      /// Broadcast new state.
      progressStateController.add(state);

      /// Check for end of the section.
      if (state.currentRoundIndex >= workoutSection.rounds) {
        sectionComplete = true;
        markSectionComplete();
      }
    }
  }

  void reset() {
    repsCompleted = 0;
    super.reset();
  }
}
