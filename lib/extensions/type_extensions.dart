import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/components/text.dart';

extension StringExtension on String {
  String get capitalize => this[0].toUpperCase() + this.substring(1);
}

extension DateTimeFormatting on DateTime {
  /// Date only - July 10, 1996
  String get dateString => DateFormat.yMMMMd().format(this);
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

extension ListExtension on List {
  /// If not in list, add it, else remove it.
  /// Assumes Equatable functionality if item is non scalar.
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
