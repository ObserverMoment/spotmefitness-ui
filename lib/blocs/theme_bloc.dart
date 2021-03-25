import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';

enum ThemeName { dark, light }

class ThemeBloc extends ChangeNotifier {
  GraphQLClient graphqlClient;
  final String _hiveThemeKey = 'themeName';

  ThemeBloc({required this.graphqlClient}) {
    // Initialise them from Hive box.
    final themeNameFromSettings =
        Hive.box('settings').get(_hiveThemeKey, defaultValue: ThemeName.dark);
    if (themeNameFromSettings == 'dark') {
      _setToDark();
    } else {
      _setToLight();
    }
  }

  Theme theme = ThemeData.darkTheme;
  ThemeName themeName = ThemeName.dark;

  /// Getters for regularly used attributes
  /// Context has been extended to allow for calling context.[getter]
  /// Rather than context.watch<ThemeBloc>()
  CupertinoThemeData get cupertinoThemeData => theme.cupertinoThemeData;
  CustomThemeData get customThemeData => theme.customThemeData;
  Color get primary => theme.cupertinoThemeData.primaryColor;
  Color get background => theme.cupertinoThemeData.scaffoldBackgroundColor;
  Color get activeIcon => theme.customThemeData.activeIcon;

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
  CustomThemeData(
      {required this.scaffoldGradient,
      required this.bottomNavigationBackground,
      required this.activeIcon});
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
      bottomNavigationBackground: const Color(0xff434343));

  static CustomThemeData customLightData = CustomThemeData(
      scaffoldGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [CupertinoColors.white, const Color(0xffE0EAFC)],
        stops: [0.1, 0.9],
      ),
      activeIcon: Styles.neonBlueOne,
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
  static const black = CupertinoColors.black;
  static const white = CupertinoColors.white;
  static const grey = CupertinoColors.systemGrey;
  static final lightGrey = CupertinoColors.systemGrey.withOpacity(0.2);
  static const errorRed = CupertinoColors.destructiveRed;
  static const infoBlue = CupertinoColors.activeBlue;
  static const heartRed = const Color(0xffA8294B);
  static const colorOne = const Color(0xff286E6E);
  static const colorTwo = const Color(0xffFC7436);
  static const colorThree = const Color(0xff492B58);
  static const colorFour = const Color(0xff6DD5ED);
  static const neonBlueOne = const Color(0xff2193B0);
  static const peachRed = const Color(0xffF28367);

  // Difficulty Level Colours
  static const difficultyLevelOne = const Color(0xff226F54); // Green
  static const difficultyLevelTwo = const Color(0xff005AA7); // Blue
  static const difficultyLevelThree = const Color(0xffFFA62B); // Orange
  static const difficultyLevelFour = Color(0xff990133); // Red
  static const difficultyLevelFive = const Color(0xff1A1B25); // Black

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
    colors: [const Color(0xffF28367), const Color(0xffFF5282)],
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
