import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

/// Extensions which pertain to the processing of fitness related data (i.e. the graphql types.)

extension WorkoutExtension on Workout {
  /// Returns a copy of the workout with all child lists, ([workoutSections], [workoutSets], [workoutMoves]) sorted by [sortPosition].
  Workout get copyAndSortAllChildren {
    final copy = Workout.fromJson(this.toJson());

    copy.workoutSections
        .sortBy<num>((workoutSection) => workoutSection.sortPosition);

    for (final workoutSection in copy.workoutSections) {
      workoutSection.workoutSets
          .sortBy<num>((workoutSets) => workoutSets.sortPosition);

      for (final workoutSet in workoutSection.workoutSets) {
        workoutSet.workoutMoves
            .sortBy<num>((workoutMove) => workoutMove.sortPosition);
      }
    }

    return copy;
  }
}
