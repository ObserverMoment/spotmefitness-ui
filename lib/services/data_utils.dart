import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:supercharged/supercharged.dart';

class DataUtils {
  /// Receives any list of bodyAreaMove scores and returns a new list.
  /// Where each body area is represented only once and the score associated with it is calculated as a percentage of the whole list.
  static List<BodyAreaMoveScore> percentageBodyAreaMoveScores(
      List<BodyAreaMoveScore> bodyAreaMoveScores) {
    final totalPoints = bodyAreaMoveScores.sumByDouble((bams) => bams.score);
    final grouped = bodyAreaMoveScores.groupBy((bams) => bams.bodyArea);
    final summed = grouped.keys.map((bodyArea) {
      return grouped[bodyArea]!.fold(
          BodyAreaMoveScore()
            ..bodyArea = bodyArea
            ..score = 0, (BodyAreaMoveScore acum, next) {
        acum.score += next.score as int;
        return acum;
      });
    });
    return summed.map((bams) {
      bams.score = ((bams.score ~/ totalPoints) * 100);
      return bams;
    }).toList();
  }

  /// Used when creating or doing a workout.
  static Duration calculateTimedSectionDuration(WorkoutSection workoutSection) {
    switch (workoutSection.workoutSectionType.name) {
      case kHIITCircuitName:
      case kEMOMName:
        return Duration(
            seconds: workoutSection.workoutSets.sumBy((s) => s.duration!));
      case kTabataName:
        return Duration(
            seconds: workoutSection.workoutSets.sumBy((s) => s.workoutMoves
                .sumBy((wm) => workoutMoveTimeRepsInSeconds(wm))));
      default:
        throw Exception(
            'DataUtils.calculateTimedSectionDuration: ${workoutSection.workoutSectionType.name} is not a timed workout type - so a duration cannot be calculated.');
    }
  }

  static int workoutMoveTimeRepsInSeconds(WorkoutMove workoutMove) {
    switch (workoutMove.timeUnit) {
      case TimeUnit.hours:
        return workoutMove.reps.round() * 3600;
      case TimeUnit.minutes:
        return workoutMove.reps.round() * 60;
      case TimeUnit.seconds:
        return workoutMove.reps.round();
      default:
        throw Exception(
            'DataUtils.workoutMoveTimeRepsInSeconds: ${workoutMove.timeUnit} is not a time unit that we can process.');
    }
  }

  /// Used when creating a log.
  static Duration calculateTimedLoggedSectionDuration(
      LoggedWorkoutSection loggedWorkoutSection) {
    switch (loggedWorkoutSection.workoutSectionType.name) {
      case kHIITCircuitName:
      case kEMOMName:
        return Duration(
            milliseconds: loggedWorkoutSection.roundsCompleted *
                loggedWorkoutSection.loggedWorkoutSets
                    .sumBy((s) => s.roundsCompleted * s.timeTakenMs!));
      case kTabataName:
        return Duration(
            milliseconds: loggedWorkoutSection.roundsCompleted *
                loggedWorkoutSection.loggedWorkoutSets.sumBy((s) =>
                    s.roundsCompleted *
                    s.loggedWorkoutMoves.sumBy((lwm) => lwm.timeTakenMs!)));
      default:
        throw Exception(
            'DataUtils.calculateTimedSectionDuration: ${loggedWorkoutSection.workoutSectionType.name} is not a timed workout type - so a duration cannot be calculated.');
    }
  }

  /// Time and distance moves: a workoutMove is one 'rep'.
  static int totalRepsPerSectionRound<T>(T section) {
    assert(section is WorkoutSection || section is LoggedWorkoutSection,
        'DataUtils.totalRepsPerSectionRound: section must (currently) be WorkoutSection or LoggedWorkoutSection.');
    if (section is WorkoutSection) {
      return section.workoutSets.fold(0, (acum, nextSet) {
        return nextSet.rounds *
            nextSet.workoutMoves.fold(0, (acum, nextMove) {
              if ([
                WorkoutMoveRepType.time,
                WorkoutMoveRepType.distance,
                WorkoutMoveRepType.artemisUnknown
              ].contains(nextMove.repType)) {
                return acum + 1;
              } else {
                return acum + nextMove.reps.round();
              }
            });
      });
    } else {
      return (section as LoggedWorkoutSection).loggedWorkoutSets.fold(0,
          (acum, nextSet) {
        return nextSet.roundsCompleted *
            nextSet.loggedWorkoutMoves.fold(0, (acum, nextMove) {
              if ([
                WorkoutMoveRepType.time,
                WorkoutMoveRepType.distance,
                WorkoutMoveRepType.artemisUnknown
              ].contains(nextMove.repType)) {
                return acum + 1;
              } else {
                return acum + nextMove.reps.round();
              }
            });
      });
    }
  }
}
