import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class LoggedWorkoutCreatorBloc extends ChangeNotifier {
  final Workout workout;
  final ScheduledWorkout? scheduledWorkout;

  late LoggedWorkout loggedWorkout;
  List<LoggedWorkoutSection> sectionsToIncludeInLog = [];

  LoggedWorkoutCreatorBloc({required this.workout, this.scheduledWorkout}) {
    loggedWorkout = workoutToLoggedWorkout(
        workout: workout, scheduledWorkout: scheduledWorkout);
  }

  bool showFullSetInfo = true;

  void toggleIncludeSection(LoggedWorkoutSection loggedWorkoutSection) {
    sectionsToIncludeInLog = sectionsToIncludeInLog
        .toggleItem<LoggedWorkoutSection>(loggedWorkoutSection);
    notifyListeners();
  }

  void updateGymProfile(GymProfile? profile) {
    loggedWorkout.gymProfile = profile;
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

  void updateSectionRepsScore(int sectionIndex, int score) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].repScore = score;
    notifyListeners();
  }

  void updateSectionTimeTakenMs(int sectionIndex, int timeTakenMs) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].timeTakenMs = timeTakenMs;
    notifyListeners();
  }

  void deleteLoggedWorkoutSet(int sectionIndex, int setIndex) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets
        .removeAt(setIndex);
    notifyListeners();
  }

  void createLoggedWorkoutMove(int sectionIndex, int setIndex,
      LoggedWorkoutMove loggedWorkoutMove) async {
    loggedWorkout.loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex].loggedWorkoutMoves
        .add(loggedWorkoutMove);
    notifyListeners();
  }

  void editLoggedWorkoutMove(int sectionIndex, int setIndex,
      LoggedWorkoutMove loggedWorkoutMove) async {
    loggedWorkout
        .loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex]
        .loggedWorkoutMoves[loggedWorkoutMove.sortPosition] = loggedWorkoutMove;
    notifyListeners();
  }

  void deleteLoggedWorkoutMove(
      int sectionIndex, int setIndex, int workoutMoveIndex) {
    loggedWorkout.loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex].loggedWorkoutMoves
        .removeAt(workoutMoveIndex);
    notifyListeners();
  }
}
