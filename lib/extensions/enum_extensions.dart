import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

extension BenchmarkTypeExtension on BenchmarkType {
  String get apiValue => describeEnum(this).toUpperCase();

  String get display {
    switch (this) {
      case BenchmarkType.maxload:
        return 'Max load';
      case BenchmarkType.unbrokenreps:
        return 'Reps Unbroken';
      case BenchmarkType.unbrokentime:
        return 'Time Unbroken';
      case BenchmarkType.fastesttime:
        return 'Fastest Time';
      default:
        throw new Exception('This is not a valid BenchmarkType enum: $this');
    }
  }
}

extension BodyweightUnitExtension on BodyweightUnit {
  String get apiValue => describeEnum(this).toUpperCase();
  String get display => describeEnum(this);
}

extension ContentAccessScopeExtension on ContentAccessScope {
  String get display => describeEnum(this).capitalize;
  String get apiValue => describeEnum(this).toUpperCase();
}

extension DifficultyLevelExtension on DifficultyLevel {
  String get display => describeEnum(this).capitalize;
  String get apiValue => describeEnum(this).toUpperCase();

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
}

extension DistanceUnitExtension on DistanceUnit {
  String get shortDisplay {
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

  String get display => describeEnum(this).capitalize;
  String get apiValue => describeEnum(this).toUpperCase();
}

extension GenderExtension on Gender {
  String get display => describeEnum(this).capitalize;
  String get apiValue => describeEnum(this).toUpperCase();
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
      case LoadUnit.percentmax:
        return '% max';
      default:
        throw new Exception('This is not a valid LoadUnit enum: $this');
    }
  }

  String get apiValue => describeEnum(this).toUpperCase();
}

extension TimeUnitExtension on TimeUnit {
  String get shortDisplay {
    switch (this) {
      case TimeUnit.hours:
        return 'hrs';
      case TimeUnit.minutes:
        return 'mins';
      case TimeUnit.seconds:
        return 'secs';
      default:
        throw new Exception('This is not a valid TimeUnit enum: $this');
    }
  }

  String get display => describeEnum(this).capitalize;
  String get apiValue => describeEnum(this).toUpperCase();
}

extension WorkoutMoveRepTypeExtension on WorkoutMoveRepType {
  String get display => describeEnum(this).capitalize;
  String get apiValue => describeEnum(this).toUpperCase();
}
