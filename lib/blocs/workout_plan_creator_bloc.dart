import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';

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
  }

  bool _checkApiResult(MutationResult result) {
    if (result.hasErrors || result.data == null) {
      _revertChanges(result.errors!);
      return false;
    } else {
      return true;
    }
  }

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

  void createWorkoutPlanDay(int dayNumber, Workout workout) {
    /// Client / Optimistic
    _backupAndMarkDirty();
    workoutPlan.workoutPlanDays.add(WorkoutPlanDay()
      ..id = 'temp-workoutPlanDay-$dayNumber'
      ..dayNumber = dayNumber
      ..workoutPlanDayWorkouts = [
        WorkoutPlanDayWorkout()
          ..id = 'temp-workoutPlanDayWorkout-${workout.id}'
          ..sortPosition = 0
          ..workout = workout
      ]);
    notifyListeners();

    /// Api
  }

  void deleteWorkoutPlanDay(int dayNumber) {
    /// Client / Optimistic
    _backupAndMarkDirty();
    workoutPlan.workoutPlanDays.removeWhere((d) => d.dayNumber == dayNumber);
    notifyListeners();

    /// Api
  }
}
