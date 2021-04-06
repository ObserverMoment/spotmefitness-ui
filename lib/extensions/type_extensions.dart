import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/components/text.dart';

extension DoubleExtension on double {
  double roundMyDouble(
    int decimalPlaces,
  ) {
    int i = this.truncate();
    if (this == i) {
      return i.toDouble();
    }
    // Returns to max of [decimalPlaces] decimal places
    return ((this * pow(10, decimalPlaces)).truncate() / 100);
  }
}

extension DateTimeFormatting on DateTime {
  /// Date only - July 10, 1996
  String get dateString => DateFormat.yMMMMd().format(this);
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
