/// For Artemis package - custom scalar conversions for types.
/// DateTime
DateTime fromGraphQLDateTimeToDartDateTime(int date) =>
    DateTime.fromMillisecondsSinceEpoch(date);

int fromDartDateTimeToGraphQLDateTime(DateTime date) =>
    date.millisecondsSinceEpoch;

DateTime? fromGraphQLDateTimeToDartDateTimeNullable(int? date) =>
    date != null ? DateTime.fromMillisecondsSinceEpoch(date) : null;

int? fromDartDateTimeToGraphQLDateTimeNullable(DateTime? date) =>
    date != null ? date.millisecondsSinceEpoch : null;

/// JSON
Map fromGraphQLJsonToDartMap(dynamic data) {
  return Map<String, dynamic>.from(data as Map<dynamic, dynamic>);
}

dynamic fromDartMapToGraphQLJson(Map data) => data;

Map? fromGraphQLJsonToDartMapNullable(dynamic? data) {
  return data != null
      ? Map<String, dynamic>.from(data as Map<dynamic, dynamic>)
      : null;
}

dynamic? fromDartMapToGraphQLJsonNullable(Map? data) =>
    data != null ? data : null;
