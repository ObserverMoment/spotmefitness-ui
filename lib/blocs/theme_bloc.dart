import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:sofie_ui/constants.dart';

enum ThemeName { dark, light }

class ThemeBloc extends ChangeNotifier {
  ThemeBloc({Brightness deviceBrightness = Brightness.dark}) {
    // Check for saved setting in local Hive box.
    final themeNameFromSettings = Hive.box(kSettingsHiveBoxName)
        .get(kSettingsHiveBoxThemeKey, defaultValue: null);

    if (themeNameFromSettings != null) {
      if (themeNameFromSettings == kSettingsDarkThemeKey) {
        _setToDark();
      } else {
        _setToLight();
      }
    } else {
      // Initialise from device or default to dark.
      if (deviceBrightness == Brightness.dark) {
        _setToDark();
      } else {
        _setToLight();
      }
    }
  }

  Theme theme = ThemeData.darkTheme;
  ThemeName themeName = ThemeName.dark;

  /// Getters for regularly used attributes
  /// Context has been extended to allow for calling context.theme.[getter]
  /// Rather than context.watch<ThemeBloc>()
  CupertinoThemeData get cupertinoThemeData => theme.cupertinoThemeData;
  CustomThemeData get customThemeData => theme.customThemeData;
  Brightness get brightness =>
      themeName == ThemeName.dark ? Brightness.dark : Brightness.light;
  Color get primary => theme.cupertinoThemeData.primaryColor;
  Color get background => theme.cupertinoThemeData.scaffoldBackgroundColor;
  Color get activeIcon => theme.customThemeData.activeIcon;
  Color get cardBackground => theme.customThemeData.cardBackground;
  Color get modalBackground => theme.customThemeData.cardBackground;
  Color get barBackground => theme.cupertinoThemeData.barBackgroundColor;
  Color get navbarBottomBorder => theme.customThemeData.navbarBottomBorder;

  Future<void> switchToTheme(ThemeName switchToTheme) async {
    if (switchToTheme == ThemeName.dark && themeName != ThemeName.dark) {
      _setToDark();
      await Hive.box(kSettingsHiveBoxName)
          .put(kSettingsHiveBoxThemeKey, kSettingsDarkThemeKey);
    } else if (switchToTheme == ThemeName.light &&
        themeName != ThemeName.light) {
      _setToLight();
      await Hive.box(kSettingsHiveBoxName)
          .put(kSettingsHiveBoxThemeKey, kSettingsLightThemeKey);
    }
  }

  void _setToDark() {
    theme = ThemeData.darkTheme;
    themeName = ThemeName.dark;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    notifyListeners();
  }

  void _setToLight() {
    theme = ThemeData.lightTheme;
    themeName = ThemeName.light;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    notifyListeners();
  }
}

class Theme {
  final CupertinoThemeData cupertinoThemeData;
  final CustomThemeData customThemeData;
  Theme(this.cupertinoThemeData, this.customThemeData);
}

class CustomThemeData {
  final Color greyOne;
  final Color greyTwo;
  final Color greyThree;
  final Color greyFour;
  final LinearGradient scaffoldGradient;
  final Color bottomNavigationBackground;
  final Color activeIcon;
  final Color cardBackground;
  final Color navbarBottomBorder;
  CustomThemeData(
      {required this.greyOne,
      required this.greyTwo,
      required this.greyThree,
      required this.greyFour,
      required this.scaffoldGradient,
      required this.bottomNavigationBackground,
      required this.activeIcon,
      required this.cardBackground,
      required this.navbarBottomBorder});
}

abstract class ThemeData {
  static Theme darkTheme = Theme(cupertinoDarkData, customDarkData);
  static Theme lightTheme = Theme(cupertinoLightData, customLightData);

  static CustomThemeData customDarkData = CustomThemeData(
      greyOne: Styles.greyOne,
      greyTwo: Styles.greyTwo,
      greyThree: Styles.greyThree,
      greyFour: Styles.greyFour,
      scaffoldGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [CupertinoColors.black, Color(0xff434343)],
        stops: [0.1, 0.9],
      ),
      activeIcon: Styles.colorFour,
      cardBackground: const Color(0xff1a1a1c),
      bottomNavigationBackground: const Color(0xff434343),
      navbarBottomBorder: Styles.white.withOpacity(0.1));

  static CustomThemeData customLightData = CustomThemeData(
      greyOne: Styles.greyFour,
      greyTwo: Styles.greyThree,
      greyThree: Styles.greyTwo,
      greyFour: Styles.greyOne,
      scaffoldGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [CupertinoColors.white, Color(0xffE0EAFC)],
        stops: [0.1, 0.9],
      ),
      activeIcon: Styles.neonBlueOne,
      cardBackground: CupertinoColors.white,
      bottomNavigationBackground: const Color(0xffffffff),
      navbarBottomBorder: Styles.black.withOpacity(0.1));

  static CupertinoThemeData cupertinoDarkData = CupertinoThemeData(
      brightness: Brightness.dark,
      barBackgroundColor: const Color(0xff0a0a0a),
      scaffoldBackgroundColor: CupertinoColors.black,
      primaryColor: CupertinoColors.white,
      primaryContrastingColor: const Color(0xff286E6E),
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.white,
        textStyle: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(color: CupertinoColors.white)),
      ));

  static CupertinoThemeData cupertinoLightData = CupertinoThemeData(
      brightness: Brightness.light,
      barBackgroundColor: const Color(0xFFF7F7F7),
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      primaryColor: CupertinoColors.black,
      primaryContrastingColor: const Color(0xff286E6E),
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.black,
        textStyle: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(color: CupertinoColors.black)),
      ));
}

//// Values which stay constant across both themes ////
abstract class Styles {
  // Theme colors
  static const Color black = CupertinoColors.black;
  static const Color white = CupertinoColors.white;
  static const Color lightGrey = CupertinoColors.systemGrey;
  static final Color grey = CupertinoColors.darkBackgroundGray;
  static const Color errorRed = CupertinoColors.destructiveRed;
  static const Color infoBlue = CupertinoColors.activeBlue;
  static const Color heartRed = Color(0xffA8294B);
  static const Color colorOne = Color(0xff286E6E);
  static const Color colorTwo = Color(0xffFC7436);
  static const Color colorThree = Color(0xff492B58);
  static const Color colorFour = Color(0xff6DD5ED);
  static const Color neonBlueOne = Color(0xff2193B0);
  static const Color peachRed = Color(0xffF28367);
  static const Color pink = Color(0xffFF5282);
  static const Color starGold = Colors.amber;
  static const Color yellow = Colors.yellow;

  // Shades of grey
  static const Color greyOne = Color(0xff383838);
  static const Color greyTwo = Color(0xff595959);
  static const Color greyThree = Color(0xff9c9c9c);
  static const Color greyFour = Color(0xffc9c9c9);

  // Difficulty Level Colours
  static const difficultyLevelOne = Color(0xff226F54); // Green
  static const difficultyLevelTwo = Color(0xff005AA7); // Blue
  static const difficultyLevelThree = Color(0xffFFA62B); // Orange
  static const difficultyLevelFour = Color(0xff990133); // Red
  static const difficultyLevelFive = CupertinoColors.black; // Black

  static const LinearGradient colorOneGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Styles.colorOne, Styles.colorOne],
    stops: [0.1, 0.9],
  );

  static const neonBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Styles.neonBlueOne, Styles.colorFour],
    stops: [0.1, 0.9],
  );

  static const neonBlueSweepGradient = SweepGradient(
    colors: [Styles.neonBlueOne, Styles.colorFour],
    stops: [0.1, 0.9],
  );

  static const secondaryButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff232526), Color(0xff272b33), Color(0xff232526)],
    stops: [0, 0.5, 1],
  );

  static const pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Styles.peachRed, Styles.pink],
    stops: [0.1, 0.9],
  );

  static final LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Styles.colorOne,
      Color.lerp(Styles.colorOne, CupertinoColors.white, 0.15)!
    ],
    stops: const [0.1, 0.9],
  );

  static final BoxShadow avatarBoxShadow = BoxShadow(
      color: CupertinoColors.black.withOpacity(0.4),
      blurRadius: 2.0, // soften the shadow
      spreadRadius: 1.0, //extend the shadow
      offset: const Offset(
        1.0, // Move to right horizontally
        1.0, // Move to bottom Vertically
      ));

  static final BoxShadow elevatedButtonShadow = BoxShadow(
      color: CupertinoColors.black.withOpacity(0.3),
      blurRadius: 3, // soften the shadow
      spreadRadius: 3.0, //extend the shadow
      offset: const Offset(
        0.3, // Move to right horizontally
        0.3, // Move to bottom Vertically
      ));

  static final BoxShadow colorPickerSelectorBoxShadow = BoxShadow(
      color: CupertinoColors.black.withOpacity(0.2),
      blurRadius: 2, // soften the shadow
      spreadRadius: 1.5, //extend the shadow
      offset: const Offset(
        0.2, // Move to right horizontally
        0.2, // Move to bottom Vertically
      ));

  static final BoxShadow cardBoxShadow = BoxShadow(
      color: CupertinoColors.black.withOpacity(0.1),
      blurRadius: 3.0, // soften the shadow
      spreadRadius: 1.0, //extend the shadow
      offset: const Offset(
        0.2, // Move to right horizontally
        0.2, // Move to bottom Vertically
      ));

  /// For use in nav bars, headers and buttons.
  static const double buttonIconSize = 25.0;
}
