// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
