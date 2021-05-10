import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class LoggedWorkoutCreatorBloc extends ChangeNotifier {
  final Workout workout;
  final ScheduledWorkout? scheduledWorkout;

  late CreateLoggedWorkoutInput loggedWorkout;
  late GymProfile? gymProfile;
  late List<WorkoutSection> sectionsToIncludeInLog;

  LoggedWorkoutCreatorBloc({required this.workout, this.scheduledWorkout}) {
    loggedWorkout = workoutToCreateLoggedWorkout(
        workout: workout, scheduledWorkout: scheduledWorkout);

    gymProfile = scheduledWorkout?.gymProfile;

    sectionsToIncludeInLog = [...workout.workoutSections];
  }

  void toggleIncludeSection(WorkoutSection workoutSection) {
    sectionsToIncludeInLog =
        sectionsToIncludeInLog.toggleItem<WorkoutSection>(workoutSection);
    notifyListeners();
  }

  void updateGymProfile(GymProfile? profile) {
    gymProfile = profile;
    notifyListeners();
  }

  void updateCompletedOn(DateTime completedOn) {
    loggedWorkout.completedOn = completedOn;
    notifyListeners();
  }

  void updateNote(String note) {
    loggedWorkout.note = note;
    notifyListeners();
  }
}
