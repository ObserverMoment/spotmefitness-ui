import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class DefaultObjectfactory {
  /// [Free Session].
  static WorkoutSectionType defaultWorkoutSectionType() {
    return WorkoutSectionType()
      ..$$typename
      ..id = 0.toString()
      ..name = 'Section'
      ..description = '';
  }

  static LoggedWorkoutSet defaultLoggedWorkoutSet(
      {required int setIndex, Map? roundTimesMs}) {
    return LoggedWorkoutSet()
      ..$$typename = kLoggedWorkoutSetTypename
      ..id = 'temp-$kLoggedWorkoutSetTypename-$setIndex'
      ..roundsCompleted = 1
      ..roundTimesMs = roundTimesMs ?? {}
      ..setIndex = setIndex
      ..loggedWorkoutMoves = [];
  }

  static WorkoutMove defaultRestWorkoutMove(
      {required Move move,
      required int sortPosition,
      required int timeAmount,
      required TimeUnit timeUnit}) {
    return WorkoutMove()
      ..$$typename = kWorkoutMoveTypename
      ..id = 'temp-$kWorkoutMoveTypename-$sortPosition'
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
}
