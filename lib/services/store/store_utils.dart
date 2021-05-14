import 'package:gql/ast.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:artemis/artemis.dart';

const kStoreReferenceKey = '\$ref';

/// Accepts hierarchical data and write it to a normalized key value store [Hive] box.
/// All objects must have two fields, [__typename] and [id] to generate a unique id.
void normalizeToStore(
    {required bool isQuery,
    required Map<String, dynamic> data,
    required void Function(String key, Object? data) write,
    required Map<String, dynamic> Function(String key) read,
    String referenceKey = kStoreReferenceKey}) {
  Map<String, dynamic> normalizedResult = {};

  try {
    /// Create the normalized map.
    if (isQuery) {
      /// Top data.keys will be the query names. Usually just one.
      /// { userWorkouts: [obj, obj, obj] }.
      normalizedResult['Query'] =
          data.keys.fold<Map<String, dynamic>>({}, (obj, key) {
        obj[key] =
            normalizeObject(normalized: normalizedResult, data: data[key]);
        return obj;
      });
    } else {
      normalizeObject(normalized: normalizedResult, data: data);
    }

    /// Write each key in the normalized map to the store. Overwriting previous data.
    normalizedResult.entries.forEach((entry) {
      write(entry.key, {
        ...read(entry.key),
        ...entry.value,
      });
    });
  } catch (e) {
    print(e);
    print('normalizeToStore falied - no data written.');
  }
}

/// Recursively traverses the object.
Object? normalizeObject(
    {required Object? data,
    required Map<String, dynamic> normalized,
    String referenceKey = kStoreReferenceKey}) {
  if (data is Map<String, dynamic>) {
    final normalizedData =
        data.entries.fold<Map<String, dynamic>>({}, (obj, entry) {
      obj[entry.key] =
          normalizeObject(normalized: normalized, data: entry.value);
      return obj;
    });

    final dataId = resolveDataId(data);
    if (dataId == null) {
      /// Do not normalize and return un-normalized raw data.
      return data;
    } else {
      normalized[dataId] = normalizedData;
      return {referenceKey: resolveDataId(data)};
    }
  } else if (data is List) {
    return data
        .map((obj) => normalizeObject(normalized: normalized, data: obj))
        .toList();
  } else {
    /// If data is scalar or null then return it to be written.
    return data;
  }
}

String? resolveDataId(Map<String, dynamic> data) {
  if (data['__typename'] == null) {
    /// Cannot normalize an object without a data["__typename"] field as this is required to resolve the unique id.
    return null;
  } else if (data['id'] == null) {
    /// Cannot normalize an object without a data["id"] field as this is required to resolve the unique id.
    return null;
  } else if (kExcludeFromNormalization.contains(data['__typename'])) {
    /// We do not want to normalize these objects - they are always children and should be considered only in relation to their parent.
    /// i.e. There should be no entry under [WorkoutMove:id]. This is never accessed directly and should be deleted if its parents [set, section, workout] are deleted.
    return null;
  } else {
    return '${data["__typename"]}:${data["id"]}';
  }
}

Object? recursiveMapRemoveRefsToId(
    {required Object data,
    required String id,
    String referenceKey = kStoreReferenceKey}) {
  if (data is Map) {
    if (data.keys.length == 1 && data[kStoreReferenceKey] == id) {
      return null;
    } else {
      return data.entries.fold<Map>({}, (obj, entry) {
        obj[entry.key] = recursiveMapRemoveRefsToId(data: entry.value, id: id);
        return obj;
      });
    }
  } else if (data is List) {
    /// Lists get recursive mapped.
    return data
        .map((obj) => recursiveMapRemoveRefsToId(data: obj, id: id))
        .toList();
  } else {
    /// Nulls and scalars just get returned.
    return data;
  }
}

Map<String, dynamic>? recursivelyAddAll(
  Map<String, dynamic>? target,
  Map<String, dynamic>? source,
) {
  target = Map<String, dynamic>.from(target!);
  source!.forEach((String key, dynamic value) {
    if (target!.containsKey(key) &&
        target[key] is Map<String, dynamic> &&
        value != null &&
        value is Map<String, dynamic>) {
      target[key] = recursivelyAddAll(
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
  return (<Map<String, dynamic>?>[{}]..addAll(maps)).reduce(recursivelyAddAll);
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

/// TODO: Needs some further research and testing.
/// Returns null if no alias found.
String? extractRootFieldAliasFromOperation(GraphQLQuery operation) {
  final OperationDefinitionNode operationDefinitionNode = operation
          .document.definitions
          .firstWhere((node) => node is OperationDefinitionNode)
      as OperationDefinitionNode;

  return (operationDefinitionNode.selectionSet.selections[0] as FieldNode)
      .alias
      ?.value;
}
