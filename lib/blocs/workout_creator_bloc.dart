import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
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
  final bool isCreate;

  WorkoutCreatorBloc(
      {required this.initialWorkout,
      required this.context,
      required this.isCreate})
      : workout = initialWorkout;

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

  /// Users should not be able to navigate away from the media page while this in in progress.
  /// Otherwise the upload will fail and throw an error.
  /// The top right 'done' button should also be disabled.
  bool uploadingMedia = false;
  void setUploadingMedia(bool uploading) {
    uploadingMedia = uploading;
    notifyListeners();
  }

  /// The main data that gets edited on the client by the user.
  Workout workout;

  /// Before every update we make a copy of the last workout here.
  /// If there is an issue calling the api then this is reverted to.
  Map<String, dynamic> backupJson = {};

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

        final result = await context.graphQLStore
            .mutate<CreateWorkout$Mutation, CreateWorkoutArguments>(
                mutation: CreateWorkoutMutation(variables: variables),
                writeToStore: false);

        if (result.hasErrors || result.data == null) {
          throw Exception(
              'There was a problem creating a new workout in the database.');
        }

        final newWorkout = Workout.fromJson(
            {...result.data!.createWorkout.toJson(), 'WorkoutSections': []});

        context.showToast(message: 'Workout Created');
        return newWorkout;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Send all new data to the graphql store and broadcast new data to streams.
  /// The api has been updating incrementally so does not need further update here.
  /// When updating data in this bloc we write to the bloc data and to the network only.
  /// Not to the client store. This is for two reasons.
  /// 1. Sections, sets and workoutMoves do not get normalized in the store. The object of normalization is the workout. The data returned from a network update on a section or set, for example, does not contain the necessary data for it to be normalized into the store. I.e it would need to be returned within the full workout object.
  /// 2. Witholding these store updates means that you get some optimisation in that UI in the background stack is not being updated every single time a small update is made by the user.
  /// Store gets written and the UI gets updated when the user clicks [done].
  /// This flow should be reviewed at some point.
  bool saveAllChanges() {
    /// When editing you have (currently!) come from the workout details page which is being fed by an observable query with id [workoutById({id: id})].
    /// This may need revisiting if there is a way the user can edit a workout without first opening up this page where this query will be registered.
    final success = context.graphQLStore.writeDataToStore(
      data: workout.toJson(),

      /// [addRefToQueries] does a broadcast automatically when done.
      addRefToQueries: isCreate ? [UserWorkoutsQuery().operationName] : [],
      broadcastQueryIds: isCreate
          ? []
          : [
              GQLVarParamKeys.workoutByIdQuery(initialWorkout.id),
              UserWorkoutsQuery().operationName
            ],
    );
    return success;
  }

  /// Should run at the start of all CRUD ops.
  void _backupAndMarkDirty() {
    formIsDirty = true;
    backupJson = workout.toJson();
  }

  void _revertChanges(List<Object>? errors) {
    // There was an error so revert to backup, notify listeners and show error toast.
    workout = Workout.fromJson(backupJson);
    if (errors != null && errors.isNotEmpty) {
      for (final e in errors) {
        print(e.toString());
      }
    }
    context.showToast(
        message: 'There was a problem, changes not saved',
        toastType: ToastType.destructive);
  }

  bool _checkApiResult(MutationResult result) {
    if (result.hasErrors || result.data == null) {
      _revertChanges(result.errors!);
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

    final result = await context.graphQLStore
        .mutate<UpdateWorkout$Mutation, UpdateWorkoutArguments>(
            mutation: UpdateWorkoutMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workout = Workout.fromJson(
          {...workout.toJson(), ...result.data!.updateWorkout.toJson()});
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

    final result = await context.graphQLStore
        .mutate<CreateWorkoutSection$Mutation, CreateWorkoutSectionArguments>(
            mutation: CreateWorkoutSectionMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections.add(
          WorkoutSection.fromJson(result.data!.createWorkoutSection.toJson()));
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

    final result = await context.graphQLStore
        .mutate<UpdateWorkoutSection$Mutation, UpdateWorkoutSectionArguments>(
            mutation: UpdateWorkoutSectionMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[index] = WorkoutSection.fromJson({
        ...updatedWorkoutSection.toJson(),
        ...result.data!.updateWorkoutSection.toJson()
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

      final result = await context.graphQLStore.mutate<
              ReorderWorkoutSections$Mutation, ReorderWorkoutSectionsArguments>(
          mutation: ReorderWorkoutSectionsMutation(variables: variables),
          writeToStore: false);

      final success = _checkApiResult(result);

      if (success) {
        final positions = result.data!.reorderWorkoutSections;

        /// Write new sort positions.
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

    final result = await context.graphQLStore.networkOnlyDelete<
            DeleteWorkoutSectionById$Mutation,
            DeleteWorkoutSectionByIdArguments>(
        mutation: DeleteWorkoutSectionByIdMutation(variables: variables));

    final success = _checkApiResult(result);

    if (success) {
      final deletedId = result.data!.deleteWorkoutSectionById;

      // If the ids do not match then there was a problem - revert the changes.
      if (idToDelete != deletedId) {
        _revertChanges(result.errors);
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
  /// Function is returning a workoutSet so that the caller can then immediately create a workoutMove to go in it if needed. Works in combination with [shouldNotifyListeners]. When done creating the workout move will call notifyListeners() and all UI will be updated.
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

    final result = await context.graphQLStore
        .mutate<CreateWorkoutSet$Mutation, CreateWorkoutSetArguments>(
            mutation: CreateWorkoutSetMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    WorkoutSet? createdSet;

    if (success) {
      createdSet = WorkoutSet.fromJson(
          {...result.data!.createWorkoutSet.toJson(), 'WorkoutMoves': []});

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

    final result = await context.graphQLStore
        .mutate<UpdateWorkoutSet$Mutation, UpdateWorkoutSetArguments>(
            mutation: UpdateWorkoutSetMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets[setIndex] =
          WorkoutSet.fromJson({
        ...updatedWorkoutSet.toJson(),
        ...result.data!.updateWorkoutSet.toJson(),
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

    final result = await context.graphQLStore.mutate<
            DuplicateWorkoutSetById$Mutation, DuplicateWorkoutSetByIdArguments>(
        mutation: DuplicateWorkoutSetByIdMutation(variables: variables),
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      final updated = result.data!.duplicateWorkoutSetById;
      // Write over the client write above.
      workoutSets[setIndex + 1] = WorkoutSet()
        ..$$typename = updated.$$typename
        ..id = updated.id
        ..sortPosition = updated.sortPosition
        ..rounds = updated.rounds
        ..duration = updated.duration
        ..workoutMoves =
            updated.workoutMoves.sortedBy<num>((wm) => wm.sortPosition);
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

      final result = await context.graphQLStore
          .mutate<ReorderWorkoutSets$Mutation, ReorderWorkoutSetsArguments>(
              mutation: ReorderWorkoutSetsMutation(variables: variables),
              writeToStore: false);

      final success = _checkApiResult(result);

      if (success) {
        /// Write new sort positions.
        final positions = result.data!.reorderWorkoutSets;

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

    final result = await context.graphQLStore.networkOnlyDelete<
            DeleteWorkoutSetById$Mutation, DeleteWorkoutSetByIdArguments>(
        mutation: DeleteWorkoutSetByIdMutation(variables: variables));

    final success = _checkApiResult(result);

    if (success) {
      final deletedId = result.data!.deleteWorkoutSetById;

      // If the ids do not match then there was a problem - revert the changes.
      if (idToDelete != deletedId) {
        _revertChanges(result.errors);
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

    final result = await context.graphQLStore
        .mutate<CreateWorkoutMove$Mutation, CreateWorkoutMoveArguments>(
            mutation: CreateWorkoutMoveMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves
          .add(WorkoutMove.fromJson(
        result.data!.createWorkoutMove.toJson(),
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

    final result = await context.graphQLStore
        .mutate<UpdateWorkoutMove$Mutation, UpdateWorkoutMoveArguments>(
            mutation: UpdateWorkoutMoveMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets[setIndex]
          .workoutMoves[workoutMove.sortPosition] = WorkoutMove.fromJson(
        result.data!.updateWorkoutMove.toJson(),
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

    final result = await context.graphQLStore.networkOnlyDelete<
            DeleteWorkoutMoveById$Mutation, DeleteWorkoutMoveByIdArguments>(
        mutation: DeleteWorkoutMoveByIdMutation(variables: variables));

    final success = _checkApiResult(result);

    if (success) {
      final deletedId = result.data!.deleteWorkoutMoveById;

      // If the ids do not match then there was a problem - revert the changes.
      if (idToDelete != deletedId) {
        _revertChanges(result.errors);
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

    final result = await context.graphQLStore.mutate<
            DuplicateWorkoutMoveById$Mutation,
            DuplicateWorkoutMoveByIdArguments>(
        mutation: DuplicateWorkoutMoveByIdMutation(variables: variables),
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workoutMoves[workoutMoveIndex + 1] =
          WorkoutMove.fromJson(result.data!.duplicateWorkoutMoveById.toJson());
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

      final result = await context.graphQLStore
          .mutate<ReorderWorkoutMoves$Mutation, ReorderWorkoutMovesArguments>(
              mutation: ReorderWorkoutMovesMutation(variables: variables),
              writeToStore: false);

      final success = _checkApiResult(result);

      if (success) {
        final positions = result.data!.reorderWorkoutMoves;

        // Write new sort positions.
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
