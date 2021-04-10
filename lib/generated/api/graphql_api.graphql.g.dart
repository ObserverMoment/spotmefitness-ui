// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..bio = json['bio'] as String?
    ..birthdate = fromGraphQLDateTimeToDartDateTime(json['birthdate'] as int?)
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
      'birthdate': fromDartDateTimeToGraphQLDateTime(instance.birthdate),
      'countryCode': instance.countryCode,
      'displayName': instance.displayName,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'gender': _$GenderEnumMap[instance.gender],
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
    birthdate: fromGraphQLDateTimeToDartDateTime(json['birthdate'] as int?),
    city: json['city'] as String?,
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
      'birthdate': fromDartDateTimeToGraphQLDateTime(instance.birthdate),
      'city': instance.city,
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
    equipments:
        (json['Equipments'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$CreateGymProfileInputToJson(
        CreateGymProfileInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'Equipments': instance.equipments,
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
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$UpdateGymProfileInputToJson(
        UpdateGymProfileInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'Equipments': instance.equipments,
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

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
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
    ..introAudioUri = json['introAudioUri'] as String?;
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'coverImageUri': instance.coverImageUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
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
  ContentAccessScope.official: 'OFFICIAL',
  ContentAccessScope.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

UpdateWorkout$Mutation _$UpdateWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkout$Mutation()
    ..updateWorkout =
        Workout.fromJson(json['updateWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkout$MutationToJson(
        UpdateWorkout$Mutation instance) =>
    <String, dynamic>{
      'updateWorkout': instance.updateWorkout.toJson(),
    };

UpdateWorkoutInput _$UpdateWorkoutInputFromJson(Map<String, dynamic> json) {
  return UpdateWorkoutInput(
    id: json['id'] as String,
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
        ?.map((e) => e as String)
        .toList(),
    workoutTags:
        (json['WorkoutTags'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$UpdateWorkoutInputToJson(UpdateWorkoutInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'coverImageUri': instance.coverImageUri,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'WorkoutGoals': instance.workoutGoals,
      'WorkoutTags': instance.workoutTags,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..displayName = json['displayName'] as String?;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'displayName': instance.displayName,
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

UserWorkoutsMove _$UserWorkoutsMoveFromJson(Map<String, dynamic> json) {
  return UserWorkoutsMove()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..requiredEquipments = (json['RequiredEquipments'] as List<dynamic>)
        .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkoutsMoveToJson(UserWorkoutsMove instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'RequiredEquipments':
          instance.requiredEquipments.map((e) => e.toJson()).toList(),
    };

UserWorkoutsWorkoutMoves _$UserWorkoutsWorkoutMovesFromJson(
    Map<String, dynamic> json) {
  return UserWorkoutsWorkoutMoves()
    ..equipment = json['Equipment'] == null
        ? null
        : Equipment.fromJson(json['Equipment'] as Map<String, dynamic>)
    ..userWorkoutsMove = UserWorkoutsMove.fromJson(
        json['UserWorkoutsMove'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserWorkoutsWorkoutMovesToJson(
        UserWorkoutsWorkoutMoves instance) =>
    <String, dynamic>{
      'Equipment': instance.equipment?.toJson(),
      'UserWorkoutsMove': instance.userWorkoutsMove.toJson(),
    };

UserWorkoutsWorkoutSets _$UserWorkoutsWorkoutSetsFromJson(
    Map<String, dynamic> json) {
  return UserWorkoutsWorkoutSets()
    ..userWorkoutsWorkoutMoves = (json['UserWorkoutsWorkoutMoves']
            as List<dynamic>)
        .map(
            (e) => UserWorkoutsWorkoutMoves.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkoutsWorkoutSetsToJson(
        UserWorkoutsWorkoutSets instance) =>
    <String, dynamic>{
      'UserWorkoutsWorkoutMoves':
          instance.userWorkoutsWorkoutMoves.map((e) => e.toJson()).toList(),
    };

UserWorkoutsWorkoutSections _$UserWorkoutsWorkoutSectionsFromJson(
    Map<String, dynamic> json) {
  return UserWorkoutsWorkoutSections()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..timecap = json['timecap'] as int?
    ..workoutSectionType = WorkoutSectionType.fromJson(
        json['WorkoutSectionType'] as Map<String, dynamic>)
    ..userWorkoutsWorkoutSets = (json['UserWorkoutsWorkoutSets']
            as List<dynamic>)
        .map((e) => UserWorkoutsWorkoutSets.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkoutsWorkoutSectionsToJson(
        UserWorkoutsWorkoutSections instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'timecap': instance.timecap,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
      'UserWorkoutsWorkoutSets':
          instance.userWorkoutsWorkoutSets.map((e) => e.toJson()).toList(),
    };

WorkoutSummary _$WorkoutSummaryFromJson(Map<String, dynamic> json) {
  return WorkoutSummary()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..difficultyLevel = _$enumDecode(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown)
    ..coverImageUri = json['coverImageUri'] as String?
    ..userInfo = json['UserInfo'] == null
        ? null
        : UserInfo.fromJson(json['UserInfo'] as Map<String, dynamic>)
    ..workoutGoals = (json['WorkoutGoals'] as List<dynamic>)
        .map((e) => WorkoutGoal.fromJson(e as Map<String, dynamic>))
        .toList()
    ..workoutTags = (json['WorkoutTags'] as List<dynamic>)
        .map((e) => WorkoutTag.fromJson(e as Map<String, dynamic>))
        .toList()
    ..userWorkoutsWorkoutSections =
        (json['UserWorkoutsWorkoutSections'] as List<dynamic>)
            .map((e) =>
                UserWorkoutsWorkoutSections.fromJson(e as Map<String, dynamic>))
            .toList();
}

Map<String, dynamic> _$WorkoutSummaryToJson(WorkoutSummary instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'coverImageUri': instance.coverImageUri,
      'UserInfo': instance.userInfo?.toJson(),
      'WorkoutGoals': instance.workoutGoals.map((e) => e.toJson()).toList(),
      'WorkoutTags': instance.workoutTags.map((e) => e.toJson()).toList(),
      'UserWorkoutsWorkoutSections':
          instance.userWorkoutsWorkoutSections.map((e) => e.toJson()).toList(),
    };

UserWorkouts$Query _$UserWorkouts$QueryFromJson(Map<String, dynamic> json) {
  return UserWorkouts$Query()
    ..workoutSummary = (json['WorkoutSummary'] as List<dynamic>)
        .map((e) => WorkoutSummary.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserWorkouts$QueryToJson(UserWorkouts$Query instance) =>
    <String, dynamic>{
      'WorkoutSummary': instance.workoutSummary.map((e) => e.toJson()).toList(),
    };

CreateWorkout$Mutation _$CreateWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkout$Mutation()
    ..createWorkout =
        Workout.fromJson(json['createWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkout$MutationToJson(
        CreateWorkout$Mutation instance) =>
    <String, dynamic>{
      'createWorkout': instance.createWorkout.toJson(),
    };

CreateWorkoutInput _$CreateWorkoutInputFromJson(Map<String, dynamic> json) {
  return CreateWorkoutInput(
    name: json['name'] as String,
    description: json['description'] as String?,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    introAudioUri: json['introAudioUri'] as String?,
    coverImageUri: json['coverImageUri'] as String?,
    difficultyLevel: _$enumDecode(
        _$DifficultyLevelEnumMap, json['difficultyLevel'],
        unknownValue: DifficultyLevel.artemisUnknown),
    contentAccessScope: _$enumDecode(
        _$ContentAccessScopeEnumMap, json['contentAccessScope'],
        unknownValue: ContentAccessScope.artemisUnknown),
    workoutSections: (json['WorkoutSections'] as List<dynamic>)
        .map((e) =>
            CreateWorkoutSectionInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    workoutGoals: (json['WorkoutGoals'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    workoutTags:
        (json['WorkoutTags'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$CreateWorkoutInputToJson(CreateWorkoutInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'coverImageUri': instance.coverImageUri,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'WorkoutSections':
          instance.workoutSections.map((e) => e.toJson()).toList(),
      'WorkoutGoals': instance.workoutGoals,
      'WorkoutTags': instance.workoutTags,
    };

CreateWorkoutSectionInput _$CreateWorkoutSectionInputFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutSectionInput(
    name: json['name'] as String?,
    notes: json['notes'] as String?,
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
    workoutSectionType: json['WorkoutSectionType'] as String,
    workout: json['Workout'] as String,
  );
}

Map<String, dynamic> _$CreateWorkoutSectionInputToJson(
        CreateWorkoutSectionInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
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
      'WorkoutSectionType': instance.workoutSectionType,
      'Workout': instance.workout,
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

BodyAreaMoveScore _$BodyAreaMoveScoreFromJson(Map<String, dynamic> json) {
  return BodyAreaMoveScore()
    ..score = (json['score'] as num).toDouble()
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
    ..bodyAreaMoveScores = (json['BodyAreaMoveScores'] as List<dynamic>?)
        ?.map((e) => BodyAreaMoveScore.fromJson(e as Map<String, dynamic>))
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
      'description': instance.description,
      'demoVideoUri': instance.demoVideoUri,
      'demoVideoThumbUri': instance.demoVideoThumbUri,
      'scope': _$MoveScopeEnumMap[instance.scope],
      'validRepTypes': instance.validRepTypes
          .map((e) => _$WorkoutMoveRepTypeEnumMap[e])
          .toList(),
      'MoveType': instance.moveType.toJson(),
      'BodyAreaMoveScores':
          instance.bodyAreaMoveScores?.map((e) => e.toJson()).toList(),
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
    ..loadAmount = (json['loadAmount'] as num?)?.toDouble()
    ..loadUnit = _$enumDecode(_$LoadUnitEnumMap, json['loadUnit'],
        unknownValue: LoadUnit.artemisUnknown)
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
  LoadUnit.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

WorkoutSet _$WorkoutSetFromJson(Map<String, dynamic> json) {
  return WorkoutSet()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..sortPosition = json['sortPosition'] as int
    ..rounds = json['rounds'] as int
    ..notes = json['notes'] as String?
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
      'notes': instance.notes,
      'WorkoutMoves': instance.workoutMoves.map((e) => e.toJson()).toList(),
    };

WorkoutSection _$WorkoutSectionFromJson(Map<String, dynamic> json) {
  return WorkoutSection()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String?
    ..notes = json['notes'] as String?
    ..rounds = json['rounds'] as int
    ..timecap = json['timecap'] as int?
    ..sortPosition = json['sortPosition'] as int
    ..introVideoUri = json['introVideoUri'] as String?
    ..introVideoThumbUri = json['introVideoThumbUri'] as String?
    ..introAudioUri = json['introAudioUri'] as String?
    ..classVideoUri = json['classVideoUri'] as String?
    ..classVideoThumbUri = json['classVideoThumbUri'] as String?
    ..classAudioUri = json['classAudioUri'] as String?
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
      'notes': instance.notes,
      'rounds': instance.rounds,
      'timecap': instance.timecap,
      'sortPosition': instance.sortPosition,
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'classVideoUri': instance.classVideoUri,
      'classVideoThumbUri': instance.classVideoThumbUri,
      'classAudioUri': instance.classAudioUri,
      'WorkoutSectionType': instance.workoutSectionType.toJson(),
      'WorkoutSets': instance.workoutSets.map((e) => e.toJson()).toList(),
    };

WorkoutData _$WorkoutDataFromJson(Map<String, dynamic> json) {
  return WorkoutData()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
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
    ..userInfo = json['UserInfo'] == null
        ? null
        : UserInfo.fromJson(json['UserInfo'] as Map<String, dynamic>)
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

Map<String, dynamic> _$WorkoutDataToJson(WorkoutData instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'difficultyLevel': _$DifficultyLevelEnumMap[instance.difficultyLevel],
      'coverImageUri': instance.coverImageUri,
      'contentAccessScope':
          _$ContentAccessScopeEnumMap[instance.contentAccessScope],
      'introVideoUri': instance.introVideoUri,
      'introVideoThumbUri': instance.introVideoThumbUri,
      'introAudioUri': instance.introAudioUri,
      'UserInfo': instance.userInfo?.toJson(),
      'WorkoutGoals': instance.workoutGoals.map((e) => e.toJson()).toList(),
      'WorkoutTags': instance.workoutTags.map((e) => e.toJson()).toList(),
      'WorkoutSections':
          instance.workoutSections.map((e) => e.toJson()).toList(),
    };

WorkoutById$Query _$WorkoutById$QueryFromJson(Map<String, dynamic> json) {
  return WorkoutById$Query()
    ..workoutData =
        WorkoutData.fromJson(json['WorkoutData'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutById$QueryToJson(WorkoutById$Query instance) =>
    <String, dynamic>{
      'WorkoutData': instance.workoutData.toJson(),
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
