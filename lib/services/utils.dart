import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

abstract class Utils {
  static void unfocusAny() => FocusManager.instance.primaryFocus?.unfocus();
  // https://stackoverflow.com/questions/47776045/is-there-a-good-way-to-write-wait-for-variables-to-change-in-darts-async-meth
  // Completes the future when async test() return true
  // Or bails out after maxAttempts with an error.
  static Future waitWhile(Future<bool> Function() test,
      {Duration pollInterval = Duration.zero, int? maxAttempts}) {
    var completer = new Completer();
    int attempt = 0;
    check() async {
      if (await test()) {
        completer.complete();
      } else {
        attempt++;
        if (maxAttempts != null && attempt > maxAttempts) {
          completer.completeError(Exception(
              'waitWhile: Max attempts reached without receiving a valid response'));
        } else {
          new Timer(pollInterval, check);
        }
      }
    }

    check();
    return completer.future;
  }

  static Widget getEquipmentIcon(BuildContext context, String name,
      {Color? color, bool isSelected = false}) {
    return SvgPicture.asset(
      'assets/equipment_icons/${getSvgAssetUriFromEquipmentName(name)}.svg',
      color: color ?? context.theme.primary,
    );
  }

  /// Assets should be snake case versions of the equipment name.
  static String getSvgAssetUriFromEquipmentName(String name) {
    return name.toLowerCase().split(' ').join('_');
  }

  /// Assets should be snake case versions of the body area name in the db.
  static String getSvgAssetUriFromBodyAreaName(String name) {
    return name.toLowerCase().split(' ').join('_');
  }

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Checks that text is not null and not an empty string.
  static bool textNotNull(String? text) => (text != null && text != '');

  /// returns true if any items in the list exist (are not null).
  static bool anyNotNull(List list) => list.any((e) => e != null);

  /// Checks that reps is not null and not zero.
  static bool hasReps(double? reps) => (reps != null && reps != 0);

  /// Checks that load is not null and not zero.
  static bool hasLoad(double? load) => (load != null && load != 0);

  /// Checks that load is not null and not zero.
  static bool notNullNotEmpty(List? list) => list != null && list.isNotEmpty;
}
