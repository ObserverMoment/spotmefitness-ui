import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

// /// Converts a workout to a logged workout.
LoggedWorkout workoutToLoggedWorkout(
    {required Workout workout, ScheduledWorkout? scheduledWorkout}) {
  final name = Utils.textNotNull(workout.name)
      ? 'Log - ${workout.name}'
      : 'Log - ${DateTime.now().dateString}';
  return LoggedWorkout()
    ..id = workout.id // Temp ID matches the workout
    ..completedOn = scheduledWorkout?.scheduledAt ?? DateTime.now()
    ..note = scheduledWorkout?.note
    ..name = name
    ..gymProfile = scheduledWorkout?.gymProfile
    ..loggedWorkoutSections = []
    ..workoutGoals = workout.workoutGoals;
}

LoggedWorkoutSection workoutSectionToLoggedWorkoutSection(
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
            .map((wSet) => List.generate(
                wSet.rounds,
                (_) => WorkoutSectionRoundSetData()
                  ..moves = generateMovesList(wSet)
                  ..timeTakenSeconds = workoutSetDurationOrNull(
                          workoutSection.workoutSectionType, wSet) ??
                      0))
            .expand((x) => x)
            .toList()
            .toList());

  return LoggedWorkoutSectionData()..rounds = rounds;
}

String generateMovesList(WorkoutSet workoutSet) => workoutSet.workoutMoves
    .map((wm) => generateWorkoutMoveString(wm))
    .join(',');

String generateWorkoutMoveString(WorkoutMove workoutMove) =>
    '${generateRepString(workoutMove)} ${workoutMove.move.name} ${generateLoadString(workoutMove)}';

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
