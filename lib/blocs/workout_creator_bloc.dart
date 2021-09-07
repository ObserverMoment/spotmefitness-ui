import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

class WorkoutCreatorBloc extends ChangeNotifier {
  final BuildContext context;

  /// The main data that gets edited on the client by the user.
  late Workout workout;

  /// Before every update we make a copy of the last workout here.
  /// If there is an issue calling the api then this is reverted to.
  late Map<String, dynamic> backupJson = {};

  WorkoutCreatorBloc(this.context, Workout initialWorkout) {
    workout = Workout.fromJson(initialWorkout.toJson());
    backupJson = workout.toJson();
  }

  /// Use when creating new objects which have to wait for network responses before updating the UI with their presence.
  bool creatingSection = false;
  bool creatingSet = false;
  bool creatingMove = false;

  /// Send all new data to the graphql store and broadcast new data to streams.
  /// The api has been updating incrementally so does not need further update here.
  /// When updating data in this bloc we write to the bloc data and to the network only.
  /// Not to the client store. This is for two reasons.
  /// 1. Sections, sets and workoutMoves do not get normalized in the store. The object of normalization is the workout. The data returned from a network update on a section or set, for example, does not contain the necessary data for it to be normalized into the store. I.e it would need to be returned within the full workout object.
  /// 2. Witholding these store updates means that you get some optimisation in that UI in that the background stack is not being updated every time a small update is made by the user.
  /// Store gets written and the UI gets updated when the user clicks [done].
  /// This flow should be reviewed at some point.
  bool saveAllChanges() {
    final success = context.graphQLStore.writeDataToStore(
      data: workout.toJson(),
      broadcastQueryIds: [
        GQLVarParamKeys.workoutByIdQuery(workout.id),
        GQLOpNames.userScheduledWorkoutsQuery,
        GQLOpNames.userWorkoutsQuery,
      ],
    );
    return success;
  }

  /// Helpers for write methods.
  /// Should run at the start of all CRUD ops.
  void _backup() {
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

  /// When false workout sets are displayed as a minimal single line item.
  /// To allow clear overview and to make re-ordering more simple.
  bool showFullSetInfo = true;
  void toggleShowFullSetInfo() {
    showFullSetInfo = !showFullSetInfo;
    notifyListeners();
  }

  /// Users should not be able to navigate away from the media page while this in in progress.
  /// Otherwise the upload will fail and throw an error.
  /// The top right 'done' button should also be disabled.
  bool uploadingMedia = false;
  void setUploadingMedia(bool uploading) {
    uploadingMedia = uploading;
    notifyListeners();
  }

  void updateWorkoutMeta(Map<String, dynamic> data) async {
    /// Client / Optimistic
    _backup();
    workout = Workout.fromJson({...workout.toJson(), ...data});
    notifyListeners();

    /// Api
    final variables = UpdateWorkoutArguments(
        data: UpdateWorkoutInput.fromJson(workout.toJson()));

    final result = await context.graphQLStore
        .networkOnlyOperation<UpdateWorkout$Mutation, UpdateWorkoutArguments>(
      operation: UpdateWorkoutMutation(variables: variables),
    );

    final success = _checkApiResult(result);

    if (success) {
      workout = Workout.fromJson(
          {...workout.toJson(), ...result.data!.updateWorkout.toJson()});
    }

    notifyListeners();
  }

  ////// WorkoutSection CRUD //////
  Future<void> createWorkoutSection(WorkoutSection workoutSection) async {
    _backup();
    creatingSection = true;
    notifyListeners();

    /// New sections go in last position by default.
    final nextIndex = workout.workoutSections.length;

    /// Api only for creates.
    final variables = CreateWorkoutSectionArguments(
        data: CreateWorkoutSectionInput(
            sortPosition: nextIndex,
            name: workoutSection.name,
            timecap: workoutSection.timecap,
            workout: ConnectRelationInput(id: workout.id),
            workoutSectionType: ConnectRelationInput(
                id: workoutSection.workoutSectionType.id)));

    final result = await context.graphQLStore.networkOnlyOperation<
        CreateWorkoutSection$Mutation, CreateWorkoutSectionArguments>(
      operation: CreateWorkoutSectionMutation(variables: variables),
    );

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
    _backup();
    final updatedWorkoutSection = WorkoutSection.fromJson(
        {...workout.workoutSections[index].toJson(), ...data});

    workout.workoutSections[index] = WorkoutSection.fromJson(
        {...workout.workoutSections[index].toJson(), ...data});

    notifyListeners();

    /// Api
    final variables = UpdateWorkoutSectionArguments(
        data:
            UpdateWorkoutSectionInput.fromJson(updatedWorkoutSection.toJson()));

    final result = await context.graphQLStore.networkOnlyOperation<
        UpdateWorkoutSection$Mutation, UpdateWorkoutSectionArguments>(
      operation: UpdateWorkoutSectionMutation(variables: variables),
    );

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
      _backup();

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

      final result = await context.graphQLStore.networkOnlyOperation<
          ReorderWorkoutSections$Mutation, ReorderWorkoutSectionsArguments>(
        operation: ReorderWorkoutSectionsMutation(variables: variables),
      );

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
    _backup();

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
  /// [defaults] used to create sets for certain workoutsection types.
  /// E.g a set for a HIIT circuit with a pre filled [duration] field which matches what the user has inputted previously. Or a 20 second timed set if it is a tabata.
  Future<void> createWorkoutSet(int sectionIndex, {int? duration}) async {
    _backup();
    creatingSet = true;
    notifyListeners();

    final parentSection = workout.workoutSections[sectionIndex];
    final newSetSortPosition = parentSection.workoutSets.length;

    /// Api only for create.
    final variables = CreateWorkoutSetArguments(
        data: CreateWorkoutSetInput(
      sortPosition: newSetSortPosition,
      duration: duration,
      workoutSection: ConnectRelationInput(id: parentSection.id),
    ));

    final result = await context.graphQLStore.networkOnlyOperation<
        CreateWorkoutSet$Mutation, CreateWorkoutSetArguments>(
      operation: CreateWorkoutSetMutation(variables: variables),
    );

    final success = _checkApiResult(result);

    if (success) {
      final newCreatedSet = WorkoutSet.fromJson(
          {...result.data!.createWorkoutSet.toJson(), 'WorkoutMoves': []});

      workout.workoutSections[sectionIndex].workoutSets.add(newCreatedSet);
    }

    creatingSet = false;
    notifyListeners();
  }

  void editWorkoutSet(
      int sectionIndex, int setIndex, Map<String, dynamic> data) async {
    _backup();

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

    final result = await context.graphQLStore.networkOnlyOperation<
        UpdateWorkoutSet$Mutation, UpdateWorkoutSetArguments>(
      operation: UpdateWorkoutSetMutation(variables: variables),
    );

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
    _backup();

    final workoutSets = workout.workoutSections[sectionIndex].workoutSets;
    final toDuplicate = workoutSets[setIndex];

    /// Client.
    workoutSets.insert(
        setIndex + 1,
        WorkoutSet.fromJson({
          ...toDuplicate.toJson(),
          'id': 'temp-${Uuid().v1()}',
        }));

    _updateWorkoutSetsSortPosition(workoutSets);

    notifyListeners();

    /// Api
    final variables = DuplicateWorkoutSetByIdArguments(id: toDuplicate.id);

    final result = await context.graphQLStore.networkOnlyOperation<
        DuplicateWorkoutSetById$Mutation, DuplicateWorkoutSetByIdArguments>(
      operation: DuplicateWorkoutSetByIdMutation(variables: variables),
    );

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
      _backup();

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

      final result = await context.graphQLStore.networkOnlyOperation<
          ReorderWorkoutSets$Mutation, ReorderWorkoutSetsArguments>(
        operation: ReorderWorkoutSetsMutation(variables: variables),
      );

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
    _backup();

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
  void _updateWorkoutSetsSortPosition(List<WorkoutSet> workoutSets) {
    workoutSets.forEachIndexed((i, workoutSet) {
      workoutSet.sortPosition = i;
    });
  }

  ////// WorkoutMove CRUD //////
  /// Add a workoutMove to a set.
  Future<void> createWorkoutMove(
      int sectionIndex, int setIndex, WorkoutMove workoutMove) async {
    _backup();

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

    final result = await context.graphQLStore.networkOnlyOperation<
        CreateWorkoutMove$Mutation, CreateWorkoutMoveArguments>(
      operation: CreateWorkoutMoveMutation(variables: variables),
    );

    final success = _checkApiResult(result);

    if (success) {
      workout.workoutSections[sectionIndex].workoutSets[setIndex].workoutMoves
          .add(WorkoutMove.fromJson(
        result.data!.createWorkoutMove.toJson(),
      ));
    }
    notifyListeners();
  }
}
