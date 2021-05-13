import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
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
  final Workout? workout;
  final ScheduledWorkout? scheduledWorkout;
  final LoggedWorkout? initialLoggedWorkout;

  late LoggedWorkout loggedWorkout;
  List<LoggedWorkoutSection> sectionsToIncludeInLog = [];

  LoggedWorkoutCreatorBloc(
      {this.initialLoggedWorkout, this.workout, this.scheduledWorkout})
      : assert(workout != null || initialLoggedWorkout != null,
            'Must provide either a workout (to creating a logged workout from) or a loggedWorkout (to edit)') {
    if (initialLoggedWorkout != null) {
      loggedWorkout = LoggedWorkout.fromJson(initialLoggedWorkout!.toJson());
    } else {
      loggedWorkout = workoutToLoggedWorkout(
          workout: workout, scheduledWorkout: scheduledWorkout);
    }
  }

  bool showFullSetInfo = true;

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
        loggedWorkoutSections: log.loggedWorkoutSections
            .where((section) => sectionsToIncludeInLog.contains(section))
            .map((section) => CreateLoggedWorkoutSectionInLoggedWorkoutInput(
                name: section.name,
                note: section.note,
                sectionIndex: section.sectionIndex,
                roundsCompleted: section.roundsCompleted,

                /// TODO: Add round times input UI to create process.
                roundTimesMs: {},
                repScore: section.repScore,
                timeTakenMs: section.timeTakenMs,
                timecap: section.timecap,
                workoutSectionType:
                    ConnectRelationInput(id: section.workoutSectionType.id),
                loggedWorkoutSets: section.loggedWorkoutSets
                    .map((logSet) => CreateLoggedWorkoutSetInLoggedSectionInput(
                        setIndex: logSet.setIndex,
                        note: logSet.note,
                        roundsCompleted: logSet.roundsCompleted,
                        roundTimesMs: logSet.roundTimesMs,
                        loggedWorkoutMoves: logSet.loggedWorkoutMoves
                            .map((logWorkoutMove) =>
                                CreateLoggedWorkoutMoveInLoggedSetInput(
                                    sortPosition: logWorkoutMove.sortPosition,
                                    timeTakenMs: logWorkoutMove.timeTakenMs,
                                    note: logWorkoutMove.note,
                                    repType: logWorkoutMove.repType,
                                    reps: logWorkoutMove.reps,
                                    distanceUnit: logWorkoutMove.distanceUnit,
                                    loadAmount: logWorkoutMove.loadAmount,
                                    loadUnit: logWorkoutMove.loadUnit,
                                    timeUnit: logWorkoutMove.timeUnit,
                                    equipment: logWorkoutMove.equipment != null
                                        ? ConnectRelationInput(
                                            id: logWorkoutMove.equipment!.id)
                                        : null,
                                    move: ConnectRelationInput(
                                        id: logWorkoutMove.move.id)))
                            .toList()))
                    .toList()))
            .toList());

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

  void updateSectionRepsScore(int sectionIndex, int score) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].repScore = score;
    notifyListeners();
  }

  void updateSectionTimeTakenMs(int sectionIndex, int timeTakenMs) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].timeTakenMs = timeTakenMs;
    notifyListeners();
  }

  void updateSectionRoundsCompleted(int sectionIndex, int roundsCompleted) {
    loggedWorkout.loggedWorkoutSections[sectionIndex].roundsCompleted =
        roundsCompleted;
    notifyListeners();
  }

  void editLoggedWorkoutSection(
      int sectionIndex, LoggedWorkoutSection section) {
    loggedWorkout.loggedWorkoutSections[sectionIndex] = section;
    notifyListeners();
  }

  /// Internal: Client
  void _updateLoggedWorkoutSectionsSortPosition(
      List<LoggedWorkoutSection> loggedWorkoutSections) {
    loggedWorkoutSections.forEachIndexed((i, loggedWorkoutSection) {
      loggedWorkoutSection.sectionIndex = i;
    });
  }

  void addLoggedWorkoutSet(int sectionIndex,
      {Map<dynamic, dynamic>? roundTimesMs}) {
    final sets =
        loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets;
    loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets = [
      ...sets,
      DefaultObjectfactory.defaultLoggedWorkoutSet(
          setIndex: sets.length, roundTimesMs: roundTimesMs)
    ];
    notifyListeners();
  }

  void editLoggedWorkoutSet(
      int sectionIndex, int setIndex, LoggedWorkoutSet loggedWorkoutSet) {
    final oldSetsCopy =
        loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets;

    loggedWorkout.loggedWorkoutSections[sectionIndex].loggedWorkoutSets =
        oldSetsCopy
            .map((original) => original.setIndex == loggedWorkoutSet.setIndex
                ? loggedWorkoutSet
                : original)
            .toList();
    notifyListeners();
  }

  void deleteLoggedWorkoutSet(int sectionIndex, int setIndex) {
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
      loggedWorkoutSet.setIndex = i;
    });
  }

  /// To the end of a set.
  void addLoggedWorkoutMove(int sectionIndex, int setIndex,
      LoggedWorkoutMove loggedWorkoutMove) async {
    loggedWorkout.loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex].loggedWorkoutMoves
        .add(loggedWorkoutMove);
    notifyListeners();
  }

  void editLoggedWorkoutMove(int sectionIndex, int setIndex,
      LoggedWorkoutMove loggedWorkoutMove) async {
    loggedWorkout
        .loggedWorkoutSections[sectionIndex]
        .loggedWorkoutSets[setIndex]
        .loggedWorkoutMoves[loggedWorkoutMove.sortPosition] = loggedWorkoutMove;
    notifyListeners();
  }

  void deleteLoggedWorkoutMove(
      int sectionIndex, int setIndex, int workoutMoveIndex) {
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
