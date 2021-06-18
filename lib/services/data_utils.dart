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
            seconds: workoutSection.rounds *
                workoutSection.workoutSets.sumBy((s) => s.duration!));
      case kTabataName:
        return Duration(
            seconds: workoutSection.rounds *
                workoutSection.workoutSets.sumBy((workoutSet) =>
                    workoutSet.rounds *
                    workoutSet.workoutMoves
                        .sumBy((wm) => workoutMoveTimeRepsInSeconds(wm))));
      default:
        throw Exception(
            'DataUtils.calculateTimedSectionDuration: ${workoutSection.workoutSectionType.name} is not a timed workout type - so a duration cannot be calculated.');
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
                    .sumBy((s) => s.duration! * 1000));
      case kTabataName:
        return Duration(
            milliseconds: loggedWorkoutSection.roundsCompleted *
                loggedWorkoutSection.loggedWorkoutSets.sumBy((s) =>
                    s.roundsCompleted *
                    s.loggedWorkoutMoves
                        .sumBy((lwm) => lwm.reps.toInt() * 1000)));
      default:
        throw Exception(
            'DataUtils.calculateTimedSectionDuration: ${loggedWorkoutSection.workoutSectionType.name} is not a timed workout type - so a duration cannot be calculated.');
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

  /// Time and distance moves: a workoutMove counts as one 'rep'.
  static int totalRepsPerSectionRound<T>(T section) {
    assert(section is WorkoutSection || section is LoggedWorkoutSection,
        'DataUtils.totalRepsPerSectionRound: section must (currently) be WorkoutSection or LoggedWorkoutSection.');
    if (section is WorkoutSection) {
      return section.workoutSets.fold(0, (sectionAcum, nextSet) {
        return sectionAcum +
            nextSet.rounds *
                nextSet.workoutMoves.fold(0, (setAcum, nextMove) {
                  if ([
                    WorkoutMoveRepType.time,
                    WorkoutMoveRepType.distance,
                    WorkoutMoveRepType.artemisUnknown
                  ].contains(nextMove.repType)) {
                    return setAcum + 1;
                  } else {
                    return setAcum + nextMove.reps.round();
                  }
                });
      });
    } else {
      return (section as LoggedWorkoutSection).loggedWorkoutSets.fold(0,
          (sectionAcum, nextSet) {
        return sectionAcum +
            nextSet.roundsCompleted *
                nextSet.loggedWorkoutMoves.fold(0, (setAcum, nextMove) {
                  if ([
                    WorkoutMoveRepType.time,
                    WorkoutMoveRepType.distance,
                    WorkoutMoveRepType.artemisUnknown
                  ].contains(nextMove.repType)) {
                    return setAcum + 1;
                  } else {
                    return setAcum + nextMove.reps.round();
                  }
                });
      });
    }
  }

  static List<BodyArea> bodyAreasInWorkoutSection(WorkoutSection section) {
    List<BodyArea> bodyAreas = [];
    for (final s in section.workoutSets) {
      for (final m in s.workoutMoves) {
        bodyAreas.addAll(
            m.move.bodyAreaMoveScores.map((bams) => bams.bodyArea).toList());
      }
    }
    return bodyAreas;
  }

  static List<BodyArea> bodyAreasInLoggedWorkoutSection(
      LoggedWorkoutSection section) {
    List<BodyArea> bodyAreas = [];
    for (final s in section.loggedWorkoutSets) {
      for (final m in s.loggedWorkoutMoves) {
        bodyAreas.addAll(
            m.move.bodyAreaMoveScores.map((bams) => bams.bodyArea).toList());
      }
    }
    return bodyAreas;
  }

  /// Recursively cast a nested map of any [Map<K,V>]
  /// Initially to convert from [_InternalLinkedHashMap<dynamic, dynamic>] to [Map<String, dynamic>]
  /// When retrieving nested data from Hive.
  static Map<String, dynamic> convertToJsonMap(Map original) {
    return original.entries.fold<Map<String, dynamic>>({}, (map, next) {
      if (next.value is Map) {
        map[next.key.toString()] = convertToJsonMap(next.value);
      } else if (next.value is List) {
        map[next.key.toString()] = (next.value as List)
            .map((o) => o is Map ? convertToJsonMap(o) : o)
            .toList();
      } else {
        map[next.key.toString()] = next.value;
      }

      return map;
    });
  }

  /// 0 = true / yes
  /// 1 = false / no
  /// 2 = null / don't care
  static int nullableBoolToInt(bool? b) {
    return b == null
        ? 2
        : b
            ? 0
            : 1;
  }

  static bool? intToNullableBool(int i) {
    return i == 0
        ? true
        : i == 1
            ? false
            : null;
  }
}
