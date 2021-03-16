// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:spotmefitness_ui/coercers.dart';
part 'graphql_api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation$User extends JsonSerializable with EquatableMixin {
  CreateUser$Mutation$User();

  factory CreateUser$Mutation$User.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$Mutation$UserFromJson(json);

  late String id;

  late bool hasOnboarded;

  @override
  List<Object?> get props => [id, hasOnboarded];
  Map<String, dynamic> toJson() => _$CreateUser$Mutation$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation extends JsonSerializable with EquatableMixin {
  CreateUser$Mutation();

  factory CreateUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$MutationFromJson(json);

  late CreateUser$Mutation$User createUser;

  @override
  List<Object?> get props => [createUser];
  Map<String, dynamic> toJson() => _$CreateUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Equipments$Query$Equipment extends JsonSerializable with EquatableMixin {
  Equipments$Query$Equipment();

  factory Equipments$Query$Equipment.fromJson(Map<String, dynamic> json) =>
      _$Equipments$Query$EquipmentFromJson(json);

  late String id;

  late String name;

  late String? imageUrl;

  late bool loadAdjustable;

  @override
  List<Object?> get props => [id, name, imageUrl, loadAdjustable];
  Map<String, dynamic> toJson() => _$Equipments$Query$EquipmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Equipments$Query extends JsonSerializable with EquatableMixin {
  Equipments$Query();

  factory Equipments$Query.fromJson(Map<String, dynamic> json) =>
      _$Equipments$QueryFromJson(json);

  late List<Equipments$Query$Equipment> equipments;

  @override
  List<Object?> get props => [equipments];
  Map<String, dynamic> toJson() => _$Equipments$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserArguments extends JsonSerializable with EquatableMixin {
  CreateUserArguments({required this.firebaseUid});

  @override
  factory CreateUserArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateUserArgumentsFromJson(json);

  final String firebaseUid;

  @override
  List<Object?> get props => [firebaseUid];
  @override
  Map<String, dynamic> toJson() => _$CreateUserArgumentsToJson(this);
}

class CreateUserMutation
    extends GraphQLQuery<CreateUser$Mutation, CreateUserArguments> {
  CreateUserMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'createUser'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'firebaseUid')),
              type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createUser'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'firebaseUid'),
                    value: VariableNode(name: NameNode(value: 'firebaseUid')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'hasOnboarded'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'createUser';

  @override
  final CreateUserArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateUser$Mutation parse(Map<String, dynamic> json) =>
      CreateUser$Mutation.fromJson(json);
}

class EquipmentsQuery extends GraphQLQuery<Equipments$Query, JsonSerializable> {
  EquipmentsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'equipments'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'equipments'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'loadAdjustable'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'equipments';

  @override
  List<Object?> get props => [document, operationName];
  @override
  Equipments$Query parse(Map<String, dynamic> json) =>
      Equipments$Query.fromJson(json);
}
