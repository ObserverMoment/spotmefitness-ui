import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';
import 'package:spotmefitness_ui/services/type_converters.dart';

/// All updates to workout or descendants follow this pattern.
/// 1: Update local data
/// 2. Notify listeners so UI rebuilds optimistically
/// 3. Call API mutation.
/// 4. Check response is what was expected.
/// 5. If not then roll back local state changes and display error message.
/// 6: If ok then action is complete.
class WorkoutCreatorBloc extends ChangeNotifier {
  final Workout initialWorkout;
  final BuildContext context;

  int _sectionId = 0;
  int _setId = 0;
  int _workoutMoveId = 0;

  bool formIsDirty = false;
  Workout workout;

  /// Before every update we make a copy of the last workout here.
  /// If there is an issue calling the api then this is reverted to.
  Map<String, dynamic> backupJson = {};

  WorkoutCreatorBloc(this.initialWorkout, this.context)
      : workout = initialWorkout;

  /// Run this before constructing the bloc
  static Future<Workout> initialize(
      BuildContext context, Workout? prevWorkout) async {
    try {
      if (prevWorkout != null) {
        // User is editing a previous workout - just return a copy.
        return Workout.fromJson(prevWorkout.toJson());
      } else {
        // User is creating - make an empty workout in the db and return.
        final variables = CreateWorkoutArguments(
            data: CreateWorkoutInput.fromJson({
          'name': 'Workout ${DateTime.now().dateString}',
          'difficultyLevel': DifficultyLevel.challenging.apiValue,
          'contentAccessScope': ContentAccessScope.private.apiValue,
        }));

        final result = await context.graphQLClient.mutate(
          MutationOptions(
              variables: variables.toJson(),
              document: CreateWorkoutMutation(variables: variables).document),
        );

        if (result.hasException || result.data == null) {
          throw Exception(
              'There was a problem creating a new workout in the database.');
        }

        final newWorkout = Workout.fromJson({
          ...CreateWorkout$Mutation.fromJson(result.data!)
              .createWorkout
              .toJson(),
          'WorkoutSections': []
        });

        context.showToast(message: 'Workout Created');
        return newWorkout;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Send all new data to the device cache so that gql query streams get updated.
  /// The api has been updated incrementally so does not need further update here.
  Future<void> saveAllChanges(BuildContext context) async {
    final query = UserWorkoutsQuery();

    /// The alias type of the [userWorkouts] query is [WorkoutSummary]
    /// So this is the data type that needs to be passed to this update.
    GraphQL.updateCacheListQuery(
        client: context.graphQLClient,
        queryDocument: query.document,
        queryOperationNameOrAlias: query.operationName,
        data: Converters.fromWorkoutToWorkoutSummary(workout).toJson());
  }

  /// Should run at the start of all CRUD ops.
  void _backupAndMarkDirty() {
    formIsDirty = true;
    backupJson = workout.toJson();
  }

  void _revertChanges() {
    // There was an error so revert to backup, notify listeners and show error toast.
    workout = Workout.fromJson(backupJson);
    context.showToast(
        message: 'There was a problem, changes not saved', isError: true);
  }

  bool _checkApiResult(QueryResult result) {
    if (result.hasException || result.data == null) {
      _revertChanges();
      return false;
    } else {
      return true;
    }
  }

  void updateWorkoutMeta(Map<String, dynamic> data) async {
    /// Client / Optimistic
    _backupAndMarkDirty();
    workout = Workout.fromJson({...workout.toJson(), ...data});
    notifyListeners();

    /// Api
    final variables = UpdateWorkoutArguments(
        data: UpdateWorkoutInput.fromJson({...workout.toJson(), ...data}));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: UpdateWorkoutMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout = Workout.fromJson({
        ...workout.toJson(),
        ...UpdateWorkout$Mutation.fromJson(result.data!).updateWorkout.toJson()
      });
    }

    notifyListeners();
  }

  ////// WorkoutSection CRUD //////
  void createWorkoutSection(WorkoutSectionType type) async {
    _backupAndMarkDirty();

    /// New sections go in last position by default.
    final nextIndex = workout.workoutSections.length;

    /// Client / Optimistic
    workout.workoutSections.add(_genDefaultWorkoutSection(type, nextIndex));
    notifyListeners();

    /// Api
    final variables = CreateWorkoutSectionArguments(
        data: CreateWorkoutSectionInput(
            sortPosition: nextIndex,
            workout: ConnectRelationInput(id: workout.id),
            workoutSectionType: ConnectRelationInput(id: type.id)));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: CreateWorkoutSectionMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections.last = WorkoutSection.fromJson({
        ...CreateWorkoutSection$Mutation.fromJson(result.data!)
            .createWorkoutSection
            .toJson(),
        'WorkoutSets': []
      });
    }

    notifyListeners();
  }

  void updateWorkoutSection(int index, Map<String, dynamic> data) async {
    /// Client
    _backupAndMarkDirty();
    final oldWorkoutSection =
        WorkoutSection.fromJson(workout.workoutSections[index].toJson());

    workout.workoutSections[index] = WorkoutSection.fromJson(
        {...workout.workoutSections[index].toJson(), ...data});

    notifyListeners();

    /// Api
    final variables = UpdateWorkoutSectionArguments(
        data: UpdateWorkoutSectionInput.fromJson(
            {...oldWorkoutSection.toJson(), ...data}));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: UpdateWorkoutSectionMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[index] = WorkoutSection.fromJson({
        ...oldWorkoutSection.toJson(),
        ...UpdateWorkoutSection$Mutation.fromJson(result.data!)
            .updateWorkoutSection
            .toJson()
      });
    }

    notifyListeners();
  }

  void duplicateWorkoutSection(int index) async {
    _backupAndMarkDirty();

    final int insertToIndex = index + 1;

    final newSection = WorkoutSection.fromJson({
      ...workout.workoutSections[index].toJson(),
      'id': 'temp-${_sectionId++}',
    });

    /// Client
    workout.workoutSections.insert(insertToIndex, newSection);

    _updateWorkoutSectionsSortPosition(workout.workoutSections);

    notifyListeners();

    /// Api.
    final variables = DuplicateWorkoutSectionArguments(
        data: CreateWorkoutSectionInput.fromJson(newSection.toJson()),
        sort: true);

    final result = await context.graphQLClient.mutate(MutationOptions(
        document:
            DuplicateWorkoutSectionMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[insertToIndex] = WorkoutSection.fromJson(
          DuplicateWorkoutSection$Mutation.fromJson(result.data!)
              .createWorkoutSection
              .toJson());
    }

    notifyListeners();
  }

  void reorderWorkoutSections(int from, int to) async {
    _backupAndMarkDirty();
    // Check that user is not trying to move beyond the bounds of the list.
    if (to >= 0 && to < workout.workoutSections.length) {
      /// Client.
      formIsDirty = true;

      final inTransit = workout.workoutSections.removeAt(from);
      workout.workoutSections.insert(to, inTransit);

      _updateWorkoutSectionsSortPosition(workout.workoutSections);

      notifyListeners();

      /// Api.
      final variables = ReorderWorkoutSectionsArguments(
          data: workout.workoutSections
              .map((s) => UpdateSortPositionInput(
                  id: s.id, sortPosition: s.sortPosition))
              .toList());

      final result = await context.graphQLClient.mutate(MutationOptions(
          document:
              ReorderWorkoutSectionsMutation(variables: variables).document,
          variables: variables.toJson()));

      final success = _checkApiResult(result);

      if (success) {
        /// Write new sort positions.
        final positions = ReorderWorkoutSections$Mutation.fromJson(result.data!)
            .reorderWorkoutSections;

        workout.workoutSections.forEach((ws) {
          ws.sortPosition =
              positions.firstWhere((p) => p.id == ws.id).sortPosition;
        });
      }

      notifyListeners();
    }
  }

  void deleteWorkoutSection(int sectionIndex) async {
    _backupAndMarkDirty();

    final idToDelete = workout.workoutSections[sectionIndex].id;

    /// Client
    workout.workoutSections.removeAt(sectionIndex);

    _updateWorkoutSectionsSortPosition(workout.workoutSections);

    notifyListeners();

    /// Api.
    final variables = DeleteWorkoutSectionByIdArguments(id: idToDelete);

    final result = await context.graphQLClient.mutate(MutationOptions(
        document:
            DeleteWorkoutSectionByIdMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      final deletedId = DeleteWorkoutSectionById$Mutation.fromJson(result.data!)
          .deleteWorkoutSectionById;

      // If the ids do not match then there was a problem - revert the changes.
      if (idToDelete != deletedId) {
        _revertChanges();
        notifyListeners();
      }
    }
  }

  /// Internal
  void _updateWorkoutSectionsSortPosition(
      List<WorkoutSection> workoutSections) {
    workoutSections.forEachIndexed((i, workoutSection) {
      workoutSection.sortPosition = i;
    });
  }

  /// Internal
  WorkoutSection _genDefaultWorkoutSection(
          WorkoutSectionType type, int sortPosition) =>
      WorkoutSection()
        ..$$typename = 'WorkoutSection'
        ..id = (_sectionId++).toString()
        ..rounds = 1
        ..workoutSectionType = type
        ..sortPosition = sortPosition
        ..workoutSets = [];

  ////// WorkoutSet CRUD //////
  void createWorkoutSet(int sectionIndex) async {
    _backupAndMarkDirty();

    /// Client / Optimistic.
    final oldSection = workout.workoutSections[sectionIndex];
    final oldWorkoutSets = [...oldSection.workoutSets];
    workout.workoutSections[sectionIndex].workoutSets = [
      ...oldWorkoutSets,
      _genDefaultWorkoutSet(oldWorkoutSets.length)
    ];
    notifyListeners();

    /// Api
    final variables = CreateWorkoutSetArguments(
        data: CreateWorkoutSetInput(
            sortPosition: oldWorkoutSets.length,
            workoutSection: ConnectRelationInput(id: oldSection.id)));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: CreateWorkoutSetMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets.last =
          WorkoutSet.fromJson(
              {...result.data!['createWorkoutSet'], 'WorkoutMoves': []});
    }
  }

  void editWorkoutSet(
      int sectionIndex, int setIndex, Map<String, dynamic> data) {
    _backupAndMarkDirty();

    final oldWorkoutSet =
        workout.workoutSections[sectionIndex].workoutSets[setIndex];

    workout.workoutSections[sectionIndex].workoutSets[setIndex] =
        WorkoutSet.fromJson({...oldWorkoutSet.toJson(), ...data});
    notifyListeners();
  }

  void duplicateWorkoutSet(int sectionIndex, int setIndex) {
    _backupAndMarkDirty();

    final workoutSets = workout.workoutSections[sectionIndex].workoutSets;

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
    _backupAndMarkDirty();

    // Check that user is not trying to move beyond the bounds of the list.
    if (to >= 0 &&
        to < workout.workoutSections[sectionIndex].workoutSets.length) {
      formIsDirty = true;
      final workoutSets = workout.workoutSections[sectionIndex].workoutSets;

      final inTransit = workoutSets.removeAt(from);
      workoutSets.insert(to, inTransit);

      _updateWorkoutSetsSortPosition(workoutSets);

      notifyListeners();
    }
  }

  void deleteWorkoutSet(int sectionIndex, int setIndex) {
    _backupAndMarkDirty();

    final oldWorkoutSets = workout.workoutSections[sectionIndex].workoutSets;

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
    _backupAndMarkDirty();

    // Until now the workoutMove has id 'tempId'
    // We need to give it something unique as the [ImplicitlyAnimatedReorderableList] uses id as a global key.
    workoutMove.id = 'temp-${_workoutMoveId++}';

    workout.workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves
        .add(workoutMove);
    notifyListeners();
  }

  void editWorkoutMove(
      int sectionIndex, int setIndex, WorkoutMove workoutMove) {
    _backupAndMarkDirty();

    workout.workoutSections[sectionIndex].workoutSets[setIndex]
        .workoutMoves[workoutMove.sortPosition] = workoutMove;
    notifyListeners();
  }

  void deleteWorkoutMove(int sectionIndex, int setIndex, int workoutMoveIndex) {
    _backupAndMarkDirty();

    final workoutMoves = workout
        .workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves;

    // Remove the deleted move.
    workoutMoves.removeAt(workoutMoveIndex);

    _updateWorkoutMovesSortPosition(workoutMoves);

    notifyListeners();
  }

  void duplicateWorkoutMove(
      int sectionIndex, int setIndex, int workoutMoveIndex) {
    _backupAndMarkDirty();

    final workoutMoves = workout
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
    _backupAndMarkDirty();

    final workoutMoves = workout
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
