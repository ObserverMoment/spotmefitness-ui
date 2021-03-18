import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/model/enum.dart';

/// For Artemis package - custom scalar conversions for types.
DateTime? fromGraphQLDateTimeToDartDateTime(String? date) =>
    date != null ? DateTime.parse(date) : null;
String? fromDartDateTimeToGraphQLDateTime(DateTime? date) =>
    date != null ? date.toUtc().toIso8601String() : null;

// ThemeName? fromGraphQLThemeNameToDartThemeName(String? themeName) =>
//     themeName != null ? themeName.toThemeName() : null;
// String? fromDartThemeNameToGraphQLThemeName(ThemeName? themeName) =>
//     themeName != null ? describeEnum(themeName) : null;
