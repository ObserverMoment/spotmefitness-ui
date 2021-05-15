// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoveType _$MoveTypeFromJson(Map<String, dynamic> json) {
  return MoveType()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..imageUri = json['imageUri'] as String?;
}

Map<String, dynamic> _$MoveTypeToJson(MoveType instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUri': instance.imageUri,
    };

MoveTypes$Query _$MoveTypes$QueryFromJson(Map<String, dynamic> json) {
  return MoveTypes$Query()
    ..moveTypes = (json['moveTypes'] as List<dynamic>)
        .map((e) => MoveType.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MoveTypes$QueryToJson(MoveTypes$Query instance) =>
    <String, dynamic>{
      'moveTypes': instance.moveTypes.map((e) => e.toJson()).toList(),
    };

BodyArea _$BodyAreaFromJson(Map<String, dynamic> json) {
  return BodyArea()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..frontBack = _$enumDecode(_$BodyAreaFrontBackEnumMap, json['frontBack'],
        unknownValue: BodyAreaFrontBack.artemisUnknown)
    ..upperLower = _$enumDecode(_$BodyAreaUpperLowerEnumMap, json['upperLower'],
        unknownValue: BodyAreaUpperLower.artemisUnknown);
}

Map<String, dynamic> _$BodyAreaToJson(BodyArea instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'frontBack': _$BodyAreaFrontBackEnumMap[instance.frontBack],
      'upperLower': _$BodyAreaUpperLowerEnumMap[instance.upperLower],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$BodyAreaFrontBackEnumMap = {
  BodyAreaFrontBack.back: 'BACK',
  BodyAreaFrontBack.front: 'FRONT',
  BodyAreaFrontBack.both: 'BOTH',
  BodyAreaFrontBack.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

const _$BodyAreaUpperLowerEnumMap = {
  BodyAreaUpperLower.core: 'CORE',
  BodyAreaUpperLower.lower: 'LOWER',
  BodyAreaUpperLower.upper: 'UPPER',
  BodyAreaUpperLower.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

BodyAreaMoveScore _$BodyAreaMoveScoreFromJson(Map<String, dynamic> json) {
  return BodyAreaMoveScore()
    ..score = json['score'] as int
    ..bodyArea = BodyArea.fromJson(json['BodyArea'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BodyAreaMoveScoreToJson(BodyAreaMoveScore instance) =>
    <String, dynamic>{
      'score': instance.score,
      'BodyArea': instance.bodyArea.toJson(),
    };

Equipment _$EquipmentFromJson(Map<String, dynamic> json) {
  return Equipment()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..loadAdjustable = json['loadAdjustable'] as bool;
}

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'loadAdjustable': instance.loadAdjustable,
    };

Move _$MoveFromJson(Map<String, dynamic> json) {
  return Move()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..searchTerms = json['searchTerms'] as String?
    ..description = json['description'] as String?
    ..demoVideoUri = json['demoVideoUri'] as String?
    ..demoVideoThumbUri = json['demoVideoThumbUri'] as String?
    ..scope = _$enumDecode(_$MoveScopeEnumMap, json['scope'],
        unknownValue: MoveScope.artemisUnknown)
    ..validRepTypes = (json['validRepTypes'] as List<dynamic>)
        .map((e) => _$enumDecode(_$WorkoutMoveRepTypeEnumMap, e,
            unknownValue: WorkoutMoveRepType.artemisUnknown))
        .toList()
    ..moveType = MoveType.fromJson(json['MoveType'] as Map<String, dynamic>)
    ..bodyAreaMoveScores = (json['BodyAreaMoveScores'] as List<dynamic>)
        .map((e) => BodyAreaMoveScore.fromJson(e as Map<String, dynamic>))
        .toList()
    ..requiredEquipments = (json['RequiredEquipments'] as List<dynamic>)
        .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
        .toList()
    ..selectableEquipments = (json['SelectableEquipments'] as List<dynamic>)
        .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MoveToJson(Move instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'searchTerms': instance.searchTerms,
      'description': instance.description,
      'demoVideoUri': instance.demoVideoUri,
      'demoVideoThumbUri': instance.demoVideoThumbUri,
      'scope': _$MoveScopeEnumMap[instance.scope],
      'validRepTypes': instance.validRepTypes
          .map((e) => _$WorkoutMoveRepTypeEnumMap[e])
          .toList(),
      'MoveType': instance.moveType.toJson(),
      'BodyAreaMoveScores':
          instance.bodyAreaMoveScores.map((e) => e.toJson()).toList(),
      'RequiredEquipments':
          instance.requiredEquipments.map((e) => e.toJson()).toList(),
      'SelectableEquipments':
          instance.selectableEquipments.map((e) => e.toJson()).toList(),
    };

const _$MoveScopeEnumMap = {
  MoveScope.standard: 'STANDARD',
  MoveScope.custom: 'CUSTOM',
  MoveScope.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

const _$WorkoutMoveRepTypeEnumMap = {
  WorkoutMoveRepType.reps: 'REPS',
  WorkoutMoveRepType.calories: 'CALORIES',
  WorkoutMoveRepType.distance: 'DISTANCE',
  WorkoutMoveRepType.time: 'TIME',
  WorkoutMoveRepType.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

StandardMoves$Query _$StandardMoves$QueryFromJson(Map<String, dynamic> json) {
  return StandardMoves$Query()
    ..standardMoves = (json['standardMoves'] as List<dynamic>)
        .map((e) => Move.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$StandardMoves$QueryToJson(
        StandardMoves$Query instance) =>
    <String, dynamic>{
      'standardMoves': instance.standardMoves.map((e) => e.toJson()).toList(),
    };

WorkoutGoal _$WorkoutGoalFromJson(Map<String, dynamic> json) {
  return WorkoutGoal()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$WorkoutGoalToJson(WorkoutGoal instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

WorkoutGoals$Query _$WorkoutGoals$QueryFromJson(Map<String, dynamic> json) {
  return WorkoutGoals$Query()
    ..workoutGoals = (json['workoutGoals'] as List<dynamic>)
        .map((e) => WorkoutGoal.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkoutGoals$QueryToJson(WorkoutGoals$Query instance) =>
    <String, dynamic>{
      'workoutGoals': instance.workoutGoals.map((e) => e.toJson()).toList(),
    };

CheckUniqueDisplayName$Query _$CheckUniqueDisplayName$QueryFromJson(
    Map<String, dynamic> json) {
  return CheckUniqueDisplayName$Query()
    ..checkUniqueDisplayName = json['checkUniqueDisplayName'] as bool;
}

Map<String, dynamic> _$CheckUniqueDisplayName$QueryToJson(
        CheckUniqueDisplayName$Query instance) =>
    <String, dynamic>{
      'checkUniqueDisplayName': instance.checkUniqueDisplayName,
    };

WorkoutSectionType _$WorkoutSectionTypeFromJson(Map<String, dynamic> json) {
  return WorkoutSectionType()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$WorkoutSectionTypeToJson(WorkoutSectionType instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

WorkoutSectionTypes$Query _$WorkoutSectionTypes$QueryFromJson(
    Map<String, dynamic> json) {
  return WorkoutSectionTypes$Query()
    ..workoutSectionTypes = (json['workoutSectionTypes'] as List<dynamic>)
        .map((e) => WorkoutSectionType.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkoutSectionTypes$QueryToJson(
        WorkoutSectionTypes$Query instance) =>
    <String, dynamic>{
      'workoutSectionTypes':
          instance.workoutSectionTypes.map((e) => e.toJson()).toList(),
    };

BodyAreas$Query _$BodyAreas$QueryFromJson(Map<String, dynamic> json) {
  return BodyAreas$Query()
    ..bodyAreas = (json['bodyAreas'] as List<dynamic>)
        .map((e) => BodyArea.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$BodyAreas$QueryToJson(BodyAreas$Query instance) =>
    <String, dynamic>{
      'bodyAreas': instance.bodyAreas.map((e) => e.toJson()).toList(),
    };

Equipments$Query _$Equipments$QueryFromJson(Map<String, dynamic> json) {
  return Equipments$Query()
    ..equipments = (json['equipments'] as List<dynamic>)
        .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Equipments$QueryToJson(Equipments$Query instance) =>
    <String, dynamic>{
      'equipments': instance.equipments.map((e) => e.toJson()).toList(),
    };

WorkoutMove _$WorkoutMoveFromJson(Map<String, dynamic> json) {
  return WorkoutMove()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..sortPosition = json['sortPosition'] as int
    ..reps = (json['reps'] as num).toDouble()
    ..repType = _$enumDecode(_$WorkoutMoveRepTypeEnumMap, json['repType'],
        unknownValue: WorkoutMoveRepType.artemisUnknown)
    ..distanceUnit = _$enumDecode(_$DistanceUnitEnumMap, json['distanceUnit'],
        unknownValue: DistanceUnit.artemisUnknown)
    ..loadAmount = (json['loadAmount'] as num).toDouble()
    ..loadUnit = _$enumDecode(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown)
    ..timeUnit = _$enumDecode(_$TimeUnitEnumMap, json['timeUnit'],
        unknownValue: TimeUnit.artemisUnknown)
    ..equipment = json['Equipment'] == null
        ? null
        : Equipment.fromJson(json['Equipment'] as Map<String, dynamic>)
    ..move = Move.fromJson(json['Move'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutMoveToJson(WorkoutMove instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'sortPosition': instance.sortPosition,
      'reps': instance.reps,
      'repType': _$WorkoutMoveRepTypeEnumMap[instance.repType],
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Equipment': instance.equipment?.toJson(),
      'Move': instance.move.toJson(),
    };

const _$DistanceUnitEnumMap = {
  DistanceUnit.metres: 'METRES',
  DistanceUnit.kilometres: 'KILOMETRES',
  DistanceUnit.yards: 'YARDS',
  DistanceUnit.miles: 'MILES',
  DistanceUnit.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

const _$LoadUnitEnumMap = {
  LoadUnit.kg: 'KG',
  LoadUnit.lb: 'LB',
  LoadUnit.bodyweightpercent: 'BODYWEIGHTPERCENT',
  LoadUnit.percentmax: 'PERCENTMAX',
  LoadUnit.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

const _$TimeUnitEnumMap = {
  TimeUnit.hours: 'HOURS',
  TimeUnit.minutes: 'MINUTES',
  TimeUnit.seconds: 'SECONDS',
  TimeUnit.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

CreateWorkoutMove$Mutation _$CreateWorkoutMove$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutMove$Mutation()
    ..createWorkoutMove =
        WorkoutMove.fromJson(json['createWorkoutMove'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutMove$MutationToJson(
        CreateWorkoutMove$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutMove': instance.createWorkoutMove.toJson(),
    };

ConnectRelationInput _$ConnectRelationInputFromJson(Map<String, dynamic> json) {
  return ConnectRelationInput(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$ConnectRelationInputToJson(
        ConnectRelationInput instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateWorkoutMoveInput _$CreateWorkoutMoveInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutMoveInput(
    sortPosition: json['sortPosition'] as int,
    reps: (json['reps'] as num).toDouble(),
    repType: _$enumDecode(_$WorkoutMoveRepTypeEnumMap, json['repType'],
        unknownValue: WorkoutMoveRepType.artemisUnknown),
    distanceUnit: _$enumDecodeNullable(
        _$DistanceUnitEnumMap, json['distanceUnit'],
        unknownValue: DistanceUnit.artemisUnknown),
    loadAmount: (json['loadAmount'] as num).toDouble(),
    loadUnit: _$enumDecodeNullable(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown),
    timeUnit: _$enumDecodeNullable(_$TimeUnitEnumMap, json['timeUnit'],
        unknownValue: TimeUnit.artemisUnknown),
    move: ConnectRelationInput.fromJson(json['Move'] as Map<String, dynamic>),
    equipment: json['Equipment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Equipment'] as Map<String, dynamic>),
    workoutSet: ConnectRelationInput.fromJson(
        json['WorkoutSet'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutMoveInputToJson(
        CreateWorkoutMoveInput instance) =>
    <String, dynamic>{
      'sortPosition': instance.sortPosition,
      'reps': instance.reps,
      'repType': _$WorkoutMoveRepTypeEnumMap[instance.repType],
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Move': instance.move.toJson(),
      'Equipment': instance.equipment?.toJson(),
      'WorkoutSet': instance.workoutSet.toJson(),
    };

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

DuplicateWorkoutMoveById$Mutation _$DuplicateWorkoutMoveById$MutationFromJson(
    Map<String, dynamic> json) {
  return DuplicateWorkoutMoveById$Mutation()
    ..duplicateWorkoutMoveById = WorkoutMove.fromJson(
        json['duplicateWorkoutMoveById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DuplicateWorkoutMoveById$MutationToJson(
        DuplicateWorkoutMoveById$Mutation instance) =>
    <String, dynamic>{
      'duplicateWorkoutMoveById': instance.duplicateWorkoutMoveById.toJson(),
    };

DeleteWorkoutMoveById$Mutation _$DeleteWorkoutMoveById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutMoveById$Mutation()
    ..deleteWorkoutMoveById = json['deleteWorkoutMoveById'] as String;
}

Map<String, dynamic> _$DeleteWorkoutMoveById$MutationToJson(
        DeleteWorkoutMoveById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutMoveById': instance.deleteWorkoutMoveById,
    };

SortPositionUpdated _$SortPositionUpdatedFromJson(Map<String, dynamic> json) {
  return SortPositionUpdated()
    ..id = json['id'] as String
    ..sortPosition = json['sortPosition'] as int;
}

Map<String, dynamic> _$SortPositionUpdatedToJson(
        SortPositionUpdated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortPosition': instance.sortPosition,
    };

ReorderWorkoutMoves$Mutation _$ReorderWorkoutMoves$MutationFromJson(
    Map<String, dynamic> json) {
  return ReorderWorkoutMoves$Mutation()
    ..reorderWorkoutMoves = (json['reorderWorkoutMoves'] as List<dynamic>)
        .map((e) => SortPositionUpdated.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ReorderWorkoutMoves$MutationToJson(
        ReorderWorkoutMoves$Mutation instance) =>
    <String, dynamic>{
      'reorderWorkoutMoves':
          instance.reorderWorkoutMoves.map((e) => e.toJson()).toList(),
    };

UpdateSortPositionInput _$UpdateSortPositionInputFromJson(
    Map<String, dynamic> json) {
  return UpdateSortPositionInput(
    id: json['id'] as String,
    sortPosition: json['sortPosition'] as int,
  );
}

Map<String, dynamic> _$UpdateSortPositionInputToJson(
        UpdateSortPositionInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortPosition': instance.sortPosition,
    };

UpdateWorkoutMove$Mutation _$UpdateWorkoutMove$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutMove$Mutation()
    ..updateWorkoutMove =
        WorkoutMove.fromJson(json['updateWorkoutMove'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutMove$MutationToJson(
        UpdateWorkoutMove$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutMove': instance.updateWorkoutMove.toJson(),
    };

UpdateWorkoutMoveInput _$UpdateWorkoutMoveInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutMoveInput(
    id: json['id'] as String,
    reps: (json['reps'] as num?)?.toDouble(),
    repType: _$enumDecodeNullable(_$WorkoutMoveRepTypeEnumMap, json['repType'],
        unknownValue: WorkoutMoveRepType.artemisUnknown),
    distanceUnit: _$enumDecodeNullable(
        _$DistanceUnitEnumMap, json['distanceUnit'],
        unknownValue: DistanceUnit.artemisUnknown),
    loadAmount: (json['loadAmount'] as num?)?.toDouble(),
    loadUnit: _$enumDecodeNullable(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown),
    timeUnit: _$enumDecodeNullable(_$TimeUnitEnumMap, json['timeUnit'],
        unknownValue: TimeUnit.artemisUnknown),
    move: json['Move'] == null
        ? null
        : ConnectRelationInput.fromJson(json['Move'] as Map<String, dynamic>),
    equipment: json['Equipment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Equipment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutMoveInputToJson(
        UpdateWorkoutMoveInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reps': instance.reps,
      'repType': _$WorkoutMoveRepTypeEnumMap[instance.repType],
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Move': instance.move?.toJson(),
      'Equipment': instance.equipment?.toJson(),
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..bio = json['bio'] as String?
    ..birthdate =
        fromGraphQLDateTimeToDartDateTimeNullable(json['birthdate'] as int?)
    ..countryCode = json['countryCode'] as String?
    ..displayName = json['displayName'] as String?
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..gender = _$enumDecodeNullable(_$GenderEnumMap, json['gender'],
        unknownValue: Gender.artemisUnknown);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'bio': instance.bio,
      'birthdate':
          fromDartDateTimeToGraphQLDateTimeNullable(instance.birthdate),
      'countryCode': instance.countryCode,
      'displayName': instance.displayName,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'gender': _$GenderEnumMap[instance.gender],
    };

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.nonbinary: 'NONBINARY',
  Gender.none: 'NONE',
  Gender.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

AuthedUser$Query _$AuthedUser$QueryFromJson(Map<String, dynamic> json) {
  return AuthedUser$Query()
    ..authedUser = User.fromJson(json['authedUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AuthedUser$QueryToJson(AuthedUser$Query instance) =>
    <String, dynamic>{
      'authedUser': instance.authedUser.toJson(),
    };

UpdateUser$Mutation _$UpdateUser$MutationFromJson(Map<String, dynamic> json) {
  return UpdateUser$Mutation()
    ..updateUser = User.fromJson(json['updateUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateUser$MutationToJson(
        UpdateUser$Mutation instance) =>
    <String, dynamic>{
      'updateUser': instance.updateUser.toJson(),
    };

UpdateUserInput _$UpdateUserInputFromJson(Map<String, dynamic> json) {
  return UpdateUserInput(
    userProfileScope: _$enumDecodeNullable(
        _$UserProfileScopeEnumMap, json['userProfileScope'],
        unknownValue: UserProfileScope.artemisUnknown),
    avatarUri: json['avatarUri'] as String?,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    bio: json['bio'] as String?,
    tagline: json['tagline'] as String?,
    birthdate:
        fromGraphQLDateTimeToDartDateTimeNullable(json['birthdate'] as int?),
    townCity: json['townCity'] as String?,
    countryCode: json['countryCode'] as String?,
    displayName: json['displayName'] as String?,
    instagramUrl: json['instagramUrl'] as String?,
    tiktokUrl: json['tiktokUrl'] as String?,
    youtubeUrl: json['youtubeUrl'] as String?,
    snapUrl: json['snapUrl'] as String?,
    linkedinUrl: json['linkedinUrl'] as String?,
    firstname: json['firstname'] as String?,
    gender: _$enumDecodeNullable(_$GenderEnumMap, json['gender'],
        unknownValue: Gender.artemisUnknown),
    hasOnboarded: json['hasOnboarded'] as bool?,
    lastname: json['lastname'] as String?,
  );
}

Map<String, dynamic> _$UpdateUserInputToJson(UpdateUserInput instance) =>
    <String, dynamic>{
      'userProfileScope': _$UserProfileScopeEnumMap[instance.userProfileScope],
      'avatarUri': instance.avatarUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'bio': instance.bio,
      'tagline': instance.tagline,
      'birthdate':
          fromDartDateTimeToGraphQLDateTimeNullable(instance.birthdate),
      'townCity': instance.townCity,
      'countryCode': instance.countryCode,
      'displayName': instance.displayName,
      'instagramUrl': instance.instagramUrl,
      'tiktokUrl': instance.tiktokUrl,
      'youtubeUrl': instance.youtubeUrl,
      'snapUrl': instance.snapUrl,
      'linkedinUrl': instance.linkedinUrl,
      'firstname': instance.firstname,
      'gender': _$GenderEnumMap[instance.gender],
      'hasOnboarded': instance.hasOnboarded,
      'lastname': instance.lastname,
    };

const _$UserProfileScopeEnumMap = {
  UserProfileScope.private: 'PRIVATE',
  UserProfileScope.public: 'PUBLIC',
  UserProfileScope.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

CreateMove$Mutation _$CreateMove$MutationFromJson(Map<String, dynamic> json) {
  return CreateMove$Mutation()
    ..createMove = Move.fromJson(json['createMove'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateMove$MutationToJson(
        CreateMove$Mutation instance) =>
    <String, dynamic>{
      'createMove': instance.createMove.toJson(),
    };

CreateMoveInput _$CreateMoveInputFromJson(Map<String, dynamic> json) {
  return CreateMoveInput(
    name: json['name'] as String,
    searchTerms: json['searchTerms'] as String?,
    description: json['description'] as String?,
    demoVideoUri: json['demoVideoUri'] as String?,
    demoVideoThumbUri: json['demoVideoThumbUri'] as String?,
    scope: _$enumDecodeNullable(_$MoveScopeEnumMap, json['scope'],
        unknownValue: MoveScope.artemisUnknown),
    moveType:
        ConnectRelationInput.fromJson(json['MoveType'] as Map<String, dynamic>),
    validRepTypes: (json['validRepTypes'] as List<dynamic>)
        .map((e) => _$enumDecode(_$WorkoutMoveRepTypeEnumMap, e,
            unknownValue: WorkoutMoveRepType.artemisUnknown))
        .toList(),
    requiredEquipments: (json['RequiredEquipments'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    selectableEquipments: (json['SelectableEquipments'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    bodyAreaMoveScores: (json['BodyAreaMoveScores'] as List<dynamic>?)
        ?.map((e) => BodyAreaMoveScoreInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateMoveInputToJson(CreateMoveInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'searchTerms': instance.searchTerms,
      'description': instance.description,
      'demoVideoUri': instance.demoVideoUri,
      'demoVideoThumbUri': instance.demoVideoThumbUri,
      'scope': _$MoveScopeEnumMap[instance.scope],
      'MoveType': instance.moveType.toJson(),
      'validRepTypes': instance.validRepTypes
          .map((e) => _$WorkoutMoveRepTypeEnumMap[e])
          .toList(),
      'RequiredEquipments':
          instance.requiredEquipments?.map((e) => e.toJson()).toList(),
      'SelectableEquipments':
          instance.selectableEquipments?.map((e) => e.toJson()).toList(),
      'BodyAreaMoveScores':
          instance.bodyAreaMoveScores?.map((e) => e.toJson()).toList(),
    };

BodyAreaMoveScoreInput _$BodyAreaMoveScoreInputFromJson(
    Map<String, dynamic> json) {
  return BodyAreaMoveScoreInput(
    bodyArea:
        ConnectRelationInput.fromJson(json['BodyArea'] as Map<String, dynamic>),
    score: (json['score'] as num).toDouble(),
  );
}

Map<String, dynamic> _$BodyAreaMoveScoreInputToJson(
        BodyAreaMoveScoreInput instance) =>
    <String, dynamic>{
      'BodyArea': instance.bodyArea.toJson(),
      'score': instance.score,
    };

UpdateMove$Mutation _$UpdateMove$MutationFromJson(Map<String, dynamic> json) {
  return UpdateMove$Mutation()
    ..updateMove = Move.fromJson(json['updateMove'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateMove$MutationToJson(
        UpdateMove$Mutation instance) =>
    <String, dynamic>{
      'updateMove': instance.updateMove.toJson(),
    };

UpdateMoveInput _$UpdateMoveInputFromJson(Map<String, dynamic> json) {
  return UpdateMoveInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    searchTerms: json['searchTerms'] as String?,
    description: json['description'] as String?,
    demoVideoUri: json['demoVideoUri'] as String?,
    demoVideoThumbUri: json['demoVideoThumbUri'] as String?,
    scope: _$enumDecodeNullable(_$MoveScopeEnumMap, json['scope'],
        unknownValue: MoveScope.artemisUnknown),
    moveType: json['MoveType'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['MoveType'] as Map<String, dynamic>),
    validRepTypes: (json['validRepTypes'] as List<dynamic>?)
        ?.map((e) => _$enumDecode(_$WorkoutMoveRepTypeEnumMap, e,
            unknownValue: WorkoutMoveRepType.artemisUnknown))
        .toList(),
    requiredEquipments: (json['RequiredEquipments'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    selectableEquipments: (json['SelectableEquipments'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    bodyAreaMoveScores: (json['BodyAreaMoveScores'] as List<dynamic>?)
        ?.map((e) => BodyAreaMoveScoreInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UpdateMoveInputToJson(UpdateMoveInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'searchTerms': instance.searchTerms,
      'description': instance.description,
      'demoVideoUri': instance.demoVideoUri,
      'demoVideoThumbUri': instance.demoVideoThumbUri,
      'scope': _$MoveScopeEnumMap[instance.scope],
      'MoveType': instance.moveType?.toJson(),
      'validRepTypes': instance.validRepTypes
          ?.map((e) => _$WorkoutMoveRepTypeEnumMap[e])
          .toList(),
      'RequiredEquipments':
          instance.requiredEquipments?.map((e) => e.toJson()).toList(),
      'SelectableEquipments':
          instance.selectableEquipments?.map((e) => e.toJson()).toList(),
      'BodyAreaMoveScores':
          instance.bodyAreaMoveScores?.map((e) => e.toJson()).toList(),
    };

DeleteMoveById$Mutation _$DeleteMoveById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteMoveById$Mutation()
    ..softDeleteMoveById = json['softDeleteMoveById'] as String;
}

Map<String, dynamic> _$DeleteMoveById$MutationToJson(
        DeleteMoveById$Mutation instance) =>
    <String, dynamic>{
      'softDeleteMoveById': instance.softDeleteMoveById,
    };

UserCustomMoves$Query _$UserCustomMoves$QueryFromJson(
    Map<String, dynamic> json) {
  return UserCustomMoves$Query()
    ..userCustomMoves = (json['userCustomMoves'] as List<dynamic>)
        .map((e) => Move.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserCustomMoves$QueryToJson(
        UserCustomMoves$Query instance) =>
    <String, dynamic>{
      'userCustomMoves':
          instance.userCustomMoves.map((e) => e.toJson()).toList(),
    };

DeleteGymProfileById$Mutation _$DeleteGymProfileById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteGymProfileById$Mutation()
    ..deleteGymProfileById = json['deleteGymProfileById'] as String?;
}

Map<String, dynamic> _$DeleteGymProfileById$MutationToJson(
        DeleteGymProfileById$Mutation instance) =>
    <String, dynamic>{
      'deleteGymProfileById': instance.deleteGymProfileById,
    };

GymProfile _$GymProfileFromJson(Map<String, dynamic> json) {
  return GymProfile()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..equipments = (json['Equipments'] as List<dynamic>)
        .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$GymProfileToJson(GymProfile instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'Equipments': instance.equipments.map((e) => e.toJson()).toList(),
    };

CreateGymProfile$Mutation _$CreateGymProfile$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateGymProfile$Mutation()
    ..createGymProfile =
        GymProfile.fromJson(json['createGymProfile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateGymProfile$MutationToJson(
        CreateGymProfile$Mutation instance) =>
    <String, dynamic>{
      'createGymProfile': instance.createGymProfile.toJson(),
    };

CreateGymProfileInput _$CreateGymProfileInputFromJson(
    Map<String, dynamic> json) {
  return CreateGymProfileInput(
    name: json['name'] as String,
    description: json['description'] as String?,
    equipments: (json['Equipments'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateGymProfileInputToJson(
        CreateGymProfileInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'Equipments': instance.equipments?.map((e) => e.toJson()).toList(),
    };

GymProfiles$Query _$GymProfiles$QueryFromJson(Map<String, dynamic> json) {
  return GymProfiles$Query()
    ..gymProfiles = (json['gymProfiles'] as List<dynamic>)
        .map((e) => GymProfile.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$GymProfiles$QueryToJson(GymProfiles$Query instance) =>
    <String, dynamic>{
      'gymProfiles': instance.gymProfiles.map((e) => e.toJson()).toList(),
    };

UpdateGymProfile$Mutation _$UpdateGymProfile$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateGymProfile$Mutation()
    ..updateGymProfile =
        GymProfile.fromJson(json['updateGymProfile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateGymProfile$MutationToJson(
        UpdateGymProfile$Mutation instance) =>
    <String, dynamic>{
      'updateGymProfile': instance.updateGymProfile.toJson(),
    };

UpdateGymProfileInput _$UpdateGymProfileInputFromJson(
    Map<String, dynamic> json) {
  return UpdateGymProfileInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
    equipments: (json['Equipments'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UpdateGymProfileInputToJson(
        UpdateGymProfileInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'Equipments': instance.equipments?.map((e) => e.toJson()).toList(),
    };

WorkoutTag _$WorkoutTagFromJson(Map<String, dynamic> json) {
  return WorkoutTag()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..tag = json['tag'] as String;
}

Map<String, dynamic> _$WorkoutTagToJson(WorkoutTag instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'tag': instance.tag,
    };

UserWorkoutTags$Query _$UserWorkoutTags$QueryFromJson(
    Map<String, dynamic> json) {
  return UserWorkoutTags$Query()
    ..userWorkoutTags = (json['userWorkoutTags'] as List<dynamic>)
        .map((e) => WorkoutTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkoutTags$QueryToJson(
        UserWorkoutTags$Query instance) =>
    <String, dynamic>{
      'userWorkoutTags':
          instance.userWorkoutTags.map((e) => e.toJson()).toList(),
    };

CreateWorkoutTag$Mutation _$CreateWorkoutTag$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutTag$Mutation()
    ..createWorkoutTag =
        WorkoutTag.fromJson(json['createWorkoutTag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutTag$MutationToJson(
        CreateWorkoutTag$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutTag': instance.createWorkoutTag.toJson(),
    };

CreateWorkoutTagInput _$CreateWorkoutTagInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutTagInput(
    tag: json['tag'] as String,
  );
}

Map<String, dynamic> _$CreateWorkoutTagInputToJson(
        CreateWorkoutTagInput instance) =>
    <String, dynamic>{
      'tag': instance.tag,
    };

UpdateWorkoutSet _$UpdateWorkoutSetFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutSet()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..sortPosition = json['sortPosition'] as int
    ..rounds = json['rounds'] as int
    ..duration = json['duration'] as int?;
}

Map<String, dynamic> _$UpdateWorkoutSetToJson(UpdateWorkoutSet instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'sortPosition': instance.sortPosition,
      'rounds': instance.rounds,
      'duration': instance.duration,
    };

UpdateWorkoutSet$Mutation _$UpdateWorkoutSet$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutSet$Mutation()
    ..updateWorkoutSet = UpdateWorkoutSet.fromJson(
        json['updateWorkoutSet'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutSet$MutationToJson(
        UpdateWorkoutSet$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutSet': instance.updateWorkoutSet.toJson(),
    };

UpdateWorkoutSetInput _$UpdateWorkoutSetInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutSetInput(
    id: json['id'] as String,
    rounds: json['rounds'] as int?,
    duration: json['duration'] as int?,
  );
}

Map<String, dynamic> _$UpdateWorkoutSetInputToJson(
        UpdateWorkoutSetInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rounds': instance.rounds,
      'duration': instance.duration,
    };

WorkoutSet _$WorkoutSetFromJson(Map<String, dynamic> json) {
  return WorkoutSet()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..sortPosition = json['sortPosition'] as int
    ..rounds = json['rounds'] as int
    ..duration = json['duration'] as int?
    ..workoutMoves = (json['WorkoutMoves'] as List<dynamic>)
        .map((e) => WorkoutMove.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkoutSetToJson(WorkoutSet instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'sortPosition': instance.sortPosition,
      'rounds': instance.rounds,
      'duration': instance.duration,
      'WorkoutMoves': instance.workoutMoves.map((e) => e.toJson()).toList(),
    };

DuplicateWorkoutSetById$Mutation _$DuplicateWorkoutSetById$MutationFromJson(
    Map<String, dynamic> json) {
  return DuplicateWorkoutSetById$Mutation()
    ..duplicateWorkoutSetById = WorkoutSet.fromJson(
        json['duplicateWorkoutSetById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DuplicateWorkoutSetById$MutationToJson(
        DuplicateWorkoutSetById$Mutation instance) =>
    <String, dynamic>{
      'duplicateWorkoutSetById': instance.duplicateWorkoutSetById.toJson(),
    };

ReorderWorkoutSets$Mutation _$ReorderWorkoutSets$MutationFromJson(
    Map<String, dynamic> json) {
  return ReorderWorkoutSets$Mutation()
    ..reorderWorkoutSets = (json['reorderWorkoutSets'] as List<dynamic>)
        .map((e) => SortPositionUpdated.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ReorderWorkoutSets$MutationToJson(
        ReorderWorkoutSets$Mutation instance) =>
    <String, dynamic>{
      'reorderWorkoutSets':
          instance.reorderWorkoutSets.map((e) => e.toJson()).toList(),
    };

CreateWorkoutSet _$CreateWorkoutSetFromJson(Map<String, dynamic> json) {
  return CreateWorkoutSet()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..sortPosition = json['sortPosition'] as int
    ..rounds = json['rounds'] as int
    ..duration = json['duration'] as int?;
}

Map<String, dynamic> _$CreateWorkoutSetToJson(CreateWorkoutSet instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'sortPosition': instance.sortPosition,
      'rounds': instance.rounds,
      'duration': instance.duration,
    };

CreateWorkoutSet$Mutation _$CreateWorkoutSet$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutSet$Mutation()
    ..createWorkoutSet = CreateWorkoutSet.fromJson(
        json['createWorkoutSet'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutSet$MutationToJson(
        CreateWorkoutSet$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutSet': instance.createWorkoutSet.toJson(),
    };

CreateWorkoutSetInput _$CreateWorkoutSetInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutSetInput(
    sortPosition: json['sortPosition'] as int,
    rounds: json['rounds'] as int?,
    duration: json['duration'] as int?,
    workoutSection: ConnectRelationInput.fromJson(
        json['WorkoutSection'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutSetInputToJson(
        CreateWorkoutSetInput instance) =>
    <String, dynamic>{
      'sortPosition': instance.sortPosition,
      'rounds': instance.rounds,
      'duration': instance.duration,
      'WorkoutSection': instance.workoutSection.toJson(),
    };

DeleteWorkoutSetById$Mutation _$DeleteWorkoutSetById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutSetById$Mutation()
    ..deleteWorkoutSetById = json['deleteWorkoutSetById'] as String;
}

Map<String, dynamic> _$DeleteWorkoutSetById$MutationToJson(
        DeleteWorkoutSetById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutSetById': instance.deleteWorkoutSetById,
    };

UpdateWorkoutSection _$UpdateWorkoutSectionFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutSection()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String?
    ..note = json['note'] as String?
    ..rounds = json['rounds'] as int
    ..timecap = json['timecap'] as int?
    ..sortPosition = json['sortPosition'] as int
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..classVideoUri = json['classVideoUri'] as String?
    ..classVideoThumbUri = json['classVideoThumbUri'] as String?
    ..classAudioUri = json['classAudioUri'] as String?
    ..outroVideoUri = json['outroVideoUri'] as String?
    ..outroVideoThumbUri = json['outroVideoThumbUri'] as String?
    ..outroAudioUri = json['outroAudioUri'] as String?
    ..workoutSectionType = WorkoutSectionType.fromJson(
        json['WorkoutSectionType'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutSectionToJson(
        UpdateWorkoutSection instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'rounds': instance.rounds,
      'timecap': instance.timecap,
      'sortPosition': instance.sortPosition,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'classVideoUri': instance.classVideoUri,
      'classVideoThumbUri': instance.classVideoThumbUri,
      'classAudioUri': instance.classAudioUri,
      'outroVideoUri': instance.outroVideoUri,
      'outroVideoThumbUri': instance.outroVideoThumbUri,
      'outroAudioUri': instance.outroAudioUri,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
    };

UpdateWorkoutSection$Mutation _$UpdateWorkoutSection$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutSection$Mutation()
    ..updateWorkoutSection = UpdateWorkoutSection.fromJson(
        json['updateWorkoutSection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutSection$MutationToJson(
        UpdateWorkoutSection$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutSection': instance.updateWorkoutSection.toJson(),
    };

UpdateWorkoutSectionInput _$UpdateWorkoutSectionInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutSectionInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    note: json['note'] as String?,
    rounds: json['rounds'] as int?,
    timecap: json['timecap'] as int?,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    introAudioUri: json['introAudioUri'] as String?,
    classVideoUri: json['classVideoUri'] as String?,
    classVideoThumbUri: json['classVideoThumbUri'] as String?,
    classAudioUri: json['classAudioUri'] as String?,
    outroVideoUri: json['outroVideoUri'] as String?,
    outroVideoThumbUri: json['outroVideoThumbUri'] as String?,
    outroAudioUri: json['outroAudioUri'] as String?,
    workoutSectionType: json['WorkoutSectionType'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['WorkoutSectionType'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutSectionInputToJson(
        UpdateWorkoutSectionInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'rounds': instance.rounds,
      'timecap': instance.timecap,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'classVideoUri': instance.classVideoUri,
      'classVideoThumbUri': instance.classVideoThumbUri,
      'classAudioUri': instance.classAudioUri,
      'outroVideoUri': instance.outroVideoUri,
      'outroVideoThumbUri': instance.outroVideoThumbUri,
      'outroAudioUri': instance.outroAudioUri,
      'WorkoutSectionType': instance.workoutSectionType?.toJson(),
    };

WorkoutSection _$WorkoutSectionFromJson(Map<String, dynamic> json) {
  return WorkoutSection()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String?
    ..note = json['note'] as String?
    ..rounds = json['rounds'] as int
    ..timecap = json['timecap'] as int?
    ..sortPosition = json['sortPosition'] as int
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..classVideoUri = json['classVideoUri'] as String?
    ..classVideoThumbUri = json['classVideoThumbUri'] as String?
    ..classAudioUri = json['classAudioUri'] as String?
    ..outroVideoUri = json['outroVideoUri'] as String?
    ..outroVideoThumbUri = json['outroVideoThumbUri'] as String?
    ..outroAudioUri = json['outroAudioUri'] as String?
    ..workoutSectionType = WorkoutSectionType.fromJson(
        json['WorkoutSectionType'] as Map<String, dynamic>)
    ..workoutSets = (json['WorkoutSets'] as List<dynamic>)
        .map((e) => WorkoutSet.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkoutSectionToJson(WorkoutSection instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'rounds': instance.rounds,
      'timecap': instance.timecap,
      'sortPosition': instance.sortPosition,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'classVideoUri': instance.classVideoUri,
      'classVideoThumbUri': instance.classVideoThumbUri,
      'classAudioUri': instance.classAudioUri,
      'outroVideoUri': instance.outroVideoUri,
      'outroVideoThumbUri': instance.outroVideoThumbUri,
      'outroAudioUri': instance.outroAudioUri,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
      'WorkoutSets': instance.workoutSets.map((e) => e.toJson()).toList(),
    };

CreateWorkoutSection$Mutation _$CreateWorkoutSection$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutSection$Mutation()
    ..createWorkoutSection = WorkoutSection.fromJson(
        json['createWorkoutSection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutSection$MutationToJson(
        CreateWorkoutSection$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutSection': instance.createWorkoutSection.toJson(),
    };

CreateWorkoutSectionInput _$CreateWorkoutSectionInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutSectionInput(
    name: json['name'] as String?,
    note: json['note'] as String?,
    rounds: json['rounds'] as int?,
    timecap: json['timecap'] as int?,
    sortPosition: json['sortPosition'] as int,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    introAudioUri: json['introAudioUri'] as String?,
    classVideoUri: json['classVideoUri'] as String?,
    classVideoThumbUri: json['classVideoThumbUri'] as String?,
    classAudioUri: json['classAudioUri'] as String?,
    outroVideoUri: json['outroVideoUri'] as String?,
    outroVideoThumbUri: json['outroVideoThumbUri'] as String?,
    outroAudioUri: json['outroAudioUri'] as String?,
    workoutSectionType: ConnectRelationInput.fromJson(
        json['WorkoutSectionType'] as Map<String, dynamic>),
    workout:
        ConnectRelationInput.fromJson(json['Workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutSectionInputToJson(
        CreateWorkoutSectionInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'note': instance.note,
      'rounds': instance.rounds,
      'timecap': instance.timecap,
      'sortPosition': instance.sortPosition,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'classVideoUri': instance.classVideoUri,
      'classVideoThumbUri': instance.classVideoThumbUri,
      'classAudioUri': instance.classAudioUri,
      'outroVideoUri': instance.outroVideoUri,
      'outroVideoThumbUri': instance.outroVideoThumbUri,
      'outroAudioUri': instance.outroAudioUri,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
      'Workout': instance.workout.toJson(),
    };

ReorderWorkoutSections$Mutation _$ReorderWorkoutSections$MutationFromJson(
    Map<String, dynamic> json) {
  return ReorderWorkoutSections$Mutation()
    ..reorderWorkoutSections = (json['reorderWorkoutSections'] as List<dynamic>)
        .map((e) => SortPositionUpdated.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ReorderWorkoutSections$MutationToJson(
        ReorderWorkoutSections$Mutation instance) =>
    <String, dynamic>{
      'reorderWorkoutSections':
          instance.reorderWorkoutSections.map((e) => e.toJson()).toList(),
    };

DeleteWorkoutSectionById$Mutation _$DeleteWorkoutSectionById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutSectionById$Mutation()
    ..deleteWorkoutSectionById = json['deleteWorkoutSectionById'] as String;
}

Map<String, dynamic> _$DeleteWorkoutSectionById$MutationToJson(
        DeleteWorkoutSectionById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutSectionById': instance.deleteWorkoutSectionById,
    };

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return UserSummary()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..displayName = json['displayName'] as String;
}

Map<String, dynamic> _$UserSummaryToJson(UserSummary instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'displayName': instance.displayName,
    };

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt =
        fromGraphQLDateTimeToDartDateTimeNullable(json['createdAt'] as int?)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..difficultyLevel = _$enumDecode(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown)
    ..coverImageUri = json['coverImageUri'] as String?
    ..contentAccessScope = _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown)
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>)
    ..workoutGoals = (json['WorkoutGoals'] as List<dynamic>)
        .map((e) => WorkoutGoal.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutTags = (json['WorkoutTags'] as List<dynamic>)
        .map((e) => WorkoutTag.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutSections = (json['WorkoutSections'] as List<dynamic>)
        .map((e) => WorkoutSection.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt':
          fromDartDateTimeToGraphQLDateTimeNullable(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'coverImageUri': instance.coverImageUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'User': instance.user.toJson(),
      'WorkoutGoals': instance.workoutGoals.map((e) => e.toJson()).toList(),
      'WorkoutTags': instance.workoutTags.map((e) => e.toJson()).toList(),
      'WorkoutSections':
          instance.workoutSections.map((e) => e.toJson()).toList(),
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.light: 'LIGHT',
  DifficultyLevel.challenging: 'CHALLENGING',
  DifficultyLevel.intermediate: 'INTERMEDIATE',
  DifficultyLevel.advanced: 'ADVANCED',
  DifficultyLevel.elite: 'ELITE',
  DifficultyLevel.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

const _$ContentAccessScopeEnumMap = {
  ContentAccessScope.private: 'PRIVATE',
  ContentAccessScope.public: 'PUBLIC',
  ContentAccessScope.group: 'GROUP',
  ContentAccessScope.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

LoggedWorkoutSummary _$LoggedWorkoutSummaryFromJson(Map<String, dynamic> json) {
  return LoggedWorkoutSummary()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..completedOn =
        fromGraphQLDateTimeToDartDateTime(json['completedOn'] as int)
    ..note = json['note'] as String?
    ..name = json['name'] as String;
}

Map<String, dynamic> _$LoggedWorkoutSummaryToJson(
        LoggedWorkoutSummary instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'completedOn': fromDartDateTimeToGraphQLDateTime(instance.completedOn),
      'note': instance.note,
      'name': instance.name,
    };

ScheduledWorkout _$ScheduledWorkoutFromJson(Map<String, dynamic> json) {
  return ScheduledWorkout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..scheduledAt =
        fromGraphQLDateTimeToDartDateTime(json['scheduledAt'] as int)
    ..note = json['note'] as String?
    ..workout = json['Workout'] == null
        ? null
        : Workout.fromJson(json['Workout'] as Map<String, dynamic>)
    ..loggedWorkoutSummary = json['LoggedWorkoutSummary'] == null
        ? null
        : LoggedWorkoutSummary.fromJson(
            json['LoggedWorkoutSummary'] as Map<String, dynamic>)
    ..gymProfile = json['GymProfile'] == null
        ? null
        : GymProfile.fromJson(json['GymProfile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ScheduledWorkoutToJson(ScheduledWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'scheduledAt': fromDartDateTimeToGraphQLDateTime(instance.scheduledAt),
      'note': instance.note,
      'Workout': instance.workout?.toJson(),
      'LoggedWorkoutSummary': instance.loggedWorkoutSummary?.toJson(),
      'GymProfile': instance.gymProfile?.toJson(),
    };

UpdateScheduledWorkout$Mutation _$UpdateScheduledWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateScheduledWorkout$Mutation()
    ..updateScheduledWorkout = ScheduledWorkout.fromJson(
        json['updateScheduledWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateScheduledWorkout$MutationToJson(
        UpdateScheduledWorkout$Mutation instance) =>
    <String, dynamic>{
      'updateScheduledWorkout': instance.updateScheduledWorkout.toJson(),
    };

UpdateScheduledWorkoutInput _$UpdateScheduledWorkoutInputFromJson(
    Map<String, dynamic> json) {
  return UpdateScheduledWorkoutInput(
    id: json['id'] as String,
    scheduledAt:
        fromGraphQLDateTimeToDartDateTimeNullable(json['scheduledAt'] as int?),
    note: json['note'] as String?,
    workout: json['Workout'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Workout'] as Map<String, dynamic>),
    loggedWorkout: json['LoggedWorkout'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['LoggedWorkout'] as Map<String, dynamic>),
    gymProfile: json['GymProfile'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['GymProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateScheduledWorkoutInputToJson(
        UpdateScheduledWorkoutInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduledAt':
          fromDartDateTimeToGraphQLDateTimeNullable(instance.scheduledAt),
      'note': instance.note,
      'Workout': instance.workout?.toJson(),
      'LoggedWorkout': instance.loggedWorkout?.toJson(),
      'GymProfile': instance.gymProfile?.toJson(),
    };

CreateScheduledWorkout$Mutation _$CreateScheduledWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateScheduledWorkout$Mutation()
    ..createScheduledWorkout = ScheduledWorkout.fromJson(
        json['createScheduledWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateScheduledWorkout$MutationToJson(
        CreateScheduledWorkout$Mutation instance) =>
    <String, dynamic>{
      'createScheduledWorkout': instance.createScheduledWorkout.toJson(),
    };

CreateScheduledWorkoutInput _$CreateScheduledWorkoutInputFromJson(
    Map<String, dynamic> json) {
  return CreateScheduledWorkoutInput(
    scheduledAt: fromGraphQLDateTimeToDartDateTime(json['scheduledAt'] as int),
    note: json['note'] as String?,
    workout:
        ConnectRelationInput.fromJson(json['Workout'] as Map<String, dynamic>),
    gymProfile: json['GymProfile'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['GymProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateScheduledWorkoutInputToJson(
        CreateScheduledWorkoutInput instance) =>
    <String, dynamic>{
      'scheduledAt': fromDartDateTimeToGraphQLDateTime(instance.scheduledAt),
      'note': instance.note,
      'Workout': instance.workout.toJson(),
      'GymProfile': instance.gymProfile?.toJson(),
    };

UserScheduledWorkouts$Query _$UserScheduledWorkouts$QueryFromJson(
    Map<String, dynamic> json) {
  return UserScheduledWorkouts$Query()
    ..userScheduledWorkouts = (json['userScheduledWorkouts'] as List<dynamic>)
        .map((e) => ScheduledWorkout.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserScheduledWorkouts$QueryToJson(
        UserScheduledWorkouts$Query instance) =>
    <String, dynamic>{
      'userScheduledWorkouts':
          instance.userScheduledWorkouts.map((e) => e.toJson()).toList(),
    };

DeleteScheduledWorkoutById$Mutation
    _$DeleteScheduledWorkoutById$MutationFromJson(Map<String, dynamic> json) {
  return DeleteScheduledWorkoutById$Mutation()
    ..deleteScheduledWorkoutById = json['deleteScheduledWorkoutById'] as String;
}

Map<String, dynamic> _$DeleteScheduledWorkoutById$MutationToJson(
        DeleteScheduledWorkoutById$Mutation instance) =>
    <String, dynamic>{
      'deleteScheduledWorkoutById': instance.deleteScheduledWorkoutById,
    };

UpdateWorkout _$UpdateWorkoutFromJson(Map<String, dynamic> json) {
  return UpdateWorkout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt =
        fromGraphQLDateTimeToDartDateTimeNullable(json['createdAt'] as int?)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..difficultyLevel = _$enumDecode(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown)
    ..coverImageUri = json['coverImageUri'] as String?
    ..contentAccessScope = _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown)
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..workoutGoals = (json['WorkoutGoals'] as List<dynamic>)
        .map((e) => WorkoutGoal.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutTags = (json['WorkoutTags'] as List<dynamic>)
        .map((e) => WorkoutTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UpdateWorkoutToJson(UpdateWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt':
          fromDartDateTimeToGraphQLDateTimeNullable(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'coverImageUri': instance.coverImageUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'WorkoutGoals': instance.workoutGoals.map((e) => e.toJson()).toList(),
      'WorkoutTags': instance.workoutTags.map((e) => e.toJson()).toList(),
    };

UpdateWorkout$Mutation _$UpdateWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkout$Mutation()
    ..updateWorkout =
        UpdateWorkout.fromJson(json['updateWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkout$MutationToJson(
        UpdateWorkout$Mutation instance) =>
    <String, dynamic>{
      'updateWorkout': instance.updateWorkout.toJson(),
    };

UpdateWorkoutInput _$UpdateWorkoutInputFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutInput(
    id: json['id'] as String,
    archived: json['archived'] as bool?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    introAudioUri: json['introAudioUri'] as String?,
    coverImageUri: json['coverImageUri'] as String?,
    difficultyLevel: _$enumDecodeNullable(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown),
    contentAccessScope: _$enumDecodeNullable(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown),
    workoutGoals: (json['WorkoutGoals'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    workoutTags: (json['WorkoutTags'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UpdateWorkoutInputToJson(UpdateWorkoutInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'coverImageUri': instance.coverImageUri,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'WorkoutGoals': instance.workoutGoals?.map((e) => e.toJson()).toList(),
      'WorkoutTags': instance.workoutTags?.map((e) => e.toJson()).toList(),
    };

UserWorkouts$Query _$UserWorkouts$QueryFromJson(Map<String, dynamic> json) {
  return UserWorkouts$Query()
    ..userWorkouts = (json['userWorkouts'] as List<dynamic>)
        .map((e) => Workout.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkouts$QueryToJson(UserWorkouts$Query instance) =>
    <String, dynamic>{
      'userWorkouts': instance.userWorkouts.map((e) => e.toJson()).toList(),
    };

DuplicateWorkoutById$Mutation _$DuplicateWorkoutById$MutationFromJson(
    Map<String, dynamic> json) {
  return DuplicateWorkoutById$Mutation()
    ..duplicateWorkoutById =
        Workout.fromJson(json['duplicateWorkoutById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DuplicateWorkoutById$MutationToJson(
        DuplicateWorkoutById$Mutation instance) =>
    <String, dynamic>{
      'duplicateWorkoutById': instance.duplicateWorkoutById.toJson(),
    };

SoftDeleteWorkoutById$Mutation _$SoftDeleteWorkoutById$MutationFromJson(
    Map<String, dynamic> json) {
  return SoftDeleteWorkoutById$Mutation()
    ..softDeleteWorkoutById = json['softDeleteWorkoutById'] as String?;
}

Map<String, dynamic> _$SoftDeleteWorkoutById$MutationToJson(
        SoftDeleteWorkoutById$Mutation instance) =>
    <String, dynamic>{
      'softDeleteWorkoutById': instance.softDeleteWorkoutById,
    };

CreateWorkout _$CreateWorkoutFromJson(Map<String, dynamic> json) {
  return CreateWorkout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt =
        fromGraphQLDateTimeToDartDateTimeNullable(json['createdAt'] as int?)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..difficultyLevel = _$enumDecode(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown)
    ..coverImageUri = json['coverImageUri'] as String?
    ..contentAccessScope = _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown)
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>)
    ..workoutGoals = (json['WorkoutGoals'] as List<dynamic>)
        .map((e) => WorkoutGoal.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutTags = (json['WorkoutTags'] as List<dynamic>)
        .map((e) => WorkoutTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CreateWorkoutToJson(CreateWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt':
          fromDartDateTimeToGraphQLDateTimeNullable(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'coverImageUri': instance.coverImageUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'User': instance.user.toJson(),
      'WorkoutGoals': instance.workoutGoals.map((e) => e.toJson()).toList(),
      'WorkoutTags': instance.workoutTags.map((e) => e.toJson()).toList(),
    };

CreateWorkout$Mutation _$CreateWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkout$Mutation()
    ..createWorkout =
        CreateWorkout.fromJson(json['createWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkout$MutationToJson(
        CreateWorkout$Mutation instance) =>
    <String, dynamic>{
      'createWorkout': instance.createWorkout.toJson(),
    };

CreateWorkoutInput _$CreateWorkoutInputFromJson(Map<String, dynamic> json) {
  return CreateWorkoutInput(
    name: json['name'] as String,
    difficultyLevel: _$enumDecode(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown),
    contentAccessScope: _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown),
  );
}

Map<String, dynamic> _$CreateWorkoutInputToJson(CreateWorkoutInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
    };

WorkoutById$Query _$WorkoutById$QueryFromJson(Map<String, dynamic> json) {
  return WorkoutById$Query()
    ..workoutById =
        Workout.fromJson(json['workoutById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutById$QueryToJson(WorkoutById$Query instance) =>
    <String, dynamic>{
      'workoutById': instance.workoutById.toJson(),
    };

LoggedWorkoutMove _$LoggedWorkoutMoveFromJson(Map<String, dynamic> json) {
  return LoggedWorkoutMove()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..note = json['note'] as String?
    ..sortPosition = json['sortPosition'] as int
    ..reps = (json['reps'] as num).toDouble()
    ..repType = _$enumDecode(_$WorkoutMoveRepTypeEnumMap, json['repType'],
        unknownValue: WorkoutMoveRepType.artemisUnknown)
    ..distanceUnit = _$enumDecode(_$DistanceUnitEnumMap, json['distanceUnit'],
        unknownValue: DistanceUnit.artemisUnknown)
    ..loadAmount = (json['loadAmount'] as num?)?.toDouble()
    ..loadUnit = _$enumDecode(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown)
    ..timeUnit = _$enumDecode(_$TimeUnitEnumMap, json['timeUnit'],
        unknownValue: TimeUnit.artemisUnknown)
    ..equipment = json['Equipment'] == null
        ? null
        : Equipment.fromJson(json['Equipment'] as Map<String, dynamic>)
    ..move = Move.fromJson(json['Move'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LoggedWorkoutMoveToJson(LoggedWorkoutMove instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'note': instance.note,
      'sortPosition': instance.sortPosition,
      'reps': instance.reps,
      'repType': _$WorkoutMoveRepTypeEnumMap[instance.repType],
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Equipment': instance.equipment?.toJson(),
      'Move': instance.move.toJson(),
    };

LoggedWorkoutSet _$LoggedWorkoutSetFromJson(Map<String, dynamic> json) {
  return LoggedWorkoutSet()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..note = json['note'] as String?
    ..roundsCompleted = json['roundsCompleted'] as int
    ..duration = json['duration'] as int?
    ..sortPosition = json['sortPosition'] as int
    ..loggedWorkoutMoves = (json['LoggedWorkoutMoves'] as List<dynamic>)
        .map((e) => LoggedWorkoutMove.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$LoggedWorkoutSetToJson(LoggedWorkoutSet instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'note': instance.note,
      'roundsCompleted': instance.roundsCompleted,
      'duration': instance.duration,
      'sortPosition': instance.sortPosition,
      'LoggedWorkoutMoves':
          instance.loggedWorkoutMoves.map((e) => e.toJson()).toList(),
    };

LoggedWorkoutSection _$LoggedWorkoutSectionFromJson(Map<String, dynamic> json) {
  return LoggedWorkoutSection()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String?
    ..note = json['note'] as String?
    ..timecap = json['timecap'] as int?
    ..roundsCompleted = json['roundsCompleted'] as int
    ..repScore = json['repScore'] as int?
    ..timeTakenMs = json['timeTakenMs'] as int?
    ..roundTimesMs = fromGraphQLJsonToDartMap(json['roundTimesMs'])
    ..sortPosition = json['sortPosition'] as int
    ..workoutSectionType = WorkoutSectionType.fromJson(
        json['WorkoutSectionType'] as Map<String, dynamic>)
    ..loggedWorkoutSets = (json['LoggedWorkoutSets'] as List<dynamic>)
        .map((e) => LoggedWorkoutSet.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$LoggedWorkoutSectionToJson(
        LoggedWorkoutSection instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'timecap': instance.timecap,
      'roundsCompleted': instance.roundsCompleted,
      'repScore': instance.repScore,
      'timeTakenMs': instance.timeTakenMs,
      'roundTimesMs': fromDartMapToGraphQLJson(instance.roundTimesMs),
      'sortPosition': instance.sortPosition,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
      'LoggedWorkoutSets':
          instance.loggedWorkoutSets.map((e) => e.toJson()).toList(),
    };

LoggedWorkout _$LoggedWorkoutFromJson(Map<String, dynamic> json) {
  return LoggedWorkout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..completedOn =
        fromGraphQLDateTimeToDartDateTime(json['completedOn'] as int)
    ..note = json['note'] as String?
    ..name = json['name'] as String
    ..gymProfile = json['GymProfile'] == null
        ? null
        : GymProfile.fromJson(json['GymProfile'] as Map<String, dynamic>)
    ..loggedWorkoutSections = (json['LoggedWorkoutSections'] as List<dynamic>)
        .map((e) => LoggedWorkoutSection.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$LoggedWorkoutToJson(LoggedWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'completedOn': fromDartDateTimeToGraphQLDateTime(instance.completedOn),
      'note': instance.note,
      'name': instance.name,
      'GymProfile': instance.gymProfile?.toJson(),
      'LoggedWorkoutSections':
          instance.loggedWorkoutSections.map((e) => e.toJson()).toList(),
    };

LoggedWorkoutById$Query _$LoggedWorkoutById$QueryFromJson(
    Map<String, dynamic> json) {
  return LoggedWorkoutById$Query()
    ..loggedWorkoutById = LoggedWorkout.fromJson(
        json['loggedWorkoutById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LoggedWorkoutById$QueryToJson(
        LoggedWorkoutById$Query instance) =>
    <String, dynamic>{
      'loggedWorkoutById': instance.loggedWorkoutById.toJson(),
    };

DeleteLoggedWorkoutById$Mutation _$DeleteLoggedWorkoutById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteLoggedWorkoutById$Mutation()
    ..deleteLoggedWorkoutById = json['deleteLoggedWorkoutById'] as String;
}

Map<String, dynamic> _$DeleteLoggedWorkoutById$MutationToJson(
        DeleteLoggedWorkoutById$Mutation instance) =>
    <String, dynamic>{
      'deleteLoggedWorkoutById': instance.deleteLoggedWorkoutById,
    };

UserLoggedWorkouts$Query _$UserLoggedWorkouts$QueryFromJson(
    Map<String, dynamic> json) {
  return UserLoggedWorkouts$Query()
    ..userLoggedWorkouts = (json['userLoggedWorkouts'] as List<dynamic>)
        .map((e) => LoggedWorkout.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserLoggedWorkouts$QueryToJson(
        UserLoggedWorkouts$Query instance) =>
    <String, dynamic>{
      'userLoggedWorkouts':
          instance.userLoggedWorkouts.map((e) => e.toJson()).toList(),
    };

UpdateLoggedWorkout _$UpdateLoggedWorkoutFromJson(Map<String, dynamic> json) {
  return UpdateLoggedWorkout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..completedOn =
        fromGraphQLDateTimeToDartDateTime(json['completedOn'] as int)
    ..note = json['note'] as String?
    ..name = json['name'] as String;
}

Map<String, dynamic> _$UpdateLoggedWorkoutToJson(
        UpdateLoggedWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'completedOn': fromDartDateTimeToGraphQLDateTime(instance.completedOn),
      'note': instance.note,
      'name': instance.name,
    };

UpdateLoggedWorkout$Mutation _$UpdateLoggedWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkout$Mutation()
    ..updateLoggedWorkout = UpdateLoggedWorkout.fromJson(
        json['updateLoggedWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateLoggedWorkout$MutationToJson(
        UpdateLoggedWorkout$Mutation instance) =>
    <String, dynamic>{
      'updateLoggedWorkout': instance.updateLoggedWorkout.toJson(),
    };

UpdateLoggedWorkoutInput _$UpdateLoggedWorkoutInputFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutInput(
    id: json['id'] as String,
    completedOn:
        fromGraphQLDateTimeToDartDateTimeNullable(json['completedOn'] as int?),
    name: json['name'] as String?,
    note: json['note'] as String?,
    gymProfile: json['GymProfile'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['GymProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutInputToJson(
        UpdateLoggedWorkoutInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'completedOn':
          fromDartDateTimeToGraphQLDateTimeNullable(instance.completedOn),
      'name': instance.name,
      'note': instance.note,
      'GymProfile': instance.gymProfile?.toJson(),
    };

CreateLoggedWorkout$Mutation _$CreateLoggedWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkout$Mutation()
    ..createLoggedWorkout = LoggedWorkout.fromJson(
        json['createLoggedWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateLoggedWorkout$MutationToJson(
        CreateLoggedWorkout$Mutation instance) =>
    <String, dynamic>{
      'createLoggedWorkout': instance.createLoggedWorkout.toJson(),
    };

CreateLoggedWorkoutInput _$CreateLoggedWorkoutInputFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutInput(
    completedOn: fromGraphQLDateTimeToDartDateTime(json['completedOn'] as int),
    name: json['name'] as String,
    note: json['note'] as String?,
    loggedWorkoutSections: (json['LoggedWorkoutSections'] as List<dynamic>)
        .map((e) => CreateLoggedWorkoutSectionInLoggedWorkoutInput.fromJson(
            e as Map<String, dynamic>))
        .toList(),
    workout: json['Workout'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Workout'] as Map<String, dynamic>),
    scheduledWorkout: json['ScheduledWorkout'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['ScheduledWorkout'] as Map<String, dynamic>),
    gymProfile: json['GymProfile'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['GymProfile'] as Map<String, dynamic>),
    workoutProgramWorkout: json['WorkoutProgramWorkout'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['WorkoutProgramWorkout'] as Map<String, dynamic>),
    workoutProgramEnrolment: json['WorkoutProgramEnrolment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['WorkoutProgramEnrolment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutInputToJson(
        CreateLoggedWorkoutInput instance) =>
    <String, dynamic>{
      'completedOn': fromDartDateTimeToGraphQLDateTime(instance.completedOn),
      'name': instance.name,
      'note': instance.note,
      'LoggedWorkoutSections':
          instance.loggedWorkoutSections.map((e) => e.toJson()).toList(),
      'Workout': instance.workout?.toJson(),
      'ScheduledWorkout': instance.scheduledWorkout?.toJson(),
      'GymProfile': instance.gymProfile?.toJson(),
      'WorkoutProgramWorkout': instance.workoutProgramWorkout?.toJson(),
      'WorkoutProgramEnrolment': instance.workoutProgramEnrolment?.toJson(),
    };

CreateLoggedWorkoutSectionInLoggedWorkoutInput
    _$CreateLoggedWorkoutSectionInLoggedWorkoutInputFromJson(
        Map<String, dynamic> json) {
  return CreateLoggedWorkoutSectionInLoggedWorkoutInput(
    name: json['name'] as String?,
    note: json['note'] as String?,
    sortPosition: json['sortPosition'] as int,
    roundsCompleted: json['roundsCompleted'] as int,
    timeTakenMs: json['timeTakenMs'] as int?,
    roundTimesMs: fromGraphQLJsonToDartMapNullable(json['roundTimesMs']),
    repScore: json['repScore'] as int?,
    timecap: json['timecap'] as int?,
    workoutSectionType: ConnectRelationInput.fromJson(
        json['WorkoutSectionType'] as Map<String, dynamic>),
    loggedWorkoutSets: (json['LoggedWorkoutSets'] as List<dynamic>)
        .map((e) => CreateLoggedWorkoutSetInLoggedSectionInput.fromJson(
            e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutSectionInLoggedWorkoutInputToJson(
        CreateLoggedWorkoutSectionInLoggedWorkoutInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'note': instance.note,
      'sortPosition': instance.sortPosition,
      'roundsCompleted': instance.roundsCompleted,
      'timeTakenMs': instance.timeTakenMs,
      'roundTimesMs': fromDartMapToGraphQLJsonNullable(instance.roundTimesMs),
      'repScore': instance.repScore,
      'timecap': instance.timecap,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
      'LoggedWorkoutSets':
          instance.loggedWorkoutSets.map((e) => e.toJson()).toList(),
    };

CreateLoggedWorkoutSetInLoggedSectionInput
    _$CreateLoggedWorkoutSetInLoggedSectionInputFromJson(
        Map<String, dynamic> json) {
  return CreateLoggedWorkoutSetInLoggedSectionInput(
    sortPosition: json['sortPosition'] as int,
    note: json['note'] as String?,
    roundsCompleted: json['roundsCompleted'] as int,
    duration: json['duration'] as int?,
    loggedWorkoutMoves: (json['LoggedWorkoutMoves'] as List<dynamic>)
        .map((e) => CreateLoggedWorkoutMoveInLoggedSetInput.fromJson(
            e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutSetInLoggedSectionInputToJson(
        CreateLoggedWorkoutSetInLoggedSectionInput instance) =>
    <String, dynamic>{
      'sortPosition': instance.sortPosition,
      'note': instance.note,
      'roundsCompleted': instance.roundsCompleted,
      'duration': instance.duration,
      'LoggedWorkoutMoves':
          instance.loggedWorkoutMoves.map((e) => e.toJson()).toList(),
    };

CreateLoggedWorkoutMoveInLoggedSetInput
    _$CreateLoggedWorkoutMoveInLoggedSetInputFromJson(
        Map<String, dynamic> json) {
  return CreateLoggedWorkoutMoveInLoggedSetInput(
    sortPosition: json['sortPosition'] as int,
    note: json['note'] as String?,
    repType: _$enumDecode(_$WorkoutMoveRepTypeEnumMap, json['repType'],
        unknownValue: WorkoutMoveRepType.artemisUnknown),
    reps: (json['reps'] as num).toDouble(),
    distanceUnit: _$enumDecodeNullable(
        _$DistanceUnitEnumMap, json['distanceUnit'],
        unknownValue: DistanceUnit.artemisUnknown),
    loadAmount: (json['loadAmount'] as num?)?.toDouble(),
    loadUnit: _$enumDecodeNullable(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown),
    timeUnit: _$enumDecodeNullable(_$TimeUnitEnumMap, json['timeUnit'],
        unknownValue: TimeUnit.artemisUnknown),
    move: ConnectRelationInput.fromJson(json['Move'] as Map<String, dynamic>),
    equipment: json['Equipment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Equipment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutMoveInLoggedSetInputToJson(
        CreateLoggedWorkoutMoveInLoggedSetInput instance) =>
    <String, dynamic>{
      'sortPosition': instance.sortPosition,
      'note': instance.note,
      'repType': _$WorkoutMoveRepTypeEnumMap[instance.repType],
      'reps': instance.reps,
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Move': instance.move.toJson(),
      'Equipment': instance.equipment?.toJson(),
    };

DeleteLoggedWorkoutSetById$Mutation
    _$DeleteLoggedWorkoutSetById$MutationFromJson(Map<String, dynamic> json) {
  return DeleteLoggedWorkoutSetById$Mutation()
    ..deleteLoggedWorkoutSetById = json['deleteLoggedWorkoutSetById'] as String;
}

Map<String, dynamic> _$DeleteLoggedWorkoutSetById$MutationToJson(
        DeleteLoggedWorkoutSetById$Mutation instance) =>
    <String, dynamic>{
      'deleteLoggedWorkoutSetById': instance.deleteLoggedWorkoutSetById,
    };

CreateLoggedWorkoutSet _$CreateLoggedWorkoutSetFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutSet()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..note = json['note'] as String?
    ..roundsCompleted = json['roundsCompleted'] as int
    ..duration = json['duration'] as int?
    ..sortPosition = json['sortPosition'] as int;
}

Map<String, dynamic> _$CreateLoggedWorkoutSetToJson(
        CreateLoggedWorkoutSet instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'note': instance.note,
      'roundsCompleted': instance.roundsCompleted,
      'duration': instance.duration,
      'sortPosition': instance.sortPosition,
    };

CreateLoggedWorkoutSet$Mutation _$CreateLoggedWorkoutSet$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutSet$Mutation()
    ..createLoggedWorkoutSet = CreateLoggedWorkoutSet.fromJson(
        json['createLoggedWorkoutSet'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateLoggedWorkoutSet$MutationToJson(
        CreateLoggedWorkoutSet$Mutation instance) =>
    <String, dynamic>{
      'createLoggedWorkoutSet': instance.createLoggedWorkoutSet.toJson(),
    };

CreateLoggedWorkoutSetInput _$CreateLoggedWorkoutSetInputFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutSetInput(
    sortPosition: json['sortPosition'] as int,
    note: json['note'] as String?,
    roundsCompleted: json['roundsCompleted'] as int,
    duration: json['duration'] as int?,
    loggedWorkoutSection: ConnectRelationInput.fromJson(
        json['LoggedWorkoutSection'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutSetInputToJson(
        CreateLoggedWorkoutSetInput instance) =>
    <String, dynamic>{
      'sortPosition': instance.sortPosition,
      'note': instance.note,
      'roundsCompleted': instance.roundsCompleted,
      'duration': instance.duration,
      'LoggedWorkoutSection': instance.loggedWorkoutSection.toJson(),
    };

UpdateLoggedWorkoutSet _$UpdateLoggedWorkoutSetFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSet()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..note = json['note'] as String?
    ..roundsCompleted = json['roundsCompleted'] as int
    ..duration = json['duration'] as int?
    ..sortPosition = json['sortPosition'] as int;
}

Map<String, dynamic> _$UpdateLoggedWorkoutSetToJson(
        UpdateLoggedWorkoutSet instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'note': instance.note,
      'roundsCompleted': instance.roundsCompleted,
      'duration': instance.duration,
      'sortPosition': instance.sortPosition,
    };

UpdateLoggedWorkoutSet$Mutation _$UpdateLoggedWorkoutSet$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSet$Mutation()
    ..updateLoggedWorkoutSet = UpdateLoggedWorkoutSet.fromJson(
        json['updateLoggedWorkoutSet'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateLoggedWorkoutSet$MutationToJson(
        UpdateLoggedWorkoutSet$Mutation instance) =>
    <String, dynamic>{
      'updateLoggedWorkoutSet': instance.updateLoggedWorkoutSet.toJson(),
    };

UpdateLoggedWorkoutSetInput _$UpdateLoggedWorkoutSetInputFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSetInput(
    id: json['id'] as String,
    note: json['note'] as String?,
    duration: json['duration'] as int?,
    roundsCompleted: json['roundsCompleted'] as int?,
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutSetInputToJson(
        UpdateLoggedWorkoutSetInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'duration': instance.duration,
      'roundsCompleted': instance.roundsCompleted,
    };

DeleteLoggedWorkoutSectionById$Mutation
    _$DeleteLoggedWorkoutSectionById$MutationFromJson(
        Map<String, dynamic> json) {
  return DeleteLoggedWorkoutSectionById$Mutation()
    ..deleteLoggedWorkoutSectionById =
        json['deleteLoggedWorkoutSectionById'] as String;
}

Map<String, dynamic> _$DeleteLoggedWorkoutSectionById$MutationToJson(
        DeleteLoggedWorkoutSectionById$Mutation instance) =>
    <String, dynamic>{
      'deleteLoggedWorkoutSectionById': instance.deleteLoggedWorkoutSectionById,
    };

UpdateLoggedWorkoutSection _$UpdateLoggedWorkoutSectionFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSection()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String?
    ..note = json['note'] as String?
    ..timecap = json['timecap'] as int?
    ..roundsCompleted = json['roundsCompleted'] as int
    ..repScore = json['repScore'] as int?
    ..timeTakenMs = json['timeTakenMs'] as int?
    ..roundTimesMs = fromGraphQLJsonToDartMap(json['roundTimesMs'])
    ..sortPosition = json['sortPosition'] as int
    ..workoutSectionType = WorkoutSectionType.fromJson(
        json['WorkoutSectionType'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateLoggedWorkoutSectionToJson(
        UpdateLoggedWorkoutSection instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'timecap': instance.timecap,
      'roundsCompleted': instance.roundsCompleted,
      'repScore': instance.repScore,
      'timeTakenMs': instance.timeTakenMs,
      'roundTimesMs': fromDartMapToGraphQLJson(instance.roundTimesMs),
      'sortPosition': instance.sortPosition,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
    };

UpdateLoggedWorkoutSection$Mutation
    _$UpdateLoggedWorkoutSection$MutationFromJson(Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSection$Mutation()
    ..updateLoggedWorkoutSection = UpdateLoggedWorkoutSection.fromJson(
        json['updateLoggedWorkoutSection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateLoggedWorkoutSection$MutationToJson(
        UpdateLoggedWorkoutSection$Mutation instance) =>
    <String, dynamic>{
      'updateLoggedWorkoutSection':
          instance.updateLoggedWorkoutSection.toJson(),
    };

UpdateLoggedWorkoutSectionInput _$UpdateLoggedWorkoutSectionInputFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSectionInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    roundsCompleted: json['roundsCompleted'] as int?,
    timeTakenMs: json['timeTakenMs'] as int?,
    roundTimesMs: fromGraphQLJsonToDartMapNullable(json['roundTimesMs']),
    timecap: json['timecap'] as int?,
    repScore: json['repScore'] as int?,
    note: json['note'] as String?,
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutSectionInputToJson(
        UpdateLoggedWorkoutSectionInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'roundsCompleted': instance.roundsCompleted,
      'timeTakenMs': instance.timeTakenMs,
      'roundTimesMs': fromDartMapToGraphQLJsonNullable(instance.roundTimesMs),
      'timecap': instance.timecap,
      'repScore': instance.repScore,
      'note': instance.note,
    };

DeleteLoggedWorkoutMoveById$Mutation
    _$DeleteLoggedWorkoutMoveById$MutationFromJson(Map<String, dynamic> json) {
  return DeleteLoggedWorkoutMoveById$Mutation()
    ..deleteLoggedWorkoutMoveById =
        json['deleteLoggedWorkoutMoveById'] as String;
}

Map<String, dynamic> _$DeleteLoggedWorkoutMoveById$MutationToJson(
        DeleteLoggedWorkoutMoveById$Mutation instance) =>
    <String, dynamic>{
      'deleteLoggedWorkoutMoveById': instance.deleteLoggedWorkoutMoveById,
    };

UpdateLoggedWorkoutMove$Mutation _$UpdateLoggedWorkoutMove$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutMove$Mutation()
    ..updateLoggedWorkoutMove = LoggedWorkoutMove.fromJson(
        json['updateLoggedWorkoutMove'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateLoggedWorkoutMove$MutationToJson(
        UpdateLoggedWorkoutMove$Mutation instance) =>
    <String, dynamic>{
      'updateLoggedWorkoutMove': instance.updateLoggedWorkoutMove.toJson(),
    };

UpdateLoggedWorkoutMoveInput _$UpdateLoggedWorkoutMoveInputFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutMoveInput(
    id: json['id'] as String,
    note: json['note'] as String?,
    reps: (json['reps'] as num?)?.toDouble(),
    distanceUnit: _$enumDecodeNullable(
        _$DistanceUnitEnumMap, json['distanceUnit'],
        unknownValue: DistanceUnit.artemisUnknown),
    loadAmount: (json['loadAmount'] as num?)?.toDouble(),
    loadUnit: _$enumDecodeNullable(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown),
    timeUnit: _$enumDecodeNullable(_$TimeUnitEnumMap, json['timeUnit'],
        unknownValue: TimeUnit.artemisUnknown),
    move: json['Move'] == null
        ? null
        : ConnectRelationInput.fromJson(json['Move'] as Map<String, dynamic>),
    equipment: json['Equipment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Equipment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutMoveInputToJson(
        UpdateLoggedWorkoutMoveInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'reps': instance.reps,
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Move': instance.move?.toJson(),
      'Equipment': instance.equipment?.toJson(),
    };

CreateLoggedWorkoutMove$Mutation _$CreateLoggedWorkoutMove$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutMove$Mutation()
    ..createLoggedWorkoutMove = LoggedWorkoutMove.fromJson(
        json['createLoggedWorkoutMove'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateLoggedWorkoutMove$MutationToJson(
        CreateLoggedWorkoutMove$Mutation instance) =>
    <String, dynamic>{
      'createLoggedWorkoutMove': instance.createLoggedWorkoutMove.toJson(),
    };

CreateLoggedWorkoutMoveInput _$CreateLoggedWorkoutMoveInputFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutMoveInput(
    sortPosition: json['sortPosition'] as int,
    note: json['note'] as String?,
    repType: _$enumDecode(_$WorkoutMoveRepTypeEnumMap, json['repType'],
        unknownValue: WorkoutMoveRepType.artemisUnknown),
    reps: (json['reps'] as num).toDouble(),
    distanceUnit: _$enumDecodeNullable(
        _$DistanceUnitEnumMap, json['distanceUnit'],
        unknownValue: DistanceUnit.artemisUnknown),
    loadAmount: (json['loadAmount'] as num?)?.toDouble(),
    loadUnit: _$enumDecodeNullable(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown),
    timeUnit: _$enumDecodeNullable(_$TimeUnitEnumMap, json['timeUnit'],
        unknownValue: TimeUnit.artemisUnknown),
    move: ConnectRelationInput.fromJson(json['Move'] as Map<String, dynamic>),
    equipment: json['Equipment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Equipment'] as Map<String, dynamic>),
    loggedWorkoutSet: ConnectRelationInput.fromJson(
        json['LoggedWorkoutSet'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutMoveInputToJson(
        CreateLoggedWorkoutMoveInput instance) =>
    <String, dynamic>{
      'sortPosition': instance.sortPosition,
      'note': instance.note,
      'repType': _$WorkoutMoveRepTypeEnumMap[instance.repType],
      'reps': instance.reps,
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Move': instance.move.toJson(),
      'Equipment': instance.equipment?.toJson(),
      'LoggedWorkoutSet': instance.loggedWorkoutSet.toJson(),
    };

ProgressJournalEntry _$ProgressJournalEntryFromJson(Map<String, dynamic> json) {
  return ProgressJournalEntry()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..note = json['note'] as String?
    ..voiceNoteUri = json['voiceNoteUri'] as String?
    ..bodyweight = (json['bodyweight'] as num?)?.toDouble()
    ..moodScore = (json['moodScore'] as num?)?.toDouble()
    ..energyScore = (json['energyScore'] as num?)?.toDouble()
    ..stressScore = (json['stressScore'] as num?)?.toDouble()
    ..motivationScore = (json['motivationScore'] as num?)?.toDouble()
    ..progressPhotoUris = (json['progressPhotoUris'] as List<dynamic>)
        .map((e) => e as String)
        .toList();
}

Map<String, dynamic> _$ProgressJournalEntryToJson(
        ProgressJournalEntry instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'note': instance.note,
      'voiceNoteUri': instance.voiceNoteUri,
      'bodyweight': instance.bodyweight,
      'moodScore': instance.moodScore,
      'energyScore': instance.energyScore,
      'stressScore': instance.stressScore,
      'motivationScore': instance.motivationScore,
      'progressPhotoUris': instance.progressPhotoUris,
    };

ProgressJournal _$ProgressJournalFromJson(Map<String, dynamic> json) {
  return ProgressJournal()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..progressJournalEntries = (json['ProgressJournalEntries'] as List<dynamic>)
        .map((e) => ProgressJournalEntry.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ProgressJournalToJson(ProgressJournal instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'name': instance.name,
      'description': instance.description,
      'ProgressJournalEntries':
          instance.progressJournalEntries.map((e) => e.toJson()).toList(),
    };

UserProgressJournals$Query _$UserProgressJournals$QueryFromJson(
    Map<String, dynamic> json) {
  return UserProgressJournals$Query()
    ..userProgressJournals = (json['userProgressJournals'] as List<dynamic>)
        .map((e) => ProgressJournal.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserProgressJournals$QueryToJson(
        UserProgressJournals$Query instance) =>
    <String, dynamic>{
      'userProgressJournals':
          instance.userProgressJournals.map((e) => e.toJson()).toList(),
    };

ProgressJournalById$Query _$ProgressJournalById$QueryFromJson(
    Map<String, dynamic> json) {
  return ProgressJournalById$Query()
    ..progressJournalById = ProgressJournal.fromJson(
        json['progressJournalById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProgressJournalById$QueryToJson(
        ProgressJournalById$Query instance) =>
    <String, dynamic>{
      'progressJournalById': instance.progressJournalById.toJson(),
    };

CheckUniqueDisplayNameArguments _$CheckUniqueDisplayNameArgumentsFromJson(
    Map<String, dynamic> json) {
  return CheckUniqueDisplayNameArguments(
    displayName: json['displayName'] as String,
  );
}

Map<String, dynamic> _$CheckUniqueDisplayNameArgumentsToJson(
        CheckUniqueDisplayNameArguments instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
    };

CreateWorkoutMoveArguments _$CreateWorkoutMoveArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutMoveArguments(
    data: CreateWorkoutMoveInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutMoveArgumentsToJson(
        CreateWorkoutMoveArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DuplicateWorkoutMoveByIdArguments _$DuplicateWorkoutMoveByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DuplicateWorkoutMoveByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DuplicateWorkoutMoveByIdArgumentsToJson(
        DuplicateWorkoutMoveByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

DeleteWorkoutMoveByIdArguments _$DeleteWorkoutMoveByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutMoveByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutMoveByIdArgumentsToJson(
        DeleteWorkoutMoveByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ReorderWorkoutMovesArguments _$ReorderWorkoutMovesArgumentsFromJson(
    Map<String, dynamic> json) {
  return ReorderWorkoutMovesArguments(
    data: (json['data'] as List<dynamic>)
        .map((e) => UpdateSortPositionInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReorderWorkoutMovesArgumentsToJson(
        ReorderWorkoutMovesArguments instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

UpdateWorkoutMoveArguments _$UpdateWorkoutMoveArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutMoveArguments(
    data: UpdateWorkoutMoveInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutMoveArgumentsToJson(
        UpdateWorkoutMoveArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateUserArguments _$UpdateUserArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateUserArguments(
    data: UpdateUserInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateUserArgumentsToJson(
        UpdateUserArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateMoveArguments _$CreateMoveArgumentsFromJson(Map<String, dynamic> json) {
  return CreateMoveArguments(
    data: CreateMoveInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateMoveArgumentsToJson(
        CreateMoveArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateMoveArguments _$UpdateMoveArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateMoveArguments(
    data: UpdateMoveInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateMoveArgumentsToJson(
        UpdateMoveArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteMoveByIdArguments _$DeleteMoveByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteMoveByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteMoveByIdArgumentsToJson(
        DeleteMoveByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

DeleteGymProfileByIdArguments _$DeleteGymProfileByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteGymProfileByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteGymProfileByIdArgumentsToJson(
        DeleteGymProfileByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateGymProfileArguments _$CreateGymProfileArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateGymProfileArguments(
    data: CreateGymProfileInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateGymProfileArgumentsToJson(
        CreateGymProfileArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateGymProfileArguments _$UpdateGymProfileArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateGymProfileArguments(
    data: UpdateGymProfileInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateGymProfileArgumentsToJson(
        UpdateGymProfileArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateWorkoutTagArguments _$CreateWorkoutTagArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutTagArguments(
    data: CreateWorkoutTagInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutTagArgumentsToJson(
        CreateWorkoutTagArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateWorkoutSetArguments _$UpdateWorkoutSetArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutSetArguments(
    data: UpdateWorkoutSetInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutSetArgumentsToJson(
        UpdateWorkoutSetArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DuplicateWorkoutSetByIdArguments _$DuplicateWorkoutSetByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DuplicateWorkoutSetByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DuplicateWorkoutSetByIdArgumentsToJson(
        DuplicateWorkoutSetByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ReorderWorkoutSetsArguments _$ReorderWorkoutSetsArgumentsFromJson(
    Map<String, dynamic> json) {
  return ReorderWorkoutSetsArguments(
    data: (json['data'] as List<dynamic>)
        .map((e) => UpdateSortPositionInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReorderWorkoutSetsArgumentsToJson(
        ReorderWorkoutSetsArguments instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreateWorkoutSetArguments _$CreateWorkoutSetArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutSetArguments(
    data: CreateWorkoutSetInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutSetArgumentsToJson(
        CreateWorkoutSetArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteWorkoutSetByIdArguments _$DeleteWorkoutSetByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutSetByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutSetByIdArgumentsToJson(
        DeleteWorkoutSetByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateWorkoutSectionArguments _$UpdateWorkoutSectionArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutSectionArguments(
    data: UpdateWorkoutSectionInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutSectionArgumentsToJson(
        UpdateWorkoutSectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateWorkoutSectionArguments _$CreateWorkoutSectionArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutSectionArguments(
    data: CreateWorkoutSectionInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutSectionArgumentsToJson(
        CreateWorkoutSectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

ReorderWorkoutSectionsArguments _$ReorderWorkoutSectionsArgumentsFromJson(
    Map<String, dynamic> json) {
  return ReorderWorkoutSectionsArguments(
    data: (json['data'] as List<dynamic>)
        .map((e) => UpdateSortPositionInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReorderWorkoutSectionsArgumentsToJson(
        ReorderWorkoutSectionsArguments instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

DeleteWorkoutSectionByIdArguments _$DeleteWorkoutSectionByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutSectionByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutSectionByIdArgumentsToJson(
        DeleteWorkoutSectionByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateScheduledWorkoutArguments _$UpdateScheduledWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateScheduledWorkoutArguments(
    data: UpdateScheduledWorkoutInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateScheduledWorkoutArgumentsToJson(
        UpdateScheduledWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateScheduledWorkoutArguments _$CreateScheduledWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateScheduledWorkoutArguments(
    data: CreateScheduledWorkoutInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateScheduledWorkoutArgumentsToJson(
        CreateScheduledWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteScheduledWorkoutByIdArguments
    _$DeleteScheduledWorkoutByIdArgumentsFromJson(Map<String, dynamic> json) {
  return DeleteScheduledWorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteScheduledWorkoutByIdArgumentsToJson(
        DeleteScheduledWorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateWorkoutArguments _$UpdateWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutArguments(
    data: UpdateWorkoutInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutArgumentsToJson(
        UpdateWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DuplicateWorkoutByIdArguments _$DuplicateWorkoutByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DuplicateWorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DuplicateWorkoutByIdArgumentsToJson(
        DuplicateWorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SoftDeleteWorkoutByIdArguments _$SoftDeleteWorkoutByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return SoftDeleteWorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$SoftDeleteWorkoutByIdArgumentsToJson(
        SoftDeleteWorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateWorkoutArguments _$CreateWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutArguments(
    data: CreateWorkoutInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutArgumentsToJson(
        CreateWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

WorkoutByIdArguments _$WorkoutByIdArgumentsFromJson(Map<String, dynamic> json) {
  return WorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$WorkoutByIdArgumentsToJson(
        WorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

LoggedWorkoutByIdArguments _$LoggedWorkoutByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return LoggedWorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$LoggedWorkoutByIdArgumentsToJson(
        LoggedWorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

DeleteLoggedWorkoutByIdArguments _$DeleteLoggedWorkoutByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteLoggedWorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteLoggedWorkoutByIdArgumentsToJson(
        DeleteLoggedWorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateLoggedWorkoutArguments _$UpdateLoggedWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutArguments(
    data:
        UpdateLoggedWorkoutInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutArgumentsToJson(
        UpdateLoggedWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateLoggedWorkoutArguments _$CreateLoggedWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutArguments(
    data:
        CreateLoggedWorkoutInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutArgumentsToJson(
        CreateLoggedWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteLoggedWorkoutSetByIdArguments
    _$DeleteLoggedWorkoutSetByIdArgumentsFromJson(Map<String, dynamic> json) {
  return DeleteLoggedWorkoutSetByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteLoggedWorkoutSetByIdArgumentsToJson(
        DeleteLoggedWorkoutSetByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateLoggedWorkoutSetArguments _$CreateLoggedWorkoutSetArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutSetArguments(
    data: CreateLoggedWorkoutSetInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutSetArgumentsToJson(
        CreateLoggedWorkoutSetArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateLoggedWorkoutSetArguments _$UpdateLoggedWorkoutSetArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSetArguments(
    data: UpdateLoggedWorkoutSetInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutSetArgumentsToJson(
        UpdateLoggedWorkoutSetArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteLoggedWorkoutSectionByIdArguments
    _$DeleteLoggedWorkoutSectionByIdArgumentsFromJson(
        Map<String, dynamic> json) {
  return DeleteLoggedWorkoutSectionByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteLoggedWorkoutSectionByIdArgumentsToJson(
        DeleteLoggedWorkoutSectionByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateLoggedWorkoutSectionArguments
    _$UpdateLoggedWorkoutSectionArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateLoggedWorkoutSectionArguments(
    data: UpdateLoggedWorkoutSectionInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutSectionArgumentsToJson(
        UpdateLoggedWorkoutSectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteLoggedWorkoutMoveByIdArguments
    _$DeleteLoggedWorkoutMoveByIdArgumentsFromJson(Map<String, dynamic> json) {
  return DeleteLoggedWorkoutMoveByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteLoggedWorkoutMoveByIdArgumentsToJson(
        DeleteLoggedWorkoutMoveByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateLoggedWorkoutMoveArguments _$UpdateLoggedWorkoutMoveArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateLoggedWorkoutMoveArguments(
    data: UpdateLoggedWorkoutMoveInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateLoggedWorkoutMoveArgumentsToJson(
        UpdateLoggedWorkoutMoveArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateLoggedWorkoutMoveArguments _$CreateLoggedWorkoutMoveArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateLoggedWorkoutMoveArguments(
    data: CreateLoggedWorkoutMoveInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateLoggedWorkoutMoveArgumentsToJson(
        CreateLoggedWorkoutMoveArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

ProgressJournalByIdArguments _$ProgressJournalByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return ProgressJournalByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$ProgressJournalByIdArgumentsToJson(
        ProgressJournalByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
