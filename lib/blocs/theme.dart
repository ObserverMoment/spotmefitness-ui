import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

enum ThemeName { LIGHT, DARK }

class ThemeBloc {
  static const CupertinoThemeData darkTheme = CupertinoThemeData(
      brightness: Brightness.dark,
      barBackgroundColor: CupertinoColors.black,
      scaffoldBackgroundColor: CupertinoColors.black,
      primaryColor: const Color(0xff8f28f6),
      primaryContrastingColor: const Color(0xfffefe7e),
      textTheme: CupertinoTextThemeData(
        primaryColor: const Color(0xff8f28f6),
        textStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        tabLabelTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        navTitleTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        navLargeTitleTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: LARGE_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        actionTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        navActionTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        pickerTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        dateTimePickerTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
      ));

  static CupertinoThemeData lightTheme = CupertinoThemeData(
      brightness: Brightness.light,
      barBackgroundColor: CupertinoColors.systemGroupedBackground,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      primaryColor: const Color(0xff8f28f6),
      primaryContrastingColor: const Color(0xff0088ff),
      textTheme: CupertinoTextThemeData(
        primaryColor: const Color(0xff8f28f6),
        textStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        tabLabelTextStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        navTitleTextStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        navLargeTitleTextStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: LARGE_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        actionTextStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        navActionTextStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        pickerTextStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
        dateTimePickerTextStyle: TextStyle(
            color: CupertinoColors.black,
            fontSize: MAIN_FONT_SIZE,
            fontFamily: 'Nunito_Sans'),
      ));

  StreamController<CupertinoThemeData> _theme =
      StreamController<CupertinoThemeData>.broadcast();

  Stream<CupertinoThemeData> get theme => _theme.stream;

  void switchTheme(ThemeName themeName) async {
    _theme.add(themeName == ThemeName.DARK ? darkTheme : lightTheme);
  }

  void dispose() {
    _theme.close();
  }
}
