/// For Artemis package - custom scalar conversions for types.
DateTime? fromGraphQLDateTimeToDartDateTime(String? date) =>
    date != null ? DateTime.parse(date) : null;
String? fromDartDateTimeToGraphQLDateTime(DateTime? date) =>
    date != null ? date.toUtc().toIso8601String() : null;
