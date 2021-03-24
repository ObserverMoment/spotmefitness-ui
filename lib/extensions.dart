import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';

// https://stackoverflow.com/questions/49172746/is-it-possible-extend-themedata-in-flutter
extension BuildContextExtension on BuildContext {
  ThemeBloc get theme {
    return watch<ThemeBloc>();
  }
}

/// TODO: Implement NumberParsing on String
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

/// TODO: Implement NumberUtils on num
extension NumberUtils on num {}

/// TODO: Implement DateTimeFormatting on String
extension DateTimeFormatting on DateTime {}
