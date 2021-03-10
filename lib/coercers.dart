/// For Artemis package - custom scalar conversions
DateTime fromGraphQLDateTimeToDartDateTime(String date) => DateTime.parse(date);
String fromDartDateTimeToGraphQLDateTime(DateTime date) =>
    date.toUtc().toIso8601String();
