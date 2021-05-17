import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:uuid/uuid.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class DefaultObjectfactory {
  /// [Free Session].
  static WorkoutSectionType defaultWorkoutSectionType() {
    return WorkoutSectionType()
      ..$$typename
      ..id = 0.toString()
      ..name = 'Section'
      ..description = '';
  }

  static LoggedWorkoutSet defaultLoggedWorkoutSet({required int sortPosition}) {
    return LoggedWorkoutSet()
      ..$$typename = kLoggedWorkoutSetTypename
      ..id = 'temp-$kLoggedWorkoutSetTypename:${Uuid().v1()}'
      ..roundsCompleted = 1
      ..sortPosition = sortPosition
      ..loggedWorkoutMoves = [];
  }

  static WorkoutMove defaultRestWorkoutMove(
      {required Move move,
      required int sortPosition,
      required int timeAmount,
      required TimeUnit timeUnit}) {
    return WorkoutMove()
      ..$$typename = kWorkoutMoveTypename
      ..id = 'temp-$kWorkoutMoveTypename:${Uuid().v1()}'
      ..sortPosition = sortPosition
      ..equipment = null
      ..reps = timeAmount.toDouble()
      ..repType = WorkoutMoveRepType.time
      ..distanceUnit = DistanceUnit.metres
      ..loadUnit = LoadUnit.kg
      ..timeUnit = timeUnit
      ..loadAmount = 0
      ..move = move;
  }

  static ProgressJournal defaultProgressJournal() {
    return ProgressJournal()
      ..$$typename
      ..id = 'temp-$kProgressJournalTypename:${Uuid().v1()}'
      ..name = 'Journal ${DateTime.now().compactDateString}'
      ..createdAt = DateTime.now()
      ..progressJournalGoals = [];
  }

  static ProgressJournalGoal defaultProgressJournalGoal() {
    return ProgressJournalGoal()
      ..$$typename
      ..id = 'temp-$kProgressJournalGoalTypename:${Uuid().v1()}'
      ..name = 'Goal ${DateTime.now().compactDateString}'
      ..progressJournalGoalTags = [];
  }
}
