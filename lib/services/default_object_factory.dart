import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class DefaultObjectfactory {
  /// [Free Session].
  static WorkoutSectionType defaultWorkoutSectionType() {
    return WorkoutSectionType()
      ..id = 0.toString()
      ..name = 'Section'
      ..description = '';
  }

  static WorkoutMove defaultRestWorkoutMove(
      {required Move move,
      required int sortPosition,
      required int timeAmount,
      required TimeUnit timeUnit}) {
    return WorkoutMove()
      ..id = 'move-temp-$sortPosition'
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
