import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

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

////// WorkoutSet CRUD //////
  void createWorkoutSection(WorkoutSectionType type) {
    formIsDirty = true;
    workoutData.workoutSections.add(_genDefaultWorkoutSection(type));
    notifyListeners();
  }

  void updateWorkoutSection(int index, Map<String, dynamic> data) {
    formIsDirty = true;
    workoutData.workoutSections[index] = WorkoutSection.fromJson(
        {...workoutData.workoutSections[index].toJson(), ...data});
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

  ////// WorkoutSet CRUD //////
  void createWorkoutSet(int sectionIndex) {
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

  void editWorkoutSet(
      int sectionIndex, int setIndex, Map<String, dynamic> data) {
    formIsDirty = true;
    final oldWorkoutSet =
        workoutData.workoutSections[sectionIndex].workoutSets[setIndex];
    workoutData.workoutSections[sectionIndex].workoutSets[setIndex] =
        WorkoutSet.fromJson({...oldWorkoutSet.toJson(), ...data});
    notifyListeners();
  }

  void duplicateWorkoutSet(int sectionIndex, int setIndex) {
    formIsDirty = true;
    final workoutSets = workoutData.workoutSections[sectionIndex].workoutSets;

    workoutSets.insert(
        setIndex + 1,
        WorkoutSet.fromJson({
          ...workoutSets[setIndex].toJson(),
          'id': 'temp-${_setId++}',
        }));

    _updateWorkoutSetsSortPosition(workoutSets);

    notifyListeners();
  }

  void reorderWorkoutSets(int sectionIndex, int from, int to) {
    formIsDirty = true;
    final workoutSets = workoutData.workoutSections[sectionIndex].workoutSets;

    final inTransit = workoutSets.removeAt(from);
    workoutSets.insert(to, inTransit);

    _updateWorkoutSetsSortPosition(workoutSets);

    notifyListeners();
  }

  void deleteWorkoutSet(int sectionIndex, int setIndex) {
    formIsDirty = true;
    final oldWorkoutSets =
        workoutData.workoutSections[sectionIndex].workoutSets;

    // Remove the deleted move.
    oldWorkoutSets.removeAt(setIndex);

    _updateWorkoutSetsSortPosition(oldWorkoutSets);

    workoutData.workoutSections[sectionIndex].workoutSets = [...oldWorkoutSets];

    notifyListeners();
  }

  WorkoutSet _genDefaultWorkoutSet(int sortPosition) => WorkoutSet()
    ..$$typename = 'WorkoutSet'
    ..id = (_setId++).toString()
    ..rounds = 1
    ..sortPosition = sortPosition
    ..workoutMoves = [];

  void _updateWorkoutSetsSortPosition(List<WorkoutSet> workoutSets) {
    workoutSets.forEachIndexed((i, workoutSet) {
      workoutSet.sortPosition = i;
    });
  }

  ////// WorkoutMove CRUD //////
  /// Add a workoutMove to a set.
  void createWorkoutMove(
      int sectionIndex, int setIndex, WorkoutMove workoutMove) {
    formIsDirty = true;

    // Until now the workoutMove has id 'tempId'
    // We need to give it something unique as the [ImplicitlyAnimatedReorderableList] uses id as a global key.
    workoutMove.id = 'temp-${_workoutMoveId++}';

    workoutData.workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves
        .add(workoutMove);
    notifyListeners();
  }

  void editWorkoutMove(
      int sectionIndex, int setIndex, WorkoutMove workoutMove) {
    formIsDirty = true;

    workoutData.workoutSections[sectionIndex].workoutSets[setIndex]
        .workoutMoves[workoutMove.sortPosition] = workoutMove;
    notifyListeners();
  }

  void deleteWorkoutMove(int sectionIndex, int setIndex, int workoutMoveIndex) {
    formIsDirty = true;
    final workoutMoves = workoutData
        .workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves;

    // Remove the deleted move.
    workoutMoves.removeAt(workoutMoveIndex);

    _updateWorkoutMovesSortPosition(workoutMoves);

    notifyListeners();
  }

  void duplicateWorkoutMove(
      int sectionIndex, int setIndex, int workoutMoveIndex) {
    formIsDirty = true;
    final workoutMoves = workoutData
        .workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves;

    workoutMoves.insert(
        workoutMoveIndex + 1,
        WorkoutMove.fromJson({
          ...workoutMoves[workoutMoveIndex].toJson(),
          'id': 'temp-${_workoutMoveId++}',
        }));

    _updateWorkoutMovesSortPosition(workoutMoves);

    notifyListeners();
  }

  void reorderWorkoutMoves(int sectionIndex, int setIndex, int from, int to) {
    formIsDirty = true;
    final workoutMoves = workoutData
        .workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves;

    final inTransit = workoutMoves.removeAt(from);
    workoutMoves.insert(to, inTransit);

    _updateWorkoutMovesSortPosition(workoutMoves);

    notifyListeners();
  }

  void _updateWorkoutMovesSortPosition(List<WorkoutMove> workoutMoves) {
    workoutMoves.forEachIndexed((i, workoutMove) {
      workoutMove.sortPosition = i;
    });
  }
}
