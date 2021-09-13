import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';

/// Can either create a new logged workout or edit (in real time) an already existing one.
/// Create: The full object is constructed on the client and then saved as a whole to the API when the user is done.
/// Edit: Edits are made and saved to the API in real time incrementally, then the client side store is updated once when the user is done. (Similar to the workout creator bloc).
class LoggedWorkoutCreatorBloc extends ChangeNotifier {
  final BuildContext context;

  final Workout? workout;
  final ScheduledWorkout? scheduledWorkout;
  final LoggedWorkout? initialLoggedWorkout;

  late LoggedWorkout loggedWorkout;
  late Map<String, dynamic> _backupJson;
  List<String> includedSectionIds = [];

  /// When [creating] the initial log - nothing is saved to the API until the end of the flow and the user hits save.
  /// When [editing]:
  ///  - Log: Edits are saved to the DB immediately (optimistically to local UI state, then to the API). The global store is written after the API has returned.
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
    } else {
      _isEditing = false;
      loggedWorkout = workoutToLoggedWorkout(
          workout: workout, scheduledWorkout: scheduledWorkout);
    }

    // Make sure the sections are correctly ordered.
    loggedWorkout.loggedWorkoutSections.sortBy<num>((s) => s.sortPosition);

    _backupJson = loggedWorkout.toJson();
  }

  bool showFullSetInfo = true;

  void _backup() {
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

  bool _checkApiResult(MutationResult result) {
    if (result.hasErrors || result.data == null) {
      _revertChanges(errors: result.errors!);
      return false;
    } else {
      return true;
    }
  }

  /// Writes all changes to the graphQLStore.
  /// Via the normalized root object which is the LoggedWorkout.
  /// At [LoggedWorkout:{loggedWorkout.id}].
  /// Should only be run when user is editing the log, not when they are creating it.
  bool writeAllChangesToStore() {
    final success = context.graphQLStore.writeDataToStore(
        data: loggedWorkout.toJson(),
        broadcastQueryIds: [GQLNullVarsKeys.userLoggedWorkoutsQuery]);
    return success;
  }

  Future<MutationResult> createAndSave(BuildContext context) async {
    final log = LoggedWorkout.fromJson(loggedWorkout.toJson());

    /// Need to update the workout section indexes because the user may not have included all of the workout sections in the log.
    _updateLoggedWorkoutSectionsSortPosition(log.loggedWorkoutSections);

    final input = CreateLoggedWorkoutInput(
      name: log.name,
      note: log.note,
      scheduledWorkout: scheduledWorkout != null
          ? ConnectRelationInput(id: scheduledWorkout!.id)
          : null,
      gymProfile: log.gymProfile != null
          ? ConnectRelationInput(id: log.gymProfile!.id)
          : null,

      /// TODO
      workoutGoals: [],
      completedOn: log.completedOn,
      loggedWorkoutSections: log.loggedWorkoutSections
          .where((s) => includedSectionIds.contains(s.id))
          .sortedBy<num>((s) => s.sortPosition)
          .mapIndexed((index, section) =>
              CreateLoggedWorkoutSectionInLoggedWorkoutInput(
                name: section.name,
                note: section.note,
                // Not the original sortPosition, the index from within the selected sections list at [includedSectionIds]
                sortPosition: index,

                /// TODO
                moveTypes: [],
                bodyAreas: [],
                repScore: section.repScore,
                timeTakenSeconds: section.timeTakenSeconds,
                timecap: section.timecap,

                /// TODO
                workoutSectionData: WorkoutSectionDataInput(rounds: []),
                workoutSectionType:
                    ConnectRelationInput(id: section.workoutSectionType.id),
              ))
          .toList(),
    );

    final variables = CreateLoggedWorkoutArguments(data: input);

    final result = await context.graphQLStore.create(
        mutation: CreateLoggedWorkoutMutation(variables: variables),
        addRefToQueries: [GQLNullVarsKeys.userLoggedWorkoutsQuery]);

    await checkOperationResult(context, result);

    /// If the log is being created from a scheduled workout then we need to add the newly completed workout log to the scheduledWorkout.loggedWorkout in the store.
    if (scheduledWorkout != null && result.data != null) {
      updateScheduleWithLoggedWorkout(
          context, scheduledWorkout!, result.data!.createLoggedWorkout);
    }

    return result;
  }

  void toggleIncludeSection(LoggedWorkoutSection loggedWorkoutSection) {
    includedSectionIds =
        includedSectionIds.toggleItem<String>(loggedWorkoutSection.id);
    notifyListeners();
  }

  Future<void> updateGymProfile(GymProfile? profile) async {
    _backup();
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
          'data': {
            'id': loggedWorkout.id,
            'GymProfile': profile == null ? null : {'id': profile.id}
          }
        },
        broadcastQueryIds: [GQLNullVarsKeys.userLoggedWorkoutsQuery],
      );

      _checkApiResult(result);
    }
  }

  Future<void> updateCompletedOn(DateTime completedOn) async {
    _backup();
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
        broadcastQueryIds: [GQLNullVarsKeys.userLoggedWorkoutsQuery],
      );

      _checkApiResult(result);
    }
  }

  Future<void> updateNote(String note) async {
    _backup();
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
        broadcastQueryIds: [GQLNullVarsKeys.userLoggedWorkoutsQuery],
      );

      _checkApiResult(result);
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
  ///
  /// When updating "score" inputs (section reps, time, rounds) we check if the section is being included in the log via [includedSectionIds]. If the user is entering a score for this section then we can assume that they want to include it and so should update this automatically.

  /// Also calls the API to update the DB.
  /// Does not write to graphql store.
  Future<void> editLoggedWorkoutSection(
      int sectionIndex, Map<String, dynamic> data) async {
    _backup();

    final updated = LoggedWorkoutSection.fromJson({
      ...loggedWorkout.loggedWorkoutSections[sectionIndex].toJson(),
      ...data,
    });

    loggedWorkout.loggedWorkoutSections = loggedWorkout.loggedWorkoutSections
        .mapIndexed((i, logSection) => i == sectionIndex ? updated : logSection)
        .toList();

    /// Add to included sections if not already there.
    if (!includedSectionIds.contains(updated.id)) {
      includedSectionIds.add(updated.id);
    }

    notifyListeners();

    if (_isEditing) {
      await apiUpdateLoggedWorkoutSection(
          loggedWorkout.loggedWorkoutSections[sectionIndex]);
    }
  }

  Future<void> apiUpdateLoggedWorkoutSection(
      LoggedWorkoutSection loggedWorkoutSection) async {
    final variables = UpdateLoggedWorkoutSectionArguments(
        data: UpdateLoggedWorkoutSectionInput.fromJson(
            loggedWorkoutSection.toJson()));

    final result = await context.graphQLStore.mutate(
      mutation: UpdateLoggedWorkoutSectionMutation(variables: variables),
      writeToStore: false,
    );

    _checkApiResult(result);
  }

  /// Only available when user is editing as logged workout, not when creating.
  /// So [if (_isEditing)] check is not required before calling the network.
  /// When creating use [includedSectionIds] to add / remove sections.
  /// These deletes get written to the [graphQLStore] immediately that the API result confirms.
  // Future<void> deleteLoggedWorkoutSection(int sectionIndex) async {
  //   _backup();
  //   final idToDelete = loggedWorkout.loggedWorkoutSections[sectionIndex].id;
  //   loggedWorkout.loggedWorkoutSections.removeAt(sectionIndex);
  //   notifyListeners();

  //   /// Delete from DB.
  //   /// Not using [graphQLStore.delete] as that is designed for deleting root objects that have been normalized.
  //   final result = await context.graphQLStore.mutate(
  //       writeToStore: false,
  //       mutation: DeleteLoggedWorkoutSectionByIdMutation(
  //           variables:
  //               DeleteLoggedWorkoutSectionByIdArguments(id: idToDelete)));

  //   /// Check the result.
  //   if (!_checkApiResult(result) ||
  //       idToDelete != result.data?.deleteLoggedWorkoutSectionById) {
  //     _revertChanges(errors: result.errors!);
  //   } else {
  //     _updateLoggedWorkoutSectionsSortPosition(
  //         loggedWorkout.loggedWorkoutSections);

  //     /// Immediately update the client store with the updated log.
  //     writeAllChangesToStore();
  //   }
  // }

  /// Internal: Client
  void _updateLoggedWorkoutSectionsSortPosition(
      List<LoggedWorkoutSection> loggedWorkoutSections) {
    loggedWorkoutSections.forEachIndexed((i, loggedWorkoutSection) {
      loggedWorkoutSection.sortPosition = i;
    });
  }

  /// Static helpers and methods ///
  /// Updates the client side store by adding the newly created workout log to the scheduled workout at [scheduledWorkout.loggedWorkoutId].
  /// Meaning that the user's schedule will update and show the scheduled workout as completed.
  static void updateScheduleWithLoggedWorkout(BuildContext context,
      ScheduledWorkout scheduledWorkout, LoggedWorkout loggedWorkout) {
    final prevData = context.graphQLStore
        .readDenomalized('$kScheduledWorkoutTypename:${scheduledWorkout.id}');

    final updated = ScheduledWorkout.fromJson(prevData);
    updated.loggedWorkoutId = loggedWorkout.id;

    context.graphQLStore.writeDataToStore(
        data: updated.toJson(),
        broadcastQueryIds: [GQLOpNames.userScheduledWorkoutsQuery]);
  }
}
