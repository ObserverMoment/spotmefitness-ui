Map<String, dynamic>? _recursivelyAddAll(
  Map<String, dynamic>? target,
  Map<String, dynamic>? source,
) {
  target = Map<String, dynamic>.from(target!);
  source!.forEach((String key, dynamic value) {
    if (target!.containsKey(key) &&
        target[key] is Map<String, dynamic> &&
        value != null &&
        value is Map<String, dynamic>) {
      target[key] = _recursivelyAddAll(
        target[key] as Map<String, dynamic>,
        value,
      );
    } else {
      // Lists and nulls overwrite target as if they were normal scalars
      target[key] = value;
    }
  });
  return target;
}

/// Deeply merges `maps` into a new map, merging nested maps recursively.
///
/// Paths in the rightmost maps override those in the earlier ones, so:
/// ```
/// print(deeplyMergeLeft([
///   {'keyA': 'a1'},
///   {'keyA': 'a2', 'keyB': 'b2'},
///   {'keyB': 'b3'}
/// ]));
/// // { keyA: a2, keyB: b3 }
/// ```
///
/// Conflicting [List]s are overwritten like scalars
Map<String, dynamic>? deeplyMergeLeft(
  Iterable<Map<String, dynamic>?> maps,
) {
  // prepend an empty literal for functional immutability
  return (<Map<String, dynamic>?>[{}]..addAll(maps)).reduce(_recursivelyAddAll);
}

/// Returns a set of all IDs reachable from the given data ID.
/// Includes the given [dataId] itself.
/// usually [dataId] will be ['Query']
Set<String> reachableIdsFromDataId({
  required String dataId,
  required Map<String, dynamic> Function(String dataId) read,
  String referenceKey = '\$ref',
}) =>
    _idsInObject(read(dataId), read, referenceKey, {})..add(dataId);

/// Recursively finds reachable IDs in [object]
Set<String> _idsInObject(
  Object object,
  Map<String, dynamic> Function(String dataId) read,
  String referenceKey,
  Set<String> visited,
) {
  if (object is Map) {
    if (object.containsKey(referenceKey)) {
      if (object[referenceKey] ==
          'Workout:cbc79d39-ebbd-4a21-b3d6-314d63d23bb7') {
        print(object);
      }
      if (visited.contains(object[referenceKey])) return {};
      return {object[referenceKey]}..addAll(
          _idsInObject(
            read(object[referenceKey]),
            read,
            referenceKey,
            visited..add(object[referenceKey]),
          ),
        );
    }

    return object.values.fold(
      {},
      (ids, element) => ids
        ..addAll(
          _idsInObject(
            /// Had to add [?? {}] to the original function by [normalize] because it is possible for element to be null and this was throwing. Not sure why this was not an issue in the original library - possibly due to more strict partial data rules when writing fragments.
            element ?? {},
            read,
            referenceKey,
            visited,
          ),
        ),
    );
  } else if (object is List) {
    return object.fold(
      {},
      (ids, element) => ids
        ..addAll(
          _idsInObject(
            element,
            read,
            referenceKey,
            visited,
          ),
        ),
    );
  }
  return {};
}
