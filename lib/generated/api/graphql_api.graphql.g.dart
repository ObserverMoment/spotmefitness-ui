// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return UserSummary()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..displayName = json['displayName'] as String?
    ..userProfileScope = _$enumDecode(
        _$UserProfileScopeEnumMap, json['userProfileScope'],
        unknownValue: UserProfileScope.artemisUnknown)
    ..tagline = json['tagline'] as String?
    ..countryCode = json['countryCode'] as String?
    ..townCity = json['townCity'] as String?;
}

Map<String, dynamic> _$UserSummaryToJson(UserSummary instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'displayName': instance.displayName,
      'userProfileScope': _$UserProfileScopeEnumMap[instance.userProfileScope],
      'tagline': instance.tagline,
      'countryCode': instance.countryCode,
      'townCity': instance.townCity,
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

const _$UserProfileScopeEnumMap = {
  UserProfileScope.private: 'PRIVATE',
  UserProfileScope.public: 'PUBLIC',
  UserProfileScope.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

ClubInviteToken _$ClubInviteTokenFromJson(Map<String, dynamic> json) {
  return ClubInviteToken()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..name = json['name'] as String
    ..active = json['active'] as bool
    ..inviteLimit = json['inviteLimit'] as int
    ..invitesUsed = json['invitesUsed'] as int
    ..joinedUserIds = (json['joinedUserIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList();
}

Map<String, dynamic> _$ClubInviteTokenToJson(ClubInviteToken instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'name': instance.name,
      'active': instance.active,
      'inviteLimit': instance.inviteLimit,
      'invitesUsed': instance.invitesUsed,
      'joinedUserIds': instance.joinedUserIds,
    };

JoinClubInvite _$JoinClubInviteFromJson(Map<String, dynamic> json) {
  return JoinClubInvite()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..respondedAt = fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['respondedAt'] as int?)
    ..status = _$enumDecode(_$JoinClubRequestStatusEnumMap, json['status'],
        unknownValue: JoinClubRequestStatus.artemisUnknown)
    ..invited = UserSummary.fromJson(json['Invited'] as Map<String, dynamic>);
}

Map<String, dynamic> _$JoinClubInviteToJson(JoinClubInvite instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'respondedAt': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.respondedAt),
      'status': _$JoinClubRequestStatusEnumMap[instance.status],
      'Invited': instance.invited.toJson(),
    };

const _$JoinClubRequestStatusEnumMap = {
  JoinClubRequestStatus.pending: 'PENDING',
  JoinClubRequestStatus.accepted: 'ACCEPTED',
  JoinClubRequestStatus.rejected: 'REJECTED',
  JoinClubRequestStatus.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

JoinClubRequest _$JoinClubRequestFromJson(Map<String, dynamic> json) {
  return JoinClubRequest()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..respondedAt = fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['respondedAt'] as int?)
    ..status = _$enumDecode(_$JoinClubRequestStatusEnumMap, json['status'],
        unknownValue: JoinClubRequestStatus.artemisUnknown)
    ..applicant =
        UserSummary.fromJson(json['Applicant'] as Map<String, dynamic>);
}

Map<String, dynamic> _$JoinClubRequestToJson(JoinClubRequest instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'respondedAt': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.respondedAt),
      'status': _$JoinClubRequestStatusEnumMap[instance.status],
      'Applicant': instance.applicant.toJson(),
    };

Club _$ClubFromJson(Map<String, dynamic> json) {
  return Club()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..location = json['location'] as String?
    ..coverImageUri = json['coverImageUri'] as String?
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..owner = UserSummary.fromJson(json['Owner'] as Map<String, dynamic>)
    ..admins = (json['Admins'] as List<dynamic>)
        .map((e) => UserSummary.fromJson(e as Map<String, dynamic>))
        .toList()
    ..members = (json['Members'] as List<dynamic>)
        .map((e) => UserSummary.fromJson(e as Map<String, dynamic>))
        .toList()
    ..clubInviteTokens = (json['ClubInviteTokens'] as List<dynamic>)
        .map((e) => ClubInviteToken.fromJson(e as Map<String, dynamic>))
        .toList()
    ..joinClubInvites = (json['JoinClubInvites'] as List<dynamic>)
        .map((e) => JoinClubInvite.fromJson(e as Map<String, dynamic>))
        .toList()
    ..joinClubRequests = (json['JoinClubRequests'] as List<dynamic>)
        .map((e) => JoinClubRequest.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'coverImageUri': instance.coverImageUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'Owner': instance.owner.toJson(),
      'Admins': instance.admins.map((e) => e.toJson()).toList(),
      'Members': instance.members.map((e) => e.toJson()).toList(),
      'ClubInviteTokens':
          instance.clubInviteTokens.map((e) => e.toJson()).toList(),
      'JoinClubInvites':
          instance.joinClubInvites.map((e) => e.toJson()).toList(),
      'JoinClubRequests':
          instance.joinClubRequests.map((e) => e.toJson()).toList(),
    };

CreateClub$Mutation _$CreateClub$MutationFromJson(Map<String, dynamic> json) {
  return CreateClub$Mutation()
    ..createClub = Club.fromJson(json['createClub'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateClub$MutationToJson(
        CreateClub$Mutation instance) =>
    <String, dynamic>{
      'createClub': instance.createClub.toJson(),
    };

CreateClubInput _$CreateClubInputFromJson(Map<String, dynamic> json) {
  return CreateClubInput(
    name: json['name'] as String,
    description: json['description'] as String?,
    location: json['location'] as String?,
  );
}

Map<String, dynamic> _$CreateClubInputToJson(CreateClubInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
    };

DeleteClubById$Mutation _$DeleteClubById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteClubById$Mutation()
    ..deleteClubById = json['deleteClubById'] as String;
}

Map<String, dynamic> _$DeleteClubById$MutationToJson(
        DeleteClubById$Mutation instance) =>
    <String, dynamic>{
      'deleteClubById': instance.deleteClubById,
    };

UpdateClub$Mutation _$UpdateClub$MutationFromJson(Map<String, dynamic> json) {
  return UpdateClub$Mutation()
    ..updateClub = Club.fromJson(json['updateClub'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateClub$MutationToJson(
        UpdateClub$Mutation instance) =>
    <String, dynamic>{
      'updateClub': instance.updateClub.toJson(),
    };

UpdateClubInput _$UpdateClubInputFromJson(Map<String, dynamic> json) {
  return UpdateClubInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
    location: json['location'] as String?,
    coverImageUri: json['coverImageUri'] as String?,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    introAudioUri: json['introAudioUri'] as String?,
  );
}

Map<String, dynamic> _$UpdateClubInputToJson(UpdateClubInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'coverImageUri': instance.coverImageUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
    };

ClubById$Query _$ClubById$QueryFromJson(Map<String, dynamic> json) {
  return ClubById$Query()
    ..clubById = Club.fromJson(json['clubById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ClubById$QueryToJson(ClubById$Query instance) =>
    <String, dynamic>{
      'clubById': instance.clubById.toJson(),
    };

UserClubs$Query _$UserClubs$QueryFromJson(Map<String, dynamic> json) {
  return UserClubs$Query()
    ..userClubs = (json['userClubs'] as List<dynamic>)
        .map((e) => Club.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserClubs$QueryToJson(UserClubs$Query instance) =>
    <String, dynamic>{
      'userClubs': instance.userClubs.map((e) => e.toJson()).toList(),
    };

UpdateClubInviteToken$Mutation _$UpdateClubInviteToken$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateClubInviteToken$Mutation()
    ..updateClubInviteToken = ClubInviteToken.fromJson(
        json['updateClubInviteToken'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateClubInviteToken$MutationToJson(
        UpdateClubInviteToken$Mutation instance) =>
    <String, dynamic>{
      'updateClubInviteToken': instance.updateClubInviteToken.toJson(),
    };

UpdateClubInviteTokenInput _$UpdateClubInviteTokenInputFromJson(
    Map<String, dynamic> json) {
  return UpdateClubInviteTokenInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    inviteLimit: json['inviteLimit'] as int?,
    active: json['active'] as bool?,
  );
}

Map<String, dynamic> _$UpdateClubInviteTokenInputToJson(
        UpdateClubInviteTokenInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'inviteLimit': instance.inviteLimit,
      'active': instance.active,
    };

CreateClubInviteToken$Mutation _$CreateClubInviteToken$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateClubInviteToken$Mutation()
    ..createClubInviteToken = ClubInviteToken.fromJson(
        json['createClubInviteToken'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateClubInviteToken$MutationToJson(
        CreateClubInviteToken$Mutation instance) =>
    <String, dynamic>{
      'createClubInviteToken': instance.createClubInviteToken.toJson(),
    };

CreateClubInviteTokenInput _$CreateClubInviteTokenInputFromJson(
    Map<String, dynamic> json) {
  return CreateClubInviteTokenInput(
    name: json['name'] as String,
    inviteLimit: json['inviteLimit'] as int,
    club: ConnectRelationInput.fromJson(json['Club'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateClubInviteTokenInputToJson(
        CreateClubInviteTokenInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'inviteLimit': instance.inviteLimit,
      'Club': instance.club.toJson(),
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

DeleteClubInviteTokenById$Mutation _$DeleteClubInviteTokenById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteClubInviteTokenById$Mutation()
    ..deleteClubInviteTokenById = json['deleteClubInviteTokenById'] as String;
}

Map<String, dynamic> _$DeleteClubInviteTokenById$MutationToJson(
        DeleteClubInviteTokenById$Mutation instance) =>
    <String, dynamic>{
      'deleteClubInviteTokenById': instance.deleteClubInviteTokenById,
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

DeleteCollectionById$Mutation _$DeleteCollectionById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteCollectionById$Mutation()
    ..deleteCollectionById = json['deleteCollectionById'] as String;
}

Map<String, dynamic> _$DeleteCollectionById$MutationToJson(
        DeleteCollectionById$Mutation instance) =>
    <String, dynamic>{
      'deleteCollectionById': instance.deleteCollectionById,
    };

WorkoutGoal _$WorkoutGoalFromJson(Map<String, dynamic> json) {
  return WorkoutGoal()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..hexColor = json['hexColor'] as String;
}

Map<String, dynamic> _$WorkoutGoalToJson(WorkoutGoal instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'hexColor': instance.hexColor,
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

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..lengthMinutes = json['lengthMinutes'] as int?
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
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'lengthMinutes': instance.lengthMinutes,
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
  ContentAccessScope.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

WorkoutPlanDayWorkout _$WorkoutPlanDayWorkoutFromJson(
    Map<String, dynamic> json) {
  return WorkoutPlanDayWorkout()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..note = json['note'] as String?
    ..sortPosition = json['sortPosition'] as int
    ..workout = Workout.fromJson(json['Workout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutPlanDayWorkoutToJson(
        WorkoutPlanDayWorkout instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'note': instance.note,
      'sortPosition': instance.sortPosition,
      'Workout': instance.workout.toJson(),
    };

WorkoutPlanDay _$WorkoutPlanDayFromJson(Map<String, dynamic> json) {
  return WorkoutPlanDay()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..note = json['note'] as String?
    ..dayNumber = json['dayNumber'] as int
    ..workoutPlanDayWorkouts = (json['WorkoutPlanDayWorkouts'] as List<dynamic>)
        .map((e) => WorkoutPlanDayWorkout.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkoutPlanDayToJson(WorkoutPlanDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'note': instance.note,
      'dayNumber': instance.dayNumber,
      'WorkoutPlanDayWorkouts':
          instance.workoutPlanDayWorkouts.map((e) => e.toJson()).toList(),
    };

WorkoutPlanEnrolmentSummary _$WorkoutPlanEnrolmentSummaryFromJson(
    Map<String, dynamic> json) {
  return WorkoutPlanEnrolmentSummary()
    ..id = json['id'] as String
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutPlanEnrolmentSummaryToJson(
        WorkoutPlanEnrolmentSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'User': instance.user.toJson(),
    };

WorkoutPlanReview _$WorkoutPlanReviewFromJson(Map<String, dynamic> json) {
  return WorkoutPlanReview()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..score = (json['score'] as num).toDouble()
    ..comment = json['comment'] as String?
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutPlanReviewToJson(WorkoutPlanReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'score': instance.score,
      'comment': instance.comment,
      'User': instance.user.toJson(),
    };

WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) {
  return WorkoutPlan()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..lengthWeeks = json['lengthWeeks'] as int
    ..daysPerWeek = json['daysPerWeek'] as int
    ..coverImageUri = json['coverImageUri'] as String?
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..contentAccessScope = _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown)
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>)
    ..workoutPlanDays = (json['WorkoutPlanDays'] as List<dynamic>)
        .map((e) => WorkoutPlanDay.fromJson(e as Map<String, dynamic>))
        .toList()
    ..enrolments = (json['Enrolments'] as List<dynamic>)
        .map((e) =>
            WorkoutPlanEnrolmentSummary.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutPlanReviews = (json['WorkoutPlanReviews'] as List<dynamic>)
        .map((e) => WorkoutPlanReview.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutTags = (json['WorkoutTags'] as List<dynamic>)
        .map((e) => WorkoutTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkoutPlanToJson(WorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'lengthWeeks': instance.lengthWeeks,
      'daysPerWeek': instance.daysPerWeek,
      'coverImageUri': instance.coverImageUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'User': instance.user.toJson(),
      'WorkoutPlanDays':
          instance.workoutPlanDays.map((e) => e.toJson()).toList(),
      'Enrolments': instance.enrolments.map((e) => e.toJson()).toList(),
      'WorkoutPlanReviews':
          instance.workoutPlanReviews.map((e) => e.toJson()).toList(),
      'WorkoutTags': instance.workoutTags.map((e) => e.toJson()).toList(),
    };

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>)
    ..workouts = (json['Workouts'] as List<dynamic>)
        .map((e) => Workout.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutPlans = (json['WorkoutPlans'] as List<dynamic>)
        .map((e) => WorkoutPlan.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'name': instance.name,
      'description': instance.description,
      'User': instance.user.toJson(),
      'Workouts': instance.workouts.map((e) => e.toJson()).toList(),
      'WorkoutPlans': instance.workoutPlans.map((e) => e.toJson()).toList(),
    };

AddWorkoutPlanToCollection$Mutation
    _$AddWorkoutPlanToCollection$MutationFromJson(Map<String, dynamic> json) {
  return AddWorkoutPlanToCollection$Mutation()
    ..addWorkoutPlanToCollection = Collection.fromJson(
        json['addWorkoutPlanToCollection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AddWorkoutPlanToCollection$MutationToJson(
        AddWorkoutPlanToCollection$Mutation instance) =>
    <String, dynamic>{
      'addWorkoutPlanToCollection':
          instance.addWorkoutPlanToCollection.toJson(),
    };

AddWorkoutPlanToCollectionInput _$AddWorkoutPlanToCollectionInputFromJson(
    Map<String, dynamic> json) {
  return AddWorkoutPlanToCollectionInput(
    collectionId: json['collectionId'] as String,
    workoutPlan: ConnectRelationInput.fromJson(
        json['WorkoutPlan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddWorkoutPlanToCollectionInputToJson(
        AddWorkoutPlanToCollectionInput instance) =>
    <String, dynamic>{
      'collectionId': instance.collectionId,
      'WorkoutPlan': instance.workoutPlan.toJson(),
    };

CreateCollection$Mutation _$CreateCollection$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateCollection$Mutation()
    ..createCollection =
        Collection.fromJson(json['createCollection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateCollection$MutationToJson(
        CreateCollection$Mutation instance) =>
    <String, dynamic>{
      'createCollection': instance.createCollection.toJson(),
    };

CreateCollectionInput _$CreateCollectionInputFromJson(
    Map<String, dynamic> json) {
  return CreateCollectionInput(
    name: json['name'] as String,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$CreateCollectionInputToJson(
        CreateCollectionInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

UserCollectionById$Query _$UserCollectionById$QueryFromJson(
    Map<String, dynamic> json) {
  return UserCollectionById$Query()
    ..userCollectionById =
        Collection.fromJson(json['userCollectionById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserCollectionById$QueryToJson(
        UserCollectionById$Query instance) =>
    <String, dynamic>{
      'userCollectionById': instance.userCollectionById.toJson(),
    };

AddWorkoutToCollection$Mutation _$AddWorkoutToCollection$MutationFromJson(
    Map<String, dynamic> json) {
  return AddWorkoutToCollection$Mutation()
    ..addWorkoutToCollection = Collection.fromJson(
        json['addWorkoutToCollection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AddWorkoutToCollection$MutationToJson(
        AddWorkoutToCollection$Mutation instance) =>
    <String, dynamic>{
      'addWorkoutToCollection': instance.addWorkoutToCollection.toJson(),
    };

AddWorkoutToCollectionInput _$AddWorkoutToCollectionInputFromJson(
    Map<String, dynamic> json) {
  return AddWorkoutToCollectionInput(
    collectionId: json['collectionId'] as String,
    workout:
        ConnectRelationInput.fromJson(json['Workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddWorkoutToCollectionInputToJson(
        AddWorkoutToCollectionInput instance) =>
    <String, dynamic>{
      'collectionId': instance.collectionId,
      'Workout': instance.workout.toJson(),
    };

UserCollections$Query _$UserCollections$QueryFromJson(
    Map<String, dynamic> json) {
  return UserCollections$Query()
    ..userCollections = (json['userCollections'] as List<dynamic>)
        .map((e) => Collection.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserCollections$QueryToJson(
        UserCollections$Query instance) =>
    <String, dynamic>{
      'userCollections':
          instance.userCollections.map((e) => e.toJson()).toList(),
    };

UpdateCollection$Mutation _$UpdateCollection$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateCollection$Mutation()
    ..updateCollection =
        Collection.fromJson(json['updateCollection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateCollection$MutationToJson(
        UpdateCollection$Mutation instance) =>
    <String, dynamic>{
      'updateCollection': instance.updateCollection.toJson(),
    };

UpdateCollectionInput _$UpdateCollectionInputFromJson(
    Map<String, dynamic> json) {
  return UpdateCollectionInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$UpdateCollectionInputToJson(
        UpdateCollectionInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

RemoveWorkoutPlanFromCollection$Mutation
    _$RemoveWorkoutPlanFromCollection$MutationFromJson(
        Map<String, dynamic> json) {
  return RemoveWorkoutPlanFromCollection$Mutation()
    ..removeWorkoutPlanFromCollection = Collection.fromJson(
        json['removeWorkoutPlanFromCollection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RemoveWorkoutPlanFromCollection$MutationToJson(
        RemoveWorkoutPlanFromCollection$Mutation instance) =>
    <String, dynamic>{
      'removeWorkoutPlanFromCollection':
          instance.removeWorkoutPlanFromCollection.toJson(),
    };

RemoveWorkoutPlanFromCollectionInput
    _$RemoveWorkoutPlanFromCollectionInputFromJson(Map<String, dynamic> json) {
  return RemoveWorkoutPlanFromCollectionInput(
    collectionId: json['collectionId'] as String,
    workoutPlan: ConnectRelationInput.fromJson(
        json['WorkoutPlan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RemoveWorkoutPlanFromCollectionInputToJson(
        RemoveWorkoutPlanFromCollectionInput instance) =>
    <String, dynamic>{
      'collectionId': instance.collectionId,
      'WorkoutPlan': instance.workoutPlan.toJson(),
    };

RemoveWorkoutFromCollection$Mutation
    _$RemoveWorkoutFromCollection$MutationFromJson(Map<String, dynamic> json) {
  return RemoveWorkoutFromCollection$Mutation()
    ..removeWorkoutFromCollection = Collection.fromJson(
        json['removeWorkoutFromCollection'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RemoveWorkoutFromCollection$MutationToJson(
        RemoveWorkoutFromCollection$Mutation instance) =>
    <String, dynamic>{
      'removeWorkoutFromCollection':
          instance.removeWorkoutFromCollection.toJson(),
    };

RemoveWorkoutFromCollectionInput _$RemoveWorkoutFromCollectionInputFromJson(
    Map<String, dynamic> json) {
  return RemoveWorkoutFromCollectionInput(
    collectionId: json['collectionId'] as String,
    workout:
        ConnectRelationInput.fromJson(json['Workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RemoveWorkoutFromCollectionInputToJson(
        RemoveWorkoutFromCollectionInput instance) =>
    <String, dynamic>{
      'collectionId': instance.collectionId,
      'Workout': instance.workout.toJson(),
    };

DiscoverFeatured _$DiscoverFeaturedFromJson(Map<String, dynamic> json) {
  return DiscoverFeatured()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..tag = json['tag'] as String
    ..name = json['name'] as String
    ..tagline = json['tagline'] as String
    ..description = json['description'] as String
    ..coverImageUri = json['coverImageUri'] as String;
}

Map<String, dynamic> _$DiscoverFeaturedToJson(DiscoverFeatured instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'tag': instance.tag,
      'name': instance.name,
      'tagline': instance.tagline,
      'description': instance.description,
      'coverImageUri': instance.coverImageUri,
    };

DiscoverFeatured$Query _$DiscoverFeatured$QueryFromJson(
    Map<String, dynamic> json) {
  return DiscoverFeatured$Query()
    ..discoverFeatured = (json['discoverFeatured'] as List<dynamic>)
        .map((e) => DiscoverFeatured.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DiscoverFeatured$QueryToJson(
        DiscoverFeatured$Query instance) =>
    <String, dynamic>{
      'discoverFeatured':
          instance.discoverFeatured.map((e) => e.toJson()).toList(),
    };

DiscoverWorkoutPlanCategory _$DiscoverWorkoutPlanCategoryFromJson(
    Map<String, dynamic> json) {
  return DiscoverWorkoutPlanCategory()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..active = json['active'] as bool
    ..name = json['name'] as String
    ..tagline = json['tagline'] as String
    ..description = json['description'] as String
    ..coverImageUri = json['coverImageUri'] as String;
}

Map<String, dynamic> _$DiscoverWorkoutPlanCategoryToJson(
        DiscoverWorkoutPlanCategory instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'active': instance.active,
      'name': instance.name,
      'tagline': instance.tagline,
      'description': instance.description,
      'coverImageUri': instance.coverImageUri,
    };

DiscoverWorkoutPlanCategories$Query
    _$DiscoverWorkoutPlanCategories$QueryFromJson(Map<String, dynamic> json) {
  return DiscoverWorkoutPlanCategories$Query()
    ..discoverWorkoutPlanCategories =
        (json['discoverWorkoutPlanCategories'] as List<dynamic>)
            .map((e) =>
                DiscoverWorkoutPlanCategory.fromJson(e as Map<String, dynamic>))
            .toList();
}

Map<String, dynamic> _$DiscoverWorkoutPlanCategories$QueryToJson(
        DiscoverWorkoutPlanCategories$Query instance) =>
    <String, dynamic>{
      'discoverWorkoutPlanCategories': instance.discoverWorkoutPlanCategories
          .map((e) => e.toJson())
          .toList(),
    };

DiscoverWorkoutCategory _$DiscoverWorkoutCategoryFromJson(
    Map<String, dynamic> json) {
  return DiscoverWorkoutCategory()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..active = json['active'] as bool
    ..name = json['name'] as String
    ..tagline = json['tagline'] as String
    ..description = json['description'] as String
    ..coverImageUri = json['coverImageUri'] as String;
}

Map<String, dynamic> _$DiscoverWorkoutCategoryToJson(
        DiscoverWorkoutCategory instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'active': instance.active,
      'name': instance.name,
      'tagline': instance.tagline,
      'description': instance.description,
      'coverImageUri': instance.coverImageUri,
    };

DiscoverWorkoutCategories$Query _$DiscoverWorkoutCategories$QueryFromJson(
    Map<String, dynamic> json) {
  return DiscoverWorkoutCategories$Query()
    ..discoverWorkoutCategories = (json['discoverWorkoutCategories']
            as List<dynamic>)
        .map((e) => DiscoverWorkoutCategory.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DiscoverWorkoutCategories$QueryToJson(
        DiscoverWorkoutCategories$Query instance) =>
    <String, dynamic>{
      'discoverWorkoutCategories':
          instance.discoverWorkoutCategories.map((e) => e.toJson()).toList(),
    };

ReorderWorkoutPlanDayWorkouts$Mutation
    _$ReorderWorkoutPlanDayWorkouts$MutationFromJson(
        Map<String, dynamic> json) {
  return ReorderWorkoutPlanDayWorkouts$Mutation()
    ..reorderWorkoutPlanDayWorkouts =
        (json['reorderWorkoutPlanDayWorkouts'] as List<dynamic>)
            .map((e) => SortPositionUpdated.fromJson(e as Map<String, dynamic>))
            .toList();
}

Map<String, dynamic> _$ReorderWorkoutPlanDayWorkouts$MutationToJson(
        ReorderWorkoutPlanDayWorkouts$Mutation instance) =>
    <String, dynamic>{
      'reorderWorkoutPlanDayWorkouts': instance.reorderWorkoutPlanDayWorkouts
          .map((e) => e.toJson())
          .toList(),
    };

CreateWorkoutPlanDayWorkout$Mutation
    _$CreateWorkoutPlanDayWorkout$MutationFromJson(Map<String, dynamic> json) {
  return CreateWorkoutPlanDayWorkout$Mutation()
    ..createWorkoutPlanDayWorkout = WorkoutPlanDayWorkout.fromJson(
        json['createWorkoutPlanDayWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutPlanDayWorkout$MutationToJson(
        CreateWorkoutPlanDayWorkout$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutPlanDayWorkout':
          instance.createWorkoutPlanDayWorkout.toJson(),
    };

CreateWorkoutPlanDayWorkoutInput _$CreateWorkoutPlanDayWorkoutInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutPlanDayWorkoutInput(
    note: json['note'] as String?,
    sortPosition: json['sortPosition'] as int,
    workoutPlanDay: ConnectRelationInput.fromJson(
        json['WorkoutPlanDay'] as Map<String, dynamic>),
    workout:
        ConnectRelationInput.fromJson(json['Workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanDayWorkoutInputToJson(
        CreateWorkoutPlanDayWorkoutInput instance) =>
    <String, dynamic>{
      'note': instance.note,
      'sortPosition': instance.sortPosition,
      'WorkoutPlanDay': instance.workoutPlanDay.toJson(),
      'Workout': instance.workout.toJson(),
    };

UpdateWorkoutPlanDayWorkout$Mutation
    _$UpdateWorkoutPlanDayWorkout$MutationFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutPlanDayWorkout$Mutation()
    ..updateWorkoutPlanDayWorkout = WorkoutPlanDayWorkout.fromJson(
        json['updateWorkoutPlanDayWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutPlanDayWorkout$MutationToJson(
        UpdateWorkoutPlanDayWorkout$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutPlanDayWorkout':
          instance.updateWorkoutPlanDayWorkout.toJson(),
    };

UpdateWorkoutPlanDayWorkoutInput _$UpdateWorkoutPlanDayWorkoutInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanDayWorkoutInput(
    id: json['id'] as String,
    note: json['note'] as String?,
    workoutPlanDay: json['WorkoutPlanDay'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['WorkoutPlanDay'] as Map<String, dynamic>),
    workout: json['Workout'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['Workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanDayWorkoutInputToJson(
        UpdateWorkoutPlanDayWorkoutInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'WorkoutPlanDay': instance.workoutPlanDay?.toJson(),
      'Workout': instance.workout?.toJson(),
    };

DeleteWorkoutPlanDayWorkoutById$Mutation
    _$DeleteWorkoutPlanDayWorkoutById$MutationFromJson(
        Map<String, dynamic> json) {
  return DeleteWorkoutPlanDayWorkoutById$Mutation()
    ..deleteWorkoutPlanDayWorkoutById =
        json['deleteWorkoutPlanDayWorkoutById'] as String;
}

Map<String, dynamic> _$DeleteWorkoutPlanDayWorkoutById$MutationToJson(
        DeleteWorkoutPlanDayWorkoutById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutPlanDayWorkoutById':
          instance.deleteWorkoutPlanDayWorkoutById,
    };

WorkoutPlanEnrolment _$WorkoutPlanEnrolmentFromJson(Map<String, dynamic> json) {
  return WorkoutPlanEnrolment()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..startDate = fromGraphQLDateTimeToDartDateTime(json['startDate'] as int)
    ..completedPlanDayWorkoutIds =
        (json['completedPlanDayWorkoutIds'] as List<dynamic>)
            .map((e) => e as String)
            .toList()
    ..workoutPlan =
        WorkoutPlan.fromJson(json['WorkoutPlan'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutPlanEnrolmentToJson(
        WorkoutPlanEnrolment instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'startDate': fromDartDateTimeToGraphQLDateTime(instance.startDate),
      'completedPlanDayWorkoutIds': instance.completedPlanDayWorkoutIds,
      'WorkoutPlan': instance.workoutPlan.toJson(),
    };

UpdateWorkoutPlanEnrolment$Mutation
    _$UpdateWorkoutPlanEnrolment$MutationFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutPlanEnrolment$Mutation()
    ..updateWorkoutPlanEnrolment = WorkoutPlanEnrolment.fromJson(
        json['updateWorkoutPlanEnrolment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutPlanEnrolment$MutationToJson(
        UpdateWorkoutPlanEnrolment$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutPlanEnrolment':
          instance.updateWorkoutPlanEnrolment.toJson(),
    };

UpdateWorkoutPlanEnrolmentInput _$UpdateWorkoutPlanEnrolmentInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanEnrolmentInput(
    id: json['id'] as String,
    startDate: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['startDate'] as int?),
    completedPlanDayWorkoutIds:
        (json['completedPlanDayWorkoutIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanEnrolmentInputToJson(
        UpdateWorkoutPlanEnrolmentInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.startDate),
      'completedPlanDayWorkoutIds': instance.completedPlanDayWorkoutIds,
    };

DeleteWorkoutPlanEnrolmentById$Mutation
    _$DeleteWorkoutPlanEnrolmentById$MutationFromJson(
        Map<String, dynamic> json) {
  return DeleteWorkoutPlanEnrolmentById$Mutation()
    ..deleteWorkoutPlanEnrolmentById =
        json['deleteWorkoutPlanEnrolmentById'] as String;
}

Map<String, dynamic> _$DeleteWorkoutPlanEnrolmentById$MutationToJson(
        DeleteWorkoutPlanEnrolmentById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutPlanEnrolmentById': instance.deleteWorkoutPlanEnrolmentById,
    };

CreateWorkoutPlanEnrolment$Mutation
    _$CreateWorkoutPlanEnrolment$MutationFromJson(Map<String, dynamic> json) {
  return CreateWorkoutPlanEnrolment$Mutation()
    ..createWorkoutPlanEnrolment = WorkoutPlanEnrolment.fromJson(
        json['createWorkoutPlanEnrolment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutPlanEnrolment$MutationToJson(
        CreateWorkoutPlanEnrolment$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutPlanEnrolment':
          instance.createWorkoutPlanEnrolment.toJson(),
    };

UserWorkoutPlanEnrolmentById$Query _$UserWorkoutPlanEnrolmentById$QueryFromJson(
    Map<String, dynamic> json) {
  return UserWorkoutPlanEnrolmentById$Query()
    ..userWorkoutPlanEnrolmentById = WorkoutPlanEnrolment.fromJson(
        json['userWorkoutPlanEnrolmentById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserWorkoutPlanEnrolmentById$QueryToJson(
        UserWorkoutPlanEnrolmentById$Query instance) =>
    <String, dynamic>{
      'userWorkoutPlanEnrolmentById':
          instance.userWorkoutPlanEnrolmentById.toJson(),
    };

UserWorkoutPlanEnrolments$Query _$UserWorkoutPlanEnrolments$QueryFromJson(
    Map<String, dynamic> json) {
  return UserWorkoutPlanEnrolments$Query()
    ..userWorkoutPlanEnrolments = (json['userWorkoutPlanEnrolments']
            as List<dynamic>)
        .map((e) => WorkoutPlanEnrolment.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkoutPlanEnrolments$QueryToJson(
        UserWorkoutPlanEnrolments$Query instance) =>
    <String, dynamic>{
      'userWorkoutPlanEnrolments':
          instance.userWorkoutPlanEnrolments.map((e) => e.toJson()).toList(),
    };

ProgressJournalGoalTag _$ProgressJournalGoalTagFromJson(
    Map<String, dynamic> json) {
  return ProgressJournalGoalTag()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..tag = json['tag'] as String
    ..hexColor = json['hexColor'] as String;
}

Map<String, dynamic> _$ProgressJournalGoalTagToJson(
        ProgressJournalGoalTag instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'tag': instance.tag,
      'hexColor': instance.hexColor,
    };

UpdateProgressJournalGoalTag$Mutation
    _$UpdateProgressJournalGoalTag$MutationFromJson(Map<String, dynamic> json) {
  return UpdateProgressJournalGoalTag$Mutation()
    ..updateProgressJournalGoalTag = ProgressJournalGoalTag.fromJson(
        json['updateProgressJournalGoalTag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateProgressJournalGoalTag$MutationToJson(
        UpdateProgressJournalGoalTag$Mutation instance) =>
    <String, dynamic>{
      'updateProgressJournalGoalTag':
          instance.updateProgressJournalGoalTag.toJson(),
    };

UpdateProgressJournalGoalTagInput _$UpdateProgressJournalGoalTagInputFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournalGoalTagInput(
    id: json['id'] as String,
    tag: json['tag'] as String?,
    hexColor: json['hexColor'] as String?,
  );
}

Map<String, dynamic> _$UpdateProgressJournalGoalTagInputToJson(
        UpdateProgressJournalGoalTagInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'hexColor': instance.hexColor,
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
    ..confidenceScore = (json['confidenceScore'] as num?)?.toDouble()
    ..motivationScore = (json['motivationScore'] as num?)?.toDouble();
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
      'confidenceScore': instance.confidenceScore,
      'motivationScore': instance.motivationScore,
    };

ProgressJournalGoal _$ProgressJournalGoalFromJson(Map<String, dynamic> json) {
  return ProgressJournalGoal()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..deadline = fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['deadline'] as int?)
    ..completedDate = fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['completedDate'] as int?)
    ..progressJournalGoalTags = (json['ProgressJournalGoalTags']
            as List<dynamic>)
        .map((e) => ProgressJournalGoalTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ProgressJournalGoalToJson(
        ProgressJournalGoal instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'name': instance.name,
      'description': instance.description,
      'deadline':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.deadline),
      'completedDate': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.completedDate),
      'ProgressJournalGoalTags':
          instance.progressJournalGoalTags.map((e) => e.toJson()).toList(),
    };

ProgressJournal _$ProgressJournalFromJson(Map<String, dynamic> json) {
  return ProgressJournal()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..coverImageUri = json['coverImageUri'] as String?
    ..bodyweightUnit = _$enumDecode(
        _$BodyweightUnitEnumMap, json['bodyweightUnit'],
        unknownValue: BodyweightUnit.artemisUnknown)
    ..progressJournalEntries = (json['ProgressJournalEntries'] as List<dynamic>)
        .map((e) => ProgressJournalEntry.fromJson(e as Map<String, dynamic>))
        .toList()
    ..progressJournalGoals = (json['ProgressJournalGoals'] as List<dynamic>)
        .map((e) => ProgressJournalGoal.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ProgressJournalToJson(ProgressJournal instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'name': instance.name,
      'description': instance.description,
      'coverImageUri': instance.coverImageUri,
      'bodyweightUnit': _$BodyweightUnitEnumMap[instance.bodyweightUnit],
      'ProgressJournalEntries':
          instance.progressJournalEntries.map((e) => e.toJson()).toList(),
      'ProgressJournalGoals':
          instance.progressJournalGoals.map((e) => e.toJson()).toList(),
    };

const _$BodyweightUnitEnumMap = {
  BodyweightUnit.kg: 'KG',
  BodyweightUnit.lb: 'LB',
  BodyweightUnit.artemisUnknown: 'ARTEMIS_UNKNOWN',
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

CreateProgressJournalEntry$Mutation
    _$CreateProgressJournalEntry$MutationFromJson(Map<String, dynamic> json) {
  return CreateProgressJournalEntry$Mutation()
    ..createProgressJournalEntry = ProgressJournalEntry.fromJson(
        json['createProgressJournalEntry'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateProgressJournalEntry$MutationToJson(
        CreateProgressJournalEntry$Mutation instance) =>
    <String, dynamic>{
      'createProgressJournalEntry':
          instance.createProgressJournalEntry.toJson(),
    };

CreateProgressJournalEntryInput _$CreateProgressJournalEntryInputFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournalEntryInput(
    note: json['note'] as String?,
    voiceNoteUri: json['voiceNoteUri'] as String?,
    bodyweight: (json['bodyweight'] as num?)?.toDouble(),
    moodScore: (json['moodScore'] as num?)?.toDouble(),
    energyScore: (json['energyScore'] as num?)?.toDouble(),
    confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
    motivationScore: (json['motivationScore'] as num?)?.toDouble(),
    progressJournal: ConnectRelationInput.fromJson(
        json['ProgressJournal'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateProgressJournalEntryInputToJson(
        CreateProgressJournalEntryInput instance) =>
    <String, dynamic>{
      'note': instance.note,
      'voiceNoteUri': instance.voiceNoteUri,
      'bodyweight': instance.bodyweight,
      'moodScore': instance.moodScore,
      'energyScore': instance.energyScore,
      'confidenceScore': instance.confidenceScore,
      'motivationScore': instance.motivationScore,
      'ProgressJournal': instance.progressJournal.toJson(),
    };

DeleteProgressJournalById$Mutation _$DeleteProgressJournalById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteProgressJournalById$Mutation()
    ..deleteProgressJournalById = json['deleteProgressJournalById'] as String;
}

Map<String, dynamic> _$DeleteProgressJournalById$MutationToJson(
        DeleteProgressJournalById$Mutation instance) =>
    <String, dynamic>{
      'deleteProgressJournalById': instance.deleteProgressJournalById,
    };

CreateProgressJournal$Mutation _$CreateProgressJournal$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournal$Mutation()
    ..createProgressJournal = ProgressJournal.fromJson(
        json['createProgressJournal'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateProgressJournal$MutationToJson(
        CreateProgressJournal$Mutation instance) =>
    <String, dynamic>{
      'createProgressJournal': instance.createProgressJournal.toJson(),
    };

CreateProgressJournalInput _$CreateProgressJournalInputFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournalInput(
    name: json['name'] as String,
    description: json['description'] as String?,
    coverImageUri: json['coverImageUri'] as String?,
    bodyweightUnit: _$enumDecodeNullable(
        _$BodyweightUnitEnumMap, json['bodyweightUnit'],
        unknownValue: BodyweightUnit.artemisUnknown),
  );
}

Map<String, dynamic> _$CreateProgressJournalInputToJson(
        CreateProgressJournalInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'coverImageUri': instance.coverImageUri,
      'bodyweightUnit': _$BodyweightUnitEnumMap[instance.bodyweightUnit],
    };

UpdateProgressJournal$Mutation _$UpdateProgressJournal$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournal$Mutation()
    ..updateProgressJournal = ProgressJournal.fromJson(
        json['updateProgressJournal'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateProgressJournal$MutationToJson(
        UpdateProgressJournal$Mutation instance) =>
    <String, dynamic>{
      'updateProgressJournal': instance.updateProgressJournal.toJson(),
    };

UpdateProgressJournalInput _$UpdateProgressJournalInputFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournalInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
    coverImageUri: json['coverImageUri'] as String?,
    bodyweightUnit: _$enumDecodeNullable(
        _$BodyweightUnitEnumMap, json['bodyweightUnit'],
        unknownValue: BodyweightUnit.artemisUnknown),
  );
}

Map<String, dynamic> _$UpdateProgressJournalInputToJson(
        UpdateProgressJournalInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'coverImageUri': instance.coverImageUri,
      'bodyweightUnit': _$BodyweightUnitEnumMap[instance.bodyweightUnit],
    };

DeleteProgressJournalEntryById$Mutation
    _$DeleteProgressJournalEntryById$MutationFromJson(
        Map<String, dynamic> json) {
  return DeleteProgressJournalEntryById$Mutation()
    ..deleteProgressJournalEntryById =
        json['deleteProgressJournalEntryById'] as String;
}

Map<String, dynamic> _$DeleteProgressJournalEntryById$MutationToJson(
        DeleteProgressJournalEntryById$Mutation instance) =>
    <String, dynamic>{
      'deleteProgressJournalEntryById': instance.deleteProgressJournalEntryById,
    };

UpdateProgressJournalEntry$Mutation
    _$UpdateProgressJournalEntry$MutationFromJson(Map<String, dynamic> json) {
  return UpdateProgressJournalEntry$Mutation()
    ..updateProgressJournalEntry = ProgressJournalEntry.fromJson(
        json['updateProgressJournalEntry'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateProgressJournalEntry$MutationToJson(
        UpdateProgressJournalEntry$Mutation instance) =>
    <String, dynamic>{
      'updateProgressJournalEntry':
          instance.updateProgressJournalEntry.toJson(),
    };

UpdateProgressJournalEntryInput _$UpdateProgressJournalEntryInputFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournalEntryInput(
    id: json['id'] as String,
    note: json['note'] as String?,
    voiceNoteUri: json['voiceNoteUri'] as String?,
    bodyweight: (json['bodyweight'] as num?)?.toDouble(),
    moodScore: (json['moodScore'] as num?)?.toDouble(),
    energyScore: (json['energyScore'] as num?)?.toDouble(),
    confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
    motivationScore: (json['motivationScore'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$UpdateProgressJournalEntryInputToJson(
        UpdateProgressJournalEntryInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'voiceNoteUri': instance.voiceNoteUri,
      'bodyweight': instance.bodyweight,
      'moodScore': instance.moodScore,
      'energyScore': instance.energyScore,
      'confidenceScore': instance.confidenceScore,
      'motivationScore': instance.motivationScore,
    };

CreateProgressJournalGoal$Mutation _$CreateProgressJournalGoal$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournalGoal$Mutation()
    ..createProgressJournalGoal = ProgressJournalGoal.fromJson(
        json['createProgressJournalGoal'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateProgressJournalGoal$MutationToJson(
        CreateProgressJournalGoal$Mutation instance) =>
    <String, dynamic>{
      'createProgressJournalGoal': instance.createProgressJournalGoal.toJson(),
    };

CreateProgressJournalGoalInput _$CreateProgressJournalGoalInputFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournalGoalInput(
    name: json['name'] as String,
    description: json['description'] as String?,
    deadline: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['deadline'] as int?),
    progressJournal: ConnectRelationInput.fromJson(
        json['ProgressJournal'] as Map<String, dynamic>),
    progressJournalGoalTags: (json['ProgressJournalGoalTags'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateProgressJournalGoalInputToJson(
        CreateProgressJournalGoalInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'deadline':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.deadline),
      'ProgressJournal': instance.progressJournal.toJson(),
      'ProgressJournalGoalTags':
          instance.progressJournalGoalTags?.map((e) => e.toJson()).toList(),
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

UpdateProgressJournalGoal$Mutation _$UpdateProgressJournalGoal$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournalGoal$Mutation()
    ..updateProgressJournalGoal = ProgressJournalGoal.fromJson(
        json['updateProgressJournalGoal'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateProgressJournalGoal$MutationToJson(
        UpdateProgressJournalGoal$Mutation instance) =>
    <String, dynamic>{
      'updateProgressJournalGoal': instance.updateProgressJournalGoal.toJson(),
    };

UpdateProgressJournalGoalInput _$UpdateProgressJournalGoalInputFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournalGoalInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
    completedDate: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['completedDate'] as int?),
    deadline: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['deadline'] as int?),
    progressJournalGoalTags: (json['ProgressJournalGoalTags'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UpdateProgressJournalGoalInputToJson(
        UpdateProgressJournalGoalInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'completedDate': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.completedDate),
      'deadline':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.deadline),
      'ProgressJournalGoalTags':
          instance.progressJournalGoalTags?.map((e) => e.toJson()).toList(),
    };

CreateProgressJournalGoalTag$Mutation
    _$CreateProgressJournalGoalTag$MutationFromJson(Map<String, dynamic> json) {
  return CreateProgressJournalGoalTag$Mutation()
    ..createProgressJournalGoalTag = ProgressJournalGoalTag.fromJson(
        json['createProgressJournalGoalTag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateProgressJournalGoalTag$MutationToJson(
        CreateProgressJournalGoalTag$Mutation instance) =>
    <String, dynamic>{
      'createProgressJournalGoalTag':
          instance.createProgressJournalGoalTag.toJson(),
    };

CreateProgressJournalGoalTagInput _$CreateProgressJournalGoalTagInputFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournalGoalTagInput(
    tag: json['tag'] as String,
    hexColor: json['hexColor'] as String,
  );
}

Map<String, dynamic> _$CreateProgressJournalGoalTagInputToJson(
        CreateProgressJournalGoalTagInput instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'hexColor': instance.hexColor,
    };

DeleteProgressJournalGoalById$Mutation
    _$DeleteProgressJournalGoalById$MutationFromJson(
        Map<String, dynamic> json) {
  return DeleteProgressJournalGoalById$Mutation()
    ..deleteProgressJournalGoalById =
        json['deleteProgressJournalGoalById'] as String;
}

Map<String, dynamic> _$DeleteProgressJournalGoalById$MutationToJson(
        DeleteProgressJournalGoalById$Mutation instance) =>
    <String, dynamic>{
      'deleteProgressJournalGoalById': instance.deleteProgressJournalGoalById,
    };

DeleteProgressJournalGoalTagById$Mutation
    _$DeleteProgressJournalGoalTagById$MutationFromJson(
        Map<String, dynamic> json) {
  return DeleteProgressJournalGoalTagById$Mutation()
    ..deleteProgressJournalGoalTagById =
        json['deleteProgressJournalGoalTagById'] as String;
}

Map<String, dynamic> _$DeleteProgressJournalGoalTagById$MutationToJson(
        DeleteProgressJournalGoalTagById$Mutation instance) =>
    <String, dynamic>{
      'deleteProgressJournalGoalTagById':
          instance.deleteProgressJournalGoalTagById,
    };

ProgressJournalGoalTags$Query _$ProgressJournalGoalTags$QueryFromJson(
    Map<String, dynamic> json) {
  return ProgressJournalGoalTags$Query()
    ..progressJournalGoalTags = (json['progressJournalGoalTags']
            as List<dynamic>)
        .map((e) => ProgressJournalGoalTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ProgressJournalGoalTags$QueryToJson(
        ProgressJournalGoalTags$Query instance) =>
    <String, dynamic>{
      'progressJournalGoalTags':
          instance.progressJournalGoalTags.map((e) => e.toJson()).toList(),
    };

MoveWorkoutPlanDayToAnotherDay$Mutation
    _$MoveWorkoutPlanDayToAnotherDay$MutationFromJson(
        Map<String, dynamic> json) {
  return MoveWorkoutPlanDayToAnotherDay$Mutation()
    ..moveWorkoutPlanDayToAnotherDay = WorkoutPlanDay.fromJson(
        json['moveWorkoutPlanDayToAnotherDay'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MoveWorkoutPlanDayToAnotherDay$MutationToJson(
        MoveWorkoutPlanDayToAnotherDay$Mutation instance) =>
    <String, dynamic>{
      'moveWorkoutPlanDayToAnotherDay':
          instance.moveWorkoutPlanDayToAnotherDay.toJson(),
    };

MoveWorkoutPlanDayToAnotherDayInput
    _$MoveWorkoutPlanDayToAnotherDayInputFromJson(Map<String, dynamic> json) {
  return MoveWorkoutPlanDayToAnotherDayInput(
    id: json['id'] as String,
    moveToDay: json['moveToDay'] as int,
  );
}

Map<String, dynamic> _$MoveWorkoutPlanDayToAnotherDayInputToJson(
        MoveWorkoutPlanDayToAnotherDayInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moveToDay': instance.moveToDay,
    };

DeleteWorkoutPlanDaysById$Mutation _$DeleteWorkoutPlanDaysById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutPlanDaysById$Mutation()
    ..deleteWorkoutPlanDaysById =
        (json['deleteWorkoutPlanDaysById'] as List<dynamic>)
            .map((e) => e as String)
            .toList();
}

Map<String, dynamic> _$DeleteWorkoutPlanDaysById$MutationToJson(
        DeleteWorkoutPlanDaysById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutPlanDaysById': instance.deleteWorkoutPlanDaysById,
    };

UpdateWorkoutPlanDay$Mutation _$UpdateWorkoutPlanDay$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanDay$Mutation()
    ..updateWorkoutPlanDay = WorkoutPlanDay.fromJson(
        json['updateWorkoutPlanDay'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutPlanDay$MutationToJson(
        UpdateWorkoutPlanDay$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutPlanDay': instance.updateWorkoutPlanDay.toJson(),
    };

UpdateWorkoutPlanDayInput _$UpdateWorkoutPlanDayInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanDayInput(
    id: json['id'] as String,
    note: json['note'] as String?,
    dayNumber: json['dayNumber'] as int?,
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanDayInputToJson(
        UpdateWorkoutPlanDayInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'dayNumber': instance.dayNumber,
    };

CreateWorkoutPlanDayWithWorkout$Mutation
    _$CreateWorkoutPlanDayWithWorkout$MutationFromJson(
        Map<String, dynamic> json) {
  return CreateWorkoutPlanDayWithWorkout$Mutation()
    ..createWorkoutPlanDayWithWorkout = WorkoutPlanDay.fromJson(
        json['createWorkoutPlanDayWithWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutPlanDayWithWorkout$MutationToJson(
        CreateWorkoutPlanDayWithWorkout$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutPlanDayWithWorkout':
          instance.createWorkoutPlanDayWithWorkout.toJson(),
    };

CreateWorkoutPlanDayWithWorkoutInput
    _$CreateWorkoutPlanDayWithWorkoutInputFromJson(Map<String, dynamic> json) {
  return CreateWorkoutPlanDayWithWorkoutInput(
    dayNumber: json['dayNumber'] as int,
    workoutPlan: ConnectRelationInput.fromJson(
        json['WorkoutPlan'] as Map<String, dynamic>),
    workout:
        ConnectRelationInput.fromJson(json['Workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanDayWithWorkoutInputToJson(
        CreateWorkoutPlanDayWithWorkoutInput instance) =>
    <String, dynamic>{
      'dayNumber': instance.dayNumber,
      'WorkoutPlan': instance.workoutPlan.toJson(),
      'Workout': instance.workout.toJson(),
    };

CopyWorkoutPlanDayToAnotherDay$Mutation
    _$CopyWorkoutPlanDayToAnotherDay$MutationFromJson(
        Map<String, dynamic> json) {
  return CopyWorkoutPlanDayToAnotherDay$Mutation()
    ..copyWorkoutPlanDayToAnotherDay = WorkoutPlanDay.fromJson(
        json['copyWorkoutPlanDayToAnotherDay'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CopyWorkoutPlanDayToAnotherDay$MutationToJson(
        CopyWorkoutPlanDayToAnotherDay$Mutation instance) =>
    <String, dynamic>{
      'copyWorkoutPlanDayToAnotherDay':
          instance.copyWorkoutPlanDayToAnotherDay.toJson(),
    };

CopyWorkoutPlanDayToAnotherDayInput
    _$CopyWorkoutPlanDayToAnotherDayInputFromJson(Map<String, dynamic> json) {
  return CopyWorkoutPlanDayToAnotherDayInput(
    id: json['id'] as String,
    copyToDay: json['copyToDay'] as int,
  );
}

Map<String, dynamic> _$CopyWorkoutPlanDayToAnotherDayInputToJson(
        CopyWorkoutPlanDayToAnotherDayInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'copyToDay': instance.copyToDay,
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

LoggedWorkoutMove _$LoggedWorkoutMoveFromJson(Map<String, dynamic> json) {
  return LoggedWorkoutMove()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
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
    ..roundNumber = json['roundNumber'] as int
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
      'roundNumber': instance.roundNumber,
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
    ..repScore = json['repScore'] as int?
    ..timeTakenMs = json['timeTakenMs'] as int?
    ..lapTimesMs = fromGraphQLJsonToDartMap(json['lapTimesMs'])
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
      'repScore': instance.repScore,
      'timeTakenMs': instance.timeTakenMs,
      'lapTimesMs': fromDartMapToGraphQLJson(instance.lapTimesMs),
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
    completedOn: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['completedOn'] as int?),
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
      'completedOn': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.completedOn),
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
    };

CreateLoggedWorkoutSectionInLoggedWorkoutInput
    _$CreateLoggedWorkoutSectionInLoggedWorkoutInputFromJson(
        Map<String, dynamic> json) {
  return CreateLoggedWorkoutSectionInLoggedWorkoutInput(
    name: json['name'] as String?,
    note: json['note'] as String?,
    sortPosition: json['sortPosition'] as int,
    timeTakenMs: json['timeTakenMs'] as int?,
    lapTimesMs: fromGraphQLJsonNullableToDartMapNullable(json['lapTimesMs']),
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
      'timeTakenMs': instance.timeTakenMs,
      'lapTimesMs':
          fromDartMapNullableToGraphQLJsonNullable(instance.lapTimesMs),
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
    roundNumber: json['roundNumber'] as int,
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
      'roundNumber': instance.roundNumber,
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
      'repType': _$WorkoutMoveRepTypeEnumMap[instance.repType],
      'reps': instance.reps,
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit],
      'loadAmount': instance.loadAmount,
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'timeUnit': _$TimeUnitEnumMap[instance.timeUnit],
      'Move': instance.move.toJson(),
      'Equipment': instance.equipment?.toJson(),
    };

DeleteWorkoutPlanReviewById$Mutation
    _$DeleteWorkoutPlanReviewById$MutationFromJson(Map<String, dynamic> json) {
  return DeleteWorkoutPlanReviewById$Mutation()
    ..deleteWorkoutPlanReviewById =
        json['deleteWorkoutPlanReviewById'] as String;
}

Map<String, dynamic> _$DeleteWorkoutPlanReviewById$MutationToJson(
        DeleteWorkoutPlanReviewById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutPlanReviewById': instance.deleteWorkoutPlanReviewById,
    };

UpdateWorkoutPlanReview$Mutation _$UpdateWorkoutPlanReview$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanReview$Mutation()
    ..updateWorkoutPlanReview = WorkoutPlanReview.fromJson(
        json['updateWorkoutPlanReview'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutPlanReview$MutationToJson(
        UpdateWorkoutPlanReview$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutPlanReview': instance.updateWorkoutPlanReview.toJson(),
    };

UpdateWorkoutPlanReviewInput _$UpdateWorkoutPlanReviewInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanReviewInput(
    id: json['id'] as String,
    score: (json['score'] as num?)?.toDouble(),
    comment: json['comment'] as String?,
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanReviewInputToJson(
        UpdateWorkoutPlanReviewInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'comment': instance.comment,
    };

CreateWorkoutPlanReview$Mutation _$CreateWorkoutPlanReview$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutPlanReview$Mutation()
    ..createWorkoutPlanReview = WorkoutPlanReview.fromJson(
        json['createWorkoutPlanReview'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutPlanReview$MutationToJson(
        CreateWorkoutPlanReview$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutPlanReview': instance.createWorkoutPlanReview.toJson(),
    };

CreateWorkoutPlanReviewInput _$CreateWorkoutPlanReviewInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutPlanReviewInput(
    score: (json['score'] as num).toDouble(),
    comment: json['comment'] as String?,
    workoutPlan: ConnectRelationInput.fromJson(
        json['WorkoutPlan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanReviewInputToJson(
        CreateWorkoutPlanReviewInput instance) =>
    <String, dynamic>{
      'score': instance.score,
      'comment': instance.comment,
      'WorkoutPlan': instance.workoutPlan.toJson(),
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
    ..sortPosition = json['sortPosition'] as int
    ..roundNumber = json['roundNumber'] as int;
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
      'roundNumber': instance.roundNumber,
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
    roundNumber: json['roundNumber'] as int,
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
      'roundNumber': instance.roundNumber,
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
    ..sortPosition = json['sortPosition'] as int
    ..roundNumber = json['roundNumber'] as int;
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
      'roundNumber': instance.roundNumber,
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

UserWorkoutPlans$Query _$UserWorkoutPlans$QueryFromJson(
    Map<String, dynamic> json) {
  return UserWorkoutPlans$Query()
    ..userWorkoutPlans = (json['userWorkoutPlans'] as List<dynamic>)
        .map((e) => WorkoutPlan.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkoutPlans$QueryToJson(
        UserWorkoutPlans$Query instance) =>
    <String, dynamic>{
      'userWorkoutPlans':
          instance.userWorkoutPlans.map((e) => e.toJson()).toList(),
    };

PublicWorkoutPlans$Query _$PublicWorkoutPlans$QueryFromJson(
    Map<String, dynamic> json) {
  return PublicWorkoutPlans$Query()
    ..publicWorkoutPlans = (json['publicWorkoutPlans'] as List<dynamic>)
        .map((e) => WorkoutPlan.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PublicWorkoutPlans$QueryToJson(
        PublicWorkoutPlans$Query instance) =>
    <String, dynamic>{
      'publicWorkoutPlans':
          instance.publicWorkoutPlans.map((e) => e.toJson()).toList(),
    };

WorkoutPlanFiltersInput _$WorkoutPlanFiltersInputFromJson(
    Map<String, dynamic> json) {
  return WorkoutPlanFiltersInput(
    difficultyLevel: _$enumDecodeNullable(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown),
    lengthWeeks: json['lengthWeeks'] as int?,
    daysPerWeek: json['daysPerWeek'] as int?,
    workoutGoals: (json['workoutGoals'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    bodyweightOnly: json['bodyweightOnly'] as bool?,
  );
}

Map<String, dynamic> _$WorkoutPlanFiltersInputToJson(
        WorkoutPlanFiltersInput instance) =>
    <String, dynamic>{
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'lengthWeeks': instance.lengthWeeks,
      'daysPerWeek': instance.daysPerWeek,
      'workoutGoals': instance.workoutGoals,
      'bodyweightOnly': instance.bodyweightOnly,
    };

WorkoutPlanById$Query _$WorkoutPlanById$QueryFromJson(
    Map<String, dynamic> json) {
  return WorkoutPlanById$Query()
    ..workoutPlanById =
        WorkoutPlan.fromJson(json['workoutPlanById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutPlanById$QueryToJson(
        WorkoutPlanById$Query instance) =>
    <String, dynamic>{
      'workoutPlanById': instance.workoutPlanById.toJson(),
    };

UpdateWorkoutPlan _$UpdateWorkoutPlanFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutPlan()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..lengthWeeks = json['lengthWeeks'] as int
    ..daysPerWeek = json['daysPerWeek'] as int
    ..coverImageUri = json['coverImageUri'] as String?
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..contentAccessScope = _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown)
    ..workoutTags = (json['WorkoutTags'] as List<dynamic>)
        .map((e) => WorkoutTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UpdateWorkoutPlanToJson(UpdateWorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'lengthWeeks': instance.lengthWeeks,
      'daysPerWeek': instance.daysPerWeek,
      'coverImageUri': instance.coverImageUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'WorkoutTags': instance.workoutTags.map((e) => e.toJson()).toList(),
    };

UpdateWorkoutPlan$Mutation _$UpdateWorkoutPlan$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlan$Mutation()
    ..updateWorkoutPlan = UpdateWorkoutPlan.fromJson(
        json['updateWorkoutPlan'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutPlan$MutationToJson(
        UpdateWorkoutPlan$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutPlan': instance.updateWorkoutPlan.toJson(),
    };

UpdateWorkoutPlanInput _$UpdateWorkoutPlanInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanInput(
    id: json['id'] as String,
    archived: json['archived'] as bool?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    lengthWeeks: json['lengthWeeks'] as int?,
    daysPerWeek: json['daysPerWeek'] as int?,
    coverImageUri: json['coverImageUri'] as String?,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    introAudioUri: json['introAudioUri'] as String?,
    contentAccessScope: _$enumDecodeNullable(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown),
    workoutTags: (json['WorkoutTags'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanInputToJson(
        UpdateWorkoutPlanInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'lengthWeeks': instance.lengthWeeks,
      'daysPerWeek': instance.daysPerWeek,
      'coverImageUri': instance.coverImageUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'WorkoutTags': instance.workoutTags?.map((e) => e.toJson()).toList(),
    };

CreateWorkoutPlan _$CreateWorkoutPlanFromJson(Map<String, dynamic> json) {
  return CreateWorkoutPlan()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..lengthWeeks = json['lengthWeeks'] as int
    ..daysPerWeek = json['daysPerWeek'] as int
    ..coverImageUri = json['coverImageUri'] as String?
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..contentAccessScope = _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown)
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutPlanToJson(CreateWorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'lengthWeeks': instance.lengthWeeks,
      'daysPerWeek': instance.daysPerWeek,
      'coverImageUri': instance.coverImageUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'User': instance.user.toJson(),
    };

CreateWorkoutPlan$Mutation _$CreateWorkoutPlan$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutPlan$Mutation()
    ..createWorkoutPlan = CreateWorkoutPlan.fromJson(
        json['createWorkoutPlan'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutPlan$MutationToJson(
        CreateWorkoutPlan$Mutation instance) =>
    <String, dynamic>{
      'createWorkoutPlan': instance.createWorkoutPlan.toJson(),
    };

CreateWorkoutPlanInput _$CreateWorkoutPlanInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutPlanInput(
    name: json['name'] as String,
    contentAccessScope: _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanInputToJson(
        CreateWorkoutPlanInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..bio = json['bio'] as String?
    ..birthdate = fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['birthdate'] as int?)
    ..countryCode = json['countryCode'] as String?
    ..displayName = json['displayName'] as String?
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..gender = _$enumDecode(_$GenderEnumMap, json['gender'],
        unknownValue: Gender.artemisUnknown)
    ..userProfileScope = _$enumDecode(
        _$UserProfileScopeEnumMap, json['userProfileScope'],
        unknownValue: UserProfileScope.artemisUnknown);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'bio': instance.bio,
      'birthdate':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.birthdate),
      'countryCode': instance.countryCode,
      'displayName': instance.displayName,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'gender': _$GenderEnumMap[instance.gender],
      'userProfileScope': _$UserProfileScopeEnumMap[instance.userProfileScope],
    };

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.nonbinary: 'NONBINARY',
  Gender.pnts: 'PNTS',
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
    birthdate: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['birthdate'] as int?),
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
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.birthdate),
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

UserPublicProfileSummary _$UserPublicProfileSummaryFromJson(
    Map<String, dynamic> json) {
  return UserPublicProfileSummary()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..tagline = json['tagline'] as String?
    ..townCity = json['townCity'] as String?
    ..countryCode = json['countryCode'] as String?
    ..displayName = json['displayName'] as String?
    ..numberPublicWorkouts = json['numberPublicWorkouts'] as int
    ..numberPublicPlans = json['numberPublicPlans'] as int;
}

Map<String, dynamic> _$UserPublicProfileSummaryToJson(
        UserPublicProfileSummary instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'tagline': instance.tagline,
      'townCity': instance.townCity,
      'countryCode': instance.countryCode,
      'displayName': instance.displayName,
      'numberPublicWorkouts': instance.numberPublicWorkouts,
      'numberPublicPlans': instance.numberPublicPlans,
    };

UserPublicProfiles$Query _$UserPublicProfiles$QueryFromJson(
    Map<String, dynamic> json) {
  return UserPublicProfiles$Query()
    ..userPublicProfiles = (json['userPublicProfiles'] as List<dynamic>)
        .map(
            (e) => UserPublicProfileSummary.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserPublicProfiles$QueryToJson(
        UserPublicProfiles$Query instance) =>
    <String, dynamic>{
      'userPublicProfiles':
          instance.userPublicProfiles.map((e) => e.toJson()).toList(),
    };

UserPublicProfile _$UserPublicProfileFromJson(Map<String, dynamic> json) {
  return UserPublicProfile()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..bio = json['bio'] as String?
    ..tagline = json['tagline'] as String?
    ..townCity = json['townCity'] as String?
    ..instagramUrl = json['instagramUrl'] as String?
    ..tiktokUrl = json['tiktokUrl'] as String?
    ..youtubeUrl = json['youtubeUrl'] as String?
    ..snapUrl = json['snapUrl'] as String?
    ..linkedinUrl = json['linkedinUrl'] as String?
    ..countryCode = json['countryCode'] as String?
    ..displayName = json['displayName'] as String?
    ..workouts = (json['Workouts'] as List<dynamic>)
        .map((e) => Workout.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutPlans = (json['WorkoutPlans'] as List<dynamic>)
        .map((e) => WorkoutPlan.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserPublicProfileToJson(UserPublicProfile instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'bio': instance.bio,
      'tagline': instance.tagline,
      'townCity': instance.townCity,
      'instagramUrl': instance.instagramUrl,
      'tiktokUrl': instance.tiktokUrl,
      'youtubeUrl': instance.youtubeUrl,
      'snapUrl': instance.snapUrl,
      'linkedinUrl': instance.linkedinUrl,
      'countryCode': instance.countryCode,
      'displayName': instance.displayName,
      'Workouts': instance.workouts.map((e) => e.toJson()).toList(),
      'WorkoutPlans': instance.workoutPlans.map((e) => e.toJson()).toList(),
    };

UserPublicProfileById$Query _$UserPublicProfileById$QueryFromJson(
    Map<String, dynamic> json) {
  return UserPublicProfileById$Query()
    ..userPublicProfileById = UserPublicProfile.fromJson(
        json['userPublicProfileById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserPublicProfileById$QueryToJson(
        UserPublicProfileById$Query instance) =>
    <String, dynamic>{
      'userPublicProfileById': instance.userPublicProfileById.toJson(),
    };

DeleteWorkoutTagById$Mutation _$DeleteWorkoutTagById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutTagById$Mutation()
    ..deleteWorkoutTagById = json['deleteWorkoutTagById'] as String;
}

Map<String, dynamic> _$DeleteWorkoutTagById$MutationToJson(
        DeleteWorkoutTagById$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkoutTagById': instance.deleteWorkoutTagById,
    };

UpdateWorkoutTag$Mutation _$UpdateWorkoutTag$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutTag$Mutation()
    ..updateWorkoutTag =
        WorkoutTag.fromJson(json['updateWorkoutTag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkoutTag$MutationToJson(
        UpdateWorkoutTag$Mutation instance) =>
    <String, dynamic>{
      'updateWorkoutTag': instance.updateWorkoutTag.toJson(),
    };

UpdateWorkoutTagInput _$UpdateWorkoutTagInputFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutTagInput(
    id: json['id'] as String,
    tag: json['tag'] as String,
  );
}

Map<String, dynamic> _$UpdateWorkoutTagInputToJson(
        UpdateWorkoutTagInput instance) =>
    <String, dynamic>{
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
    ..repScore = json['repScore'] as int?
    ..timeTakenMs = json['timeTakenMs'] as int?
    ..lapTimesMs = fromGraphQLJsonToDartMap(json['lapTimesMs'])
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
      'repScore': instance.repScore,
      'timeTakenMs': instance.timeTakenMs,
      'lapTimesMs': fromDartMapToGraphQLJson(instance.lapTimesMs),
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
    timeTakenMs: json['timeTakenMs'] as int?,
    lapTimesMs: fromGraphQLJsonNullableToDartMapNullable(json['lapTimesMs']),
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
      'timeTakenMs': instance.timeTakenMs,
      'lapTimesMs':
          fromDartMapNullableToGraphQLJsonNullable(instance.lapTimesMs),
      'timecap': instance.timecap,
      'repScore': instance.repScore,
      'note': instance.note,
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

DeleteBodyTransformationPhotosById$Mutation
    _$DeleteBodyTransformationPhotosById$MutationFromJson(
        Map<String, dynamic> json) {
  return DeleteBodyTransformationPhotosById$Mutation()
    ..deleteBodyTransformationPhotosById =
        (json['deleteBodyTransformationPhotosById'] as List<dynamic>)
            .map((e) => e as String)
            .toList();
}

Map<String, dynamic> _$DeleteBodyTransformationPhotosById$MutationToJson(
        DeleteBodyTransformationPhotosById$Mutation instance) =>
    <String, dynamic>{
      'deleteBodyTransformationPhotosById':
          instance.deleteBodyTransformationPhotosById,
    };

BodyTransformationPhoto _$BodyTransformationPhotoFromJson(
    Map<String, dynamic> json) {
  return BodyTransformationPhoto()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..takenOnDate =
        fromGraphQLDateTimeToDartDateTime(json['takenOnDate'] as int)
    ..bodyweight = (json['bodyweight'] as num?)?.toDouble()
    ..note = json['note'] as String?
    ..photoUri = json['photoUri'] as String;
}

Map<String, dynamic> _$BodyTransformationPhotoToJson(
        BodyTransformationPhoto instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'takenOnDate': fromDartDateTimeToGraphQLDateTime(instance.takenOnDate),
      'bodyweight': instance.bodyweight,
      'note': instance.note,
      'photoUri': instance.photoUri,
    };

UpdateBodyTransformationPhoto$Mutation
    _$UpdateBodyTransformationPhoto$MutationFromJson(
        Map<String, dynamic> json) {
  return UpdateBodyTransformationPhoto$Mutation()
    ..updateBodyTransformationPhoto = BodyTransformationPhoto.fromJson(
        json['updateBodyTransformationPhoto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateBodyTransformationPhoto$MutationToJson(
        UpdateBodyTransformationPhoto$Mutation instance) =>
    <String, dynamic>{
      'updateBodyTransformationPhoto':
          instance.updateBodyTransformationPhoto.toJson(),
    };

UpdateBodyTransformationPhotoInput _$UpdateBodyTransformationPhotoInputFromJson(
    Map<String, dynamic> json) {
  return UpdateBodyTransformationPhotoInput(
    id: json['id'] as String,
    takenOnDate: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['takenOnDate'] as int?),
    bodyweight: (json['bodyweight'] as num?)?.toDouble(),
    note: json['note'] as String?,
    photoUri: json['photoUri'] as String?,
  );
}

Map<String, dynamic> _$UpdateBodyTransformationPhotoInputToJson(
        UpdateBodyTransformationPhotoInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'takenOnDate': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.takenOnDate),
      'bodyweight': instance.bodyweight,
      'note': instance.note,
      'photoUri': instance.photoUri,
    };

CreateBodyTransformationPhotos$Mutation
    _$CreateBodyTransformationPhotos$MutationFromJson(
        Map<String, dynamic> json) {
  return CreateBodyTransformationPhotos$Mutation()
    ..createBodyTransformationPhotos = (json['createBodyTransformationPhotos']
            as List<dynamic>)
        .map((e) => BodyTransformationPhoto.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CreateBodyTransformationPhotos$MutationToJson(
        CreateBodyTransformationPhotos$Mutation instance) =>
    <String, dynamic>{
      'createBodyTransformationPhotos': instance.createBodyTransformationPhotos
          .map((e) => e.toJson())
          .toList(),
    };

CreateBodyTransformationPhotoInput _$CreateBodyTransformationPhotoInputFromJson(
    Map<String, dynamic> json) {
  return CreateBodyTransformationPhotoInput(
    takenOnDate: fromGraphQLDateTimeToDartDateTime(json['takenOnDate'] as int),
    bodyweight: (json['bodyweight'] as num?)?.toDouble(),
    note: json['note'] as String?,
    photoUri: json['photoUri'] as String,
  );
}

Map<String, dynamic> _$CreateBodyTransformationPhotoInputToJson(
        CreateBodyTransformationPhotoInput instance) =>
    <String, dynamic>{
      'takenOnDate': fromDartDateTimeToGraphQLDateTime(instance.takenOnDate),
      'bodyweight': instance.bodyweight,
      'note': instance.note,
      'photoUri': instance.photoUri,
    };

BodyTransformationPhotos$Query _$BodyTransformationPhotos$QueryFromJson(
    Map<String, dynamic> json) {
  return BodyTransformationPhotos$Query()
    ..bodyTransformationPhotos = (json['bodyTransformationPhotos']
            as List<dynamic>)
        .map((e) => BodyTransformationPhoto.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$BodyTransformationPhotos$QueryToJson(
        BodyTransformationPhotos$Query instance) =>
    <String, dynamic>{
      'bodyTransformationPhotos':
          instance.bodyTransformationPhotos.map((e) => e.toJson()).toList(),
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

DeleteUserBenchmarkTagById$Mutation
    _$DeleteUserBenchmarkTagById$MutationFromJson(Map<String, dynamic> json) {
  return DeleteUserBenchmarkTagById$Mutation()
    ..deleteUserBenchmarkTagById = json['deleteUserBenchmarkTagById'] as String;
}

Map<String, dynamic> _$DeleteUserBenchmarkTagById$MutationToJson(
        DeleteUserBenchmarkTagById$Mutation instance) =>
    <String, dynamic>{
      'deleteUserBenchmarkTagById': instance.deleteUserBenchmarkTagById,
    };

UserBenchmarkEntry _$UserBenchmarkEntryFromJson(Map<String, dynamic> json) {
  return UserBenchmarkEntry()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..completedOn =
        fromGraphQLDateTimeToDartDateTime(json['completedOn'] as int)
    ..score = (json['score'] as num).toDouble()
    ..note = json['note'] as String?
    ..videoUri = json['videoUri'] as String?
    ..videoThumbUri = json['videoThumbUri'] as String?;
}

Map<String, dynamic> _$UserBenchmarkEntryToJson(UserBenchmarkEntry instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'completedOn': fromDartDateTimeToGraphQLDateTime(instance.completedOn),
      'score': instance.score,
      'note': instance.note,
      'videoUri': instance.videoUri,
      'videoThumbUri': instance.videoThumbUri,
    };

CreateUserBenchmarkEntry$Mutation _$CreateUserBenchmarkEntry$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkEntry$Mutation()
    ..createUserBenchmarkEntry = UserBenchmarkEntry.fromJson(
        json['createUserBenchmarkEntry'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateUserBenchmarkEntry$MutationToJson(
        CreateUserBenchmarkEntry$Mutation instance) =>
    <String, dynamic>{
      'createUserBenchmarkEntry': instance.createUserBenchmarkEntry.toJson(),
    };

CreateUserBenchmarkEntryInput _$CreateUserBenchmarkEntryInputFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkEntryInput(
    completedOn: fromGraphQLDateTimeToDartDateTime(json['completedOn'] as int),
    score: (json['score'] as num).toDouble(),
    note: json['note'] as String?,
    videoUri: json['videoUri'] as String?,
    videoThumbUri: json['videoThumbUri'] as String?,
    userBenchmark: ConnectRelationInput.fromJson(
        json['UserBenchmark'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateUserBenchmarkEntryInputToJson(
        CreateUserBenchmarkEntryInput instance) =>
    <String, dynamic>{
      'completedOn': fromDartDateTimeToGraphQLDateTime(instance.completedOn),
      'score': instance.score,
      'note': instance.note,
      'videoUri': instance.videoUri,
      'videoThumbUri': instance.videoThumbUri,
      'UserBenchmark': instance.userBenchmark.toJson(),
    };

UserBenchmarkTag _$UserBenchmarkTagFromJson(Map<String, dynamic> json) {
  return UserBenchmarkTag()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String?;
}

Map<String, dynamic> _$UserBenchmarkTagToJson(UserBenchmarkTag instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

CreateUserBenchmarkTag$Mutation _$CreateUserBenchmarkTag$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkTag$Mutation()
    ..createUserBenchmarkTag = UserBenchmarkTag.fromJson(
        json['createUserBenchmarkTag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateUserBenchmarkTag$MutationToJson(
        CreateUserBenchmarkTag$Mutation instance) =>
    <String, dynamic>{
      'createUserBenchmarkTag': instance.createUserBenchmarkTag.toJson(),
    };

CreateUserBenchmarkTagInput _$CreateUserBenchmarkTagInputFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkTagInput(
    name: json['name'] as String,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$CreateUserBenchmarkTagInputToJson(
        CreateUserBenchmarkTagInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

UserBenchmarkTags$Query _$UserBenchmarkTags$QueryFromJson(
    Map<String, dynamic> json) {
  return UserBenchmarkTags$Query()
    ..userBenchmarkTags = (json['userBenchmarkTags'] as List<dynamic>)
        .map((e) => UserBenchmarkTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserBenchmarkTags$QueryToJson(
        UserBenchmarkTags$Query instance) =>
    <String, dynamic>{
      'userBenchmarkTags':
          instance.userBenchmarkTags.map((e) => e.toJson()).toList(),
    };

UpdateUserBenchmarkTag$Mutation _$UpdateUserBenchmarkTag$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkTag$Mutation()
    ..updateUserBenchmarkTag = UserBenchmarkTag.fromJson(
        json['updateUserBenchmarkTag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateUserBenchmarkTag$MutationToJson(
        UpdateUserBenchmarkTag$Mutation instance) =>
    <String, dynamic>{
      'updateUserBenchmarkTag': instance.updateUserBenchmarkTag.toJson(),
    };

UpdateUserBenchmarkTagInput _$UpdateUserBenchmarkTagInputFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkTagInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$UpdateUserBenchmarkTagInputToJson(
        UpdateUserBenchmarkTagInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

UpdateUserBenchmarkEntry$Mutation _$UpdateUserBenchmarkEntry$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkEntry$Mutation()
    ..updateUserBenchmarkEntry = UserBenchmarkEntry.fromJson(
        json['updateUserBenchmarkEntry'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateUserBenchmarkEntry$MutationToJson(
        UpdateUserBenchmarkEntry$Mutation instance) =>
    <String, dynamic>{
      'updateUserBenchmarkEntry': instance.updateUserBenchmarkEntry.toJson(),
    };

UpdateUserBenchmarkEntryInput _$UpdateUserBenchmarkEntryInputFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkEntryInput(
    id: json['id'] as String,
    completedOn: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['completedOn'] as int?),
    score: (json['score'] as num?)?.toDouble(),
    note: json['note'] as String?,
    videoUri: json['videoUri'] as String?,
    videoThumbUri: json['videoThumbUri'] as String?,
  );
}

Map<String, dynamic> _$UpdateUserBenchmarkEntryInputToJson(
        UpdateUserBenchmarkEntryInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'completedOn': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.completedOn),
      'score': instance.score,
      'note': instance.note,
      'videoUri': instance.videoUri,
      'videoThumbUri': instance.videoThumbUri,
    };

DeleteUserBenchmarkEntryById$Mutation
    _$DeleteUserBenchmarkEntryById$MutationFromJson(Map<String, dynamic> json) {
  return DeleteUserBenchmarkEntryById$Mutation()
    ..deleteUserBenchmarkEntryById =
        json['deleteUserBenchmarkEntryById'] as String;
}

Map<String, dynamic> _$DeleteUserBenchmarkEntryById$MutationToJson(
        DeleteUserBenchmarkEntryById$Mutation instance) =>
    <String, dynamic>{
      'deleteUserBenchmarkEntryById': instance.deleteUserBenchmarkEntryById,
    };

UserBenchmark _$UserBenchmarkFromJson(Map<String, dynamic> json) {
  return UserBenchmark()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..lastEntryAt =
        fromGraphQLDateTimeToDartDateTime(json['lastEntryAt'] as int)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..equipmentInfo = json['equipmentInfo'] as String?
    ..benchmarkType = _$enumDecode(
        _$BenchmarkTypeEnumMap, json['benchmarkType'],
        unknownValue: BenchmarkType.artemisUnknown)
    ..loadUnit = _$enumDecode(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown)
    ..userBenchmarkEntries = (json['UserBenchmarkEntries'] as List<dynamic>)
        .map((e) => UserBenchmarkEntry.fromJson(e as Map<String, dynamic>))
        .toList()
    ..userBenchmarkTags = (json['UserBenchmarkTags'] as List<dynamic>)
        .map((e) => UserBenchmarkTag.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserBenchmarkToJson(UserBenchmark instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'lastEntryAt': fromDartDateTimeToGraphQLDateTime(instance.lastEntryAt),
      'name': instance.name,
      'description': instance.description,
      'equipmentInfo': instance.equipmentInfo,
      'benchmarkType': _$BenchmarkTypeEnumMap[instance.benchmarkType],
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'UserBenchmarkEntries':
          instance.userBenchmarkEntries.map((e) => e.toJson()).toList(),
      'UserBenchmarkTags':
          instance.userBenchmarkTags.map((e) => e.toJson()).toList(),
    };

const _$BenchmarkTypeEnumMap = {
  BenchmarkType.amrap: 'AMRAP',
  BenchmarkType.maxload: 'MAXLOAD',
  BenchmarkType.fastesttime: 'FASTESTTIME',
  BenchmarkType.unbrokenreps: 'UNBROKENREPS',
  BenchmarkType.unbrokentime: 'UNBROKENTIME',
  BenchmarkType.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

UpdateUserBenchmark$Mutation _$UpdateUserBenchmark$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmark$Mutation()
    ..updateUserBenchmark = UserBenchmark.fromJson(
        json['updateUserBenchmark'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateUserBenchmark$MutationToJson(
        UpdateUserBenchmark$Mutation instance) =>
    <String, dynamic>{
      'updateUserBenchmark': instance.updateUserBenchmark.toJson(),
    };

UpdateUserBenchmarkInput _$UpdateUserBenchmarkInputFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkInput(
    id: json['id'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
    equipmentInfo: json['equipmentInfo'] as String?,
    benchmarkType: _$enumDecode(_$BenchmarkTypeEnumMap, json['benchmarkType'],
        unknownValue: BenchmarkType.artemisUnknown),
    loadUnit: _$enumDecodeNullable(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown),
    userBenchmarkTags: (json['UserBenchmarkTags'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UpdateUserBenchmarkInputToJson(
        UpdateUserBenchmarkInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'equipmentInfo': instance.equipmentInfo,
      'benchmarkType': _$BenchmarkTypeEnumMap[instance.benchmarkType],
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'UserBenchmarkTags':
          instance.userBenchmarkTags?.map((e) => e.toJson()).toList(),
    };

CreateUserBenchmark$Mutation _$CreateUserBenchmark$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmark$Mutation()
    ..createUserBenchmark = UserBenchmark.fromJson(
        json['createUserBenchmark'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateUserBenchmark$MutationToJson(
        CreateUserBenchmark$Mutation instance) =>
    <String, dynamic>{
      'createUserBenchmark': instance.createUserBenchmark.toJson(),
    };

CreateUserBenchmarkInput _$CreateUserBenchmarkInputFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkInput(
    name: json['name'] as String,
    description: json['description'] as String?,
    equipmentInfo: json['equipmentInfo'] as String?,
    benchmarkType: _$enumDecode(_$BenchmarkTypeEnumMap, json['benchmarkType'],
        unknownValue: BenchmarkType.artemisUnknown),
    loadUnit: _$enumDecodeNullable(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown),
    userBenchmarkTags: (json['UserBenchmarkTags'] as List<dynamic>?)
        ?.map((e) => ConnectRelationInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateUserBenchmarkInputToJson(
        CreateUserBenchmarkInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'equipmentInfo': instance.equipmentInfo,
      'benchmarkType': _$BenchmarkTypeEnumMap[instance.benchmarkType],
      'loadUnit': _$LoadUnitEnumMap[instance.loadUnit],
      'UserBenchmarkTags':
          instance.userBenchmarkTags?.map((e) => e.toJson()).toList(),
    };

DeleteUserBenchmarkById$Mutation _$DeleteUserBenchmarkById$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteUserBenchmarkById$Mutation()
    ..deleteUserBenchmarkById = json['deleteUserBenchmarkById'] as String;
}

Map<String, dynamic> _$DeleteUserBenchmarkById$MutationToJson(
        DeleteUserBenchmarkById$Mutation instance) =>
    <String, dynamic>{
      'deleteUserBenchmarkById': instance.deleteUserBenchmarkById,
    };

UserBenchmarks$Query _$UserBenchmarks$QueryFromJson(Map<String, dynamic> json) {
  return UserBenchmarks$Query()
    ..userBenchmarks = (json['userBenchmarks'] as List<dynamic>)
        .map((e) => UserBenchmark.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserBenchmarks$QueryToJson(
        UserBenchmarks$Query instance) =>
    <String, dynamic>{
      'userBenchmarks': instance.userBenchmarks.map((e) => e.toJson()).toList(),
    };

UserBenchmarkById$Query _$UserBenchmarkById$QueryFromJson(
    Map<String, dynamic> json) {
  return UserBenchmarkById$Query()
    ..userBenchmarkById = UserBenchmark.fromJson(
        json['userBenchmarkById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserBenchmarkById$QueryToJson(
        UserBenchmarkById$Query instance) =>
    <String, dynamic>{
      'userBenchmarkById': instance.userBenchmarkById.toJson(),
    };

TextSearchWorkoutPlans$Query _$TextSearchWorkoutPlans$QueryFromJson(
    Map<String, dynamic> json) {
  return TextSearchWorkoutPlans$Query()
    ..textSearchWorkoutPlans =
        (json['textSearchWorkoutPlans'] as List<dynamic>?)
            ?.map((e) => WorkoutPlan.fromJson(e as Map<String, dynamic>))
            .toList();
}

Map<String, dynamic> _$TextSearchWorkoutPlans$QueryToJson(
        TextSearchWorkoutPlans$Query instance) =>
    <String, dynamic>{
      'textSearchWorkoutPlans':
          instance.textSearchWorkoutPlans?.map((e) => e.toJson()).toList(),
    };

TextSearchResult _$TextSearchResultFromJson(Map<String, dynamic> json) {
  return TextSearchResult()
    ..id = json['id'] as String
    ..$$typename = json['__typename'] as String?
    ..name = json['name'] as String;
}

Map<String, dynamic> _$TextSearchResultToJson(TextSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.$$typename,
      'name': instance.name,
    };

TextSearchWorkoutPlanNames$Query _$TextSearchWorkoutPlanNames$QueryFromJson(
    Map<String, dynamic> json) {
  return TextSearchWorkoutPlanNames$Query()
    ..textSearchWorkoutPlanNames =
        (json['textSearchWorkoutPlanNames'] as List<dynamic>?)
            ?.map((e) => TextSearchResult.fromJson(e as Map<String, dynamic>))
            .toList();
}

Map<String, dynamic> _$TextSearchWorkoutPlanNames$QueryToJson(
        TextSearchWorkoutPlanNames$Query instance) =>
    <String, dynamic>{
      'textSearchWorkoutPlanNames':
          instance.textSearchWorkoutPlanNames?.map((e) => e.toJson()).toList(),
    };

TextSearchWorkouts$Query _$TextSearchWorkouts$QueryFromJson(
    Map<String, dynamic> json) {
  return TextSearchWorkouts$Query()
    ..textSearchWorkouts = (json['textSearchWorkouts'] as List<dynamic>?)
        ?.map((e) => Workout.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$TextSearchWorkouts$QueryToJson(
        TextSearchWorkouts$Query instance) =>
    <String, dynamic>{
      'textSearchWorkouts':
          instance.textSearchWorkouts?.map((e) => e.toJson()).toList(),
    };

TextSearchWorkoutNames$Query _$TextSearchWorkoutNames$QueryFromJson(
    Map<String, dynamic> json) {
  return TextSearchWorkoutNames$Query()
    ..textSearchWorkoutNames =
        (json['textSearchWorkoutNames'] as List<dynamic>?)
            ?.map((e) => TextSearchResult.fromJson(e as Map<String, dynamic>))
            .toList();
}

Map<String, dynamic> _$TextSearchWorkoutNames$QueryToJson(
        TextSearchWorkoutNames$Query instance) =>
    <String, dynamic>{
      'textSearchWorkoutNames':
          instance.textSearchWorkoutNames?.map((e) => e.toJson()).toList(),
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
    ..gymProfile = json['GymProfile'] == null
        ? null
        : GymProfile.fromJson(json['GymProfile'] as Map<String, dynamic>)
    ..loggedWorkoutId = json['loggedWorkoutId'] as String?
    ..workoutPlanEnrolmentId = json['workoutPlanEnrolmentId'] as String?;
}

Map<String, dynamic> _$ScheduledWorkoutToJson(ScheduledWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'scheduledAt': fromDartDateTimeToGraphQLDateTime(instance.scheduledAt),
      'note': instance.note,
      'Workout': instance.workout?.toJson(),
      'GymProfile': instance.gymProfile?.toJson(),
      'loggedWorkoutId': instance.loggedWorkoutId,
      'workoutPlanEnrolmentId': instance.workoutPlanEnrolmentId,
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
    scheduledAt: fromGraphQLDateTimeNullableToDartDateTimeNullable(
        json['scheduledAt'] as int?),
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
    workoutPlanEnrolment: json['WorkoutPlanEnrolment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['WorkoutPlanEnrolment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateScheduledWorkoutInputToJson(
        UpdateScheduledWorkoutInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduledAt': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.scheduledAt),
      'note': instance.note,
      'Workout': instance.workout?.toJson(),
      'LoggedWorkout': instance.loggedWorkout?.toJson(),
      'GymProfile': instance.gymProfile?.toJson(),
      'WorkoutPlanEnrolment': instance.workoutPlanEnrolment?.toJson(),
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
    workoutPlanEnrolment: json['WorkoutPlanEnrolment'] == null
        ? null
        : ConnectRelationInput.fromJson(
            json['WorkoutPlanEnrolment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateScheduledWorkoutInputToJson(
        CreateScheduledWorkoutInput instance) =>
    <String, dynamic>{
      'scheduledAt': fromDartDateTimeToGraphQLDateTime(instance.scheduledAt),
      'note': instance.note,
      'Workout': instance.workout.toJson(),
      'GymProfile': instance.gymProfile?.toJson(),
      'WorkoutPlanEnrolment': instance.workoutPlanEnrolment?.toJson(),
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

ClubInviteTokenData _$ClubInviteTokenDataFromJson(Map<String, dynamic> json) {
  return ClubInviteTokenData()
    ..$$typename = json['__typename'] as String?
    ..token = json['token'] as String
    ..club = Club.fromJson(json['Club'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ClubInviteTokenDataToJson(
        ClubInviteTokenData instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'token': instance.token,
      'Club': instance.club.toJson(),
    };

InviteTokenError _$InviteTokenErrorFromJson(Map<String, dynamic> json) {
  return InviteTokenError()
    ..$$typename = json['__typename'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$InviteTokenErrorToJson(InviteTokenError instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'message': instance.message,
    };

CheckClubInviteTokenResult _$CheckClubInviteTokenResultFromJson(
    Map<String, dynamic> json) {
  return CheckClubInviteTokenResult()
    ..$$typename = json['__typename'] as String?;
}

Map<String, dynamic> _$CheckClubInviteTokenResultToJson(
        CheckClubInviteTokenResult instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
    };

CheckClubInviteToken$Query _$CheckClubInviteToken$QueryFromJson(
    Map<String, dynamic> json) {
  return CheckClubInviteToken$Query()
    ..checkClubInviteToken = CheckClubInviteTokenResult.fromJson(
        json['checkClubInviteToken'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CheckClubInviteToken$QueryToJson(
        CheckClubInviteToken$Query instance) =>
    <String, dynamic>{
      'checkClubInviteToken': instance.checkClubInviteToken.toJson(),
    };

PublicWorkouts$Query _$PublicWorkouts$QueryFromJson(Map<String, dynamic> json) {
  return PublicWorkouts$Query()
    ..publicWorkouts = (json['publicWorkouts'] as List<dynamic>)
        .map((e) => Workout.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PublicWorkouts$QueryToJson(
        PublicWorkouts$Query instance) =>
    <String, dynamic>{
      'publicWorkouts': instance.publicWorkouts.map((e) => e.toJson()).toList(),
    };

WorkoutFiltersInput _$WorkoutFiltersInputFromJson(Map<String, dynamic> json) {
  return WorkoutFiltersInput(
    difficultyLevel: _$enumDecodeNullable(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown),
    hasClassVideo: json['hasClassVideo'] as bool?,
    hasClassAudio: json['hasClassAudio'] as bool?,
    maxLength: json['maxLength'] as int?,
    minLength: json['minLength'] as int?,
    workoutSectionTypes: (json['workoutSectionTypes'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    workoutGoals: (json['workoutGoals'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    bodyweightOnly: json['bodyweightOnly'] as bool?,
    availableEquipments: (json['availableEquipments'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    requiredMoves: (json['requiredMoves'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    excludedMoves: (json['excludedMoves'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    targetedBodyAreas: (json['targetedBodyAreas'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$WorkoutFiltersInputToJson(
        WorkoutFiltersInput instance) =>
    <String, dynamic>{
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'hasClassVideo': instance.hasClassVideo,
      'hasClassAudio': instance.hasClassAudio,
      'maxLength': instance.maxLength,
      'minLength': instance.minLength,
      'workoutSectionTypes': instance.workoutSectionTypes,
      'workoutGoals': instance.workoutGoals,
      'bodyweightOnly': instance.bodyweightOnly,
      'availableEquipments': instance.availableEquipments,
      'requiredMoves': instance.requiredMoves,
      'excludedMoves': instance.excludedMoves,
      'targetedBodyAreas': instance.targetedBodyAreas,
    };

UpdateWorkout _$UpdateWorkoutFromJson(Map<String, dynamic> json) {
  return UpdateWorkout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..lengthMinutes = json['lengthMinutes'] as int?
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
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'lengthMinutes': instance.lengthMinutes,
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
    lengthMinutes: json['lengthMinutes'] as int?,
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
      'lengthMinutes': instance.lengthMinutes,
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
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as int)
    ..archived = json['archived'] as bool
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..lengthMinutes = json['lengthMinutes'] as int?
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
    ..user = UserSummary.fromJson(json['User'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkoutToJson(CreateWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'archived': instance.archived,
      'name': instance.name,
      'description': instance.description,
      'lengthMinutes': instance.lengthMinutes,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'coverImageUri': instance.coverImageUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'User': instance.user.toJson(),
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

UserAvatarData _$UserAvatarDataFromJson(Map<String, dynamic> json) {
  return UserAvatarData()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..displayName = json['displayName'] as String?;
}

Map<String, dynamic> _$UserAvatarDataToJson(UserAvatarData instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'displayName': instance.displayName,
    };

UserAvatars$Query _$UserAvatars$QueryFromJson(Map<String, dynamic> json) {
  return UserAvatars$Query()
    ..userAvatars = (json['userAvatars'] as List<dynamic>)
        .map((e) => UserAvatarData.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserAvatars$QueryToJson(UserAvatars$Query instance) =>
    <String, dynamic>{
      'userAvatars': instance.userAvatars.map((e) => e.toJson()).toList(),
    };

UserAvatarById$Query _$UserAvatarById$QueryFromJson(Map<String, dynamic> json) {
  return UserAvatarById$Query()
    ..userAvatarById =
        UserAvatarData.fromJson(json['userAvatarById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserAvatarById$QueryToJson(
        UserAvatarById$Query instance) =>
    <String, dynamic>{
      'userAvatarById': instance.userAvatarById.toJson(),
    };

CreateClubArguments _$CreateClubArgumentsFromJson(Map<String, dynamic> json) {
  return CreateClubArguments(
    data: CreateClubInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateClubArgumentsToJson(
        CreateClubArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteClubByIdArguments _$DeleteClubByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteClubByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteClubByIdArgumentsToJson(
        DeleteClubByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateClubArguments _$UpdateClubArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateClubArguments(
    data: UpdateClubInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateClubArgumentsToJson(
        UpdateClubArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

ClubByIdArguments _$ClubByIdArgumentsFromJson(Map<String, dynamic> json) {
  return ClubByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$ClubByIdArgumentsToJson(ClubByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateClubInviteTokenArguments _$UpdateClubInviteTokenArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateClubInviteTokenArguments(
    data: UpdateClubInviteTokenInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateClubInviteTokenArgumentsToJson(
        UpdateClubInviteTokenArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateClubInviteTokenArguments _$CreateClubInviteTokenArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateClubInviteTokenArguments(
    data: CreateClubInviteTokenInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateClubInviteTokenArgumentsToJson(
        CreateClubInviteTokenArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteClubInviteTokenByIdArguments _$DeleteClubInviteTokenByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteClubInviteTokenByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteClubInviteTokenByIdArgumentsToJson(
        DeleteClubInviteTokenByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
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

DeleteCollectionByIdArguments _$DeleteCollectionByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteCollectionByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteCollectionByIdArgumentsToJson(
        DeleteCollectionByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

AddWorkoutPlanToCollectionArguments
    _$AddWorkoutPlanToCollectionArgumentsFromJson(Map<String, dynamic> json) {
  return AddWorkoutPlanToCollectionArguments(
    data: AddWorkoutPlanToCollectionInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddWorkoutPlanToCollectionArgumentsToJson(
        AddWorkoutPlanToCollectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateCollectionArguments _$CreateCollectionArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateCollectionArguments(
    data: CreateCollectionInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateCollectionArgumentsToJson(
        CreateCollectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UserCollectionByIdArguments _$UserCollectionByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return UserCollectionByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$UserCollectionByIdArgumentsToJson(
        UserCollectionByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

AddWorkoutToCollectionArguments _$AddWorkoutToCollectionArgumentsFromJson(
    Map<String, dynamic> json) {
  return AddWorkoutToCollectionArguments(
    data: AddWorkoutToCollectionInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddWorkoutToCollectionArgumentsToJson(
        AddWorkoutToCollectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateCollectionArguments _$UpdateCollectionArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateCollectionArguments(
    data: UpdateCollectionInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateCollectionArgumentsToJson(
        UpdateCollectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

RemoveWorkoutPlanFromCollectionArguments
    _$RemoveWorkoutPlanFromCollectionArgumentsFromJson(
        Map<String, dynamic> json) {
  return RemoveWorkoutPlanFromCollectionArguments(
    data: RemoveWorkoutPlanFromCollectionInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RemoveWorkoutPlanFromCollectionArgumentsToJson(
        RemoveWorkoutPlanFromCollectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

RemoveWorkoutFromCollectionArguments
    _$RemoveWorkoutFromCollectionArgumentsFromJson(Map<String, dynamic> json) {
  return RemoveWorkoutFromCollectionArguments(
    data: RemoveWorkoutFromCollectionInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RemoveWorkoutFromCollectionArgumentsToJson(
        RemoveWorkoutFromCollectionArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

ReorderWorkoutPlanDayWorkoutsArguments
    _$ReorderWorkoutPlanDayWorkoutsArgumentsFromJson(
        Map<String, dynamic> json) {
  return ReorderWorkoutPlanDayWorkoutsArguments(
    data: (json['data'] as List<dynamic>)
        .map((e) => UpdateSortPositionInput.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReorderWorkoutPlanDayWorkoutsArgumentsToJson(
        ReorderWorkoutPlanDayWorkoutsArguments instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreateWorkoutPlanDayWorkoutArguments
    _$CreateWorkoutPlanDayWorkoutArgumentsFromJson(Map<String, dynamic> json) {
  return CreateWorkoutPlanDayWorkoutArguments(
    data: CreateWorkoutPlanDayWorkoutInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanDayWorkoutArgumentsToJson(
        CreateWorkoutPlanDayWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateWorkoutPlanDayWorkoutArguments
    _$UpdateWorkoutPlanDayWorkoutArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutPlanDayWorkoutArguments(
    data: UpdateWorkoutPlanDayWorkoutInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanDayWorkoutArgumentsToJson(
        UpdateWorkoutPlanDayWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteWorkoutPlanDayWorkoutByIdArguments
    _$DeleteWorkoutPlanDayWorkoutByIdArgumentsFromJson(
        Map<String, dynamic> json) {
  return DeleteWorkoutPlanDayWorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutPlanDayWorkoutByIdArgumentsToJson(
        DeleteWorkoutPlanDayWorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateWorkoutPlanEnrolmentArguments
    _$UpdateWorkoutPlanEnrolmentArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutPlanEnrolmentArguments(
    data: UpdateWorkoutPlanEnrolmentInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanEnrolmentArgumentsToJson(
        UpdateWorkoutPlanEnrolmentArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteWorkoutPlanEnrolmentByIdArguments
    _$DeleteWorkoutPlanEnrolmentByIdArgumentsFromJson(
        Map<String, dynamic> json) {
  return DeleteWorkoutPlanEnrolmentByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutPlanEnrolmentByIdArgumentsToJson(
        DeleteWorkoutPlanEnrolmentByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateWorkoutPlanEnrolmentArguments
    _$CreateWorkoutPlanEnrolmentArgumentsFromJson(Map<String, dynamic> json) {
  return CreateWorkoutPlanEnrolmentArguments(
    workoutPlanId: json['workoutPlanId'] as String,
  );
}

Map<String, dynamic> _$CreateWorkoutPlanEnrolmentArgumentsToJson(
        CreateWorkoutPlanEnrolmentArguments instance) =>
    <String, dynamic>{
      'workoutPlanId': instance.workoutPlanId,
    };

UserWorkoutPlanEnrolmentByIdArguments
    _$UserWorkoutPlanEnrolmentByIdArgumentsFromJson(Map<String, dynamic> json) {
  return UserWorkoutPlanEnrolmentByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$UserWorkoutPlanEnrolmentByIdArgumentsToJson(
        UserWorkoutPlanEnrolmentByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateProgressJournalGoalTagArguments
    _$UpdateProgressJournalGoalTagArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateProgressJournalGoalTagArguments(
    data: UpdateProgressJournalGoalTagInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateProgressJournalGoalTagArgumentsToJson(
        UpdateProgressJournalGoalTagArguments instance) =>
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

CreateProgressJournalEntryArguments
    _$CreateProgressJournalEntryArgumentsFromJson(Map<String, dynamic> json) {
  return CreateProgressJournalEntryArguments(
    data: CreateProgressJournalEntryInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateProgressJournalEntryArgumentsToJson(
        CreateProgressJournalEntryArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteProgressJournalByIdArguments _$DeleteProgressJournalByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteProgressJournalByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteProgressJournalByIdArgumentsToJson(
        DeleteProgressJournalByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateProgressJournalArguments _$CreateProgressJournalArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournalArguments(
    data: CreateProgressJournalInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateProgressJournalArgumentsToJson(
        CreateProgressJournalArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateProgressJournalArguments _$UpdateProgressJournalArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournalArguments(
    data: UpdateProgressJournalInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateProgressJournalArgumentsToJson(
        UpdateProgressJournalArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteProgressJournalEntryByIdArguments
    _$DeleteProgressJournalEntryByIdArgumentsFromJson(
        Map<String, dynamic> json) {
  return DeleteProgressJournalEntryByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteProgressJournalEntryByIdArgumentsToJson(
        DeleteProgressJournalEntryByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateProgressJournalEntryArguments
    _$UpdateProgressJournalEntryArgumentsFromJson(Map<String, dynamic> json) {
  return UpdateProgressJournalEntryArguments(
    data: UpdateProgressJournalEntryInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateProgressJournalEntryArgumentsToJson(
        UpdateProgressJournalEntryArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateProgressJournalGoalArguments _$CreateProgressJournalGoalArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateProgressJournalGoalArguments(
    data: CreateProgressJournalGoalInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateProgressJournalGoalArgumentsToJson(
        CreateProgressJournalGoalArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateProgressJournalGoalArguments _$UpdateProgressJournalGoalArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateProgressJournalGoalArguments(
    data: UpdateProgressJournalGoalInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateProgressJournalGoalArgumentsToJson(
        UpdateProgressJournalGoalArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateProgressJournalGoalTagArguments
    _$CreateProgressJournalGoalTagArgumentsFromJson(Map<String, dynamic> json) {
  return CreateProgressJournalGoalTagArguments(
    data: CreateProgressJournalGoalTagInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateProgressJournalGoalTagArgumentsToJson(
        CreateProgressJournalGoalTagArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteProgressJournalGoalByIdArguments
    _$DeleteProgressJournalGoalByIdArgumentsFromJson(
        Map<String, dynamic> json) {
  return DeleteProgressJournalGoalByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteProgressJournalGoalByIdArgumentsToJson(
        DeleteProgressJournalGoalByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

DeleteProgressJournalGoalTagByIdArguments
    _$DeleteProgressJournalGoalTagByIdArgumentsFromJson(
        Map<String, dynamic> json) {
  return DeleteProgressJournalGoalTagByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteProgressJournalGoalTagByIdArgumentsToJson(
        DeleteProgressJournalGoalTagByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

MoveWorkoutPlanDayToAnotherDayArguments
    _$MoveWorkoutPlanDayToAnotherDayArgumentsFromJson(
        Map<String, dynamic> json) {
  return MoveWorkoutPlanDayToAnotherDayArguments(
    data: MoveWorkoutPlanDayToAnotherDayInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MoveWorkoutPlanDayToAnotherDayArgumentsToJson(
        MoveWorkoutPlanDayToAnotherDayArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteWorkoutPlanDaysByIdArguments _$DeleteWorkoutPlanDaysByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutPlanDaysByIdArguments(
    ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$DeleteWorkoutPlanDaysByIdArgumentsToJson(
        DeleteWorkoutPlanDaysByIdArguments instance) =>
    <String, dynamic>{
      'ids': instance.ids,
    };

UpdateWorkoutPlanDayArguments _$UpdateWorkoutPlanDayArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanDayArguments(
    data: UpdateWorkoutPlanDayInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanDayArgumentsToJson(
        UpdateWorkoutPlanDayArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateWorkoutPlanDayWithWorkoutArguments
    _$CreateWorkoutPlanDayWithWorkoutArgumentsFromJson(
        Map<String, dynamic> json) {
  return CreateWorkoutPlanDayWithWorkoutArguments(
    data: CreateWorkoutPlanDayWithWorkoutInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanDayWithWorkoutArgumentsToJson(
        CreateWorkoutPlanDayWithWorkoutArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CopyWorkoutPlanDayToAnotherDayArguments
    _$CopyWorkoutPlanDayToAnotherDayArgumentsFromJson(
        Map<String, dynamic> json) {
  return CopyWorkoutPlanDayToAnotherDayArguments(
    data: CopyWorkoutPlanDayToAnotherDayInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CopyWorkoutPlanDayToAnotherDayArgumentsToJson(
        CopyWorkoutPlanDayToAnotherDayArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
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

UserLoggedWorkoutsArguments _$UserLoggedWorkoutsArgumentsFromJson(
    Map<String, dynamic> json) {
  return UserLoggedWorkoutsArguments(
    take: json['take'] as int?,
  );
}

Map<String, dynamic> _$UserLoggedWorkoutsArgumentsToJson(
        UserLoggedWorkoutsArguments instance) =>
    <String, dynamic>{
      'take': instance.take,
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

DeleteWorkoutPlanReviewByIdArguments
    _$DeleteWorkoutPlanReviewByIdArgumentsFromJson(Map<String, dynamic> json) {
  return DeleteWorkoutPlanReviewByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutPlanReviewByIdArgumentsToJson(
        DeleteWorkoutPlanReviewByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateWorkoutPlanReviewArguments _$UpdateWorkoutPlanReviewArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanReviewArguments(
    data: UpdateWorkoutPlanReviewInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanReviewArgumentsToJson(
        UpdateWorkoutPlanReviewArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateWorkoutPlanReviewArguments _$CreateWorkoutPlanReviewArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutPlanReviewArguments(
    data: CreateWorkoutPlanReviewInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanReviewArgumentsToJson(
        CreateWorkoutPlanReviewArguments instance) =>
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

PublicWorkoutPlansArguments _$PublicWorkoutPlansArgumentsFromJson(
    Map<String, dynamic> json) {
  return PublicWorkoutPlansArguments(
    cursor: json['cursor'] as String?,
    filters: json['filters'] == null
        ? null
        : WorkoutPlanFiltersInput.fromJson(
            json['filters'] as Map<String, dynamic>),
    take: json['take'] as int?,
  );
}

Map<String, dynamic> _$PublicWorkoutPlansArgumentsToJson(
        PublicWorkoutPlansArguments instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'filters': instance.filters?.toJson(),
      'take': instance.take,
    };

WorkoutPlanByIdArguments _$WorkoutPlanByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return WorkoutPlanByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$WorkoutPlanByIdArgumentsToJson(
        WorkoutPlanByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateWorkoutPlanArguments _$UpdateWorkoutPlanArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutPlanArguments(
    data: UpdateWorkoutPlanInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutPlanArgumentsToJson(
        UpdateWorkoutPlanArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateWorkoutPlanArguments _$CreateWorkoutPlanArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutPlanArguments(
    data: CreateWorkoutPlanInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutPlanArgumentsToJson(
        CreateWorkoutPlanArguments instance) =>
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

UserPublicProfilesArguments _$UserPublicProfilesArgumentsFromJson(
    Map<String, dynamic> json) {
  return UserPublicProfilesArguments(
    cursor: json['cursor'] as String?,
    take: json['take'] as int?,
  );
}

Map<String, dynamic> _$UserPublicProfilesArgumentsToJson(
        UserPublicProfilesArguments instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'take': instance.take,
    };

UserPublicProfileByIdArguments _$UserPublicProfileByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return UserPublicProfileByIdArguments(
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$UserPublicProfileByIdArgumentsToJson(
        UserPublicProfileByIdArguments instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };

DeleteWorkoutTagByIdArguments _$DeleteWorkoutTagByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutTagByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutTagByIdArgumentsToJson(
        DeleteWorkoutTagByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateWorkoutTagArguments _$UpdateWorkoutTagArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutTagArguments(
    data: UpdateWorkoutTagInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutTagArgumentsToJson(
        UpdateWorkoutTagArguments instance) =>
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

DeleteBodyTransformationPhotosByIdArguments
    _$DeleteBodyTransformationPhotosByIdArgumentsFromJson(
        Map<String, dynamic> json) {
  return DeleteBodyTransformationPhotosByIdArguments(
    ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$DeleteBodyTransformationPhotosByIdArgumentsToJson(
        DeleteBodyTransformationPhotosByIdArguments instance) =>
    <String, dynamic>{
      'ids': instance.ids,
    };

UpdateBodyTransformationPhotoArguments
    _$UpdateBodyTransformationPhotoArgumentsFromJson(
        Map<String, dynamic> json) {
  return UpdateBodyTransformationPhotoArguments(
    data: UpdateBodyTransformationPhotoInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateBodyTransformationPhotoArgumentsToJson(
        UpdateBodyTransformationPhotoArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateBodyTransformationPhotosArguments
    _$CreateBodyTransformationPhotosArgumentsFromJson(
        Map<String, dynamic> json) {
  return CreateBodyTransformationPhotosArguments(
    data: (json['data'] as List<dynamic>)
        .map((e) => CreateBodyTransformationPhotoInput.fromJson(
            e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateBodyTransformationPhotosArgumentsToJson(
        CreateBodyTransformationPhotosArguments instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
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

DeleteUserBenchmarkTagByIdArguments
    _$DeleteUserBenchmarkTagByIdArgumentsFromJson(Map<String, dynamic> json) {
  return DeleteUserBenchmarkTagByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteUserBenchmarkTagByIdArgumentsToJson(
        DeleteUserBenchmarkTagByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateUserBenchmarkEntryArguments _$CreateUserBenchmarkEntryArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkEntryArguments(
    data: CreateUserBenchmarkEntryInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateUserBenchmarkEntryArgumentsToJson(
        CreateUserBenchmarkEntryArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateUserBenchmarkTagArguments _$CreateUserBenchmarkTagArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkTagArguments(
    data: CreateUserBenchmarkTagInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateUserBenchmarkTagArgumentsToJson(
        CreateUserBenchmarkTagArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateUserBenchmarkTagArguments _$UpdateUserBenchmarkTagArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkTagArguments(
    data: UpdateUserBenchmarkTagInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateUserBenchmarkTagArgumentsToJson(
        UpdateUserBenchmarkTagArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdateUserBenchmarkEntryArguments _$UpdateUserBenchmarkEntryArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkEntryArguments(
    data: UpdateUserBenchmarkEntryInput.fromJson(
        json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateUserBenchmarkEntryArgumentsToJson(
        UpdateUserBenchmarkEntryArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteUserBenchmarkEntryByIdArguments
    _$DeleteUserBenchmarkEntryByIdArgumentsFromJson(Map<String, dynamic> json) {
  return DeleteUserBenchmarkEntryByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteUserBenchmarkEntryByIdArgumentsToJson(
        DeleteUserBenchmarkEntryByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateUserBenchmarkArguments _$UpdateUserBenchmarkArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateUserBenchmarkArguments(
    data:
        UpdateUserBenchmarkInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateUserBenchmarkArgumentsToJson(
        UpdateUserBenchmarkArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateUserBenchmarkArguments _$CreateUserBenchmarkArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateUserBenchmarkArguments(
    data:
        CreateUserBenchmarkInput.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateUserBenchmarkArgumentsToJson(
        CreateUserBenchmarkArguments instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

DeleteUserBenchmarkByIdArguments _$DeleteUserBenchmarkByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteUserBenchmarkByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteUserBenchmarkByIdArgumentsToJson(
        DeleteUserBenchmarkByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserBenchmarkByIdArguments _$UserBenchmarkByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return UserBenchmarkByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$UserBenchmarkByIdArgumentsToJson(
        UserBenchmarkByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

TextSearchWorkoutPlansArguments _$TextSearchWorkoutPlansArgumentsFromJson(
    Map<String, dynamic> json) {
  return TextSearchWorkoutPlansArguments(
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$TextSearchWorkoutPlansArgumentsToJson(
        TextSearchWorkoutPlansArguments instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

TextSearchWorkoutPlanNamesArguments
    _$TextSearchWorkoutPlanNamesArgumentsFromJson(Map<String, dynamic> json) {
  return TextSearchWorkoutPlanNamesArguments(
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$TextSearchWorkoutPlanNamesArgumentsToJson(
        TextSearchWorkoutPlanNamesArguments instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

TextSearchWorkoutsArguments _$TextSearchWorkoutsArgumentsFromJson(
    Map<String, dynamic> json) {
  return TextSearchWorkoutsArguments(
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$TextSearchWorkoutsArgumentsToJson(
        TextSearchWorkoutsArguments instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

TextSearchWorkoutNamesArguments _$TextSearchWorkoutNamesArgumentsFromJson(
    Map<String, dynamic> json) {
  return TextSearchWorkoutNamesArguments(
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$TextSearchWorkoutNamesArgumentsToJson(
        TextSearchWorkoutNamesArguments instance) =>
    <String, dynamic>{
      'text': instance.text,
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

CheckClubInviteTokenArguments _$CheckClubInviteTokenArgumentsFromJson(
    Map<String, dynamic> json) {
  return CheckClubInviteTokenArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$CheckClubInviteTokenArgumentsToJson(
        CheckClubInviteTokenArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

PublicWorkoutsArguments _$PublicWorkoutsArgumentsFromJson(
    Map<String, dynamic> json) {
  return PublicWorkoutsArguments(
    cursor: json['cursor'] as String?,
    filters: json['filters'] == null
        ? null
        : WorkoutFiltersInput.fromJson(json['filters'] as Map<String, dynamic>),
    take: json['take'] as int?,
  );
}

Map<String, dynamic> _$PublicWorkoutsArgumentsToJson(
        PublicWorkoutsArguments instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'filters': instance.filters?.toJson(),
      'take': instance.take,
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

UserAvatarsArguments _$UserAvatarsArgumentsFromJson(Map<String, dynamic> json) {
  return UserAvatarsArguments(
    ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$UserAvatarsArgumentsToJson(
        UserAvatarsArguments instance) =>
    <String, dynamic>{
      'ids': instance.ids,
    };

UserAvatarByIdArguments _$UserAvatarByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return UserAvatarByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$UserAvatarByIdArgumentsToJson(
        UserAvatarByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
