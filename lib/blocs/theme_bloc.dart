import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

enum ThemeName { dark, light }

class ThemeBloc extends ChangeNotifier {
  final String _hiveThemeKey = 'themeName';

  ThemeBloc({bool? isLanding = false}) {
    if (isLanding != null && isLanding) {
      /// Always a dark theme for sign in and landing.
      _setToDark();
    } else {
      // Initialise them from Hive box.
      final themeNameFromSettings =
          Hive.box('settings').get(_hiveThemeKey, defaultValue: 'dark');

      if (themeNameFromSettings == 'dark') {
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
  Color get primary => theme.cupertinoThemeData.primaryColor;
  Color get background => theme.cupertinoThemeData.scaffoldBackgroundColor;
  Color get activeIcon => theme.customThemeData.activeIcon;
  Color get cardBackground => theme.customThemeData.cardBackground;

  Future<void> switchToTheme(ThemeName switchToTheme) async {
    if (switchToTheme == ThemeName.dark && themeName != ThemeName.dark) {
      _setToDark();
      await Hive.box('settings').put(_hiveThemeKey, 'dark');
    } else if (switchToTheme == ThemeName.light &&
        themeName != ThemeName.light) {
      _setToLight();
      await Hive.box('settings').put(_hiveThemeKey, 'light');
    }
  }

  void _setToDark() {
    theme = ThemeData.darkTheme;
    themeName = ThemeName.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    notifyListeners();
  }

  void _setToLight() {
    theme = ThemeData.lightTheme;
    themeName = ThemeName.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
  final LinearGradient scaffoldGradient;
  final Color bottomNavigationBackground;
  final Color activeIcon;
  final Color cardBackground;
  CustomThemeData(
      {required this.scaffoldGradient,
      required this.bottomNavigationBackground,
      required this.activeIcon,
      required this.cardBackground});
}

abstract class ThemeData {
  static Theme darkTheme = Theme(cupertinoDarkData, customDarkData);
  static Theme lightTheme = Theme(cupertinoLightData, customLightData);

  static CustomThemeData customDarkData = CustomThemeData(
      scaffoldGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [CupertinoColors.black, const Color(0xff434343)],
        stops: [0.1, 0.9],
      ),
      activeIcon: Styles.colorFour,
      cardBackground: const Color(0xFF1c1c1c),
      bottomNavigationBackground: const Color(0xff434343));

  static CustomThemeData customLightData = CustomThemeData(
      scaffoldGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [CupertinoColors.white, const Color(0xffE0EAFC)],
        stops: [0.1, 0.9],
      ),
      activeIcon: Styles.neonBlueOne,
      cardBackground: CupertinoColors.white,
      bottomNavigationBackground: const Color(0xffffffff));

  static CupertinoThemeData cupertinoDarkData = CupertinoThemeData(
      brightness: Brightness.dark,
      barBackgroundColor: CupertinoColors.black,
      scaffoldBackgroundColor: CupertinoColors.black,
      primaryColor: CupertinoColors.white,
      primaryContrastingColor: const Color(0xff286E6E),
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.white,
        textStyle: GoogleFonts.palanquin(
            textStyle: TextStyle(color: CupertinoColors.white)),
      ));

  static CupertinoThemeData cupertinoLightData = CupertinoThemeData(
      brightness: Brightness.light,
      barBackgroundColor: CupertinoColors.systemGroupedBackground,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      primaryColor: CupertinoColors.black,
      primaryContrastingColor: const Color(0xff286E6E),
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.black,
        textStyle: GoogleFonts.palanquin(
            textStyle: TextStyle(color: CupertinoColors.black)),
      ));
}

//// Values which stay constant across both themes ////
abstract class Styles {
  // Theme colors
  static const Color black = CupertinoColors.black;
  static const Color white = CupertinoColors.white;
  static const Color grey = CupertinoColors.systemGrey;
  static final Color lightGrey = CupertinoColors.systemGrey.withOpacity(0.2);
  static const Color errorRed = CupertinoColors.destructiveRed;
  static const Color infoBlue = CupertinoColors.activeBlue;
  static const Color heartRed = const Color(0xffA8294B);
  static const Color colorOne = const Color(0xff286E6E);
  static const Color colorTwo = const Color(0xffFC7436);
  static const Color colorThree = const Color(0xff492B58);
  static const Color colorFour = const Color(0xff6DD5ED);
  static const Color neonBlueOne = const Color(0xff2193B0);
  static const Color peachRed = const Color(0xffF28367);

  // Difficulty Level Colours
  static const difficultyLevelOne = const Color(0xff226F54); // Green
  static const difficultyLevelTwo = const Color(0xff005AA7); // Blue
  static const difficultyLevelThree = const Color(0xffFFA62B); // Orange
  static const difficultyLevelFour = Color(0xff990133); // Red
  static const difficultyLevelFive = CupertinoColors.black; // Black

  static final LinearGradient colorOneGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Styles.colorOne, Styles.colorOne],
    stops: [0.1, 0.9],
  );

  static final fullPageModalGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Styles.colorOne.withOpacity(0.7),
      Styles.colorOne.withOpacity(0.4),
      CupertinoColors.black.withOpacity(0.5),
      CupertinoColors.black.withOpacity(0.7),
      CupertinoColors.black.withOpacity(1),
    ],
    stops: [0.1, 0.2, 0.4, 0.7, 0.9],
  );

  static final neonBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Styles.neonBlueOne, Styles.colorFour],
    stops: [0.1, 0.9],
  );

  static final pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Styles.peachRed, const Color(0xffFF5282)],
    stops: [0.1, 0.9],
  );

  static final LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Styles.colorOne,
      Color.lerp(Styles.colorOne, CupertinoColors.white, 0.15)!
    ],
    stops: [0.1, 0.9],
  );

  static final BoxShadow avatarBoxShadow = BoxShadow(
      color: CupertinoColors.black.withOpacity(0.5),
      blurRadius: 2.0, // soften the shadow
      spreadRadius: 1.0, //extend the shadow
      offset: Offset(
        1.0, // Move to right horizontally
        1.0, // Move to bottom Vertically
      ));

  static final BoxShadow elevatedButtonShadow = BoxShadow(
      color: CupertinoColors.black.withOpacity(0.3),
      blurRadius: 3, // soften the shadow
      spreadRadius: 3.0, //extend the shadow
      offset: Offset(
        0.3, // Move to right horizontally
        0.3, // Move to bottom Vertically
      ));

  static final BoxShadow cardBoxShadow = BoxShadow(
      color: CupertinoColors.black.withOpacity(0.1),
      blurRadius: 3.0, // soften the shadow
      spreadRadius: 1.0, //extend the shadow
      offset: Offset(
        0.2, // Move to right horizontally
        0.2, // Move to bottom Vertically
      ));

  /// For use in nav bars, headers and buttons.
  static final double buttonIconSize = 25.0;

  // static final BorderRadius sharpRadius = BorderRadius.circular(4);
  // static final BorderRadius mediumSharpRadius = BorderRadius.circular(6);
  // static final BorderRadius mediumRadius = BorderRadius.circular(8);
  // static final BorderRadius roundedRadius = BorderRadius.circular(12);
  // static final BorderRadius pillRadius = BorderRadius.circular(24);
  // static final BorderRadius circleRadius = BorderRadius.circular(32);

  // static const double fontSizeH1 = 22;
  // static const double fontSizeH2 = 20;
  // static const double fontSizeH3 = 18;
  // static const double fontSizeMain = 16;
  // static const double fontSizeSmall = 14;
  // static const double fontSizeTiny = 12;
  // static const double fontSizeNano = 10;

  // static final actionSheetDestructive = TextStyle(color: Styles.errorRed);

  // static final roundedContainerDecoration = BoxDecoration(
  //     borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
  //     color: Styles.black);

  // static final blackBGGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     Styles.black.withOpacity(1),
  //     Styles.black.withOpacity(0.95),
  //     Styles.black.withOpacity(1),
  //     Styles.black.withOpacity(0.95),
  //     Styles.black.withOpacity(1),
  //   ],
  //   stops: [0.1, 0.3, 0.5, 0.7, 0.9],
  // );

  // static const Color highlightTwo = Color.fromRGBO(252, 116, 54, 1); // Yellow
  // static const Color highlightThree = Color.fromRGBO(101, 69, 151, 1); // Purple

  // static const highlightFour = Color.fromRGBO(87, 75, 226, 1); // Blue
  // static const highlightFive = Color.fromRGBO(249, 244, 233, 1); // Ivory

  // static final colorOneGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     Styles.colorOne,
  //     Color.lerp(Styles.colorOne, Styles.white, 0.4)
  //   ],
  //   stops: [0.1, 0.9],
  // );

  // static final highlightTwoGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     Styles.highlightTwo,
  //     Color.lerp(Styles.highlightTwo, Styles.white, 0.2)
  //   ],
  //   stops: [0.1, 0.9],
  // );

  // // Padding and spacing
  // static final onboardingPagePadding =
  //     EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 60);

  // static final double inlineInputRowHeight = 64;
}
