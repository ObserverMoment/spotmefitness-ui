import 'dart:ui';

import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';

extension GenderExtension on Gender {
  String get display {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.nonbinary:
        return 'Non-binary';
      case Gender.none:
        return 'None';
      default:
        throw new Exception('This is not a valid Gender enum: $this');
    }
  }

  String get apiValue {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
      case Gender.nonbinary:
        return 'NONBINARY';
      case Gender.none:
        return 'NONE';
      default:
        throw new Exception('This is not a valid Gender enum: $this');
    }
  }
}

extension DifficultyLevelExtension on DifficultyLevel {
  String get displayText {
    switch (this) {
      case DifficultyLevel.light:
        return 'Light';
      case DifficultyLevel.challenging:
        return 'Challenging';
      case DifficultyLevel.intermediate:
        return 'Intermediate';
      case DifficultyLevel.advanced:
        return 'Advanced';
      case DifficultyLevel.elite:
        return 'Elite';
      default:
        throw new Exception('This is not a valid DifficultyLevel enum: $this');
    }
  }

  Color get displayColor {
    switch (this) {
      case DifficultyLevel.light:
        return Styles.difficultyLevelOne;
      case DifficultyLevel.challenging:
        return Styles.difficultyLevelTwo;
      case DifficultyLevel.intermediate:
        return Styles.difficultyLevelThree;
      case DifficultyLevel.advanced:
        return Styles.difficultyLevelFour;
      case DifficultyLevel.elite:
        return Styles.difficultyLevelFive;
      default:
        throw new Exception('This is not a valid DifficultyLevel enum: $this');
    }
  }

  String get apiValue {
    switch (this) {
      case DifficultyLevel.light:
        return 'LIGHT';
      case DifficultyLevel.challenging:
        return 'CHALLENGING';
      case DifficultyLevel.intermediate:
        return 'INTERMEDIATE';
      case DifficultyLevel.advanced:
        return 'ADVANCED';
      case DifficultyLevel.elite:
        return 'ELITE';
      default:
        throw new Exception('This is not a valid DifficultyLevel enum: $this');
    }
  }
}

extension DistanceUnitExtension on DistanceUnit {
  String get display {
    switch (this) {
      case DistanceUnit.metres:
        return 'mtr';
      case DistanceUnit.kilometres:
        return 'km';
      case DistanceUnit.yards:
        return 'yd';
      case DistanceUnit.miles:
        return 'mi';
      default:
        throw new Exception('This is not a valid DistanceUnit enum: $this');
    }
  }

  String get apiValue {
    switch (this) {
      case DistanceUnit.metres:
        return 'METRES';
      case DistanceUnit.kilometres:
        return 'KILOMETRES';
      case DistanceUnit.yards:
        return 'YARDS';
      case DistanceUnit.miles:
        return 'MILES';
      default:
        throw new Exception('This is not a valid DistanceUnit enum: $this');
    }
  }
}

extension LoadUnitExtension on LoadUnit {
  String get display {
    switch (this) {
      case LoadUnit.kg:
        return 'kg';
      case LoadUnit.lb:
        return 'lb';
      case LoadUnit.bodyweightpercent:
        return '% body';
      default:
        throw new Exception('This is not a valid LoadUnit enum: $this');
    }
  }

  String get apiValue {
    switch (this) {
      case LoadUnit.kg:
        return 'KG';
      case LoadUnit.lb:
        return 'LB';
      case LoadUnit.bodyweightpercent:
        return 'BODYWEIGHTPERCENT';
      default:
        throw new Exception('This is not a valid LoadUnit enum: $this');
    }
  }
}
