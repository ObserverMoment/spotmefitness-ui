/// For Artemis package - custom scalar conversions for types.
DateTime fromGraphQLDateTimeToDartDateTime(int date) =>
    DateTime.fromMillisecondsSinceEpoch(date);

int fromDartDateTimeToGraphQLDateTime(DateTime date) =>
    date.millisecondsSinceEpoch;

DateTime? fromGraphQLDateTimeToDartDateTimeNullable(int? date) =>
    date != null ? DateTime.fromMillisecondsSinceEpoch(date) : null;

int? fromDartDateTimeToGraphQLDateTimeNullable(DateTime? date) =>
    date != null ? date.millisecondsSinceEpoch : null;
