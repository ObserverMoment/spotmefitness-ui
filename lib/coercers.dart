/// For Artemis package - custom scalar conversions for types.
DateTime? fromGraphQLDateTimeToDartDateTime(int? date) =>
    date != null ? DateTime.fromMillisecondsSinceEpoch(date) : null;

int? fromDartDateTimeToGraphQLDateTime(DateTime? date) =>
    date != null ? date.millisecondsSinceEpoch : null;
