// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:spotmefitness_ui/coercers.dart';
part 'graphql_api.graphql.g.dart';

mixin UserMixin {
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
  String? introVideoThumbUri;
  @JsonKey(unknownEnumValue: Gender.artemisUnknown)
  Gender? gender;
}
mixin EquipmentMixin {
  @JsonKey(name: '__typename')
  late String $$typename;
  late String id;
  late String name;
  late bool loadAdjustable;
}
mixin GymProfileMixin {
  @JsonKey(name: '__typename')
  late String $$typename;
  late String id;
  late String name;
  late String? description;
}

@JsonSerializable(explicitToJson: true)
class User extends JsonSerializable with EquatableMixin, UserMixin {
  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

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
        introVideoThumbUri,
        gender
      ];
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AuthedUser$Query extends JsonSerializable with EquatableMixin {
  AuthedUser$Query();

  factory AuthedUser$Query.fromJson(Map<String, dynamic> json) =>
      _$AuthedUser$QueryFromJson(json);

  late User authedUser;

  @override
  List<Object?> get props => [authedUser];
  Map<String, dynamic> toJson() => _$AuthedUser$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUser$Mutation extends JsonSerializable with EquatableMixin {
  UpdateUser$Mutation();

  factory UpdateUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateUser$MutationFromJson(json);

  late User updateUser;

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
class Equipment extends JsonSerializable with EquatableMixin, EquipmentMixin {
  Equipment();

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, name, loadAdjustable];
  Map<String, dynamic> toJson() => _$EquipmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GymProfile extends JsonSerializable with EquatableMixin, GymProfileMixin {
  GymProfile();

  factory GymProfile.fromJson(Map<String, dynamic> json) =>
      _$GymProfileFromJson(json);

  @JsonKey(name: 'Equipments')
  late List<Equipment> equipments;

  @override
  List<Object?> get props => [$$typename, id, name, description, equipments];
  Map<String, dynamic> toJson() => _$GymProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateGymProfile$Mutation extends JsonSerializable with EquatableMixin {
  CreateGymProfile$Mutation();

  factory CreateGymProfile$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateGymProfile$MutationFromJson(json);

  late GymProfile createGymProfile;

  @override
  List<Object?> get props => [createGymProfile];
  Map<String, dynamic> toJson() => _$CreateGymProfile$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateGymProfileInput extends JsonSerializable with EquatableMixin {
  CreateGymProfileInput(
      {required this.name, this.description, required this.equipments});

  factory CreateGymProfileInput.fromJson(Map<String, dynamic> json) =>
      _$CreateGymProfileInputFromJson(json);

  late String name;

  late String? description;

  @JsonKey(name: 'Equipments')
  late List<String> equipments;

  @override
  List<Object?> get props => [name, description, equipments];
  Map<String, dynamic> toJson() => _$CreateGymProfileInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GymProfiles$Query extends JsonSerializable with EquatableMixin {
  GymProfiles$Query();

  factory GymProfiles$Query.fromJson(Map<String, dynamic> json) =>
      _$GymProfiles$QueryFromJson(json);

  late List<GymProfile> gymProfiles;

  @override
  List<Object?> get props => [gymProfiles];
  Map<String, dynamic> toJson() => _$GymProfiles$QueryToJson(this);
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

@JsonSerializable(explicitToJson: true)
class Equipments$Query extends JsonSerializable with EquatableMixin {
  Equipments$Query();

  factory Equipments$Query.fromJson(Map<String, dynamic> json) =>
      _$Equipments$QueryFromJson(json);

  late List<Equipment> equipments;

  @override
  List<Object?> get props => [equipments];
  Map<String, dynamic> toJson() => _$Equipments$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateGymProfile$Mutation extends JsonSerializable with EquatableMixin {
  UpdateGymProfile$Mutation();

  factory UpdateGymProfile$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateGymProfile$MutationFromJson(json);

  late GymProfile updateGymProfile;

  @override
  List<Object?> get props => [updateGymProfile];
  Map<String, dynamic> toJson() => _$UpdateGymProfile$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateGymProfileInput extends JsonSerializable with EquatableMixin {
  UpdateGymProfileInput(
      {required this.id, this.name, this.description, this.equipments});

  factory UpdateGymProfileInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateGymProfileInputFromJson(json);

  late String id;

  late String? name;

  late String? description;

  @JsonKey(name: 'Equipments')
  late List<String>? equipments;

  @override
  List<Object?> get props => [id, name, description, equipments];
  Map<String, dynamic> toJson() => _$UpdateGymProfileInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Workout extends JsonSerializable with EquatableMixin {
  Workout();

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  @JsonKey(name: '__typename')
  late String $$typename;

  late String id;

  late String name;

  @override
  List<Object?> get props => [$$typename, id, name];
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserWorkouts$Query extends JsonSerializable with EquatableMixin {
  UserWorkouts$Query();

  factory UserWorkouts$Query.fromJson(Map<String, dynamic> json) =>
      _$UserWorkouts$QueryFromJson(json);

  late List<Workout> userWorkouts;

  @override
  List<Object?> get props => [userWorkouts];
  Map<String, dynamic> toJson() => _$UserWorkouts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutById$Query extends JsonSerializable with EquatableMixin {
  WorkoutById$Query();

  factory WorkoutById$Query.fromJson(Map<String, dynamic> json) =>
      _$WorkoutById$QueryFromJson(json);

  late Workout workoutById;

  @override
  List<Object?> get props => [workoutById];
  Map<String, dynamic> toJson() => _$WorkoutById$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkout$Mutation extends JsonSerializable with EquatableMixin {
  UpdateWorkout$Mutation();

  factory UpdateWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkout$MutationFromJson(json);

  late Workout updateWorkout;

  @override
  List<Object?> get props => [updateWorkout];
  Map<String, dynamic> toJson() => _$UpdateWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutInput extends JsonSerializable with EquatableMixin {
  UpdateWorkoutInput(
      {required this.id,
      this.name,
      this.summary,
      this.description,
      this.introVideoUri,
      this.introVideoThumbUri,
      this.introAudioUri,
      this.coverImageUri,
      this.difficultyLevel,
      this.contentAccessScope,
      this.workoutGoals});

  factory UpdateWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutInputFromJson(json);

  late String id;

  late String? name;

  late String? summary;

  late String? description;

  late String? introVideoUri;

  late String? introVideoThumbUri;

  late String? introAudioUri;

  late String? coverImageUri;

  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  late DifficultyLevel? difficultyLevel;

  @JsonKey(unknownEnumValue: ContentAccessScope.artemisUnknown)
  late ContentAccessScope? contentAccessScope;

  @JsonKey(name: 'WorkoutGoals')
  late List<String>? workoutGoals;

  @override
  List<Object?> get props => [
        id,
        name,
        summary,
        description,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        coverImageUri,
        difficultyLevel,
        contentAccessScope,
        workoutGoals
      ];
  Map<String, dynamic> toJson() => _$UpdateWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkout$Mutation extends JsonSerializable with EquatableMixin {
  CreateWorkout$Mutation();

  factory CreateWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkout$MutationFromJson(json);

  late Workout createWorkout;

  @override
  List<Object?> get props => [createWorkout];
  Map<String, dynamic> toJson() => _$CreateWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutInput extends JsonSerializable with EquatableMixin {
  CreateWorkoutInput(
      {required this.name,
      this.summary,
      this.description,
      this.introVideoUri,
      this.introVideoThumbUri,
      this.introAudioUri,
      this.coverImageUri,
      required this.difficultyLevel,
      required this.contentAccessScope,
      required this.workoutSections,
      required this.workoutGoals});

  factory CreateWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutInputFromJson(json);

  late String name;

  late String? summary;

  late String? description;

  late String? introVideoUri;

  late String? introVideoThumbUri;

  late String? introAudioUri;

  late String? coverImageUri;

  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  late DifficultyLevel difficultyLevel;

  @JsonKey(unknownEnumValue: ContentAccessScope.artemisUnknown)
  late ContentAccessScope contentAccessScope;

  @JsonKey(name: 'WorkoutSections')
  late List<CreateWorkoutSectionInput> workoutSections;

  @JsonKey(name: 'WorkoutGoals')
  late List<String> workoutGoals;

  @override
  List<Object?> get props => [
        name,
        summary,
        description,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        coverImageUri,
        difficultyLevel,
        contentAccessScope,
        workoutSections,
        workoutGoals
      ];
  Map<String, dynamic> toJson() => _$CreateWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSectionInput extends JsonSerializable with EquatableMixin {
  CreateWorkoutSectionInput(
      {required this.name,
      this.notes,
      required this.sortPosition,
      this.introVideoUri,
      this.introVideoThumbUri,
      this.introAudioUri,
      this.classVideoUri,
      this.classVideoThumbUri,
      this.classAudioUri,
      this.outroVideoUri,
      this.outroVideoThumbUri,
      this.outroAudioUri,
      required this.workoutSectionType,
      required this.workout});

  factory CreateWorkoutSectionInput.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutSectionInputFromJson(json);

  late String name;

  late String? notes;

  late int sortPosition;

  late String? introVideoUri;

  late String? introVideoThumbUri;

  late String? introAudioUri;

  late String? classVideoUri;

  late String? classVideoThumbUri;

  late String? classAudioUri;

  late String? outroVideoUri;

  late String? outroVideoThumbUri;

  late String? outroAudioUri;

  @JsonKey(name: 'WorkoutSectionType')
  late String workoutSectionType;

  @JsonKey(name: 'Workout')
  late String workout;

  @override
  List<Object?> get props => [
        name,
        notes,
        sortPosition,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        classVideoUri,
        classVideoThumbUri,
        classAudioUri,
        outroVideoUri,
        outroVideoThumbUri,
        outroAudioUri,
        workoutSectionType,
        workout
      ];
  Map<String, dynamic> toJson() => _$CreateWorkoutSectionInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteGymProfileById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteGymProfileById$Mutation();

  factory DeleteGymProfileById$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteGymProfileById$MutationFromJson(json);

  late String? deleteGymProfileById;

  @override
  List<Object?> get props => [deleteGymProfileById];
  Map<String, dynamic> toJson() => _$DeleteGymProfileById$MutationToJson(this);
}

enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
  @JsonValue('NONBINARY')
  nonbinary,
  @JsonValue('NONE')
  none,
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
enum ContentAccessScope {
  @JsonValue('PRIVATE')
  private,
  @JsonValue('PUBLIC')
  public,
  @JsonValue('GROUP')
  group,
  @JsonValue('OFFICIAL')
  official,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum DifficultyLevel {
  @JsonValue('LIGHT')
  light,
  @JsonValue('CHALLENGING')
  challenging,
  @JsonValue('INTERMEDIATE')
  intermediate,
  @JsonValue('ADVANCED')
  advanced,
  @JsonValue('ELITE')
  elite,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

class AuthedUserQuery extends GraphQLQuery<AuthedUser$Query, JsonSerializable> {
  AuthedUserQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
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
                    name: NameNode(value: 'User'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'User'),
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
              name: NameNode(value: 'introVideoThumbUri'),
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
                    name: NameNode(value: 'User'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'User'),
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
              name: NameNode(value: 'introVideoThumbUri'),
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

@JsonSerializable(explicitToJson: true)
class CreateGymProfileArguments extends JsonSerializable with EquatableMixin {
  CreateGymProfileArguments({required this.data});

  @override
  factory CreateGymProfileArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateGymProfileArgumentsFromJson(json);

  final CreateGymProfileInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateGymProfileArgumentsToJson(this);
}

class CreateGymProfileMutation
    extends GraphQLQuery<CreateGymProfile$Mutation, CreateGymProfileArguments> {
  CreateGymProfileMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'createGymProfile'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'data')),
              type: NamedTypeNode(
                  name: NameNode(value: 'CreateGymProfileInput'),
                  isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createGymProfile'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'data'),
                    value: VariableNode(name: NameNode(value: 'data')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'GymProfile'), directives: []),
                FieldNode(
                    name: NameNode(value: 'Equipments'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'Equipment'), directives: [])
                    ]))
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'Equipment'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Equipment'), isNonNull: false)),
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
              name: NameNode(value: 'loadAdjustable'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'GymProfile'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'GymProfile'), isNonNull: false)),
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
              name: NameNode(value: 'description'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'createGymProfile';

  @override
  final CreateGymProfileArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateGymProfile$Mutation parse(Map<String, dynamic> json) =>
      CreateGymProfile$Mutation.fromJson(json);
}

class GymProfilesQuery
    extends GraphQLQuery<GymProfiles$Query, JsonSerializable> {
  GymProfilesQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'gymProfiles'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'gymProfiles'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'GymProfile'), directives: []),
                FieldNode(
                    name: NameNode(value: 'Equipments'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'Equipment'), directives: [])
                    ]))
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'Equipment'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Equipment'), isNonNull: false)),
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
              name: NameNode(value: 'loadAdjustable'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'GymProfile'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'GymProfile'), isNonNull: false)),
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
              name: NameNode(value: 'description'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'gymProfiles';

  @override
  List<Object?> get props => [document, operationName];
  @override
  GymProfiles$Query parse(Map<String, dynamic> json) =>
      GymProfiles$Query.fromJson(json);
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
                FragmentSpreadNode(
                    name: NameNode(value: 'Equipment'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'Equipment'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Equipment'), isNonNull: false)),
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
              name: NameNode(value: 'loadAdjustable'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
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
class UpdateGymProfileArguments extends JsonSerializable with EquatableMixin {
  UpdateGymProfileArguments({required this.data});

  @override
  factory UpdateGymProfileArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateGymProfileArgumentsFromJson(json);

  final UpdateGymProfileInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateGymProfileArgumentsToJson(this);
}

class UpdateGymProfileMutation
    extends GraphQLQuery<UpdateGymProfile$Mutation, UpdateGymProfileArguments> {
  UpdateGymProfileMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'updateGymProfile'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'data')),
              type: NamedTypeNode(
                  name: NameNode(value: 'UpdateGymProfileInput'),
                  isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'updateGymProfile'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'data'),
                    value: VariableNode(name: NameNode(value: 'data')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'GymProfile'), directives: []),
                FieldNode(
                    name: NameNode(value: 'Equipments'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'Equipment'), directives: [])
                    ]))
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'Equipment'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Equipment'), isNonNull: false)),
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
              name: NameNode(value: 'loadAdjustable'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'GymProfile'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'GymProfile'), isNonNull: false)),
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
              name: NameNode(value: 'description'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'updateGymProfile';

  @override
  final UpdateGymProfileArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateGymProfile$Mutation parse(Map<String, dynamic> json) =>
      UpdateGymProfile$Mutation.fromJson(json);
}

class UserWorkoutsQuery
    extends GraphQLQuery<UserWorkouts$Query, JsonSerializable> {
  UserWorkoutsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'userWorkouts'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'userWorkouts'),
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
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'userWorkouts';

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserWorkouts$Query parse(Map<String, dynamic> json) =>
      UserWorkouts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class WorkoutByIdArguments extends JsonSerializable with EquatableMixin {
  WorkoutByIdArguments({required this.id});

  @override
  factory WorkoutByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$WorkoutByIdArgumentsFromJson(json);

  final String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$WorkoutByIdArgumentsToJson(this);
}

class WorkoutByIdQuery
    extends GraphQLQuery<WorkoutById$Query, WorkoutByIdArguments> {
  WorkoutByIdQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'workoutById'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'id')),
              type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'workoutById'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'id'),
                    value: VariableNode(name: NameNode(value: 'id')))
              ],
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
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'workoutById';

  @override
  final WorkoutByIdArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  WorkoutById$Query parse(Map<String, dynamic> json) =>
      WorkoutById$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutArguments extends JsonSerializable with EquatableMixin {
  UpdateWorkoutArguments({required this.data});

  @override
  factory UpdateWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutArgumentsFromJson(json);

  final UpdateWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateWorkoutArgumentsToJson(this);
}

class UpdateWorkoutMutation
    extends GraphQLQuery<UpdateWorkout$Mutation, UpdateWorkoutArguments> {
  UpdateWorkoutMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'updateWorkout'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'data')),
              type: NamedTypeNode(
                  name: NameNode(value: 'UpdateWorkoutInput'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'updateWorkout'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'data'),
                    value: VariableNode(name: NameNode(value: 'data')))
              ],
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
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'updateWorkout';

  @override
  final UpdateWorkoutArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateWorkout$Mutation parse(Map<String, dynamic> json) =>
      UpdateWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutArguments extends JsonSerializable with EquatableMixin {
  CreateWorkoutArguments({required this.data});

  @override
  factory CreateWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutArgumentsFromJson(json);

  final CreateWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkoutArgumentsToJson(this);
}

class CreateWorkoutMutation
    extends GraphQLQuery<CreateWorkout$Mutation, CreateWorkoutArguments> {
  CreateWorkoutMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'createWorkout'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'data')),
              type: NamedTypeNode(
                  name: NameNode(value: 'CreateWorkoutInput'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createWorkout'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'data'),
                    value: VariableNode(name: NameNode(value: 'data')))
              ],
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
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'createWorkout';

  @override
  final CreateWorkoutArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateWorkout$Mutation parse(Map<String, dynamic> json) =>
      CreateWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteGymProfileByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteGymProfileByIdArguments({required this.id});

  @override
  factory DeleteGymProfileByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteGymProfileByIdArgumentsFromJson(json);

  final String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DeleteGymProfileByIdArgumentsToJson(this);
}

class DeleteGymProfileByIdMutation extends GraphQLQuery<
    DeleteGymProfileById$Mutation, DeleteGymProfileByIdArguments> {
  DeleteGymProfileByIdMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'deleteGymProfileById'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'id')),
              type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'deleteGymProfileById'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'id'),
                    value: VariableNode(name: NameNode(value: 'id')))
              ],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'deleteGymProfileById';

  @override
  final DeleteGymProfileByIdArguments? variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteGymProfileById$Mutation parse(Map<String, dynamic> json) =>
      DeleteGymProfileById$Mutation.fromJson(json);
}
