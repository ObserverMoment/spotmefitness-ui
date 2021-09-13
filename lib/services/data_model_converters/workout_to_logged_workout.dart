import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uuid/uuid.dart';

// /// Converts a workout to a logged workout by first converting each workout section to a logged workout section. The process of doing this depends on the type of workout section.
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
    ..note = scheduledWorkout?.note
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
    ..timecap = workoutSection.timecap
    ..sortPosition = workoutSection.sortPosition
    ..workoutSectionType =
        WorkoutSectionType.fromJson(workoutSection.workoutSectionType.toJson());
}
