// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthedUser$Query$User _$AuthedUser$Query$UserFromJson(
    Map<String, dynamic> json) {
  return AuthedUser$Query$User()
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..displayName = json['displayName'] as String?
    ..hasOnboarded = json['hasOnboarded'] as bool
    ..themeName = _$enumDecode(_$ThemeNameEnumMap, json['themeName'],
        unknownValue: ThemeName.artemisUnknown);
}

Map<String, dynamic> _$AuthedUser$Query$UserToJson(
        AuthedUser$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'displayName': instance.displayName,
      'hasOnboarded': instance.hasOnboarded,
      'themeName': _$ThemeNameEnumMap[instance.themeName],
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

const _$ThemeNameEnumMap = {
  ThemeName.dark: 'DARK',
  ThemeName.light: 'LIGHT',
  ThemeName.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

AuthedUser$Query _$AuthedUser$QueryFromJson(Map<String, dynamic> json) {
  return AuthedUser$Query()
    ..authedUser = AuthedUser$Query$User.fromJson(
        json['authedUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AuthedUser$QueryToJson(AuthedUser$Query instance) =>
    <String, dynamic>{
      'authedUser': instance.authedUser.toJson(),
    };

UpdateUser$Mutation$User _$UpdateUser$Mutation$UserFromJson(
    Map<String, dynamic> json) {
  return UpdateUser$Mutation$User()
    ..id = json['id'] as String
    ..avatarUri = json['avatarUri'] as String?
    ..displayName = json['displayName'] as String?
    ..hasOnboarded = json['hasOnboarded'] as bool
    ..themeName = _$enumDecode(_$ThemeNameEnumMap, json['themeName'],
        unknownValue: ThemeName.artemisUnknown);
}

Map<String, dynamic> _$UpdateUser$Mutation$UserToJson(
        UpdateUser$Mutation$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatarUri': instance.avatarUri,
      'displayName': instance.displayName,
      'hasOnboarded': instance.hasOnboarded,
      'themeName': _$ThemeNameEnumMap[instance.themeName],
    };

UpdateUser$Mutation _$UpdateUser$MutationFromJson(Map<String, dynamic> json) {
  return UpdateUser$Mutation()
    ..updateUser = UpdateUser$Mutation$User.fromJson(
        json['updateUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateUser$MutationToJson(
        UpdateUser$Mutation instance) =>
    <String, dynamic>{
      'updateUser': instance.updateUser.toJson(),
    };

UpdateUserInput _$UpdateUserInputFromJson(Map<String, dynamic> json) {
  return UpdateUserInput(
    id: json['id'] as String,
    userProfileScope: _$enumDecodeNullable(
        _$UserProfileScopeEnumMap, json['userProfileScope'],
        unknownValue: UserProfileScope.artemisUnknown),
    themeName: _$enumDecodeNullable(_$ThemeNameEnumMap, json['themeName'],
        unknownValue: ThemeName.artemisUnknown),
    avatarUri: json['avatarUri'] as String?,
    introVideoUri: json['introVideoUri'] as String?,
    introVideoThumbUri: json['introVideoThumbUri'] as String?,
    bio: json['bio'] as String?,
    tagline: json['tagline'] as String?,
    birthdate: fromGraphQLDateTimeToDartDateTime(json['birthdate'] as String?),
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
    height: (json['height'] as num?)?.toDouble(),
    lastname: json['lastname'] as String?,
    unitSystem: _$enumDecodeNullable(_$UnitSystemEnumMap, json['unitSystem'],
        unknownValue: UnitSystem.artemisUnknown),
    weight: (json['weight'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$UpdateUserInputToJson(UpdateUserInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userProfileScope': _$UserProfileScopeEnumMap[instance.userProfileScope],
      'themeName': _$ThemeNameEnumMap[instance.themeName],
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
      'height': instance.height,
      'lastname': instance.lastname,
      'unitSystem': _$UnitSystemEnumMap[instance.unitSystem],
      'weight': instance.weight,
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

const _$UserProfileScopeEnumMap = {
  UserProfileScope.private: 'PRIVATE',
  UserProfileScope.public: 'PUBLIC',
  UserProfileScope.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.nonbinary: 'NONBINARY',
  Gender.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

const _$UnitSystemEnumMap = {
  UnitSystem.imperial: 'IMPERIAL',
  UnitSystem.metric: 'METRIC',
  UnitSystem.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

Equipments$Query$Equipment _$Equipments$Query$EquipmentFromJson(
    Map<String, dynamic> json) {
  return Equipments$Query$Equipment()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..imageUrl = json['imageUrl'] as String?
    ..loadAdjustable = json['loadAdjustable'] as bool;
}

Map<String, dynamic> _$Equipments$Query$EquipmentToJson(
        Equipments$Query$Equipment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'loadAdjustable': instance.loadAdjustable,
    };

Equipments$Query _$Equipments$QueryFromJson(Map<String, dynamic> json) {
  return Equipments$Query()
    ..equipments = (json['equipments'] as List<dynamic>)
        .map((e) =>
            Equipments$Query$Equipment.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Equipments$QueryToJson(Equipments$Query instance) =>
    <String, dynamic>{
      'equipments': instance.equipments.map((e) => e.toJson()).toList(),
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
