import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';

class WorkoutSectionWithInput {
  WorkoutSection workoutSection;
  // Will be either reps (repScore) or time in seconds (timeTakenSeconds)
  // When none of these are null the user can proceed and we can generate the full list of loggedWorkoutSections.
  int? input;
  WorkoutSectionWithInput({required this.workoutSection, this.input});
}

/// This is only for CREATING a LoggedWorkout from a Workout.
/// Editing is more basic and is handled by the LoggedWorkoutDetails page (as of sept 2021).
/// LoggedWorkout is saved to teh API at the end of the flow, not incrementally.
class LoggedWorkoutCreatorBloc extends ChangeNotifier {
  final BuildContext context;

  final Workout workout;
  final ScheduledWorkout? scheduledWorkout;

  final List<String> typesInputRequired = [
    kFreeSessionName,
    kForTimeName,
    kAMRAPName
  ];
  late LoggedWorkout loggedWorkout;

  LoggedWorkoutCreatorBloc(
      {required this.context, required this.workout, this.scheduledWorkout}) {
    loggedWorkout = workoutToLoggedWorkout(
        workout: workout, scheduledWorkout: scheduledWorkout);

    /// Are there any sections that required inputs from the user?
    /// i.e. FreeSession - timeTaken
    /// i.e. AMRAP - repScore
    /// i.e. ForTIme - timeTaken
    /// If not then go ahead and form the loggedWorkoutSections.
    /// Otherwise do not.
    if (workout.workoutSections
        .none((w) => typesInputRequired.contains(w.workoutSectionType.name))) {
      loggedWorkout.loggedWorkoutSections = workout.workoutSections
          .map((ws) => workoutSectionToLoggedWorkoutSection(workoutSection: ws))
          .toList();
    }
  }

  /// From workout sections plus their inputs - inputted by the user.
  /// Do not sun this before the user has added reps and timeTakenSeconds to AMRAP, ForTime and FreeSession sections.
  void generateLoggedWorkoutSections(
      List<WorkoutSectionWithInput> sectionsWithInputs) {
    loggedWorkout.loggedWorkoutSections = workout.workoutSections
        .sortedBy<num>((ws) => ws.sortPosition)
        .map((ws) {
      if (ws.workoutSectionType.name == kAMRAPName) {
        // Get the value from the inputs
        final s =
            sectionsWithInputs.firstWhere((s) => ws.id == s.workoutSection.id);
        return workoutSectionToLoggedWorkoutSection(
            workoutSection: ws, repScore: s.input);
      } else if ([kFreeSessionName, kForTimeName]
          .contains(ws.workoutSectionType.name)) {
        // Get the value from the inputs
        final s =
            sectionsWithInputs.firstWhere((s) => ws.id == s.workoutSection.id);
        return workoutSectionToLoggedWorkoutSection(
            workoutSection: ws, timeTakenSeconds: s.input);
      } else {
        // Timed sections already have all the data needed to create a LoggedWorkoutSection
        return workoutSectionToLoggedWorkoutSection(workoutSection: ws);
      }
    }).toList();

    notifyListeners();
  }

  Future<MutationResult> createAndSave(BuildContext context) async {
    /// Need to update the workout section indexes because the user may not have included all of the workout sections in the log.
    _updateLoggedWorkoutSectionsSortPosition(
        loggedWorkout.loggedWorkoutSections);

    final input = CreateLoggedWorkoutInput(
      name: loggedWorkout.name,
      note: loggedWorkout.note,
      scheduledWorkout: scheduledWorkout != null
          ? ConnectRelationInput(id: scheduledWorkout!.id)
          : null,
      gymProfile: loggedWorkout.gymProfile != null
          ? ConnectRelationInput(id: loggedWorkout.gymProfile!.id)
          : null,

      /// TODO
      workoutGoals: [],
      completedOn: loggedWorkout.completedOn,
      loggedWorkoutSections: loggedWorkout.loggedWorkoutSections
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
                loggedWorkoutSectionData:
                    LoggedWorkoutSectionDataInput(rounds: []),
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

  void updateGymProfile(GymProfile? profile) {
    loggedWorkout.gymProfile = profile;
    notifyListeners();
  }

  void updateCompletedOn(DateTime completedOn) {
    loggedWorkout.completedOn = completedOn;
    notifyListeners();
  }

  void updateNote(String note) {
    loggedWorkout.note = note;
    notifyListeners();
  }

  /// Section ////
  void updateRepScore(int sectionIndex, int repScore) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex];
    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson({...prev.toJson(), 'repScore': repScore});
    notifyListeners();
  }

  void updateTimeTakenSeconds(int sectionIndex, int timeTakenSeconds) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex];
    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson(
            {...prev.toJson(), 'timeTakenSeconds': timeTakenSeconds});
    notifyListeners();
  }

  void updateSectionData() {
    print('updateSectionData');
  }

  /// Internal: Client
  /// Based on their position in the loggedWorkout.loggedWorkoutSections list.
  void _updateLoggedWorkoutSectionsSortPosition(
      List<LoggedWorkoutSection> loggedWorkoutSections) {
    loggedWorkoutSections.forEachIndexed((i, loggedWorkoutSection) {
      loggedWorkoutSection.sortPosition = i;
    });
  }

  /// Static helpers and methods ///
  /// Updates the [client side GraphQLStore] by adding the newly created workout log to the scheduled workout at [scheduledWorkout.loggedWorkoutId].
  /// The API will handle connecting the log to the scheduled workout in the DB.
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
