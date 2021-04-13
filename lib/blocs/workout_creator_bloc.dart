import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutCreatorBloc extends ChangeNotifier {
  int _sectionId = 0;
  int _setId = 0;
  int _workoutMoveId = 0;
  final WorkoutData? initialWorkoutData;

  bool formIsDirty = false;
  Map<String, dynamic>? _backupJson;
  late WorkoutData workoutData;

  WorkoutCreatorBloc(this.initialWorkoutData) {
    workoutData = initialWorkoutData != null
        ? WorkoutData.fromJson(initialWorkoutData!.toJson())
        : WorkoutData.fromJson({
            '__typename': 'Workout',
            'id': 'temp_id',
            'name': 'Workout ${DateTime.now().dateString}',
            'difficultyLevel': 'CHALLENGING',
            'contentAccessScope': 'PRIVATE',
            'WorkoutGoals': [],
            'WorkoutTags': [],
            'WorkoutSections': []
          });
  }

  /// Reset to the initial data or create default empty WorkoutData
  void undoAllChanges() {
    workoutData = _backupJson != null
        ? WorkoutData.fromJson(_backupJson!)
        : WorkoutData.fromJson({
            '__typename': 'Workout',
            'id': 'temp_id',
            'name': 'Workout ${DateTime.now().dateString}',
            'difficultyLevel': 'CHALLENGING',
            'contentAccessScope': 'PRIVATE',
            'WorkoutGoals': [],
            'WorkoutTags': [],
            'WorkoutSections': []
          });
    notifyListeners();
  }

  void updateWorkoutMeta(Map<String, dynamic> data) {
    formIsDirty = true;
    workoutData = WorkoutData.fromJson({...workoutData.toJson(), ...data});
    notifyListeners();
  }

  WorkoutSection _genDefaultWorkoutSection(WorkoutSectionType type) =>
      WorkoutSection()
        ..$$typename = 'WorkoutSection'
        ..id = (_sectionId++).toString()
        ..rounds = 1
        ..workoutSectionType = type
        ..sortPosition = workoutData.workoutSections.length
        ..workoutSets = [];

  void createSection(WorkoutSectionType type) {
    formIsDirty = true;
    workoutData.workoutSections.add(_genDefaultWorkoutSection(type));
    notifyListeners();
  }

  void updateSection(int index, Map<String, dynamic> data) {
    formIsDirty = true;
    workoutData.workoutSections[index] = WorkoutSection.fromJson(
        {...workoutData.workoutSections[index].toJson(), ...data});
    notifyListeners();
  }

  WorkoutSet _genDefaultWorkoutSet(int sortPosition) => WorkoutSet()
    ..$$typename = 'WorkoutSet'
    ..id = (_setId++).toString()
    ..rounds = 1
    ..sortPosition = sortPosition
    ..workoutMoves = [];

  void createSet(int sectionIndex) {
    formIsDirty = true;
    final oldWorkoutSets = [
      ...workoutData.workoutSections[sectionIndex].workoutSets
    ];
    workoutData.workoutSections[sectionIndex].workoutSets = [
      ...oldWorkoutSets,
      _genDefaultWorkoutSet(oldWorkoutSets.length)
    ];
    notifyListeners();
  }
}
