import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';

class DoWorkoutUtils {
  static bool moveIsCompleted(WorkoutSectionProgressState state,
      int moveRoundNumber, int moveSetIndex) {
    return state.currentSectionRound > moveRoundNumber ||
        (state.currentSectionRound == moveRoundNumber &&
            state.currentSetIndex > moveSetIndex);
  }
}
