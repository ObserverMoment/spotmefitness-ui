import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/components/text.dart';

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
  /// Date only - July 10, 1996
  String get dateString => DateFormat.yMMMMd().format(this);
  String get timeString => DateFormat.jm().format(this);
  String get compactDateString => DateFormat('MMM d, yy').format(this);
  String get minimalDateString => DateFormat('MMM d').format(this);

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
  Widget display({Axis direction = Axis.horizontal}) {
    final int minutes = this.inMinutes;
    final int seconds = this.inSeconds.remainder(60);
    List<Widget> children = [
      if (minutes != 0)
        Row(
          children: [
            MyText(
              minutes.toString(),
              lineHeight: 1.3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: MyText(
                'min',
                size: FONTSIZE.TINY,
              ),
            ),
          ],
        ),
      if (seconds != 0)
        Row(
          children: [
            MyText(
              seconds.toString(),
              lineHeight: 1.3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: MyText('secs', size: FONTSIZE.TINY),
            )
          ],
        ),
    ];
    if (direction == Axis.horizontal) {
      return Row(
        children: children,
      );
    } else {
      return Column(
        children: children,
      );
    }
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
