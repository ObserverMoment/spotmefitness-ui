// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:spotmefitness_ui/coercers.dart';
part 'graphql_api.graphql.g.dart';

mixin UserFieldsMixin {
  @JsonKey(name: '__typename')
  late String $$typename;
  late String id;
  String? avatarUri;
  String? bio;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  DateTime? birthdate;
  String? countryCode;
  String? displayName;
  String? introVideoUri;
  @JsonKey(unknownEnumValue: Gender.artemisUnknown)
  Gender? gender;
}

@JsonSerializable(explicitToJson: true)
class AuthedUser$Query$User extends JsonSerializable
    with EquatableMixin, UserFieldsMixin {
  AuthedUser$Query$User();

  factory AuthedUser$Query$User.fromJson(Map<String, dynamic> json) =>
      _$AuthedUser$Query$UserFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        avatarUri,
        bio,
        birthdate,
        countryCode,
        displayName,
        introVideoUri,
        gender
      ];
  Map<String, dynamic> toJson() => _$AuthedUser$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AuthedUser$Query extends JsonSerializable with EquatableMixin {
  AuthedUser$Query();

  factory AuthedUser$Query.fromJson(Map<String, dynamic> json) =>
      _$AuthedUser$QueryFromJson(json);

  late AuthedUser$Query$User authedUser;

  @override
  List<Object?> get props => [authedUser];
  Map<String, dynamic> toJson() => _$AuthedUser$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUser$Mutation$User extends JsonSerializable
    with EquatableMixin, UserFieldsMixin {
  UpdateUser$Mutation$User();

  factory UpdateUser$Mutation$User.fromJson(Map<String, dynamic> json) =>
      _$UpdateUser$Mutation$UserFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        avatarUri,
        bio,
        birthdate,
        countryCode,
        displayName,
        introVideoUri,
        gender
      ];
  Map<String, dynamic> toJson() => _$UpdateUser$Mutation$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUser$Mutation extends JsonSerializable with EquatableMixin {
  UpdateUser$Mutation();

  factory UpdateUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateUser$MutationFromJson(json);

  late UpdateUser$Mutation$User updateUser;

  @override
  List<Object?> get props => [updateUser];
  Map<String, dynamic> toJson() => _$UpdateUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserInput extends JsonSerializable with EquatableMixin {
  UpdateUserInput(
      {this.userProfileScope,
      this.avatarUri,
      this.introVideoUri,
      this.introVideoThumbUri,
      this.bio,
      this.tagline,
      this.birthdate,
      this.city,
      this.countryCode,
      this.displayName,
      this.instagramUrl,
      this.tiktokUrl,
      this.youtubeUrl,
      this.snapUrl,
      this.linkedinUrl,
      this.firstname,
      this.gender,
      this.hasOnboarded,
      this.lastname});

  factory UpdateUserInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserInputFromJson(json);

  @JsonKey(unknownEnumValue: UserProfileScope.artemisUnknown)
  late UserProfileScope? userProfileScope;

  late String? avatarUri;

  late String? introVideoUri;

  late String? introVideoThumbUri;

  late String? bio;

  late String? tagline;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime? birthdate;

  late String? city;

  late String? countryCode;

  late String? displayName;

  late String? instagramUrl;

  late String? tiktokUrl;

  late String? youtubeUrl;

  late String? snapUrl;

  late String? linkedinUrl;

  late String? firstname;

  @JsonKey(unknownEnumValue: Gender.artemisUnknown)
  late Gender? gender;

  late bool? hasOnboarded;

  late String? lastname;

  @override
  List<Object?> get props => [
        userProfileScope,
        avatarUri,
        introVideoUri,
        introVideoThumbUri,
        bio,
        tagline,
        birthdate,
        city,
        countryCode,
        displayName,
        instagramUrl,
        tiktokUrl,
        youtubeUrl,
        snapUrl,
        linkedinUrl,
        firstname,
        gender,
        hasOnboarded,
        lastname
      ];
  Map<String, dynamic> toJson() => _$UpdateUserInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Equipments$Query$Equipment extends JsonSerializable with EquatableMixin {
  Equipments$Query$Equipment();

  factory Equipments$Query$Equipment.fromJson(Map<String, dynamic> json) =>
      _$Equipments$Query$EquipmentFromJson(json);

  @JsonKey(name: '__typename')
  late String $$typename;

  late String id;

  late String name;

  late String? imageUrl;

  late bool loadAdjustable;

  @override
  List<Object?> get props => [$$typename, id, name, imageUrl, loadAdjustable];
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
class CheckUniqueDisplayName$Query extends JsonSerializable
    with EquatableMixin {
  CheckUniqueDisplayName$Query();

  factory CheckUniqueDisplayName$Query.fromJson(Map<String, dynamic> json) =>
      _$CheckUniqueDisplayName$QueryFromJson(json);

  late bool checkUniqueDisplayName;

  @override
  List<Object?> get props => [checkUniqueDisplayName];
  Map<String, dynamic> toJson() => _$CheckUniqueDisplayName$QueryToJson(this);
}

enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
  @JsonValue('NONBINARY')
  nonbinary,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum UserProfileScope {
  @JsonValue('PRIVATE')
  private,
  @JsonValue('PUBLIC')
  public,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

class AuthedUserQuery extends GraphQLQuery<AuthedUser$Query, JsonSerializable> {
  AuthedUserQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    FragmentDefinitionNode(
        name: NameNode(value: 'UserFields'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'id'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'avatarUri'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'bio'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'birthdate'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'countryCode'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'displayName'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'introVideoUri'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'gender'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'authedUser'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'authedUser'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'UserFields'), directives: [])
              ]))
        ]))
  ]);

  @override
  final String operationName = 'authedUser';

  @override
  List<Object?> get props => [document, operationName];
  @override
  AuthedUser$Query parse(Map<String, dynamic> json) =>
      AuthedUser$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserArguments extends JsonSerializable with EquatableMixin {
  UpdateUserArguments({required this.data});

  @override
  factory UpdateUserArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserArgumentsFromJson(json);

  final UpdateUserInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateUserArgumentsToJson(this);
}

class UpdateUserMutation
    extends GraphQLQuery<UpdateUser$Mutation, UpdateUserArguments> {
  UpdateUserMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    FragmentDefinitionNode(
        name: NameNode(value: 'UserFields'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: '__typename'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'id'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'avatarUri'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'bio'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'birthdate'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'countryCode'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'displayName'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'introVideoUri'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'gender'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'updateUser'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'data')),
              type: NamedTypeNode(
                  name: NameNode(value: 'UpdateUserInput'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'updateUser'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'data'),
                    value: VariableNode(name: NameNode(value: 'data')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'UserFields'), directives: [])
              ]))
        ]))
  ]);

  @override
  final String operationName = 'updateUser';

  @override
  final UpdateUserArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateUser$Mutation parse(Map<String, dynamic> json) =>
      UpdateUser$Mutation.fromJson(json);
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
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
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

@JsonSerializable(explicitToJson: true)
class CheckUniqueDisplayNameArguments extends JsonSerializable
    with EquatableMixin {
  CheckUniqueDisplayNameArguments({required this.displayName});

  @override
  factory CheckUniqueDisplayNameArguments.fromJson(Map<String, dynamic> json) =>
      _$CheckUniqueDisplayNameArgumentsFromJson(json);

  final String displayName;

  @override
  List<Object?> get props => [displayName];
  @override
  Map<String, dynamic> toJson() =>
      _$CheckUniqueDisplayNameArgumentsToJson(this);
}

class CheckUniqueDisplayNameQuery extends GraphQLQuery<
    CheckUniqueDisplayName$Query, CheckUniqueDisplayNameArguments> {
  CheckUniqueDisplayNameQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'checkUniqueDisplayName'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'displayName')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'checkUniqueDisplayName'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'displayName'),
                    value: VariableNode(name: NameNode(value: 'displayName')))
              ],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'checkUniqueDisplayName';

  @override
  final CheckUniqueDisplayNameArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CheckUniqueDisplayName$Query parse(Map<String, dynamic> json) =>
      CheckUniqueDisplayName$Query.fromJson(json);
}
