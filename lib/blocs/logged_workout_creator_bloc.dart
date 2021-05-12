import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:collection/collection.dart';

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

  void updateSectionRoundsCompleted(int sectionIndex, int roundsCompleted) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].roundsCompleted =
        roundsCompleted;
    notifyListeners();
  }

  void addLoggedWorkoutSet(int sectionIndex, {List<int>? laptimesMs}) {
    final sets =
        loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets;
    loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets = [
      ...sets,
      DefaultObjectfactory.defaultLoggedWorkoutSet(
          setIndex: sets.length, laptimesMs: laptimesMs)
    ];
    notifyListeners();
  }

  void editLoggedWorkoutSet(
      int sectionIndex, int setIndex, LoggedWorkoutSet loggedWorkoutSet) {
    loggedWorkout.loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex] = loggedWorkoutSet;
    notifyListeners();
  }

  void deleteLoggedWorkoutSet(int sectionIndex, int setIndex) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets
        .removeAt(setIndex);
    _updateLoggedWorkoutSetsSortPosition(
        loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets);
    notifyListeners();
  }

  /// Internal: Client
  void _updateLoggedWorkoutSetsSortPosition(
      List<LoggedWorkoutSet> loggedWorkoutSets) {
    loggedWorkoutSets.forEachIndexed((i, loggedWorkoutSet) {
      loggedWorkoutSet.setIndex = i;
    });
  }

  /// To the end of a set.
  void addLoggedWorkoutMove(int sectionIndex, int setIndex,
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

    _updateLoggedWorkoutMovesSortPosition(loggedWorkout
        .loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex]
        .loggedWorkoutMoves);

    notifyListeners();
  }

  /// Internal: Client
  void _updateLoggedWorkoutMovesSortPosition(
      List<LoggedWorkoutMove> loggedWorkoutMoves) {
    loggedWorkoutMoves.forEachIndexed((i, loggedWorkoutMove) {
      loggedWorkoutMove.sortPosition = i;
    });
  }
}
