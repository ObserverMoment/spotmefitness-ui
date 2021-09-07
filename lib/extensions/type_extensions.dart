import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:supercharged/supercharged.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

extension StringExtension on String {
  String get capitalize => this[0].toUpperCase() + this.substring(1);
}

// https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension DateTimeFormatting on DateTime {
  String get timeString => DateFormat.jm().format(this);
  String get timeString24 => DateFormat('HH:mm').format(this);

  /// Date only - July 10, 1996
  String get dateString => DateFormat.yMMMMd().format(this);

  String get compactDateString => DateFormat('MMM d, yyyy').format(this);
  String get minimalDateStringYear => DateFormat('MMM d, yy').format(this);
  String get minimalDateString => DateFormat('MMM d ').format(this);
  String get dateAndTime => '${minimalDateString}, ${timeString}';

  String get daysAgo => this.isToday
      ? 'Today'
      : this.isYesterday
          ? 'Yesterday'
          : '${DateTime.now().difference(this).inDays} days ago';

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return tomorrow.day == this.day &&
        tomorrow.month == this.month &&
        tomorrow.year == this.year;
  }
}

extension DoubleExtension on double {
  // https://python.developreference.com/article/10024227/How+to+remove+trailing+zeros+using+Dart
  // The "EDIT" version
  String stringMyDouble() {
    int i = this.truncate();
    if (this == i) {
      return i.toString();
    }
    // Returns to max of two decimal places
    return ((this * 100).truncate() / 100).toString();
  }

  double roundMyDouble(
    int decimalPlaces,
  ) {
    int i = this.truncate();
    if (this == i) {
      return i.toDouble();
    }
    // Returns to max of [decimalPlaces] decimal places
    return ((this * pow(10, decimalPlaces)).round() / pow(10, decimalPlaces));
  }
}

extension DurationExtension on Duration {
  Widget display(
      {Axis direction = Axis.horizontal,
      bool bold = false,
      Color? color,
      FONTSIZE fontSize = FONTSIZE.MAIN}) {
    final int minutes = this.inMinutes;
    final int seconds = this.inSeconds.remainder(60);
    final FontWeight weight = bold ? FontWeight.bold : FontWeight.normal;

    List<Widget> children = [
      if (minutes != 0)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              minutes.toString(),
              weight: weight,
              lineHeight: 1.2,
              color: color,
              size: fontSize,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: MyText(
                'min',
                weight: weight,
                size: fontSize,
                color: color,
              ),
            ),
          ],
        ),
      if (seconds != 0)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              seconds.toString(),
              weight: weight,
              lineHeight: 1.3,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: MyText('secs', weight: weight, size: FONTSIZE.SMALL),
            )
          ],
        ),
    ];
    if (direction == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }

  String get displayString {
    if (this.inSeconds == 0) {
      return '---';
    }
    final int hours = this.inHours;
    final int minutes = this.inMinutes - (hours * 60);
    final int seconds = this.inSeconds.remainder(60);
    final String hourString = hours != 0 ? '$hours hr' : "";
    final String minuteString = minutes != 0 ? '$minutes min' : "";
    final String secondsString = seconds != 0 ? '$seconds sec' : "";

    final hourSpace = hours != 0 && minutes != 0 ? ' ' : '';
    final minuteSpace = minutes != 0 && seconds != 0 ? ' ' : '';

    return '$hourString$hourSpace$minuteString$minuteSpace$secondsString';
  }

  Duration clamp(Duration lower, Duration upper) {
    if (this < lower) {
      return lower;
    } else if (this > upper) {
      return upper;
    } else {
      return this;
    }
  }

  String compactDisplay() {
    final String _hours =
        this.inHours != 0 ? '${this.inHours.toString().padLeft(2, '0')}:' : '';
    final String _minutes =
        '${this.inMinutes.remainder(60).toString().padLeft(2, '0')}:';
    final String _seconds =
        '${this.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return '$_hours$_minutes$_seconds';
  }
}

extension IntExtension on int {
  String secondsToTimeDisplay() {
    final String amount;
    final String unit;
    if (this >= 3600) {
      // Hours
      amount = (this / 3600).stringMyDouble();
      unit = amount == '1' ? 'hour' : 'hours';
    } else if (this >= 60) {
      // Minutes
      amount = (this / 60).stringMyDouble();
      unit = amount == '1' ? 'min' : 'mins';
    } else {
      // Seconds
      amount = this.toString();
      unit = amount == '1' ? 'sec' : 'secs';
    }

    return '$amount $unit';
  }
}

extension ListExtension on List {
  /// If not in list, add it, else remove it.
  /// Assumes Equatable functionality if item is non scalar.
  /// Returns a new list.
  List<T> toggleItem<T>(T item) {
    return (this as List<T>).contains(item)
        ? (this as List<T>).where((e) => e != item).toList()
        : <T>[...this, item];
  }
}

extension PageControllerExtension on PageController {
  void toPage(int page) => this.animateToPage(page,
      duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
}

extension WorkoutPlanExtension on WorkoutPlan {
  DifficultyLevel? get calcDifficulty {
    final workouts = this.workoutsInPlan;
    if (workouts.isEmpty) {
      return null;
    }
    final average = workouts.averageBy((w) => w.difficultyLevel.numericValue);
    return DifficultyLevelExtension.levelFromNumber(average!);
  }

  String get sessionsPerWeek =>
      (this.workoutPlanDays.length / this.lengthWeeks).stringMyDouble();

  String get lengthString =>
      '${this.lengthWeeks} ${this.lengthWeeks == 1 ? "week" : "weeks"}';

  List<String> get uniqueEquipmentNames {
    final Set<String> allEquipments = {};
    final workouts = this.workoutsInPlan;

    for (final workout in workouts) {
      for (final section in workout.workoutSections) {
        for (final workoutSet in section.workoutSets) {
          for (final workoutMove in workoutSet.workoutMoves) {
            if (workoutMove.equipment != null) {
              allEquipments.add(workoutMove.equipment!.name);
            }
            if (workoutMove.move.requiredEquipments.isNotEmpty) {
              allEquipments.addAll(
                  workoutMove.move.requiredEquipments.map((e) => e.name));
            }
          }
        }
      }
    }
    return allEquipments.toList();
  }

  List<Workout> get workoutsInPlan {
    return this.workoutPlanDays.fold<List<Workout>>(
        [],
        (acum, next) =>
            [...acum, ...next.workoutPlanDayWorkouts.map((d) => d.workout)]);
  }

  List<WorkoutGoal> get workoutGoalsInPlan {
    return this
        .workoutPlanDays
        .fold<List<List<WorkoutGoal>>>(
            [],
            (acum, next) => [
                  ...acum,
                  ...next.workoutPlanDayWorkouts
                      .map((d) => d.workout.workoutGoals)
                ])
        .expand((x) => x)
        .toList();
  }
}
