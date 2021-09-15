import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
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
      workoutGoals: loggedWorkout.workoutGoals
          .map((goal) => ConnectRelationInput(id: goal.id))
          .toList(),
      completedOn: loggedWorkout.completedOn,
      loggedWorkoutSections: loggedWorkout.loggedWorkoutSections
          .sortedBy<num>((section) => section.sortPosition)
          .mapIndexed((index, section) =>
              CreateLoggedWorkoutSectionInLoggedWorkoutInput(
                name: section.name,
                sortPosition: index,
                moveTypes: section.moveTypes
                    .map((m) => ConnectRelationInput(id: m.id))
                    .toList(),
                bodyAreas: section.bodyAreas
                    .map((b) => ConnectRelationInput(id: b.id))
                    .toList(),
                repScore: section.repScore,
                timeTakenSeconds: section.timeTakenSeconds,
                loggedWorkoutSectionData:
                    LoggedWorkoutSectionDataInput.fromJson(
                        section.loggedWorkoutSectionData?.toJson() ?? {}),
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

  void updateWorkoutGoals(List<WorkoutGoal> goals) {
    loggedWorkout.workoutGoals = goals;
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

  void toggleSectionBodyArea(int sectionIndex, BodyArea bodyArea) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex];
    final updated = prev.bodyAreas
        .toggleItem<BodyArea>(bodyArea)
        .map((b) => b.toJson())
        .toList();

    print(updated);

    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson({...prev.toJson(), 'BodyAreas': updated});
    notifyListeners();
  }

  void updateSectionMoveTypes(int sectionIndex, List<MoveType> moveTypes) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex];
    final updated = moveTypes.map((m) => m.toJson()).toList();

    print(updated);

    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson({...prev.toJson(), 'MoveTypes': updated});
    notifyListeners();
  }

  ///// LoggedWorkoutSectiondata //////
  /// Creates a new roundData object with original round data from
  void addRoundToSection(int sectionIndex) {
    final prevSection = loggedWorkout.loggedWorkoutSections[sectionIndex];
    final rounds = prevSection.loggedWorkoutSectionData!.rounds;

    final roundData =
        rounds.isNotEmpty ? rounds.last : WorkoutSectionRoundData()
          ..timeTakenSeconds = 60
          ..sets = [];

    prevSection.loggedWorkoutSectionData!.rounds
        .add(WorkoutSectionRoundData.fromJson(roundData.toJson()));

    notifyListeners();
  }

  void removeRoundFromSection(int sectionIndex, int roundIndex) {
    final prevSection = loggedWorkout.loggedWorkoutSections[sectionIndex];

    prevSection.loggedWorkoutSectionData!.rounds.removeAt(roundIndex);

    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson(prevSection.toJson());
    notifyListeners();
  }

  void updateRoundTimeTakenSeconds(
      {required int sectionIndex,
      required int roundIndex,
      required int seconds}) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex];
    prev.loggedWorkoutSectionData!.rounds[roundIndex].timeTakenSeconds =
        seconds;

    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson(prev.toJson());
    notifyListeners();
  }

  void addSetToSectionRound(int sectionIndex, int roundIndex) {
    final prevSection = loggedWorkout.loggedWorkoutSections[sectionIndex];
    final prevRound = prevSection.loggedWorkoutSectionData!.rounds[roundIndex];
    final setData = prevRound.sets.isNotEmpty
        ? prevRound.sets.last
        : WorkoutSectionRoundSetData()
      ..timeTakenSeconds = 60
      ..moves = 'Enter...';

    prevSection.loggedWorkoutSectionData!.rounds[roundIndex].sets
        .add(WorkoutSectionRoundSetData.fromJson(setData.toJson()));

    notifyListeners();
  }

  void removeSetFromSectionRound(
      int sectionIndex, int roundIndex, int setIndex) {
    final prevSection = loggedWorkout.loggedWorkoutSections[sectionIndex];
    prevSection.loggedWorkoutSectionData!.rounds[roundIndex].sets
        .removeAt(setIndex);

    /// Listeners are at the section level. So make a new one so that they know to rebuild.
    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson(prevSection.toJson());
    notifyListeners();
  }

  void updateSetTimeTakenSeconds(
      {required int sectionIndex,
      required int roundIndex,
      required int setIndex,
      required int seconds}) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex];
    prev.loggedWorkoutSectionData!.rounds[roundIndex].sets[setIndex]
        .timeTakenSeconds = seconds;

    /// Listeners are at the section level. So make a new one so that they know to rebuild.
    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson(prev.toJson());
    notifyListeners();
  }

  void updateSetMovesList(
      {required int sectionIndex,
      required int roundIndex,
      required int setIndex,
      required String moves}) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex];
    prev.loggedWorkoutSectionData!.rounds[roundIndex].sets[setIndex].moves =
        moves;

    /// Listeners are at the section level. So make a new one so that they know to rebuild.
    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson(prev.toJson());
    notifyListeners();
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
