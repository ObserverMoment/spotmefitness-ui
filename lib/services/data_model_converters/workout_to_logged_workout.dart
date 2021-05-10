import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

// /// Converts a workout logged workout by first converting each workout section to a logged workout section. The process of doing this depends on the type of workout section.
CreateLoggedWorkoutInput workoutToCreateLoggedWorkout(
    {Workout? workout, ScheduledWorkout? scheduledWorkout}) {
  return CreateLoggedWorkoutInput(
      completedOn: scheduledWorkout?.scheduledAt ?? DateTime.now(),
      loggedWorkoutSections: workout != null
          ? workoutSectionsToCreateLoggedWorkoutSections(
              workout.workoutSections)
          : [],
      workout: workout != null ? ConnectRelationInput(id: workout.id) : null,
      scheduledWorkout: scheduledWorkout != null
          ? ConnectRelationInput(id: scheduledWorkout.id)
          : null,
      gymProfile: scheduledWorkout?.gymProfile != null
          ? ConnectRelationInput(id: scheduledWorkout!.gymProfile!.id)
          : null,
      name: workout?.name ?? 'Log ${DateTime.now().dateString}');
}

List<CreateLoggedWorkoutSectionInLoggedWorkoutInput>
    workoutSectionsToCreateLoggedWorkoutSections(
        List<WorkoutSection> workoutSections) {
  return workoutSections
      .sortedBy<num>((ws) => ws.sortPosition)
      .map((workoutSection) => List.generate(
          workoutSection.rounds,
          (index) => CreateLoggedWorkoutSectionInLoggedWorkoutInput(
              name: workoutSection.name,
              loggedWorkoutSets: workoutSetsToCreateLoggedWorkoutSets(
                      workoutSection.workoutSets)
                  .toList(),
              roundIndex: index,
              sectionIndex: workoutSection.sortPosition,
              workoutSectionType: ConnectRelationInput(
                  id: workoutSection.workoutSectionType.id))))
      .expand((e) => e)
      .toList();
}

List<CreateLoggedWorkoutSetInLoggedSectionInput>
    workoutSetsToCreateLoggedWorkoutSets(List<WorkoutSet> workoutSets) {
  return workoutSets
      .map((workoutSet) => List.generate(
          workoutSet.rounds,
          (index) => CreateLoggedWorkoutSetInLoggedSectionInput(
              setIndex: workoutSet.sortPosition,
              roundIndex: index,
              timeTakenMs: workoutSet.duration != null
                  ? workoutSet.duration! * 1000
                  : null,
              loggedWorkoutMoves:
                  workoutMovesToLoggedWorkoutMoves(workoutSet.workoutMoves))))
      .expand((e) => e)
      .toList();
}

List<CreateLoggedWorkoutMoveInLoggedSetInput> workoutMovesToLoggedWorkoutMoves(
    List<WorkoutMove> workoutMoves) {
  return workoutMoves
      .map((workoutMove) => CreateLoggedWorkoutMoveInLoggedSetInput(
          sortPosition: workoutMove.sortPosition,
          timeTakenMs: workoutMove.repType == WorkoutMoveRepType.time
              ? (workoutMove.reps * 1000).round()
              : null,
          repType: workoutMove.repType,
          reps: workoutMove.reps,
          distanceUnit: workoutMove.distanceUnit,
          loadAmount: workoutMove.loadAmount,
          loadUnit: workoutMove.loadUnit,
          equipment: workoutMove.equipment != null
              ? ConnectRelationInput(id: workoutMove.id)
              : null,
          move: ConnectRelationInput(id: workoutMove.id)))
      .toList();
}
