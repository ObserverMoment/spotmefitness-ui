import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uuid/uuid.dart';

// /// Converts a workout logged workout by first converting each workout section to a logged workout section. The process of doing this depends on the type of workout section.
LoggedWorkout workoutToLoggedWorkout(
    {Workout? workout, ScheduledWorkout? scheduledWorkout}) {
  final name = Utils.textNotNull(workout?.name)
      ? 'Log - ${workout?.name}'
      : 'Log - ${DateTime.now().dateString}';
  return LoggedWorkout()
    ..id = 'temp - $name'
    ..completedOn = scheduledWorkout?.scheduledAt ?? DateTime.now()
    ..loggedWorkoutSections = workout != null
        ? workoutSectionsToLoggedWorkoutSections(workout.workoutSections)
            .sortedBy<num>((ws) => ws.sortPosition)
        : []
    ..gymProfile = scheduledWorkout?.gymProfile
    ..name = name;
}

List<LoggedWorkoutSection> workoutSectionsToLoggedWorkoutSections(
    List<WorkoutSection> workoutSections) {
  return workoutSections
      .sortedBy<num>((ws) => ws.sortPosition)
      .map((ws) => workoutSectionToLoggedWorkoutSection(ws))
      .toList();
}

LoggedWorkoutSection workoutSectionToLoggedWorkoutSection(
    WorkoutSection workoutSection) {
  final uuid = Uuid();
  return LoggedWorkoutSection()
    ..id = 'temp - LoggedWorkoutSection:${uuid.v1()}'
    ..name = workoutSection.name
    ..loggedWorkoutSets =
        workoutSetsToLoggedWorkoutSets(workoutSection.workoutSets)
            .sortedBy<num>((ws) => ws.sortPosition)
    ..roundsCompleted = workoutSection.rounds
    ..lapTimesMs = {}
    ..timecap = workoutSection.timecap
    ..sortPosition = workoutSection.sortPosition
    ..workoutSectionType =
        WorkoutSectionType.fromJson(workoutSection.workoutSectionType.toJson());
}

List<LoggedWorkoutSet> workoutSetsToLoggedWorkoutSets(
    List<WorkoutSet> workoutSets) {
  final uuid = Uuid();
  return workoutSets
      .map((workoutSet) => LoggedWorkoutSet()
        ..id = 'temp - loggedWorkoutSet:${uuid.v1()}'
        ..sortPosition = workoutSet.sortPosition
        ..roundsCompleted = workoutSet.rounds
        ..duration = workoutSet.duration
        ..loggedWorkoutMoves =
            workoutMovesToLoggedWorkoutMoves(workoutSet.workoutMoves)
                .sortedBy<num>((wm) => wm.sortPosition))
      .toList();
}

List<LoggedWorkoutMove> workoutMovesToLoggedWorkoutMoves(
    List<WorkoutMove> workoutMoves) {
  return workoutMoves
      .map((workoutMove) => workoutMoveToLoggedWorkoutMove(
            workoutMove,
          ))
      .toList();
}

LoggedWorkoutMove workoutMoveToLoggedWorkoutMove(WorkoutMove workoutMove) =>
    LoggedWorkoutMove()
      ..id = 'temp - LoggedWorkoutMove:${Uuid().v1()}'
      ..sortPosition = workoutMove.sortPosition
      ..repType = workoutMove.repType
      ..reps = workoutMove.reps
      ..distanceUnit = workoutMove.distanceUnit
      ..loadAmount = workoutMove.loadAmount
      ..loadUnit = workoutMove.loadUnit
      ..timeUnit = workoutMove.timeUnit
      ..equipment = workoutMove.equipment
      ..move = workoutMove.move;
