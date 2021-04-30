import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';
import 'package:spotmefitness_ui/services/type_converters.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

/// All updates to workout or descendants follow this pattern.
/// 1: Update local data
/// 2. Notify listeners so UI rebuilds optimistically
/// 3. Call API mutation (if not a create op).
/// 4. Check response is what was expected.
/// 5. If not then roll back local state changes and display error message.
/// 6: If ok then action is complete.
class WorkoutCreatorBloc extends ChangeNotifier {
  final Workout initialWorkout;
  final BuildContext context;

  int _setId = 0;
  int _workoutMoveId = 0;

  bool formIsDirty = false;

  /// When false workout sets are displayed as a minimal single line item.
  /// To allow clear overview and to make re-ordering more simple.
  bool showFullSetInfo = true;
  void toggleShowFullSetInfo() {
    showFullSetInfo = !showFullSetInfo;
    notifyListeners();
  }

  /// Use when creating new objects which have to wait for network responses before updating the UI with their presence. Anything that has children is an issue to update optimistically as the object ids will be [temp] until the network request comes back with the uid from the DB.
  bool creatingSection = false;
  bool creatingSet = false;

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
        // User is editing a previous workout - return a copy.
        // First ensure that all child lists are sorted by sort position.
        /// Reordering ops in this bloc use [list.remove] and [list.insert] whch requires that the initial sort order is correct.
        return prevWorkout.copyAndSortAllChildren;
      } else {
        // User is creating - make an empty workout in the db and return.
        final variables = CreateWorkoutArguments(
          data: CreateWorkoutInput(
              name: 'Workout ${DateTime.now().dateString}',
              difficultyLevel: DifficultyLevel.challenging,
              contentAccessScope: ContentAccessScope.private),
        );

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

  void _revertChanges(OperationException? exception) {
    // There was an error so revert to backup, notify listeners and show error toast.
    workout = Workout.fromJson(backupJson);
    if (exception != null) {
      print(exception);
    }
    context.showToast(
        message: 'There was a problem, changes not saved', isError: true);
  }

  bool _checkApiResult(QueryResult result) {
    if (result.hasException || result.data == null) {
      _revertChanges(result.exception!);
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
  Future<void> createWorkoutSection(WorkoutSectionType type) async {
    _backupAndMarkDirty();
    creatingSection = true;
    notifyListeners();

    /// New sections go in last position by default.
    final nextIndex = workout.workoutSections.length;

    /// Api only for creates.
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
      workout.workoutSections.add(WorkoutSection.fromJson(
          CreateWorkoutSection$Mutation.fromJson(result.data!)
              .createWorkoutSection
              .toJson()));
    }

    creatingSection = false;
    notifyListeners();
  }

  void updateWorkoutSection(int index, Map<String, dynamic> data) async {
    /// Client
    _backupAndMarkDirty();
    final updatedWorkoutSection = WorkoutSection.fromJson(
        {...workout.workoutSections[index].toJson(), ...data});

    workout.workoutSections[index] = WorkoutSection.fromJson(
        {...workout.workoutSections[index].toJson(), ...data});

    notifyListeners();

    /// Api
    final variables = UpdateWorkoutSectionArguments(
        data:
            UpdateWorkoutSectionInput.fromJson(updatedWorkoutSection.toJson()));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: UpdateWorkoutSectionMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[index] = WorkoutSection.fromJson({
        ...updatedWorkoutSection.toJson(),
        ...UpdateWorkoutSection$Mutation.fromJson(result.data!)
            .updateWorkoutSection
            .toJson()
      });
    }

    notifyListeners();
  }

  void reorderWorkoutSections(int from, int to) async {
    // Check that user is not trying to move beyond the bounds of the list.
    if (to >= 0 && to < workout.workoutSections.length) {
      _backupAndMarkDirty();

      /// Client.
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
        _revertChanges(result.exception);
        notifyListeners();
      }
    }
  }

  /// Internal: Client
  void _updateWorkoutSectionsSortPosition(
      List<WorkoutSection> workoutSections) {
    workoutSections.forEachIndexed((i, workoutSection) {
      workoutSection.sortPosition = i;
    });
  }

  ////// WorkoutSet CRUD //////
  /// Either empty default or from a pre made set passed as arg.
  /// [shouldNotifyListeners]: Used if you want to create a set, then a move, and then update the UI. Initially implemented for creating a workoutRestSet (i.e) a set with only a rest in it and ensuring a smooth UI update.
  /// Function is returning a workoutSet so that the caller can then immediately create a workoutMove to go in it if needed. Works in combination with [shouldNotifyListeners]. When done - Creating the workout move will call notifyListeners() and all UI will be updated.
  Future<WorkoutSet?> createWorkoutSet(int sectionIndex,
      {bool shouldNotifyListeners = true,
      Map<String, dynamic> defaults = const {}}) async {
    _backupAndMarkDirty();
    creatingSet = true;
    if (shouldNotifyListeners) {
      notifyListeners();
    }

    final oldSection = workout.workoutSections[sectionIndex];
    final newWorkoutSet = WorkoutSet.fromJson({
      ..._genDefaultWorkoutSet(oldSection.workoutSets.length).toJson(),
      ...defaults,
    });

    /// Api only for create.
    final variables = CreateWorkoutSetArguments(
        data: CreateWorkoutSetInput.fromJson({
      ...newWorkoutSet.toJson(),
      'WorkoutSection': ConnectRelationInput(id: oldSection.id).toJson()
    }));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: CreateWorkoutSetMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    WorkoutSet? createdSet;

    if (success) {
      createdSet = WorkoutSet.fromJson({
        ...CreateWorkoutSet$Mutation.fromJson(result.data!)
            .createWorkoutSet
            .toJson(),
        'WorkoutMoves': []
      });
      workout.workoutSections[sectionIndex].workoutSets.add(createdSet);
    }

    creatingSet = false;
    if (shouldNotifyListeners) {
      notifyListeners();
    }

    return createdSet;
  }

  void editWorkoutSet(
      int sectionIndex, int setIndex, Map<String, dynamic> data) async {
    _backupAndMarkDirty();

    /// Client.
    final oldWorkoutSet =
        workout.workoutSections[sectionIndex].workoutSets[setIndex];
    final updatedWorkoutSet =
        WorkoutSet.fromJson({...oldWorkoutSet.toJson(), ...data});

    workout.workoutSections[sectionIndex].workoutSets[setIndex] =
        updatedWorkoutSet;
    notifyListeners();

    /// Api.
    final variables = UpdateWorkoutSetArguments(
        data: UpdateWorkoutSetInput.fromJson(updatedWorkoutSet.toJson()));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: UpdateWorkoutSetMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets[setIndex] =
          WorkoutSet.fromJson({
        ...updatedWorkoutSet.toJson(),
        ...UpdateWorkoutSet$Mutation.fromJson(result.data!)
            .updateWorkoutSet
            .toJson(),
      });
    }

    notifyListeners();
  }

  void duplicateWorkoutSet(int sectionIndex, int setIndex) async {
    _backupAndMarkDirty();

    final workoutSets = workout.workoutSections[sectionIndex].workoutSets;
    final toDuplicate = workoutSets[setIndex];

    /// Client.
    workoutSets.insert(
        setIndex + 1,
        WorkoutSet.fromJson({
          ...toDuplicate.toJson(),
          'id': 'temp-${_setId++}',
        }));

    _updateWorkoutSetsSortPosition(workoutSets);

    notifyListeners();

    /// Api
    final variables = DuplicateWorkoutSetByIdArguments(id: toDuplicate.id);

    final result = await context.graphQLClient.mutate(MutationOptions(
        document:
            DuplicateWorkoutSetByIdMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workoutSets[setIndex + 1] = WorkoutSet.fromJson(
          DuplicateWorkoutSetById$Mutation.fromJson(result.data!)
              .duplicateWorkoutSetById
              .toJson());
    }

    notifyListeners();
  }

  void reorderWorkoutSets(int sectionIndex, int from, int to) async {
    // Check that user is not trying to move beyond the bounds of the list.
    if (to >= 0 &&
        to < workout.workoutSections[sectionIndex].workoutSets.length) {
      _backupAndMarkDirty();

      /// Client.
      final workoutSets = workout.workoutSections[sectionIndex].workoutSets;

      final inTransit = workoutSets.removeAt(from);
      workoutSets.insert(to, inTransit);

      _updateWorkoutSetsSortPosition(workoutSets);

      notifyListeners();

      /// Api.
      final variables = ReorderWorkoutSetsArguments(
          data: workoutSets
              .map((s) => UpdateSortPositionInput(
                  id: s.id, sortPosition: s.sortPosition))
              .toList());

      final result = await context.graphQLClient.mutate(MutationOptions(
          document: ReorderWorkoutSetsMutation(variables: variables).document,
          variables: variables.toJson()));

      final success = _checkApiResult(result);

      if (success) {
        /// Write new sort positions.
        final positions = ReorderWorkoutSets$Mutation.fromJson(result.data!)
            .reorderWorkoutSets;

        workoutSets.forEach((ws) {
          ws.sortPosition =
              positions.firstWhere((p) => p.id == ws.id).sortPosition;
        });
      }

      notifyListeners();
    }
  }

  void deleteWorkoutSet(int sectionIndex, int setIndex) async {
    _backupAndMarkDirty();

    final idToDelete =
        workout.workoutSections[sectionIndex].workoutSets[setIndex].id;
    final oldWorkoutSets = workout.workoutSections[sectionIndex].workoutSets;

    // Client.
    oldWorkoutSets.removeAt(setIndex);

    _updateWorkoutSetsSortPosition(oldWorkoutSets);

    notifyListeners();

    /// Api.
    final variables = DeleteWorkoutSetByIdArguments(id: idToDelete);

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: DeleteWorkoutSetByIdMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      final deletedId = DeleteWorkoutSetById$Mutation.fromJson(result.data!)
          .deleteWorkoutSetById;

      // If the ids do not match then there was a problem - revert the changes.
      if (idToDelete != deletedId) {
        _revertChanges(result.exception);
        notifyListeners();
      }
    }
  }

  /// Internal: Client
  WorkoutSet _genDefaultWorkoutSet(int sortPosition) => WorkoutSet()
    ..$$typename = 'WorkoutSet'
    ..id = (_setId++).toString()
    ..rounds = 1
    ..sortPosition = sortPosition
    ..workoutMoves = [];

  /// Internal: Client
  void _updateWorkoutSetsSortPosition(List<WorkoutSet> workoutSets) {
    workoutSets.forEachIndexed((i, workoutSet) {
      workoutSet.sortPosition = i;
    });
  }

  ////// WorkoutMove CRUD //////
  /// Add a workoutMove to a set.
  Future<void> createWorkoutMove(
      int sectionIndex, int setIndex, WorkoutMove workoutMove) async {
    _backupAndMarkDirty();

    // Until now the workoutMove has id 'tempId'
    // We need to give it something unique as the [ImplicitlyAnimatedReorderableList] uses id as a global key.
    workoutMove.id = 'temp-${_workoutMoveId++}';
    final workoutSetId =
        workout.workoutSections[sectionIndex].workoutSets[setIndex].id;

    /// Api only for create.
    final variables = CreateWorkoutMoveArguments(
        data: CreateWorkoutMoveInput(
            sortPosition: workoutMove.sortPosition,
            reps: workoutMove.reps,
            repType: workoutMove.repType,
            loadAmount: workoutMove.loadAmount,
            loadUnit: workoutMove.loadUnit,
            timeUnit: workoutMove.timeUnit,
            equipment: workoutMove.equipment != null
                ? ConnectRelationInput(id: workoutMove.equipment!.id)
                : null,
            distanceUnit: workoutMove.distanceUnit,
            move: ConnectRelationInput(id: workoutMove.move.id),
            workoutSet: ConnectRelationInput(id: workoutSetId)));

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: CreateWorkoutMoveMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves
          .add(WorkoutMove.fromJson(
        CreateWorkoutMove$Mutation.fromJson(result.data!)
            .createWorkoutMove
            .toJson(),
      ));
    }
    notifyListeners();
  }

  void editWorkoutMove(
      int sectionIndex, int setIndex, WorkoutMove workoutMove) async {
    _backupAndMarkDirty();

    /// Client.
    workout.workoutSections[sectionIndex].workoutSets[setIndex]
        .workoutMoves[workoutMove.sortPosition] = workoutMove;
    notifyListeners();

    /// Api.
    final variables = UpdateWorkoutMoveArguments(
        data: UpdateWorkoutMoveInput.fromJson(workoutMove.toJson()));

    final result = await context.graphQLClient.mutate(
      MutationOptions(
        document: UpdateWorkoutMoveMutation(variables: variables).document,
        variables: variables.toJson(),
      ),
    );

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets[setIndex]
          .workoutMoves[workoutMove.sortPosition] = WorkoutMove.fromJson(
        UpdateWorkoutMove$Mutation.fromJson(result.data!)
            .updateWorkoutMove
            .toJson(),
      );
    }

    notifyListeners();
  }

  void deleteWorkoutMove(
      int sectionIndex, int setIndex, int workoutMoveIndex) async {
    _backupAndMarkDirty();

    final workoutMoves = workout
        .workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves;

    final idToDelete = workoutMoves[workoutMoveIndex].id;

    // Client.
    workoutMoves.removeAt(workoutMoveIndex);

    _updateWorkoutMovesSortPosition(workoutMoves);

    notifyListeners();

    // Api.
    final variables = DeleteWorkoutMoveByIdArguments(id: idToDelete);

    final result = await context.graphQLClient.mutate(MutationOptions(
        document: DeleteWorkoutMoveByIdMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      final deletedId = DeleteWorkoutMoveById$Mutation.fromJson(result.data!)
          .deleteWorkoutMoveById;

      // If the ids do not match then there was a problem - revert the changes.
      if (idToDelete != deletedId) {
        _revertChanges(result.exception);
        notifyListeners();
      }
    }
  }

  void duplicateWorkoutMove(
      int sectionIndex, int setIndex, int workoutMoveIndex) async {
    _backupAndMarkDirty();

    final workoutMoves = workout
        .workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves;
    final toDuplicate = workoutMoves[workoutMoveIndex];

    /// Need to do a client side insert so that we can update the sort positions in all client side workoutMoves.
    workoutMoves.insert(
        workoutMoveIndex + 1,
        WorkoutMove.fromJson({
          ...toDuplicate.toJson(),
          'id': 'temp-${_workoutMoveId++}',
        }));

    _updateWorkoutMovesSortPosition(workoutMoves);

    /// Api only for duplication
    /// If we do optimistic client update then the user can immediately click to edit a workoutMove with a temp id that does not exist in the DB - causing network error on an update mutation request.
    final variables = DuplicateWorkoutMoveByIdArguments(id: toDuplicate.id);

    final result = await context.graphQLClient.mutate(MutationOptions(
        document:
            DuplicateWorkoutMoveByIdMutation(variables: variables).document,
        variables: variables.toJson()));

    final success = _checkApiResult(result);

    if (success) {
      workoutMoves[workoutMoveIndex + 1] = WorkoutMove.fromJson(
          DuplicateWorkoutMoveById$Mutation.fromJson(result.data!)
              .duplicateWorkoutMoveById
              .toJson());
    }

    notifyListeners();
  }

  void reorderWorkoutMoves(
      int sectionIndex, int setIndex, int from, int to) async {
    // https://api.flutter.dev/flutter/material/ReorderableListView-class.html
    // // Necessary because of how flutters reorderable list calculates drop position...I think.
    final moveTo = from < to ? to - 1 : to;

    // Check that user is not trying to move beyond the bounds of the list.
    if (moveTo >= 0 &&
        moveTo <
            workout.workoutSections[sectionIndex].workoutSets[setIndex]
                .workoutMoves.length) {
      _backupAndMarkDirty();

      final workoutMoves = workout
          .workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves;

      final inTransit = workoutMoves.removeAt(from);
      workoutMoves.insert(moveTo, inTransit);

      _updateWorkoutMovesSortPosition(workoutMoves);

      notifyListeners();

      /// Api.
      final variables = ReorderWorkoutMovesArguments(
          data: workoutMoves
              .map((s) => UpdateSortPositionInput(
                  id: s.id, sortPosition: s.sortPosition))
              .toList());

      final result = await context.graphQLClient.mutate(MutationOptions(
          document: ReorderWorkoutMovesMutation(variables: variables).document,
          variables: variables.toJson()));

      final success = _checkApiResult(result);

      if (success) {
        /// Write new sort positions.
        final positions = ReorderWorkoutMoves$Mutation.fromJson(result.data!)
            .reorderWorkoutMoves;

        workoutMoves.forEach((wm) {
          wm.sortPosition =
              positions.firstWhere((p) => p.id == wm.id).sortPosition;
        });
      }

      notifyListeners();
    }
  }

  void _updateWorkoutMovesSortPosition(List<WorkoutMove> workoutMoves) {
    workoutMoves.forEachIndexed((i, workoutMove) {
      workoutMove.sortPosition = i;
    });
  }
}
