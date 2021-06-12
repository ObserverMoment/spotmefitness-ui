import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

/// All updates to workout plan or descendants follow this pattern.
/// 1: Update local data
/// 2. Notify listeners so UI rebuilds optimistically
/// 3. Call API mutation (if not a create op).
/// 4. Check response is what was expected.
/// 5. If not then roll back local state changes and display error message.
/// 6: If ok then action is complete.
class WorkoutPlanCreatorBloc extends ChangeNotifier {
  final WorkoutPlan initialWorkoutPlan;
  final BuildContext context;
  final bool isCreate;

  WorkoutPlanCreatorBloc(
      {required this.initialWorkoutPlan,
      required this.context,
      required this.isCreate})
      : workoutPlan = initialWorkoutPlan;

  bool formIsDirty = false;

  /// The main data that gets edited on the client by the user.
  WorkoutPlan workoutPlan;

  /// Before every update we make a copy of the last workout plan here.
  /// If there is an issue calling the api then this is reverted to.
  Map<String, dynamic> backupJson = {};

  /// Users should not be able to navigate away from the media page while this in in progress.
  /// Otherwise the upload will fail and throw an error.
  /// The top right 'done' button should also be disabled.
  bool uploadingMedia = false;
  void setUploadingMedia(bool uploading) {
    uploadingMedia = uploading;
    notifyListeners();
  }

  /// Run this before constructing the bloc
  static Future<WorkoutPlan> initialize(
      BuildContext context, WorkoutPlan? prevWorkoutPlan) async {
    try {
      if (prevWorkoutPlan != null) {
        // User is editing a previous workout plan - return a copy.
        // First ensure that all child lists are sorted by sort position.
        /// Reordering ops in this bloc use [list.remove] and [list.insert] whch requires that the initial sort order is correct.
        return prevWorkoutPlan;
      } else {
        // User is creating - make an empty workout plan in the db and return.
        final variables = CreateWorkoutPlanArguments(
          data: CreateWorkoutPlanInput(
              name: 'Workout Plan ${DateTime.now().dateString}',
              lengthWeeks: 2,
              contentAccessScope: ContentAccessScope.private),
        );

        final result = await context.graphQLStore
            .mutate<CreateWorkoutPlan$Mutation, CreateWorkoutPlanArguments>(
                mutation: CreateWorkoutPlanMutation(variables: variables),
                writeToStore: false);

        if (result.hasErrors || result.data == null) {
          throw Exception(
              'There was a problem creating a new workout plan in the database.');
        }

        /// Only the [UserSummary] sub field is returned by the create resolver.
        /// Add these fields manually to avoid [fromJson] throwing an error.
        final newWorkoutPlan = WorkoutPlan.fromJson({
          ...result.data!.createWorkoutPlan.toJson(),
          'WorkoutPlanDays': [],
          'Enrolments': [],
          'WorkoutPlanReviews': [],
          'WorkoutTags': []
        });

        context.showToast(message: 'Workout Plan Created');
        return newWorkoutPlan;
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
    /// When editing you have (currently!) come from the workout details page which is being fed by an observable query with id [workoutPlanById({id: id})].
    /// This may need revisiting if there is a way the user can edit a workout without first opening up this page where this query will be registered.
    final success = context.graphQLStore.writeDataToStore(
      data: workoutPlan.toJson(),

      /// [addRefToQueries] does a broadcast automatically when done.
      addRefToQueries: isCreate ? [UserWorkoutPlansQuery().operationName] : [],
      broadcastQueryIds: isCreate
          ? []
          : [
              GQLVarParamKeys.workoutPlanByIdQuery(initialWorkoutPlan.id),
              UserWorkoutPlansQuery().operationName
            ],
    );
    return success;
  }

  /// Should run at the start of all CRUD ops.
  void _backupAndMarkDirty() {
    formIsDirty = true;
    backupJson = workoutPlan.toJson();
  }

  void _revertChanges(List<Object>? errors) {
    // There was an error so revert to backup, notify listeners and show error toast.
    workoutPlan = WorkoutPlan.fromJson(backupJson);
    if (errors != null && errors.isNotEmpty) {
      for (final e in errors) {
        print(e.toString());
      }
    }
    context.showToast(
        message: 'There was a problem, changes not saved',
        toastType: ToastType.destructive);
    notifyListeners();
  }

  /// Checks that there were no errors and also
  bool _checkApiResult(MutationResult result) {
    if (result.hasErrors || result.data == null) {
      _revertChanges(result.errors!);
      return false;
    } else {
      return true;
    }
  }

  /// TODO: Hacky? Re-think.
  /// Makes a copy so that the UI (provider [select<>()] check) spots the updates.
  /// Data flow probably needs more thought.
  List<WorkoutPlanDay> _copyWorkoutPlanDays(int dayNumber) => workoutPlan
      .workoutPlanDays
      .map((d) =>
          d.dayNumber == dayNumber ? WorkoutPlanDay.fromJson(d.toJson()) : d)
      .toList();

  ///// WorkoutPlan CRUD /////
  ////////////////////////////
  void updateWorkoutPlanMeta(Map<String, dynamic> data) async {
    /// Client / Optimistic
    _backupAndMarkDirty();
    workoutPlan = WorkoutPlan.fromJson({...workoutPlan.toJson(), ...data});
    notifyListeners();

    /// Api
    final variables = UpdateWorkoutPlanArguments(
        data: UpdateWorkoutPlanInput.fromJson(
            {...workoutPlan.toJson(), ...data}));

    final result = await context.graphQLStore
        .mutate<UpdateWorkoutPlan$Mutation, UpdateWorkoutPlanArguments>(
            mutation: UpdateWorkoutPlanMutation(variables: variables),
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workoutPlan = WorkoutPlan.fromJson({
        ...workoutPlan.toJson(),
        ...result.data!.updateWorkoutPlan.toJson()
      });
    }

    notifyListeners();
  }

  /// When reducing we need to delete all of the WorkoutPlanDays that happen later than the time period that the user is reducing the plan to.
  Future<void> reduceWorkoutPlanlength(int lengthWeeks) async {
    /// Client / Optimistic
    _backupAndMarkDirty();
    workoutPlan = WorkoutPlan.fromJson(workoutPlan.toJson());
    workoutPlan.lengthWeeks = lengthWeeks;
    notifyListeners();

    /// API
    final idsToDelete = workoutPlan.workoutPlanDays
        .where((d) => d.dayNumber > (7 * lengthWeeks) - 1)
        .map((d) => d.id)
        .toList();

    final variables = DeleteWorkoutPlanDaysByIdArguments(ids: idsToDelete);

    final result = await context.graphQLStore.networkOnlyDelete<
            DeleteWorkoutPlanDaysById$Mutation,
            DeleteWorkoutPlanDaysByIdArguments>(
        mutation: DeleteWorkoutPlanDaysByIdMutation(variables: variables));

    final success = _checkApiResult(result);

    if (success) {
      final deletedIds = result.data!.deleteWorkoutPlanDaysById;
      // If the ids do not match then there was a problem - revert the changes.
      if (!UnorderedIterableEquality().equals(idsToDelete, deletedIds)) {
        _revertChanges(result.errors);
        notifyListeners();
      }
    }
  }

  ///// WorkoutPlanDay CRUD /////
  ///////////////////////////////
  Future<void> createWorkoutPlanDayWithWorkout(
      int dayNumber, Workout workout) async {
    /// Client / Optimistic
    _backupAndMarkDirty();
    final tempWorkoutPlanDay = WorkoutPlanDay()
      ..id = Uuid().v1()
      ..dayNumber = dayNumber
      ..workoutPlanDayWorkouts = [
        WorkoutPlanDayWorkout()
          ..id = Uuid().v1()
          ..sortPosition = 0
          ..workout = workout
      ];

    workoutPlan.workoutPlanDays.add(tempWorkoutPlanDay);
    notifyListeners();

    /// Api.
    final variables = CreateWorkoutPlanDayWithWorkoutArguments(
        data: CreateWorkoutPlanDayWithWorkoutInput(
            dayNumber: dayNumber,
            workout: ConnectRelationInput(id: workout.id),
            workoutPlan: ConnectRelationInput(id: workoutPlan.id)));

    final result = await context.graphQLStore.mutate<
            CreateWorkoutPlanDayWithWorkout$Mutation,
            CreateWorkoutPlanDayWithWorkoutArguments>(
        mutation: CreateWorkoutPlanDayWithWorkoutMutation(variables: variables),
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
          .map((d) => d.id == tempWorkoutPlanDay.id
              ? result.data!.createWorkoutPlanDayWithWorkout
              : d)
          .toList();

      notifyListeners();
    }
  }

  Future<void> addNoteToWorkoutPlanDay(int dayNumber, String note) async {
    /// Client / Optimistic
    _backupAndMarkDirty();

    workoutPlan.workoutPlanDays = _copyWorkoutPlanDays(dayNumber);

    final dayToUpdate =
        workoutPlan.workoutPlanDays.firstWhere((d) => d.dayNumber == dayNumber);
    dayToUpdate.note = note;
    notifyListeners();

    /// Api
    final variables = UpdateWorkoutPlanDayArguments(
        data: UpdateWorkoutPlanDayInput(id: dayToUpdate.id));

    final result = await context.graphQLStore
        .mutate<UpdateWorkoutPlanDay$Mutation, UpdateWorkoutPlanDayArguments>(
            mutation: UpdateWorkoutPlanDayMutation(variables: variables),
            customVariablesMap: {
              'data': {'id': dayToUpdate.id, 'note': note}
            },
            writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
          .map((d) =>
              d.id == dayToUpdate.id ? result.data!.updateWorkoutPlanDay : d)
          .toList();

      notifyListeners();
    }
  }

  /// Moves it to another day by changing the dayNumber.
  Future<void> moveWorkoutPlanDay(int fromDayNumber, int toDayNumber) async {
    /// Client / Optimistic
    _backupAndMarkDirty();

    /// Check if there is content on the day we are moving to.
    if (workoutPlan.workoutPlanDays
            .firstWhereOrNull((d) => d.dayNumber == toDayNumber) !=
        null) {
      /// If there is then filter it out it.
      workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
          .where((d) => d.dayNumber != toDayNumber)
          .toList();
    }

    final dayToUpdate = WorkoutPlanDay.fromJson(workoutPlan.workoutPlanDays
        .firstWhere((d) => d.dayNumber == fromDayNumber)
        .toJson());
    dayToUpdate.dayNumber = toDayNumber;

    workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
        .map((d) => d.dayNumber == fromDayNumber ? dayToUpdate : d)
        .toList();

    notifyListeners();

    /// Api.
    final variables = MoveWorkoutPlanDayToAnotherDayArguments(
        data: MoveWorkoutPlanDayToAnotherDayInput(
            id: dayToUpdate.id, moveToDay: toDayNumber));

    final result = await context.graphQLStore.mutate<
            MoveWorkoutPlanDayToAnotherDay$Mutation,
            MoveWorkoutPlanDayToAnotherDayArguments>(
        mutation: MoveWorkoutPlanDayToAnotherDayMutation(variables: variables),
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
          .map((d) => d.id == dayToUpdate.id
              ? result.data!.moveWorkoutPlanDayToAnotherDay
              : d)
          .toList();

      notifyListeners();
    }
  }

  /// Copy contents that at workoutPlanDay.dayNumber and add to another day.
  Future<void> copyWorkoutPlanDay(int fromDayNumber, int toDayNumber) async {
    /// Client / Optimistic
    _backupAndMarkDirty();

    /// Check if there is content on the day we are copying to.
    if (workoutPlan.workoutPlanDays
            .firstWhereOrNull((d) => d.dayNumber == toDayNumber) !=
        null) {
      /// If there is then filter it out it.
      workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
          .where((d) => d.dayNumber != toDayNumber)
          .toList();
    }

    final copyDayToMove = WorkoutPlanDay.fromJson(workoutPlan.workoutPlanDays
        .firstWhere((d) => d.dayNumber == fromDayNumber)
        .toJson());

    final originalIdToCopy = copyDayToMove.id;

    copyDayToMove.id = Uuid().v1();
    copyDayToMove.dayNumber = toDayNumber;

    workoutPlan.workoutPlanDays = [
      ...workoutPlan.workoutPlanDays,
      copyDayToMove
    ];

    notifyListeners();

    /// Api.
    final variables = CopyWorkoutPlanDayToAnotherDayArguments(
        data: CopyWorkoutPlanDayToAnotherDayInput(
            id: originalIdToCopy, copyToDay: toDayNumber));

    final result = await context.graphQLStore.mutate<
            CopyWorkoutPlanDayToAnotherDay$Mutation,
            CopyWorkoutPlanDayToAnotherDayArguments>(
        mutation: CopyWorkoutPlanDayToAnotherDayMutation(variables: variables),
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
          .map((d) => d.id == copyDayToMove.id
              ? result.data!.copyWorkoutPlanDayToAnotherDay
              : d)
          .toList();

      notifyListeners();
    }
  }

  Future<void> deleteWorkoutPlanDay(int dayNumber) async {
    /// Client / Optimistic
    _backupAndMarkDirty();
    final dayToDelete =
        workoutPlan.workoutPlanDays.firstWhere((d) => d.dayNumber == dayNumber);

    workoutPlan.workoutPlanDays =
        workoutPlan.workoutPlanDays.where((d) => d != dayToDelete).toList();
    notifyListeners();

    /// Api
    /// As this resolver works via batch delete we cast to []
    /// Then do an unordered list equality check on the api result to check success.
    final idsToDelete = [dayToDelete.id];

    final variables = DeleteWorkoutPlanDaysByIdArguments(ids: idsToDelete);

    final result = await context.graphQLStore.networkOnlyDelete<
            DeleteWorkoutPlanDaysById$Mutation,
            DeleteWorkoutPlanDaysByIdArguments>(
        mutation: DeleteWorkoutPlanDaysByIdMutation(variables: variables));

    final success = _checkApiResult(result);

    if (success) {
      final deletedIds = result.data!.deleteWorkoutPlanDaysById;
      // If the ids do not match then there was a problem - revert the changes.
      if (!UnorderedIterableEquality().equals(idsToDelete, deletedIds)) {
        _revertChanges(result.errors);
        notifyListeners();
      }
    }
  }

  ///// WorkoutPlanDayWorkout CRUD /////
  //////////////////////////////////////
  /// In an already created WorkoutPlanDay - specified by its day number in the plan.
  Future<void> createWorkoutPlanDayWorkout(
      int dayNumber, Workout workout) async {
    /// Client / Optimistic
    _backupAndMarkDirty();
    final dayToUpdate =
        workoutPlan.workoutPlanDays.firstWhere((d) => d.dayNumber == dayNumber);

    final sortPosition = dayToUpdate.workoutPlanDayWorkouts.length;

    dayToUpdate.workoutPlanDayWorkouts.add(WorkoutPlanDayWorkout()
      ..id = Uuid().v1()
      ..sortPosition = sortPosition
      ..workout = workout);
    notifyListeners();

    /// Api
    final variables = CreateWorkoutPlanDayWorkoutArguments(
        data: CreateWorkoutPlanDayWorkoutInput(
            sortPosition: sortPosition,
            workout: ConnectRelationInput(id: workout.id),
            workoutPlanDay: ConnectRelationInput(id: dayToUpdate.id)));

    final result = await context.graphQLStore.mutate<
            CreateWorkoutPlanDayWorkout$Mutation,
            CreateWorkoutPlanDayWorkoutArguments>(
        mutation: CreateWorkoutPlanDayWorkoutMutation(variables: variables),
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      final updated = result.data!.createWorkoutPlanDayWorkout;
      dayToUpdate.workoutPlanDayWorkouts = dayToUpdate.workoutPlanDayWorkouts
          .map((w) => w.sortPosition == updated.sortPosition ? updated : w)
          .toList();

      notifyListeners();
    }
  }

  Future<void> addNoteToWorkoutPlanDayWorkout(int dayNumber, String note,
      WorkoutPlanDayWorkout workoutPlanDayWorkout) async {
    /// Client / Optimistic
    _backupAndMarkDirty();

    workoutPlan.workoutPlanDays = _copyWorkoutPlanDays(dayNumber);

    final dayToUpdate =
        workoutPlan.workoutPlanDays.firstWhere((d) => d.dayNumber == dayNumber);

    workoutPlanDayWorkout.note = note;

    notifyListeners();

    /// Api
    final idToUpdate = workoutPlanDayWorkout.id;
    final variables = UpdateWorkoutPlanDayWorkoutArguments(
        data: UpdateWorkoutPlanDayWorkoutInput(id: idToUpdate));

    final result = await context.graphQLStore.mutate<
            UpdateWorkoutPlanDayWorkout$Mutation,
            UpdateWorkoutPlanDayWorkoutArguments>(
        mutation: UpdateWorkoutPlanDayWorkoutMutation(variables: variables),
        customVariablesMap: {
          'data': {'id': idToUpdate, 'note': note}
        },
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      final updated = result.data!.updateWorkoutPlanDayWorkout;
      dayToUpdate.workoutPlanDayWorkouts = dayToUpdate.workoutPlanDayWorkouts
          .map((w) => w.id == updated.id ? updated : w)
          .toList();

      notifyListeners();
    }
  }

  Future<void> reorderWorkoutPlanWorkoutsInDay(
      int dayNumber, int from, int to) async {
    /// Client / Optimistic
    _backupAndMarkDirty();

    workoutPlan.workoutPlanDays = _copyWorkoutPlanDays(dayNumber);

    final dayToUpdate =
        workoutPlan.workoutPlanDays.firstWhere((d) => d.dayNumber == dayNumber);

    final inTransit = dayToUpdate.workoutPlanDayWorkouts.removeAt(from);
    dayToUpdate.workoutPlanDayWorkouts.insert(to, inTransit);

    _updateWorkoutPlanDayWorkoutSortPositions(dayToUpdate);

    notifyListeners();

    /// Api
    final variables = ReorderWorkoutPlanDayWorkoutsArguments(
        data: dayToUpdate.workoutPlanDayWorkouts
            .map((sw) => UpdateSortPositionInput(
                id: sw.id, sortPosition: sw.sortPosition))
            .toList());

    final result = await context.graphQLStore.mutate<
            ReorderWorkoutPlanDayWorkouts$Mutation,
            ReorderWorkoutPlanDayWorkoutsArguments>(
        mutation: ReorderWorkoutPlanDayWorkoutsMutation(variables: variables),
        writeToStore: false);

    final success = _checkApiResult(result);

    if (success) {
      /// From the API - overwrite client side data to be certain you have latest correct data.
      final updatedPositions = result.data!.reorderWorkoutPlanDayWorkouts;

      /// Write new sort positions.
      dayToUpdate.workoutPlanDayWorkouts.forEach((w) {
        w.sortPosition =
            updatedPositions.firstWhere((p) => p.id == w.id).sortPosition;
      });

      notifyListeners();
    }
  }

  Future<void> deleteWorkoutPlanDayWorkout(
      int dayNumber, WorkoutPlanDayWorkout workoutPlanDayWorkout) async {
    /// Client / Optimistic
    _backupAndMarkDirty();

    final dayToUpdate = WorkoutPlanDay.fromJson(workoutPlan.workoutPlanDays
        .firstWhere((d) => d.dayNumber == dayNumber)
        .toJson());

    dayToUpdate.workoutPlanDayWorkouts
        .removeWhere((w) => w == workoutPlanDayWorkout);

    workoutPlan.workoutPlanDays = workoutPlan.workoutPlanDays
        .map((d) => d.dayNumber == dayNumber ? dayToUpdate : d)
        .toList();

    _updateWorkoutPlanDayWorkoutSortPositions(dayToUpdate);
    notifyListeners();

    /// Api
    final variables =
        DeleteWorkoutPlanDayWorkoutByIdArguments(id: workoutPlanDayWorkout.id);

    final result = await context.graphQLStore.networkOnlyDelete<
            DeleteWorkoutPlanDayWorkoutById$Mutation,
            DeleteWorkoutPlanDayWorkoutByIdArguments>(
        mutation:
            DeleteWorkoutPlanDayWorkoutByIdMutation(variables: variables));

    final success = _checkApiResult(result);

    if (success) {
      final deletedId = result.data!.deleteWorkoutPlanDayWorkoutById;

      // If the ids do not match then there was a problem - revert the changes.
      if (workoutPlanDayWorkout.id != deletedId) {
        _revertChanges(result.errors);
        notifyListeners();
      }
    }
  }

  void _updateWorkoutPlanDayWorkoutSortPositions(
      WorkoutPlanDay workoutPlanDay) {
    workoutPlanDay.workoutPlanDayWorkouts
        .forEachIndexed((index, workoutPlanDayWorkout) {
      workoutPlanDayWorkout.sortPosition = index;
    });
  }
}
