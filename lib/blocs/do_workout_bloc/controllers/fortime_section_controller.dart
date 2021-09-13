import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ForTimeSectionController extends WorkoutSectionController {
  late int _totalRepsToComplete;

  ForTimeSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete})
      : super(
            stopWatchTimer: stopWatchTimer,
            workoutSection: workoutSection,
            markSectionComplete: markSectionComplete) {
    _totalRepsToComplete = DataUtils.totalRepsInSection(workoutSection);
  }

  /// Public method for the user to progress to the next set (or section if this is the last set)
  void markCurrentWorkoutSetAsComplete() {
    if (!sectionComplete) {
      /// TODO
      /// Update the [loggedWorkoutSection]
      // loggedWorkoutSection.loggedWorkoutSets.add(workoutSetToLoggedWorkoutSet(
      //     sortedWorkoutSets[state.currentSetIndex], state.currentSectionRound));

      // final secondsElapsed = stopWatchTimer.secondTime.value;
      // state.moveToNextSetOrSection(secondsElapsed);

      // /// Update percentage complete.
      // state.percentComplete =
      //     DataUtils.totalRepsInSection<LoggedWorkoutSection>(
      //             loggedWorkoutSection) /
      //         _totalRepsToComplete;

      /// Broadcast new state.
      progressStateController.add(state);

      /// Check for end of the section.
      if (state.currentSectionRound >= workoutSection.rounds) {
        sectionComplete = true;
        markSectionComplete();
      }
    }
  }
}
