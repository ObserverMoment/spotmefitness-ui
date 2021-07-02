import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// Although it extends [WorkoutSectionController] it is not very similar...
/// /// When they are ready the user can move sets across from the workout section and into the log. [loggedWorkoutSection.loggedWorkoutSets] is emptied in the constructor.
class FreeSessionSectionController extends WorkoutSectionController {
  FreeSessionSectionController(
      {required WorkoutSection workoutSection,
      required StopWatchTimer stopWatchTimer,
      required void Function() markSectionComplete})
      : super(
            workoutSection: workoutSection,
            stopWatchTimer: stopWatchTimer,
            markSectionComplete: markSectionComplete) {}

  @override
  void markCurrentWorkoutSetAsComplete() {
    /// Noop
  }
}
