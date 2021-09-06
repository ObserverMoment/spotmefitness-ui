import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';

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

  void updateWorkoutMeta(Map<String, dynamic> data) async {
    /// Client / Optimistic
    _backup();
    workout = Workout.fromJson({...workout.toJson(), ...data});
    notifyListeners();

    /// Api
    final variables = UpdateWorkoutArguments(
        data: UpdateWorkoutInput.fromJson(workout.toJson()));

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
}
