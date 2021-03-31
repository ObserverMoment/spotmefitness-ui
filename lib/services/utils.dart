import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/extensions.dart';

abstract class Utils {
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
      'assets/equipment_icons/${getSvgAssetUrlFromEquipmentName(name)}.svg',
      color: color ?? context.theme.primary,
    );
  }

  /// Assets should be snake case versions of the equipment name.
  static String getSvgAssetUrlFromEquipmentName(String name) {
    return name.toLowerCase().split(' ').join('_');
  }

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
