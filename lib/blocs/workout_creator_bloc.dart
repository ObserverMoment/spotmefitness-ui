import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutCreatorBloc extends ChangeNotifier {
  int _sectionId = 0;
  int _setId = 0;
  int _workoutMoveId = 0;
  WorkoutData initialWorkoutData;

  bool formIsDirty = false;
  Map<String, dynamic> _backupJson;
  WorkoutData workoutData;

  WorkoutCreatorBloc(this.initialWorkoutData)
      : workoutData = initialWorkoutData,
        _backupJson = initialWorkoutData.toJson();

  /// Run this before constructing the bloc
  static Future<WorkoutData> initialize(
      BuildContext context, WorkoutData? prevWorkoutData) async {
    try {
      if (prevWorkoutData != null) {
        // User is editing a previous workout - just return a copy.
        return WorkoutData.fromJson(prevWorkoutData.toJson());
      } else {
        // User is creating - make an empty workout in the db and return.
        final createInput = CreateWorkoutInput.fromJson({
          'name': 'Workout ${DateTime.now().dateString}',
          'difficultyLevel': DifficultyLevel.challenging.apiValue,
          'contentAccessScope': ContentAccessScope.private.apiValue,
        });
        final result = await context.graphQLClient.mutate(
          MutationOptions(
              variables: {'data': createInput.toJson()},
              document: CreateWorkoutMutation(
                      variables: CreateWorkoutArguments(data: createInput))
                  .document),
        );

        final newWorkout =
            WorkoutData.fromJson(result.data?['createWorkout'] ?? {});
        return newWorkout;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Reset to the initial data or create default empty WorkoutData
  void undoAllChanges() {
    // TODO: Need to reset data in the database as well
    // This probably needs to be an async function.
    workoutData = WorkoutData.fromJson(_backupJson);
    notifyListeners();
  }

  void updateWorkoutMeta(Map<String, dynamic> data) {
    formIsDirty = true;
    workoutData = WorkoutData.fromJson({...workoutData.toJson(), ...data});
    notifyListeners();
  }

////// WorkoutSection CRUD //////
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

  void duplicateWorkoutSection(int index) {
    formIsDirty = true;

    workoutData.workoutSections.insert(
        index + 1,
        WorkoutSection.fromJson({
          ...workoutData.workoutSections[index].toJson(),
          'id': 'temp-${_sectionId++}',
        }));

    _updateWorkoutSectionsSortPosition(workoutData.workoutSections);

    notifyListeners();
  }

  void reorderWorkoutSections(int from, int to) {
    // Check that user is not trying to move beyond the bounds of the list.
    if (to >= 0 && to < workoutData.workoutSections.length) {
      formIsDirty = true;

      final inTransit = workoutData.workoutSections.removeAt(from);
      workoutData.workoutSections.insert(to, inTransit);

      _updateWorkoutSectionsSortPosition(workoutData.workoutSections);

      notifyListeners();
    }
  }

  void deleteWorkoutSection(int sectionIndex) {
    formIsDirty = true;

    workoutData.workoutSections.removeAt(sectionIndex);

    _updateWorkoutSectionsSortPosition(workoutData.workoutSections);

    notifyListeners();
  }

  void _updateWorkoutSectionsSortPosition(
      List<WorkoutSection> workoutSections) {
    workoutSections.forEachIndexed((i, workoutSection) {
      workoutSection.sortPosition = i;
    });
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
    // Check that user is not trying to move beyond the bounds of the list.
    if (to >= 0 &&
        to < workoutData.workoutSections[sectionIndex].workoutSets.length) {
      formIsDirty = true;
      final workoutSets = workoutData.workoutSections[sectionIndex].workoutSets;

      final inTransit = workoutSets.removeAt(from);
      workoutSets.insert(to, inTransit);

      _updateWorkoutSetsSortPosition(workoutSets);

      notifyListeners();
    }
  }

  void deleteWorkoutSet(int sectionIndex, int setIndex) {
    formIsDirty = true;
    final oldWorkoutSets =
        workoutData.workoutSections[sectionIndex].workoutSets;

    // Remove the deleted move.
    oldWorkoutSets.removeAt(setIndex);

    _updateWorkoutSetsSortPosition(oldWorkoutSets);

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
    // If moved to a higher index then you need to insert one place lower than the original drop location.
    // As you have popped a lower index position in the action above.
    final int newIndex = to > from ? to - 1 : to;
    workoutMoves.insert(newIndex, inTransit);

    _updateWorkoutMovesSortPosition(workoutMoves);

    notifyListeners();
  }

  void _updateWorkoutMovesSortPosition(List<WorkoutMove> workoutMoves) {
    workoutMoves.forEachIndexed((i, workoutMove) {
      workoutMove.sortPosition = i;
    });
  }
}
