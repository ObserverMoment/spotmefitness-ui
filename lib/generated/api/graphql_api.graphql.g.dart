// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUser$Mutation$User _$CreateUser$Mutation$UserFromJson(
    Map<String, dynamic> json) {
  return CreateUser$Mutation$User()
    ..id = json['id'] as String
    ..hasOnboarded = json['hasOnboarded'] as bool;
}

Map<String, dynamic> _$CreateUser$Mutation$UserToJson(
        CreateUser$Mutation$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hasOnboarded': instance.hasOnboarded,
    };

CreateUser$Mutation _$CreateUser$MutationFromJson(Map<String, dynamic> json) {
  return CreateUser$Mutation()
    ..createUser = CreateUser$Mutation$User.fromJson(
        json['createUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateUser$MutationToJson(
        CreateUser$Mutation instance) =>
    <String, dynamic>{
      'createUser': instance.createUser.toJson(),
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

CreateUserArguments _$CreateUserArgumentsFromJson(Map<String, dynamic> json) {
  return CreateUserArguments(
    firebaseUid: json['firebaseUid'] as String,
  );
}

Map<String, dynamic> _$CreateUserArgumentsToJson(
        CreateUserArguments instance) =>
    <String, dynamic>{
      'firebaseUid': instance.firebaseUid,
    };
