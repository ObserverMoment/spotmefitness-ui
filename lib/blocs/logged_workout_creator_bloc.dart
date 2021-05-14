import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';

/// Can either create a new logged workout or edit (in real time) and already existing one.
/// Create: The full object is constructed on the client and then saved as a whole to the API when the user is done.
/// Edit: Edits are made and saved to the API in real time incrementally, then the client side store is updated once when the user is done. (Similar to the workout creator bloc).
class LoggedWorkoutCreatorBloc extends ChangeNotifier {
  final BuildContext context;

  final Workout? workout;
  final ScheduledWorkout? scheduledWorkout;
  final LoggedWorkout? initialLoggedWorkout;

  late LoggedWorkout loggedWorkout;
  late Map<String, dynamic> _backupJson;
  List<LoggedWorkoutSection> sectionsToIncludeInLog = [];

  /// When creating the initial log - nothing is saved to the API until the end of the flow.
  /// When editing:
  ///  - Log: Edits are saved to the DB immediately (optimistically to UI, then to the API). The store is written after the API has returned.
  ///  - Section and below. Changes are saved to the DB only when the section as a whole is saved. The returned section (from the API) is merged with the log and then written to the client store. Only the [LoggedWorkout] object is normalized into the store (as a root object) - all its children are not..
  late bool _isEditing;

  LoggedWorkoutCreatorBloc(
      {required this.context,
      this.initialLoggedWorkout,
      this.workout,
      this.scheduledWorkout})
      : assert(workout != null || initialLoggedWorkout != null,
            'Must provide either a workout (to create a logged workout from) or a loggedWorkout (to edit)') {
    if (initialLoggedWorkout != null) {
      _isEditing = true;
      loggedWorkout = LoggedWorkout.fromJson(initialLoggedWorkout!.toJson());
      // Make sure the list is correctly ordered - otherwise delete ops will be messed up.
      loggedWorkout.loggedWorkoutSections.sortBy<num>((s) => s.sortPosition);
    } else {
      _isEditing = false;
      loggedWorkout = workoutToLoggedWorkout(
          workout: workout, scheduledWorkout: scheduledWorkout);
    }
    _backupJson = loggedWorkout.toJson();
  }

  bool showFullSetInfo = true;

  void makeBackupLog() {
    _backupJson = loggedWorkout.toJson();
  }

  /// Called if there has been an error when updating to the API.
  void _revertChanges({List<Object> errors = const []}) {
    errors.forEach((e) {
      print(e);
    });
    loggedWorkout = LoggedWorkout.fromJson(_backupJson);
    notifyListeners();
    context.showToast(
        message: 'There was a problem, changes not saved',
        toastType: ToastType.destructive);
  }

  /// When editing, if the user has made changes which need to be saved or discarded on exiting the [LoggedWorkoutSectionDetailsEditable] screen.
  bool sectionHasUnsavedChanges = false;
  // Backup of the section that is currently open an being edited.
  Map<String, dynamic>? backupSectionJson;

  void _backupSectionAndMarkDirty(int sectionIndex) {
    sectionHasUnsavedChanges = true;
    backupSectionJson =
        loggedWorkout.loggedWorkoutSections[sectionIndex].toJson();
  }

  void revertChangesToSection() {
    final section = LoggedWorkoutSection.fromJson(backupSectionJson!);
    loggedWorkout.loggedWorkoutSections[section.sortPosition] = section;
    sectionHasUnsavedChanges = false;
    notifyListeners();
  }

  /// Writes all changes to the graphQLStore.
  /// Via the normalized root object which is the LoggedWorkout.
  /// At [LoggedWorkout:{loggedWorkout.id}].
  /// Should only be run when user is editing the lo, not when they are creating it.
  bool saveAllChanges() {
    /// When editing you have (currently!) come from the workout details page which is being fed by an observable query with id [workoutById({id: id})].
    /// This may need revisiting if there is a way the user can edit a workout without first opening up this page where this query will be registered.
    final success = context.graphQLStore.writeDataToStore(
        data: loggedWorkout.toJson(),
        broadcastQueryIds: [UserLoggedWorkoutsQuery().operationName]);
    return success;
  }

  Future<MutationResult> createAndSave(BuildContext context) async {
    final log = LoggedWorkout.fromJson(loggedWorkout.toJson());

    /// Need to update the workout section indexes because the user may not have included all of the workout sections in the log.
    _updateLoggedWorkoutSectionsSortPosition(log.loggedWorkoutSections);

    final input = CreateLoggedWorkoutInput(
      name: log.name,
      note: log.note,
      scheduledWorkout: null,
      gymProfile: log.gymProfile != null
          ? ConnectRelationInput(id: log.gymProfile!.id)
          : null,
      workoutProgramEnrolment: null,
      workoutProgramWorkout: null,
      completedOn: log.completedOn,
      loggedWorkoutSections: sectionsToIncludeInLog
          .sortedBy<num>((s) => s.sortPosition)
          .asMap()
          .map((index, section) => MapEntry(
              index,
              CreateLoggedWorkoutSectionInLoggedWorkoutInput(
                  name: section.name,
                  note: section.note,
                  // Not the original index, the index from within the selected sections at [sectionsToIncludeInLog]
                  sortPosition: index,
                  roundsCompleted: section.roundsCompleted,
                  roundTimesMs: section.roundTimesMs,
                  repScore: section.repScore,
                  timeTakenMs: section.timeTakenMs,
                  timecap: section.timecap,
                  workoutSectionType:
                      ConnectRelationInput(id: section.workoutSectionType.id),
                  loggedWorkoutSets: section.loggedWorkoutSets
                      .map((logSet) =>
                          CreateLoggedWorkoutSetInLoggedSectionInput(
                              sortPosition: logSet.sortPosition,
                              note: logSet.note,
                              roundsCompleted: logSet.roundsCompleted,
                              roundTimesMs: logSet.roundTimesMs,
                              duration: logSet.duration,
                              loggedWorkoutMoves: logSet.loggedWorkoutMoves
                                  .map((logWorkoutMove) =>
                                      CreateLoggedWorkoutMoveInLoggedSetInput(
                                          sortPosition:
                                              logWorkoutMove.sortPosition,
                                          timeTakenMs:
                                              logWorkoutMove.timeTakenMs,
                                          note: logWorkoutMove.note,
                                          repType: logWorkoutMove.repType,
                                          reps: logWorkoutMove.reps,
                                          distanceUnit:
                                              logWorkoutMove.distanceUnit,
                                          loadAmount: logWorkoutMove.loadAmount,
                                          loadUnit: logWorkoutMove.loadUnit,
                                          timeUnit: logWorkoutMove.timeUnit,
                                          equipment:
                                              logWorkoutMove.equipment != null
                                                  ? ConnectRelationInput(
                                                      id: logWorkoutMove
                                                          .equipment!.id)
                                                  : null,
                                          move: ConnectRelationInput(
                                              id: logWorkoutMove.move.id)))
                                  .toList()))
                      .toList())))
          .values
          .toList(),
    );

    final variables = CreateLoggedWorkoutArguments(data: input);

    final result = await context.graphQLStore.create(
        mutation: CreateLoggedWorkoutMutation(variables: variables),
        addRefToQueries: [UserLoggedWorkoutsQuery().operationName]);

    return result;
  }

  void toggleIncludeSection(LoggedWorkoutSection loggedWorkoutSection) {
    sectionsToIncludeInLog = sectionsToIncludeInLog
        .toggleItem<LoggedWorkoutSection>(loggedWorkoutSection);
    notifyListeners();
  }

  Future<void> updateGymProfile(GymProfile? profile) async {
    makeBackupLog();
    loggedWorkout.gymProfile = profile;
    notifyListeners();

    /// Save to API.
    if (_isEditing) {
      final variables = UpdateLoggedWorkoutArguments(
          data: UpdateLoggedWorkoutInput.fromJson(loggedWorkout.toJson()));

      /// MEMO: Constructors such as [UpdateLoggedWorkoutInput] will pass null for anything that you don't specify. So either pass the full object or use [customVariablesMap] from [graphQLStore.mutate].
      final result = await context.graphQLStore.mutate(
        mutation: UpdateLoggedWorkoutMutation(variables: variables),
        customVariablesMap: {
          'data': {'id': loggedWorkout.id, 'gymProfile': profile?.toJson()}
        },
        broadcastQueryIds: [UserLoggedWorkoutsQuery().operationName],
      );

      /// Check the result.
      if (result.hasErrors) {
        _revertChanges(errors: result.errors!);
      }
    }
  }

  Future<void> updateCompletedOn(DateTime completedOn) async {
    makeBackupLog();
    loggedWorkout.completedOn = completedOn;
    notifyListeners();

    /// Save to API.
    if (_isEditing) {
      final variables = UpdateLoggedWorkoutArguments(
          data: UpdateLoggedWorkoutInput.fromJson(loggedWorkout.toJson()));

      /// MEMO: Constructors such as [UpdateLoggedWorkoutInput] will pass null for anything that you don't specify. So either pass the full object or use [customVariablesMap] from [graphQLStore.mutate].
      final result = await context.graphQLStore.mutate(
        mutation: UpdateLoggedWorkoutMutation(variables: variables),
        customVariablesMap: {
          'data': {
            'id': loggedWorkout.id,
            'completedOn': completedOn.millisecondsSinceEpoch
          }
        },
        broadcastQueryIds: [UserLoggedWorkoutsQuery().operationName],
      );

      /// Check the result.
      if (result.hasErrors) {
        _revertChanges(errors: result.errors!);
      }
    }
  }

  Future<void> updateNote(String note) async {
    makeBackupLog();
    loggedWorkout.note = note;
    notifyListeners();

    /// Save to API.
    if (_isEditing) {
      final variables = UpdateLoggedWorkoutArguments(
          data: UpdateLoggedWorkoutInput.fromJson(loggedWorkout.toJson()));

      /// MEMO: Constructors such as [UpdateLoggedWorkoutInput] will pass null for anything that you don't specify. So either pass the full object or use [customVariablesMap] from [graphQLStore.mutate].
      final result = await context.graphQLStore.mutate(
        mutation: UpdateLoggedWorkoutMutation(variables: variables),
        customVariablesMap: {
          'data': {'id': loggedWorkout.id, 'note': note}
        },
        broadcastQueryIds: [UserLoggedWorkoutsQuery().operationName],
      );

      /// Check the result.
      if (result.hasErrors) {
        _revertChanges(errors: result.errors!);
      }
    }
  }

  /// Section or Section Children Updates ////
  /// In the case where user [_isEditing] ////
  /// All of these updates run as follows. !!Except [deleteLoggedWorkoutSection]!!.
  /// 0. Take backup of section before update.
  /// 1. Update the bloc state and notifyListeners. [Stop here if !_isEditing]
  /// 2. Update over network to API. Via [editLoggedWorkoutSection]
  /// 3. Check that result has no errors.
  /// 4. If no errors - return. [TODO - is this solid enough or do we need to overwrite bloc state agaiin with the returned data?]
  /// 5. If errors - rollback changes and notify listeners.
  /// NOTE: Do not write to store on any of these updates.
  /// Write to store when the user closes the section editing screen.
  Future<void> updateSectionRepsScore(int sectionIndex, int score) async {
    _backupSectionAndMarkDirty(sectionIndex);
    loggedWorkout.loggedWorkoutSections[sectionIndex].repScore = score;
    notifyListeners();

    if (_isEditing) {
      await editLoggedWorkoutSection(
          sectionIndex, loggedWorkout.loggedWorkoutSections[sectionIndex]);
    }
  }

  Future<void> updateSectionTimeTakenMs(
      int sectionIndex, int timeTakenMs) async {
    _backupSectionAndMarkDirty(sectionIndex);
    loggedWorkout.loggedWorkoutSections[sectionIndex].timeTakenMs = timeTakenMs;
    notifyListeners();

    if (_isEditing) {
      await editLoggedWorkoutSection(
          sectionIndex, loggedWorkout.loggedWorkoutSections[sectionIndex]);
    }
  }

  Future<void> updateSectionRoundsCompleted(
      int sectionIndex, int roundsCompleted) async {
    _backupSectionAndMarkDirty(sectionIndex);
    loggedWorkout.loggedWorkoutSections[sectionIndex].roundsCompleted =
        roundsCompleted;
    notifyListeners();

    if (_isEditing) {
      await editLoggedWorkoutSection(
          sectionIndex, loggedWorkout.loggedWorkoutSections[sectionIndex]);
    }
  }

  /// Also calls the API to update the DB.
  /// Does not write to graphql store.
  Future<void> editLoggedWorkoutSection(
      int sectionIndex, LoggedWorkoutSection section) async {
    _backupSectionAndMarkDirty(sectionIndex);
    loggedWorkout.loggedWorkoutSections[sectionIndex] = section;
    notifyListeners();

    final variables = UpdateLoggedWorkoutSectionArguments(
        data: UpdateLoggedWorkoutSectionInput.fromJson(
            loggedWorkout.loggedWorkoutSections[sectionIndex].toJson()));

    final result = await context.graphQLStore.mutate(
      mutation: UpdateLoggedWorkoutSectionMutation(variables: variables),
      writeToStore: false,
    );

    /// Check the result.
    if (result.hasErrors) {
      _revertChanges(errors: result.errors!);
    }
  }

  /// Only available when user is editing as logged workout, not when creating.
  /// When creating use [sectionsToIncludeInLog] to add / remove sections.
  /// These deletes get written to the [graphQLStore] immediately that the API result confirms.
  Future<void> deleteLoggedWorkoutSection(int sectionIndex) async {
    makeBackupLog();
    final idToDelete = loggedWorkout.loggedWorkoutSections[sectionIndex].id;
    loggedWorkout.loggedWorkoutSections.removeAt(sectionIndex);
    notifyListeners();

    /// Delete from DB.
    /// Not using [graphQLStore.delete] as that is designed for deleting root objects that have been normalized.
    final result = await context.graphQLStore.mutate(
        writeToStore: false,
        mutation: DeleteLoggedWorkoutSectionByIdMutation(
            variables:
                DeleteLoggedWorkoutSectionByIdArguments(id: idToDelete)));

    /// Check the result.
    if (result.hasErrors ||
        idToDelete != result.data.deleteLoggedWorkoutSectionById) {
      print('has errors');
      _revertChanges(errors: result.errors!);
    } else {
      _updateLoggedWorkoutSectionsSortPosition(
          loggedWorkout.loggedWorkoutSections);
      saveAllChanges();
    }
  }

  /// Internal: Client
  void _updateLoggedWorkoutSectionsSortPosition(
      List<LoggedWorkoutSection> loggedWorkoutSections) {
    loggedWorkoutSections.forEachIndexed((i, loggedWorkoutSection) {
      loggedWorkoutSection.sortPosition = i;
    });
  }

  Future<void> addLoggedWorkoutSet(int sectionIndex,
      {Map<dynamic, dynamic>? roundTimesMs}) async {
    _backupSectionAndMarkDirty(sectionIndex);
    final sets =
        loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets;
    loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets = [
      ...sets,
      DefaultObjectfactory.defaultLoggedWorkoutSet(
          sortPosition: sets.length, roundTimesMs: roundTimesMs)
    ];
    notifyListeners();
  }

  Future<void> editLoggedWorkoutSet(
      int sectionIndex, int setIndex, LoggedWorkoutSet loggedWorkoutSet) async {
    _backupSectionAndMarkDirty(sectionIndex);
    final oldSetsCopy =
        loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets;

    loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets =
        oldSetsCopy
            .map((original) =>
                original.sortPosition == loggedWorkoutSet.sortPosition
                    ? loggedWorkoutSet
                    : original)
            .toList();
    notifyListeners();
  }

  Future<void> deleteLoggedWorkoutSet(int sectionIndex, int setIndex) async {
    _backupSectionAndMarkDirty(sectionIndex);
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
      loggedWorkoutSet.sortPosition = i;
    });
  }

  /// To the end of a set.
  Future<void> addLoggedWorkoutMove(int sectionIndex, int setIndex,
      LoggedWorkoutMove loggedWorkoutMove) async {
    _backupSectionAndMarkDirty(sectionIndex);
    loggedWorkout.loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex].loggedWorkoutMoves
        .add(loggedWorkoutMove);
    notifyListeners();
  }

  Future<void> editLoggedWorkoutMove(int sectionIndex, int setIndex,
      LoggedWorkoutMove loggedWorkoutMove) async {
    _backupSectionAndMarkDirty(sectionIndex);
    loggedWorkout
        .loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex]
        .loggedWorkoutMoves[loggedWorkoutMove.sortPosition] = loggedWorkoutMove;
    notifyListeners();
  }

  Future<void> deleteLoggedWorkoutMove(
      int sectionIndex, int setIndex, int workoutMoveIndex) async {
    _backupSectionAndMarkDirty(sectionIndex);
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
