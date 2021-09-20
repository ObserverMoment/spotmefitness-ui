import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// Converts a workout to a logged workout.
LoggedWorkout loggedWorkoutFromWorkout(
    {required Workout workout,
    ScheduledWorkout? scheduledWorkout,
    bool copySections = false}) {
  final name = Utils.textNotNull(workout.name)
      ? 'Log - ${workout.name}'
      : 'Log - ${DateTime.now().dateString}';
  return LoggedWorkout()
    ..id = workout.id // Temp ID matches the workout
    ..completedOn = scheduledWorkout?.scheduledAt ?? DateTime.now()
    ..note = scheduledWorkout?.note
    ..name = name
    ..gymProfile = scheduledWorkout?.gymProfile
    ..loggedWorkoutSections = copySections
        ? workout.workoutSections
            .map((ws) =>
                loggedWorkoutSectionFromWorkoutSection(workoutSection: ws))
            .toList()
        : []
    ..workoutGoals = workout.workoutGoals;
}

LoggedWorkoutSection loggedWorkoutSectionFromWorkoutSection(
    {required WorkoutSection workoutSection,
    int? repScore,
    int? timeTakenSeconds}) {
  final calcedTimeTaken = workoutSection.timecapIfValid;

  if (calcedTimeTaken == null && timeTakenSeconds == null) {
    throw Exception(
        'Either [calcedTimeTaken] or [timeTakenSeconds] (usually from a user input are required to be non null when creating a [LoggedWorkoutSection]');
  }

  return LoggedWorkoutSection()
    ..id = workoutSection.id // Temp ID matches the workoutSection
    ..name = workoutSection.name
    ..repScore = repScore
    ..sortPosition = workoutSection.sortPosition
    ..timeTakenSeconds = workoutSection.timecapIfValid ?? timeTakenSeconds!
    ..workoutSectionType = workoutSection.workoutSectionType
    ..bodyAreas = workoutSection.uniqueBodyAreas
    ..moveTypes = workoutSection.uniqueMoveTypes
    ..loggedWorkoutSectionData =
        loggedWorkoutSectionDataFromWorkoutSection(workoutSection);
}

LoggedWorkoutSectionData loggedWorkoutSectionDataFromWorkoutSection(
    WorkoutSection workoutSection) {
  final rounds = List.generate(
      workoutSection.rounds,
      (index) => WorkoutSectionRoundData()
        ..timeTakenSeconds = workoutSection.timecapIfValid ?? 0
        ..sets = workoutSection.workoutSets
            .map((wSet) => loggedWorkoutSetDataFromWorkoutSet(
                wSet, workoutSection.workoutSectionType))
            .expand((x) => x)
            .toList()
            .toList());

  return LoggedWorkoutSectionData()..rounds = rounds;
}

/// Returns a list because a set can have repeats - there will be one object for each repeat.
List<WorkoutSectionRoundSetData> loggedWorkoutSetDataFromWorkoutSet(
    WorkoutSet workoutSet, WorkoutSectionType workoutSectionType) {
  return List.generate(
          workoutSet.rounds,
          (_) => WorkoutSectionRoundSetData()
            ..moves = generateMovesList(workoutSet, workoutSectionType)
            ..timeTakenSeconds =
                workoutSetDurationOrNull(workoutSectionType, workoutSet) ?? 0)
      .toList();
}

String generateMovesList(
        WorkoutSet workoutSet, WorkoutSectionType workoutSectionType) =>
    workoutSet.workoutMoves
        .map((wm) => generateWorkoutMoveString(wm, workoutSectionType))
        .join(',');

String generateWorkoutMoveString(
    WorkoutMove workoutMove, WorkoutSectionType workoutSectionType) {
  final reps =
      workoutSectionType.isTimed ? '' : '${generateRepString(workoutMove)} ';
  final equipment =
      workoutMove.equipment != null ? ' ${workoutMove.equipment!.name}' : '';
  final load =
      workoutMove.loadAmount != 0 ? ' ${generateLoadString(workoutMove)}' : '';
  return '$reps${workoutMove.move.name}$load$equipment';
}

/// Very simlar to the [WorkoutMoveDisplay] widget.
String generateRepString(
  WorkoutMove workoutMove,
) {
  final repUnit = workoutMove.repType == WorkoutMoveRepType.time
      ? workoutMove.timeUnit.shortDisplay
      : workoutMove.repType == WorkoutMoveRepType.distance
          ? workoutMove.distanceUnit.shortDisplay
          : null;

  return '${workoutMove.reps.stringMyDouble()}${repUnit != null ? " $repUnit" : ""}';
}

String generateLoadString(WorkoutMove workoutMove) =>
    '(${workoutMove.loadAmount.stringMyDouble()} ${workoutMove.loadUnit.display})';

int? workoutSetDurationOrNull(WorkoutSectionType type, WorkoutSet workoutSet) =>
    type.isTimed ? workoutSet.duration : null;
