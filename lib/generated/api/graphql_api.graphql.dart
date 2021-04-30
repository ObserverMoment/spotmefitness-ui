// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:spotmefitness_ui/coercers.dart';
part 'graphql_api.graphql.g.dart';

mixin EquipmentMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  late bool loadAdjustable;
}
mixin MoveTypeMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  String? description;
  String? imageUri;
}
mixin BodyAreaMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  @JsonKey(unknownEnumValue: BodyAreaFrontBack.artemisUnknown)
  late BodyAreaFrontBack frontBack;
  @JsonKey(unknownEnumValue: BodyAreaUpperLower.artemisUnknown)
  late BodyAreaUpperLower upperLower;
}
mixin MoveMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  String? searchTerms;
  String? description;
  String? demoVideoUri;
  String? demoVideoThumbUri;
  @JsonKey(unknownEnumValue: MoveScope.artemisUnknown)
  late MoveScope scope;
  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late List<WorkoutMoveRepType> validRepTypes;
}
mixin WorkoutMoveMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late int sortPosition;
  late double reps;
  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late WorkoutMoveRepType repType;
  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  late DistanceUnit distanceUnit;
  late double loadAmount;
  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  late LoadUnit loadUnit;
  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  late TimeUnit timeUnit;
}
mixin UserMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? avatarUri;
  String? bio;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  DateTime? birthdate;
  String? countryCode;
  late String displayName;
  String? introVideoUri;
  String? introVideoThumbUri;
  @JsonKey(unknownEnumValue: Gender.artemisUnknown)
  Gender? gender;
}
mixin GymProfileMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  String? description;
}
mixin WorkoutTagMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String tag;
}
mixin WorkoutSetMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late int sortPosition;
  late int rounds;
  int? duration;
}
mixin WorkoutGoalMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  late String description;
}
mixin WorkoutSectionTypeMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  late String description;
}
mixin WorkoutSectionMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? name;
  String? note;
  late int rounds;
  int? timecap;
  late int sortPosition;
  String? introVideoUri;
  String? introVideoThumbUri;
  String? introAudioUri;
  String? classVideoUri;
  String? classVideoThumbUri;
  String? classAudioUri;
  String? outroVideoUri;
  String? outroVideoThumbUri;
  String? outroAudioUri;
}
mixin WorkoutFieldsMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  DateTime? createdAt;
  late String name;
  String? description;
  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  late DifficultyLevel difficultyLevel;
  String? coverImageUri;
  @JsonKey(unknownEnumValue: ContentAccessScope.artemisUnknown)
  late ContentAccessScope contentAccessScope;
  String? introVideoUri;
  String? introVideoThumbUri;
  String? introAudioUri;
}
mixin UserSummaryMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? avatarUri;
  late String displayName;
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
class MoveType extends JsonSerializable with EquatableMixin, MoveTypeMixin {
  MoveType();

  factory MoveType.fromJson(Map<String, dynamic> json) =>
      _$MoveTypeFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, name, description, imageUri];
  Map<String, dynamic> toJson() => _$MoveTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BodyArea extends JsonSerializable with EquatableMixin, BodyAreaMixin {
  BodyArea();

  factory BodyArea.fromJson(Map<String, dynamic> json) =>
      _$BodyAreaFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, name, frontBack, upperLower];
  Map<String, dynamic> toJson() => _$BodyAreaToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BodyAreaMoveScore extends JsonSerializable with EquatableMixin {
  BodyAreaMoveScore();

  factory BodyAreaMoveScore.fromJson(Map<String, dynamic> json) =>
      _$BodyAreaMoveScoreFromJson(json);

  late int score;

  @JsonKey(name: 'BodyArea')
  late BodyArea bodyArea;

  @override
  List<Object?> get props => [score, bodyArea];
  Map<String, dynamic> toJson() => _$BodyAreaMoveScoreToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Move extends JsonSerializable with EquatableMixin, MoveMixin {
  Move();

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  @JsonKey(name: 'MoveType')
  late MoveType moveType;

  @JsonKey(name: 'BodyAreaMoveScores')
  late List<BodyAreaMoveScore> bodyAreaMoveScores;

  @JsonKey(name: 'RequiredEquipments')
  late List<Equipment> requiredEquipments;

  @JsonKey(name: 'SelectableEquipments')
  late List<Equipment> selectableEquipments;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        name,
        searchTerms,
        description,
        demoVideoUri,
        demoVideoThumbUri,
        scope,
        validRepTypes,
        moveType,
        bodyAreaMoveScores,
        requiredEquipments,
        selectableEquipments
      ];
  Map<String, dynamic> toJson() => _$MoveToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutMove extends JsonSerializable
    with EquatableMixin, WorkoutMoveMixin {
  WorkoutMove();

  factory WorkoutMove.fromJson(Map<String, dynamic> json) =>
      _$WorkoutMoveFromJson(json);

  @JsonKey(name: 'Equipment')
  Equipment? equipment;

  @JsonKey(name: 'Move')
  late Move move;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        sortPosition,
        reps,
        repType,
        distanceUnit,
        loadAmount,
        loadUnit,
        timeUnit,
        equipment,
        move
      ];
  Map<String, dynamic> toJson() => _$WorkoutMoveToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutMove$Mutation extends JsonSerializable with EquatableMixin {
  CreateWorkoutMove$Mutation();

  factory CreateWorkoutMove$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutMove$MutationFromJson(json);

  late WorkoutMove createWorkoutMove;

  @override
  List<Object?> get props => [createWorkoutMove];
  Map<String, dynamic> toJson() => _$CreateWorkoutMove$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConnectRelationInput extends JsonSerializable with EquatableMixin {
  ConnectRelationInput({required this.id});

  factory ConnectRelationInput.fromJson(Map<String, dynamic> json) =>
      _$ConnectRelationInputFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  Map<String, dynamic> toJson() => _$ConnectRelationInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutMoveInput extends JsonSerializable with EquatableMixin {
  CreateWorkoutMoveInput(
      {required this.sortPosition,
      required this.reps,
      required this.repType,
      this.distanceUnit,
      required this.loadAmount,
      this.loadUnit,
      this.timeUnit,
      required this.move,
      this.equipment,
      required this.workoutSet});

  factory CreateWorkoutMoveInput.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutMoveInputFromJson(json);

  late int sortPosition;

  late double reps;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late WorkoutMoveRepType repType;

  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  DistanceUnit? distanceUnit;

  late double loadAmount;

  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  LoadUnit? loadUnit;

  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  TimeUnit? timeUnit;

  @JsonKey(name: 'Move')
  late ConnectRelationInput move;

  @JsonKey(name: 'Equipment')
  ConnectRelationInput? equipment;

  @JsonKey(name: 'WorkoutSet')
  late ConnectRelationInput workoutSet;

  @override
  List<Object?> get props => [
        sortPosition,
        reps,
        repType,
        distanceUnit,
        loadAmount,
        loadUnit,
        timeUnit,
        move,
        equipment,
        workoutSet
      ];
  Map<String, dynamic> toJson() => _$CreateWorkoutMoveInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DuplicateWorkoutMoveById$Mutation extends JsonSerializable
    with EquatableMixin {
  DuplicateWorkoutMoveById$Mutation();

  factory DuplicateWorkoutMoveById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DuplicateWorkoutMoveById$MutationFromJson(json);

  late WorkoutMove duplicateWorkoutMoveById;

  @override
  List<Object?> get props => [duplicateWorkoutMoveById];
  Map<String, dynamic> toJson() =>
      _$DuplicateWorkoutMoveById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkoutMoveById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteWorkoutMoveById$Mutation();

  factory DeleteWorkoutMoveById$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteWorkoutMoveById$MutationFromJson(json);

  late String deleteWorkoutMoveById;

  @override
  List<Object?> get props => [deleteWorkoutMoveById];
  Map<String, dynamic> toJson() => _$DeleteWorkoutMoveById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SortPositionUpdated extends JsonSerializable with EquatableMixin {
  SortPositionUpdated();

  factory SortPositionUpdated.fromJson(Map<String, dynamic> json) =>
      _$SortPositionUpdatedFromJson(json);

  late String id;

  late int sortPosition;

  @override
  List<Object?> get props => [id, sortPosition];
  Map<String, dynamic> toJson() => _$SortPositionUpdatedToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReorderWorkoutMoves$Mutation extends JsonSerializable
    with EquatableMixin {
  ReorderWorkoutMoves$Mutation();

  factory ReorderWorkoutMoves$Mutation.fromJson(Map<String, dynamic> json) =>
      _$ReorderWorkoutMoves$MutationFromJson(json);

  late List<SortPositionUpdated> reorderWorkoutMoves;

  @override
  List<Object?> get props => [reorderWorkoutMoves];
  Map<String, dynamic> toJson() => _$ReorderWorkoutMoves$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateSortPositionInput extends JsonSerializable with EquatableMixin {
  UpdateSortPositionInput({required this.id, required this.sortPosition});

  factory UpdateSortPositionInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateSortPositionInputFromJson(json);

  late String id;

  late int sortPosition;

  @override
  List<Object?> get props => [id, sortPosition];
  Map<String, dynamic> toJson() => _$UpdateSortPositionInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutMove$Mutation extends JsonSerializable with EquatableMixin {
  UpdateWorkoutMove$Mutation();

  factory UpdateWorkoutMove$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutMove$MutationFromJson(json);

  late WorkoutMove updateWorkoutMove;

  @override
  List<Object?> get props => [updateWorkoutMove];
  Map<String, dynamic> toJson() => _$UpdateWorkoutMove$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutMoveInput extends JsonSerializable with EquatableMixin {
  UpdateWorkoutMoveInput(
      {required this.id,
      this.reps,
      this.repType,
      this.distanceUnit,
      this.loadAmount,
      this.loadUnit,
      this.timeUnit,
      this.move,
      this.equipment});

  factory UpdateWorkoutMoveInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutMoveInputFromJson(json);

  late String id;

  double? reps;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  WorkoutMoveRepType? repType;

  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  DistanceUnit? distanceUnit;

  double? loadAmount;

  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  LoadUnit? loadUnit;

  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  TimeUnit? timeUnit;

  @JsonKey(name: 'Move')
  ConnectRelationInput? move;

  @JsonKey(name: 'Equipment')
  ConnectRelationInput? equipment;

  @override
  List<Object?> get props => [
        id,
        reps,
        repType,
        distanceUnit,
        loadAmount,
        loadUnit,
        timeUnit,
        move,
        equipment
      ];
  Map<String, dynamic> toJson() => _$UpdateWorkoutMoveInputToJson(this);
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
  UserProfileScope? userProfileScope;

  String? avatarUri;

  String? introVideoUri;

  String? introVideoThumbUri;

  String? bio;

  String? tagline;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  DateTime? birthdate;

  String? city;

  String? countryCode;

  String? displayName;

  String? instagramUrl;

  String? tiktokUrl;

  String? youtubeUrl;

  String? snapUrl;

  String? linkedinUrl;

  String? firstname;

  @JsonKey(unknownEnumValue: Gender.artemisUnknown)
  Gender? gender;

  bool? hasOnboarded;

  String? lastname;

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
class CreateMove$Mutation extends JsonSerializable with EquatableMixin {
  CreateMove$Mutation();

  factory CreateMove$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateMove$MutationFromJson(json);

  late Move createMove;

  @override
  List<Object?> get props => [createMove];
  Map<String, dynamic> toJson() => _$CreateMove$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateMoveInput extends JsonSerializable with EquatableMixin {
  CreateMoveInput(
      {required this.name,
      this.searchTerms,
      this.description,
      this.demoVideoUri,
      this.demoVideoThumbUri,
      this.scope,
      required this.moveType,
      required this.validRepTypes,
      this.requiredEquipments,
      this.selectableEquipments,
      this.bodyAreaMoveScores});

  factory CreateMoveInput.fromJson(Map<String, dynamic> json) =>
      _$CreateMoveInputFromJson(json);

  late String name;

  String? searchTerms;

  String? description;

  String? demoVideoUri;

  String? demoVideoThumbUri;

  @JsonKey(unknownEnumValue: MoveScope.artemisUnknown)
  MoveScope? scope;

  @JsonKey(name: 'MoveType')
  late ConnectRelationInput moveType;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late List<WorkoutMoveRepType> validRepTypes;

  @JsonKey(name: 'RequiredEquipments')
  List<ConnectRelationInput>? requiredEquipments;

  @JsonKey(name: 'SelectableEquipments')
  List<ConnectRelationInput>? selectableEquipments;

  @JsonKey(name: 'BodyAreaMoveScores')
  List<BodyAreaMoveScoreInput>? bodyAreaMoveScores;

  @override
  List<Object?> get props => [
        name,
        searchTerms,
        description,
        demoVideoUri,
        demoVideoThumbUri,
        scope,
        moveType,
        validRepTypes,
        requiredEquipments,
        selectableEquipments,
        bodyAreaMoveScores
      ];
  Map<String, dynamic> toJson() => _$CreateMoveInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BodyAreaMoveScoreInput extends JsonSerializable with EquatableMixin {
  BodyAreaMoveScoreInput({required this.bodyArea, required this.score});

  factory BodyAreaMoveScoreInput.fromJson(Map<String, dynamic> json) =>
      _$BodyAreaMoveScoreInputFromJson(json);

  @JsonKey(name: 'BodyArea')
  late ConnectRelationInput bodyArea;

  late double score;

  @override
  List<Object?> get props => [bodyArea, score];
  Map<String, dynamic> toJson() => _$BodyAreaMoveScoreInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateMove$Mutation extends JsonSerializable with EquatableMixin {
  UpdateMove$Mutation();

  factory UpdateMove$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateMove$MutationFromJson(json);

  late Move updateMove;

  @override
  List<Object?> get props => [updateMove];
  Map<String, dynamic> toJson() => _$UpdateMove$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateMoveInput extends JsonSerializable with EquatableMixin {
  UpdateMoveInput(
      {required this.id,
      this.name,
      this.searchTerms,
      this.description,
      this.demoVideoUri,
      this.demoVideoThumbUri,
      this.scope,
      this.moveType,
      this.validRepTypes,
      this.requiredEquipments,
      this.selectableEquipments,
      this.bodyAreaMoveScores});

  factory UpdateMoveInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateMoveInputFromJson(json);

  late String id;

  String? name;

  String? searchTerms;

  String? description;

  String? demoVideoUri;

  String? demoVideoThumbUri;

  @JsonKey(unknownEnumValue: MoveScope.artemisUnknown)
  MoveScope? scope;

  @JsonKey(name: 'MoveType')
  ConnectRelationInput? moveType;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  List<WorkoutMoveRepType>? validRepTypes;

  @JsonKey(name: 'RequiredEquipments')
  List<ConnectRelationInput>? requiredEquipments;

  @JsonKey(name: 'SelectableEquipments')
  List<ConnectRelationInput>? selectableEquipments;

  @JsonKey(name: 'BodyAreaMoveScores')
  List<BodyAreaMoveScoreInput>? bodyAreaMoveScores;

  @override
  List<Object?> get props => [
        id,
        name,
        searchTerms,
        description,
        demoVideoUri,
        demoVideoThumbUri,
        scope,
        moveType,
        validRepTypes,
        requiredEquipments,
        selectableEquipments,
        bodyAreaMoveScores
      ];
  Map<String, dynamic> toJson() => _$UpdateMoveInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteMoveById$Mutation extends JsonSerializable with EquatableMixin {
  DeleteMoveById$Mutation();

  factory DeleteMoveById$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteMoveById$MutationFromJson(json);

  late String softDeleteMoveById;

  @override
  List<Object?> get props => [softDeleteMoveById];
  Map<String, dynamic> toJson() => _$DeleteMoveById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserCustomMoves$Query extends JsonSerializable with EquatableMixin {
  UserCustomMoves$Query();

  factory UserCustomMoves$Query.fromJson(Map<String, dynamic> json) =>
      _$UserCustomMoves$QueryFromJson(json);

  late List<Move> userCustomMoves;

  @override
  List<Object?> get props => [userCustomMoves];
  Map<String, dynamic> toJson() => _$UserCustomMoves$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteGymProfileById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteGymProfileById$Mutation();

  factory DeleteGymProfileById$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteGymProfileById$MutationFromJson(json);

  String? deleteGymProfileById;

  @override
  List<Object?> get props => [deleteGymProfileById];
  Map<String, dynamic> toJson() => _$DeleteGymProfileById$MutationToJson(this);
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

  String? description;

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

  String? name;

  String? description;

  @JsonKey(name: 'Equipments')
  List<String>? equipments;

  @override
  List<Object?> get props => [id, name, description, equipments];
  Map<String, dynamic> toJson() => _$UpdateGymProfileInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutTag extends JsonSerializable with EquatableMixin, WorkoutTagMixin {
  WorkoutTag();

  factory WorkoutTag.fromJson(Map<String, dynamic> json) =>
      _$WorkoutTagFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, tag];
  Map<String, dynamic> toJson() => _$WorkoutTagToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserWorkoutTags$Query extends JsonSerializable with EquatableMixin {
  UserWorkoutTags$Query();

  factory UserWorkoutTags$Query.fromJson(Map<String, dynamic> json) =>
      _$UserWorkoutTags$QueryFromJson(json);

  late List<WorkoutTag> userWorkoutTags;

  @override
  List<Object?> get props => [userWorkoutTags];
  Map<String, dynamic> toJson() => _$UserWorkoutTags$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutTag$Mutation extends JsonSerializable with EquatableMixin {
  CreateWorkoutTag$Mutation();

  factory CreateWorkoutTag$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutTag$MutationFromJson(json);

  late WorkoutTag createWorkoutTag;

  @override
  List<Object?> get props => [createWorkoutTag];
  Map<String, dynamic> toJson() => _$CreateWorkoutTag$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutTagInput extends JsonSerializable with EquatableMixin {
  CreateWorkoutTagInput({required this.tag});

  factory CreateWorkoutTagInput.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutTagInputFromJson(json);

  late String tag;

  @override
  List<Object?> get props => [tag];
  Map<String, dynamic> toJson() => _$CreateWorkoutTagInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutSet extends JsonSerializable
    with EquatableMixin, WorkoutSetMixin {
  UpdateWorkoutSet();

  factory UpdateWorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSetFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, sortPosition, rounds, duration];
  Map<String, dynamic> toJson() => _$UpdateWorkoutSetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutSet$Mutation extends JsonSerializable with EquatableMixin {
  UpdateWorkoutSet$Mutation();

  factory UpdateWorkoutSet$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSet$MutationFromJson(json);

  late UpdateWorkoutSet updateWorkoutSet;

  @override
  List<Object?> get props => [updateWorkoutSet];
  Map<String, dynamic> toJson() => _$UpdateWorkoutSet$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutSetInput extends JsonSerializable with EquatableMixin {
  UpdateWorkoutSetInput({required this.id, this.rounds, this.duration});

  factory UpdateWorkoutSetInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSetInputFromJson(json);

  late String id;

  int? rounds;

  int? duration;

  @override
  List<Object?> get props => [id, rounds, duration];
  Map<String, dynamic> toJson() => _$UpdateWorkoutSetInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSet extends JsonSerializable with EquatableMixin, WorkoutSetMixin {
  WorkoutSet();

  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  @JsonKey(name: 'WorkoutMoves')
  late List<WorkoutMove> workoutMoves;

  @override
  List<Object?> get props =>
      [$$typename, id, sortPosition, rounds, duration, workoutMoves];
  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DuplicateWorkoutSetById$Mutation extends JsonSerializable
    with EquatableMixin {
  DuplicateWorkoutSetById$Mutation();

  factory DuplicateWorkoutSetById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DuplicateWorkoutSetById$MutationFromJson(json);

  late WorkoutSet duplicateWorkoutSetById;

  @override
  List<Object?> get props => [duplicateWorkoutSetById];
  Map<String, dynamic> toJson() =>
      _$DuplicateWorkoutSetById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReorderWorkoutSets$Mutation extends JsonSerializable with EquatableMixin {
  ReorderWorkoutSets$Mutation();

  factory ReorderWorkoutSets$Mutation.fromJson(Map<String, dynamic> json) =>
      _$ReorderWorkoutSets$MutationFromJson(json);

  late List<SortPositionUpdated> reorderWorkoutSets;

  @override
  List<Object?> get props => [reorderWorkoutSets];
  Map<String, dynamic> toJson() => _$ReorderWorkoutSets$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSet extends JsonSerializable
    with EquatableMixin, WorkoutSetMixin {
  CreateWorkoutSet();

  factory CreateWorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutSetFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, sortPosition, rounds, duration];
  Map<String, dynamic> toJson() => _$CreateWorkoutSetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSet$Mutation extends JsonSerializable with EquatableMixin {
  CreateWorkoutSet$Mutation();

  factory CreateWorkoutSet$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutSet$MutationFromJson(json);

  late CreateWorkoutSet createWorkoutSet;

  @override
  List<Object?> get props => [createWorkoutSet];
  Map<String, dynamic> toJson() => _$CreateWorkoutSet$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSetInput extends JsonSerializable with EquatableMixin {
  CreateWorkoutSetInput(
      {required this.sortPosition,
      this.rounds,
      this.duration,
      required this.workoutSection});

  factory CreateWorkoutSetInput.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutSetInputFromJson(json);

  late int sortPosition;

  int? rounds;

  int? duration;

  @JsonKey(name: 'WorkoutSection')
  late ConnectRelationInput workoutSection;

  @override
  List<Object?> get props => [sortPosition, rounds, duration, workoutSection];
  Map<String, dynamic> toJson() => _$CreateWorkoutSetInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkoutSetById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteWorkoutSetById$Mutation();

  factory DeleteWorkoutSetById$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteWorkoutSetById$MutationFromJson(json);

  late String deleteWorkoutSetById;

  @override
  List<Object?> get props => [deleteWorkoutSetById];
  Map<String, dynamic> toJson() => _$DeleteWorkoutSetById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoveTypes$Query extends JsonSerializable with EquatableMixin {
  MoveTypes$Query();

  factory MoveTypes$Query.fromJson(Map<String, dynamic> json) =>
      _$MoveTypes$QueryFromJson(json);

  late List<MoveType> moveTypes;

  @override
  List<Object?> get props => [moveTypes];
  Map<String, dynamic> toJson() => _$MoveTypes$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StandardMoves$Query extends JsonSerializable with EquatableMixin {
  StandardMoves$Query();

  factory StandardMoves$Query.fromJson(Map<String, dynamic> json) =>
      _$StandardMoves$QueryFromJson(json);

  late List<Move> standardMoves;

  @override
  List<Object?> get props => [standardMoves];
  Map<String, dynamic> toJson() => _$StandardMoves$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutGoal extends JsonSerializable
    with EquatableMixin, WorkoutGoalMixin {
  WorkoutGoal();

  factory WorkoutGoal.fromJson(Map<String, dynamic> json) =>
      _$WorkoutGoalFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, name, description];
  Map<String, dynamic> toJson() => _$WorkoutGoalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutGoals$Query extends JsonSerializable with EquatableMixin {
  WorkoutGoals$Query();

  factory WorkoutGoals$Query.fromJson(Map<String, dynamic> json) =>
      _$WorkoutGoals$QueryFromJson(json);

  late List<WorkoutGoal> workoutGoals;

  @override
  List<Object?> get props => [workoutGoals];
  Map<String, dynamic> toJson() => _$WorkoutGoals$QueryToJson(this);
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
class WorkoutSectionType extends JsonSerializable
    with EquatableMixin, WorkoutSectionTypeMixin {
  WorkoutSectionType();

  factory WorkoutSectionType.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSectionTypeFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, name, description];
  Map<String, dynamic> toJson() => _$WorkoutSectionTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSectionTypes$Query extends JsonSerializable with EquatableMixin {
  WorkoutSectionTypes$Query();

  factory WorkoutSectionTypes$Query.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSectionTypes$QueryFromJson(json);

  late List<WorkoutSectionType> workoutSectionTypes;

  @override
  List<Object?> get props => [workoutSectionTypes];
  Map<String, dynamic> toJson() => _$WorkoutSectionTypes$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BodyAreas$Query extends JsonSerializable with EquatableMixin {
  BodyAreas$Query();

  factory BodyAreas$Query.fromJson(Map<String, dynamic> json) =>
      _$BodyAreas$QueryFromJson(json);

  late List<BodyArea> bodyAreas;

  @override
  List<Object?> get props => [bodyAreas];
  Map<String, dynamic> toJson() => _$BodyAreas$QueryToJson(this);
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
class UpdateWorkoutSection extends JsonSerializable
    with EquatableMixin, WorkoutSectionMixin {
  UpdateWorkoutSection();

  factory UpdateWorkoutSection.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSectionFromJson(json);

  @JsonKey(name: 'WorkoutSectionType')
  late WorkoutSectionType workoutSectionType;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        name,
        note,
        rounds,
        timecap,
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
        workoutSectionType
      ];
  Map<String, dynamic> toJson() => _$UpdateWorkoutSectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutSection$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateWorkoutSection$Mutation();

  factory UpdateWorkoutSection$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSection$MutationFromJson(json);

  late UpdateWorkoutSection updateWorkoutSection;

  @override
  List<Object?> get props => [updateWorkoutSection];
  Map<String, dynamic> toJson() => _$UpdateWorkoutSection$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutSectionInput extends JsonSerializable with EquatableMixin {
  UpdateWorkoutSectionInput(
      {required this.id,
      this.name,
      this.note,
      this.rounds,
      this.timecap,
      this.introVideoUri,
      this.introVideoThumbUri,
      this.introAudioUri,
      this.classVideoUri,
      this.classVideoThumbUri,
      this.classAudioUri,
      this.outroVideoUri,
      this.outroVideoThumbUri,
      this.outroAudioUri,
      this.workoutSectionType});

  factory UpdateWorkoutSectionInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSectionInputFromJson(json);

  late String id;

  String? name;

  String? note;

  int? rounds;

  int? timecap;

  String? introVideoUri;

  String? introVideoThumbUri;

  String? introAudioUri;

  String? classVideoUri;

  String? classVideoThumbUri;

  String? classAudioUri;

  String? outroVideoUri;

  String? outroVideoThumbUri;

  String? outroAudioUri;

  @JsonKey(name: 'WorkoutSectionType')
  ConnectRelationInput? workoutSectionType;

  @override
  List<Object?> get props => [
        id,
        name,
        note,
        rounds,
        timecap,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        classVideoUri,
        classVideoThumbUri,
        classAudioUri,
        outroVideoUri,
        outroVideoThumbUri,
        outroAudioUri,
        workoutSectionType
      ];
  Map<String, dynamic> toJson() => _$UpdateWorkoutSectionInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSection extends JsonSerializable
    with EquatableMixin, WorkoutSectionMixin {
  WorkoutSection();

  factory WorkoutSection.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSectionFromJson(json);

  @JsonKey(name: 'WorkoutSectionType')
  late WorkoutSectionType workoutSectionType;

  @JsonKey(name: 'WorkoutSets')
  late List<WorkoutSet> workoutSets;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        name,
        note,
        rounds,
        timecap,
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
        workoutSets
      ];
  Map<String, dynamic> toJson() => _$WorkoutSectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSection$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateWorkoutSection$Mutation();

  factory CreateWorkoutSection$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutSection$MutationFromJson(json);

  late WorkoutSection createWorkoutSection;

  @override
  List<Object?> get props => [createWorkoutSection];
  Map<String, dynamic> toJson() => _$CreateWorkoutSection$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSectionInput extends JsonSerializable with EquatableMixin {
  CreateWorkoutSectionInput(
      {this.name,
      this.note,
      this.rounds,
      this.timecap,
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

  String? name;

  String? note;

  int? rounds;

  int? timecap;

  late int sortPosition;

  String? introVideoUri;

  String? introVideoThumbUri;

  String? introAudioUri;

  String? classVideoUri;

  String? classVideoThumbUri;

  String? classAudioUri;

  String? outroVideoUri;

  String? outroVideoThumbUri;

  String? outroAudioUri;

  @JsonKey(name: 'WorkoutSectionType')
  late ConnectRelationInput workoutSectionType;

  @JsonKey(name: 'Workout')
  late ConnectRelationInput workout;

  @override
  List<Object?> get props => [
        name,
        note,
        rounds,
        timecap,
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
class ReorderWorkoutSections$Mutation extends JsonSerializable
    with EquatableMixin {
  ReorderWorkoutSections$Mutation();

  factory ReorderWorkoutSections$Mutation.fromJson(Map<String, dynamic> json) =>
      _$ReorderWorkoutSections$MutationFromJson(json);

  late List<SortPositionUpdated> reorderWorkoutSections;

  @override
  List<Object?> get props => [reorderWorkoutSections];
  Map<String, dynamic> toJson() =>
      _$ReorderWorkoutSections$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkoutSectionById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteWorkoutSectionById$Mutation();

  factory DeleteWorkoutSectionById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteWorkoutSectionById$MutationFromJson(json);

  late String deleteWorkoutSectionById;

  @override
  List<Object?> get props => [deleteWorkoutSectionById];
  Map<String, dynamic> toJson() =>
      _$DeleteWorkoutSectionById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkout extends JsonSerializable
    with EquatableMixin, WorkoutFieldsMixin {
  UpdateWorkout();

  factory UpdateWorkout.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutFromJson(json);

  @JsonKey(name: 'WorkoutGoals')
  late List<WorkoutGoal> workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  late List<WorkoutTag> workoutTags;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        name,
        description,
        difficultyLevel,
        coverImageUri,
        contentAccessScope,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        workoutGoals,
        workoutTags
      ];
  Map<String, dynamic> toJson() => _$UpdateWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkout$Mutation extends JsonSerializable with EquatableMixin {
  UpdateWorkout$Mutation();

  factory UpdateWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkout$MutationFromJson(json);

  late UpdateWorkout updateWorkout;

  @override
  List<Object?> get props => [updateWorkout];
  Map<String, dynamic> toJson() => _$UpdateWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutInput extends JsonSerializable with EquatableMixin {
  UpdateWorkoutInput(
      {required this.id,
      this.name,
      this.description,
      this.introVideoUri,
      this.introVideoThumbUri,
      this.introAudioUri,
      this.coverImageUri,
      this.difficultyLevel,
      this.contentAccessScope,
      this.workoutGoals,
      this.workoutTags});

  factory UpdateWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutInputFromJson(json);

  late String id;

  String? name;

  String? description;

  String? introVideoUri;

  String? introVideoThumbUri;

  String? introAudioUri;

  String? coverImageUri;

  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  DifficultyLevel? difficultyLevel;

  @JsonKey(unknownEnumValue: ContentAccessScope.artemisUnknown)
  ContentAccessScope? contentAccessScope;

  @JsonKey(name: 'WorkoutGoals')
  List<ConnectRelationInput>? workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  List<ConnectRelationInput>? workoutTags;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        coverImageUri,
        difficultyLevel,
        contentAccessScope,
        workoutGoals,
        workoutTags
      ];
  Map<String, dynamic> toJson() => _$UpdateWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserSummary extends JsonSerializable
    with EquatableMixin, UserSummaryMixin {
  UserSummary();

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, avatarUri, displayName];
  Map<String, dynamic> toJson() => _$UserSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoveSummary extends JsonSerializable with EquatableMixin {
  MoveSummary();

  factory MoveSummary.fromJson(Map<String, dynamic> json) =>
      _$MoveSummaryFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  late String name;

  @JsonKey(name: 'RequiredEquipments')
  late List<Equipment> requiredEquipments;

  @override
  List<Object?> get props => [$$typename, id, name, requiredEquipments];
  Map<String, dynamic> toJson() => _$MoveSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutMoveSummary extends JsonSerializable with EquatableMixin {
  WorkoutMoveSummary();

  factory WorkoutMoveSummary.fromJson(Map<String, dynamic> json) =>
      _$WorkoutMoveSummaryFromJson(json);

  @JsonKey(name: 'Equipment')
  Equipment? equipment;

  @JsonKey(name: 'Move')
  late MoveSummary move;

  @override
  List<Object?> get props => [equipment, move];
  Map<String, dynamic> toJson() => _$WorkoutMoveSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSetSummary extends JsonSerializable with EquatableMixin {
  WorkoutSetSummary();

  factory WorkoutSetSummary.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetSummaryFromJson(json);

  @JsonKey(name: 'WorkoutMoves')
  late List<WorkoutMoveSummary> workoutMoves;

  @override
  List<Object?> get props => [workoutMoves];
  Map<String, dynamic> toJson() => _$WorkoutSetSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSectionSummary extends JsonSerializable with EquatableMixin {
  WorkoutSectionSummary();

  factory WorkoutSectionSummary.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSectionSummaryFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  String? name;

  late int sortPosition;

  int? timecap;

  @JsonKey(name: 'WorkoutSectionType')
  late WorkoutSectionType workoutSectionType;

  @JsonKey(name: 'WorkoutSets')
  late List<WorkoutSetSummary> workoutSets;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        name,
        sortPosition,
        timecap,
        workoutSectionType,
        workoutSets
      ];
  Map<String, dynamic> toJson() => _$WorkoutSectionSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSummary extends JsonSerializable with EquatableMixin {
  WorkoutSummary();

  factory WorkoutSummary.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSummaryFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  DateTime? createdAt;

  late String name;

  String? description;

  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  late DifficultyLevel difficultyLevel;

  String? coverImageUri;

  @JsonKey(name: 'User')
  UserSummary? user;

  @JsonKey(name: 'WorkoutGoals')
  late List<WorkoutGoal> workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  late List<WorkoutTag> workoutTags;

  @JsonKey(name: 'WorkoutSections')
  late List<WorkoutSectionSummary> workoutSections;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        name,
        description,
        difficultyLevel,
        coverImageUri,
        user,
        workoutGoals,
        workoutTags,
        workoutSections
      ];
  Map<String, dynamic> toJson() => _$WorkoutSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserWorkouts$Query extends JsonSerializable with EquatableMixin {
  UserWorkouts$Query();

  factory UserWorkouts$Query.fromJson(Map<String, dynamic> json) =>
      _$UserWorkouts$QueryFromJson(json);

  late List<WorkoutSummary> userWorkouts;

  @override
  List<Object?> get props => [userWorkouts];
  Map<String, dynamic> toJson() => _$UserWorkouts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkout extends JsonSerializable
    with EquatableMixin, WorkoutFieldsMixin {
  CreateWorkout();

  factory CreateWorkout.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutFromJson(json);

  @JsonKey(name: 'WorkoutGoals')
  late List<WorkoutGoal> workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  late List<WorkoutTag> workoutTags;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        name,
        description,
        difficultyLevel,
        coverImageUri,
        contentAccessScope,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        workoutGoals,
        workoutTags
      ];
  Map<String, dynamic> toJson() => _$CreateWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkout$Mutation extends JsonSerializable with EquatableMixin {
  CreateWorkout$Mutation();

  factory CreateWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkout$MutationFromJson(json);

  late CreateWorkout createWorkout;

  @override
  List<Object?> get props => [createWorkout];
  Map<String, dynamic> toJson() => _$CreateWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutInput extends JsonSerializable with EquatableMixin {
  CreateWorkoutInput(
      {required this.name,
      required this.difficultyLevel,
      required this.contentAccessScope});

  factory CreateWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutInputFromJson(json);

  late String name;

  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  late DifficultyLevel difficultyLevel;

  @JsonKey(unknownEnumValue: ContentAccessScope.artemisUnknown)
  late ContentAccessScope contentAccessScope;

  @override
  List<Object?> get props => [name, difficultyLevel, contentAccessScope];
  Map<String, dynamic> toJson() => _$CreateWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Workout extends JsonSerializable with EquatableMixin, WorkoutFieldsMixin {
  Workout();

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  @JsonKey(name: 'User')
  UserSummary? user;

  @JsonKey(name: 'WorkoutGoals')
  late List<WorkoutGoal> workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  late List<WorkoutTag> workoutTags;

  @JsonKey(name: 'WorkoutSections')
  late List<WorkoutSection> workoutSections;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        name,
        description,
        difficultyLevel,
        coverImageUri,
        contentAccessScope,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        user,
        workoutGoals,
        workoutTags,
        workoutSections
      ];
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
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

enum BodyAreaFrontBack {
  @JsonValue('BACK')
  back,
  @JsonValue('FRONT')
  front,
  @JsonValue('BOTH')
  both,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum BodyAreaUpperLower {
  @JsonValue('CORE')
  core,
  @JsonValue('LOWER')
  lower,
  @JsonValue('UPPER')
  upper,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum DistanceUnit {
  @JsonValue('METRES')
  metres,
  @JsonValue('KILOMETRES')
  kilometres,
  @JsonValue('YARDS')
  yards,
  @JsonValue('MILES')
  miles,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum LoadUnit {
  @JsonValue('KG')
  kg,
  @JsonValue('LB')
  lb,
  @JsonValue('BODYWEIGHTPERCENT')
  bodyweightpercent,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum MoveScope {
  @JsonValue('STANDARD')
  standard,
  @JsonValue('CUSTOM')
  custom,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum TimeUnit {
  @JsonValue('HOURS')
  hours,
  @JsonValue('MINUTES')
  minutes,
  @JsonValue('SECONDS')
  seconds,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum WorkoutMoveRepType {
  @JsonValue('REPS')
  reps,
  @JsonValue('CALORIES')
  calories,
  @JsonValue('DISTANCE')
  distance,
  @JsonValue('TIME')
  time,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
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

@JsonSerializable(explicitToJson: true)
class CreateWorkoutMoveArguments extends JsonSerializable with EquatableMixin {
  CreateWorkoutMoveArguments({required this.data});

  @override
  factory CreateWorkoutMoveArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutMoveArgumentsFromJson(json);

  late CreateWorkoutMoveInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkoutMoveArgumentsToJson(this);
}

final CREATE_WORKOUT_MOVE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createWorkoutMove'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateWorkoutMoveInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createWorkoutMove'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutMove'), directives: []),
              FieldNode(
                  name: NameNode(value: 'Equipment'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Equipment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'Move'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Move'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'MoveType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'MoveType'), directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'BodyAreaMoveScores'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'score'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'BodyArea'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'BodyArea'),
                                    directives: [])
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'RequiredEquipments'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'SelectableEquipments'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ]))
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reps'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadAmount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateWorkoutMoveMutation extends GraphQLQuery<CreateWorkoutMove$Mutation,
    CreateWorkoutMoveArguments> {
  CreateWorkoutMoveMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_WORKOUT_MOVE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createWorkoutMove';

  @override
  final CreateWorkoutMoveArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateWorkoutMove$Mutation parse(Map<String, dynamic> json) =>
      CreateWorkoutMove$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DuplicateWorkoutMoveByIdArguments extends JsonSerializable
    with EquatableMixin {
  DuplicateWorkoutMoveByIdArguments({required this.id});

  @override
  factory DuplicateWorkoutMoveByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DuplicateWorkoutMoveByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DuplicateWorkoutMoveByIdArgumentsToJson(this);
}

final DUPLICATE_WORKOUT_MOVE_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'duplicateWorkoutMoveById'),
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
            name: NameNode(value: 'duplicateWorkoutMoveById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutMove'), directives: []),
              FieldNode(
                  name: NameNode(value: 'Equipment'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Equipment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'Move'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Move'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'MoveType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'MoveType'), directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'BodyAreaMoveScores'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'score'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'BodyArea'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'BodyArea'),
                                    directives: [])
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'RequiredEquipments'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'SelectableEquipments'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ]))
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reps'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadAmount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class DuplicateWorkoutMoveByIdMutation extends GraphQLQuery<
    DuplicateWorkoutMoveById$Mutation, DuplicateWorkoutMoveByIdArguments> {
  DuplicateWorkoutMoveByIdMutation({required this.variables});

  @override
  final DocumentNode document = DUPLICATE_WORKOUT_MOVE_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'duplicateWorkoutMoveById';

  @override
  final DuplicateWorkoutMoveByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DuplicateWorkoutMoveById$Mutation parse(Map<String, dynamic> json) =>
      DuplicateWorkoutMoveById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkoutMoveByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteWorkoutMoveByIdArguments({required this.id});

  @override
  factory DeleteWorkoutMoveByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteWorkoutMoveByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DeleteWorkoutMoveByIdArgumentsToJson(this);
}

final DELETE_WORKOUT_MOVE_BY_ID_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteWorkoutMoveById'),
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
            name: NameNode(value: 'deleteWorkoutMoveById'),
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

class DeleteWorkoutMoveByIdMutation extends GraphQLQuery<
    DeleteWorkoutMoveById$Mutation, DeleteWorkoutMoveByIdArguments> {
  DeleteWorkoutMoveByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_WORKOUT_MOVE_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteWorkoutMoveById';

  @override
  final DeleteWorkoutMoveByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteWorkoutMoveById$Mutation parse(Map<String, dynamic> json) =>
      DeleteWorkoutMoveById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ReorderWorkoutMovesArguments extends JsonSerializable
    with EquatableMixin {
  ReorderWorkoutMovesArguments({required this.data});

  @override
  factory ReorderWorkoutMovesArguments.fromJson(Map<String, dynamic> json) =>
      _$ReorderWorkoutMovesArgumentsFromJson(json);

  late List<UpdateSortPositionInput> data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$ReorderWorkoutMovesArgumentsToJson(this);
}

final REORDER_WORKOUT_MOVES_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'reorderWorkoutMoves'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'UpdateSortPositionInput'),
                    isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'reorderWorkoutMoves'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
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
                  name: NameNode(value: 'sortPosition'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class ReorderWorkoutMovesMutation extends GraphQLQuery<
    ReorderWorkoutMoves$Mutation, ReorderWorkoutMovesArguments> {
  ReorderWorkoutMovesMutation({required this.variables});

  @override
  final DocumentNode document = REORDER_WORKOUT_MOVES_MUTATION_DOCUMENT;

  @override
  final String operationName = 'reorderWorkoutMoves';

  @override
  final ReorderWorkoutMovesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ReorderWorkoutMoves$Mutation parse(Map<String, dynamic> json) =>
      ReorderWorkoutMoves$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutMoveArguments extends JsonSerializable with EquatableMixin {
  UpdateWorkoutMoveArguments({required this.data});

  @override
  factory UpdateWorkoutMoveArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutMoveArgumentsFromJson(json);

  late UpdateWorkoutMoveInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateWorkoutMoveArgumentsToJson(this);
}

final UPDATE_WORKOUT_MOVE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateWorkoutMove'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateWorkoutMoveInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateWorkoutMove'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutMove'), directives: []),
              FieldNode(
                  name: NameNode(value: 'Equipment'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Equipment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'Move'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Move'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'MoveType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'MoveType'), directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'BodyAreaMoveScores'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'score'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'BodyArea'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'BodyArea'),
                                    directives: [])
                              ]))
                        ])),
                    FieldNode(
                        name: NameNode(value: 'RequiredEquipments'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'SelectableEquipments'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ]))
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reps'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadAmount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateWorkoutMoveMutation extends GraphQLQuery<UpdateWorkoutMove$Mutation,
    UpdateWorkoutMoveArguments> {
  UpdateWorkoutMoveMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_WORKOUT_MOVE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateWorkoutMove';

  @override
  final UpdateWorkoutMoveArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateWorkoutMove$Mutation parse(Map<String, dynamic> json) =>
      UpdateWorkoutMove$Mutation.fromJson(json);
}

final AUTHED_USER_QUERY_DOCUMENT = DocumentNode(definitions: [
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
              FragmentSpreadNode(name: NameNode(value: 'User'), directives: [])
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

class AuthedUserQuery extends GraphQLQuery<AuthedUser$Query, JsonSerializable> {
  AuthedUserQuery();

  @override
  final DocumentNode document = AUTHED_USER_QUERY_DOCUMENT;

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

  late UpdateUserInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateUserArgumentsToJson(this);
}

final UPDATE_USER_MUTATION_DOCUMENT = DocumentNode(definitions: [
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
              FragmentSpreadNode(name: NameNode(value: 'User'), directives: [])
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

class UpdateUserMutation
    extends GraphQLQuery<UpdateUser$Mutation, UpdateUserArguments> {
  UpdateUserMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_USER_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateUser';

  @override
  final UpdateUserArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateUser$Mutation parse(Map<String, dynamic> json) =>
      UpdateUser$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateMoveArguments extends JsonSerializable with EquatableMixin {
  CreateMoveArguments({required this.data});

  @override
  factory CreateMoveArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateMoveArgumentsFromJson(json);

  late CreateMoveInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateMoveArgumentsToJson(this);
}

final CREATE_MOVE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createMove'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateMoveInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createMove'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: 'Move'), directives: []),
              FieldNode(
                  name: NameNode(value: 'MoveType'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'MoveType'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'BodyAreaMoveScores'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'score'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'BodyArea'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'BodyArea'), directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'RequiredEquipments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Equipment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'SelectableEquipments'),
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
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
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateMoveMutation
    extends GraphQLQuery<CreateMove$Mutation, CreateMoveArguments> {
  CreateMoveMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_MOVE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createMove';

  @override
  final CreateMoveArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateMove$Mutation parse(Map<String, dynamic> json) =>
      CreateMove$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateMoveArguments extends JsonSerializable with EquatableMixin {
  UpdateMoveArguments({required this.data});

  @override
  factory UpdateMoveArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateMoveArgumentsFromJson(json);

  late UpdateMoveInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateMoveArgumentsToJson(this);
}

final UPDATE_MOVE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateMove'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateMoveInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateMove'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: 'Move'), directives: []),
              FieldNode(
                  name: NameNode(value: 'MoveType'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'MoveType'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'BodyAreaMoveScores'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'score'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'BodyArea'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'BodyArea'), directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'RequiredEquipments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Equipment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'SelectableEquipments'),
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
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
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateMoveMutation
    extends GraphQLQuery<UpdateMove$Mutation, UpdateMoveArguments> {
  UpdateMoveMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_MOVE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateMove';

  @override
  final UpdateMoveArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateMove$Mutation parse(Map<String, dynamic> json) =>
      UpdateMove$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteMoveByIdArguments extends JsonSerializable with EquatableMixin {
  DeleteMoveByIdArguments({required this.id});

  @override
  factory DeleteMoveByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteMoveByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DeleteMoveByIdArgumentsToJson(this);
}

final DELETE_MOVE_BY_ID_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteMoveById'),
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
            name: NameNode(value: 'softDeleteMoveById'),
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

class DeleteMoveByIdMutation
    extends GraphQLQuery<DeleteMoveById$Mutation, DeleteMoveByIdArguments> {
  DeleteMoveByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_MOVE_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteMoveById';

  @override
  final DeleteMoveByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteMoveById$Mutation parse(Map<String, dynamic> json) =>
      DeleteMoveById$Mutation.fromJson(json);
}

final USER_CUSTOM_MOVES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userCustomMoves'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userCustomMoves'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: 'Move'), directives: []),
              FieldNode(
                  name: NameNode(value: 'MoveType'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'MoveType'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'BodyAreaMoveScores'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'score'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'BodyArea'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'BodyArea'), directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'RequiredEquipments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Equipment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'SelectableEquipments'),
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
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
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UserCustomMovesQuery
    extends GraphQLQuery<UserCustomMoves$Query, JsonSerializable> {
  UserCustomMovesQuery();

  @override
  final DocumentNode document = USER_CUSTOM_MOVES_QUERY_DOCUMENT;

  @override
  final String operationName = 'userCustomMoves';

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserCustomMoves$Query parse(Map<String, dynamic> json) =>
      UserCustomMoves$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteGymProfileByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteGymProfileByIdArguments({required this.id});

  @override
  factory DeleteGymProfileByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteGymProfileByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DeleteGymProfileByIdArgumentsToJson(this);
}

final DELETE_GYM_PROFILE_BY_ID_MUTATION_DOCUMENT = DocumentNode(definitions: [
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

class DeleteGymProfileByIdMutation extends GraphQLQuery<
    DeleteGymProfileById$Mutation, DeleteGymProfileByIdArguments> {
  DeleteGymProfileByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_GYM_PROFILE_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteGymProfileById';

  @override
  final DeleteGymProfileByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteGymProfileById$Mutation parse(Map<String, dynamic> json) =>
      DeleteGymProfileById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateGymProfileArguments extends JsonSerializable with EquatableMixin {
  CreateGymProfileArguments({required this.data});

  @override
  factory CreateGymProfileArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateGymProfileArgumentsFromJson(json);

  late CreateGymProfileInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateGymProfileArgumentsToJson(this);
}

final CREATE_GYM_PROFILE_MUTATION_DOCUMENT = DocumentNode(definitions: [
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

class CreateGymProfileMutation
    extends GraphQLQuery<CreateGymProfile$Mutation, CreateGymProfileArguments> {
  CreateGymProfileMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_GYM_PROFILE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createGymProfile';

  @override
  final CreateGymProfileArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateGymProfile$Mutation parse(Map<String, dynamic> json) =>
      CreateGymProfile$Mutation.fromJson(json);
}

final GYM_PROFILES_QUERY_DOCUMENT = DocumentNode(definitions: [
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

class GymProfilesQuery
    extends GraphQLQuery<GymProfiles$Query, JsonSerializable> {
  GymProfilesQuery();

  @override
  final DocumentNode document = GYM_PROFILES_QUERY_DOCUMENT;

  @override
  final String operationName = 'gymProfiles';

  @override
  List<Object?> get props => [document, operationName];
  @override
  GymProfiles$Query parse(Map<String, dynamic> json) =>
      GymProfiles$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateGymProfileArguments extends JsonSerializable with EquatableMixin {
  UpdateGymProfileArguments({required this.data});

  @override
  factory UpdateGymProfileArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateGymProfileArgumentsFromJson(json);

  late UpdateGymProfileInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateGymProfileArgumentsToJson(this);
}

final UPDATE_GYM_PROFILE_MUTATION_DOCUMENT = DocumentNode(definitions: [
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

class UpdateGymProfileMutation
    extends GraphQLQuery<UpdateGymProfile$Mutation, UpdateGymProfileArguments> {
  UpdateGymProfileMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_GYM_PROFILE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateGymProfile';

  @override
  final UpdateGymProfileArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateGymProfile$Mutation parse(Map<String, dynamic> json) =>
      UpdateGymProfile$Mutation.fromJson(json);
}

final USER_WORKOUT_TAGS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userWorkoutTags'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userWorkoutTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutTag'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutTag'), isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UserWorkoutTagsQuery
    extends GraphQLQuery<UserWorkoutTags$Query, JsonSerializable> {
  UserWorkoutTagsQuery();

  @override
  final DocumentNode document = USER_WORKOUT_TAGS_QUERY_DOCUMENT;

  @override
  final String operationName = 'userWorkoutTags';

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserWorkoutTags$Query parse(Map<String, dynamic> json) =>
      UserWorkoutTags$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutTagArguments extends JsonSerializable with EquatableMixin {
  CreateWorkoutTagArguments({required this.data});

  @override
  factory CreateWorkoutTagArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutTagArgumentsFromJson(json);

  late CreateWorkoutTagInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkoutTagArgumentsToJson(this);
}

final CREATE_WORKOUT_TAG_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createWorkoutTag'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateWorkoutTagInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createWorkoutTag'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutTag'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutTag'), isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateWorkoutTagMutation
    extends GraphQLQuery<CreateWorkoutTag$Mutation, CreateWorkoutTagArguments> {
  CreateWorkoutTagMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_WORKOUT_TAG_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createWorkoutTag';

  @override
  final CreateWorkoutTagArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateWorkoutTag$Mutation parse(Map<String, dynamic> json) =>
      CreateWorkoutTag$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutSetArguments extends JsonSerializable with EquatableMixin {
  UpdateWorkoutSetArguments({required this.data});

  @override
  factory UpdateWorkoutSetArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSetArgumentsFromJson(json);

  late UpdateWorkoutSetInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateWorkoutSetArgumentsToJson(this);
}

final UPDATE_WORKOUT_SET_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateWorkoutSet'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateWorkoutSetInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateWorkoutSet'),
            alias: NameNode(value: 'updateWorkoutSet'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutSet'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateWorkoutSetMutation
    extends GraphQLQuery<UpdateWorkoutSet$Mutation, UpdateWorkoutSetArguments> {
  UpdateWorkoutSetMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_WORKOUT_SET_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateWorkoutSet';

  @override
  final UpdateWorkoutSetArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateWorkoutSet$Mutation parse(Map<String, dynamic> json) =>
      UpdateWorkoutSet$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DuplicateWorkoutSetByIdArguments extends JsonSerializable
    with EquatableMixin {
  DuplicateWorkoutSetByIdArguments({required this.id});

  @override
  factory DuplicateWorkoutSetByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DuplicateWorkoutSetByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DuplicateWorkoutSetByIdArgumentsToJson(this);
}

final DUPLICATE_WORKOUT_SET_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'duplicateWorkoutSetById'),
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
            name: NameNode(value: 'duplicateWorkoutSetById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutSet'), directives: []),
              FieldNode(
                  name: NameNode(value: 'WorkoutMoves'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutMove'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'Equipment'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'Move'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'Move'), directives: []),
                          FieldNode(
                              name: NameNode(value: 'MoveType'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'MoveType'),
                                    directives: [])
                              ])),
                          FieldNode(
                              name: NameNode(value: 'BodyAreaMoveScores'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'score'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'BodyArea'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'BodyArea'),
                                          directives: [])
                                    ]))
                              ])),
                          FieldNode(
                              name: NameNode(value: 'RequiredEquipments'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Equipment'),
                                    directives: [])
                              ])),
                          FieldNode(
                              name: NameNode(value: 'SelectableEquipments'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Equipment'),
                                    directives: [])
                              ]))
                        ]))
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reps'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadAmount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class DuplicateWorkoutSetByIdMutation extends GraphQLQuery<
    DuplicateWorkoutSetById$Mutation, DuplicateWorkoutSetByIdArguments> {
  DuplicateWorkoutSetByIdMutation({required this.variables});

  @override
  final DocumentNode document = DUPLICATE_WORKOUT_SET_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'duplicateWorkoutSetById';

  @override
  final DuplicateWorkoutSetByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DuplicateWorkoutSetById$Mutation parse(Map<String, dynamic> json) =>
      DuplicateWorkoutSetById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ReorderWorkoutSetsArguments extends JsonSerializable with EquatableMixin {
  ReorderWorkoutSetsArguments({required this.data});

  @override
  factory ReorderWorkoutSetsArguments.fromJson(Map<String, dynamic> json) =>
      _$ReorderWorkoutSetsArgumentsFromJson(json);

  late List<UpdateSortPositionInput> data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$ReorderWorkoutSetsArgumentsToJson(this);
}

final REORDER_WORKOUT_SETS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'reorderWorkoutSets'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'UpdateSortPositionInput'),
                    isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'reorderWorkoutSets'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
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
                  name: NameNode(value: 'sortPosition'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class ReorderWorkoutSetsMutation extends GraphQLQuery<
    ReorderWorkoutSets$Mutation, ReorderWorkoutSetsArguments> {
  ReorderWorkoutSetsMutation({required this.variables});

  @override
  final DocumentNode document = REORDER_WORKOUT_SETS_MUTATION_DOCUMENT;

  @override
  final String operationName = 'reorderWorkoutSets';

  @override
  final ReorderWorkoutSetsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ReorderWorkoutSets$Mutation parse(Map<String, dynamic> json) =>
      ReorderWorkoutSets$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSetArguments extends JsonSerializable with EquatableMixin {
  CreateWorkoutSetArguments({required this.data});

  @override
  factory CreateWorkoutSetArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutSetArgumentsFromJson(json);

  late CreateWorkoutSetInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkoutSetArgumentsToJson(this);
}

final CREATE_WORKOUT_SET_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createWorkoutSet'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateWorkoutSetInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createWorkoutSet'),
            alias: NameNode(value: 'createWorkoutSet'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutSet'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateWorkoutSetMutation
    extends GraphQLQuery<CreateWorkoutSet$Mutation, CreateWorkoutSetArguments> {
  CreateWorkoutSetMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_WORKOUT_SET_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createWorkoutSet';

  @override
  final CreateWorkoutSetArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateWorkoutSet$Mutation parse(Map<String, dynamic> json) =>
      CreateWorkoutSet$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkoutSetByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteWorkoutSetByIdArguments({required this.id});

  @override
  factory DeleteWorkoutSetByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteWorkoutSetByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DeleteWorkoutSetByIdArgumentsToJson(this);
}

final DELETE_WORKOUT_SET_BY_ID_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteWorkoutSetById'),
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
            name: NameNode(value: 'deleteWorkoutSetById'),
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

class DeleteWorkoutSetByIdMutation extends GraphQLQuery<
    DeleteWorkoutSetById$Mutation, DeleteWorkoutSetByIdArguments> {
  DeleteWorkoutSetByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_WORKOUT_SET_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteWorkoutSetById';

  @override
  final DeleteWorkoutSetByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteWorkoutSetById$Mutation parse(Map<String, dynamic> json) =>
      DeleteWorkoutSetById$Mutation.fromJson(json);
}

final MOVE_TYPES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'moveTypes'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'moveTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'MoveType'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class MoveTypesQuery extends GraphQLQuery<MoveTypes$Query, JsonSerializable> {
  MoveTypesQuery();

  @override
  final DocumentNode document = MOVE_TYPES_QUERY_DOCUMENT;

  @override
  final String operationName = 'moveTypes';

  @override
  List<Object?> get props => [document, operationName];
  @override
  MoveTypes$Query parse(Map<String, dynamic> json) =>
      MoveTypes$Query.fromJson(json);
}

final STANDARD_MOVES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'standardMoves'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'standardMoves'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(name: NameNode(value: 'Move'), directives: []),
              FieldNode(
                  name: NameNode(value: 'MoveType'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'MoveType'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'BodyAreaMoveScores'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'score'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'BodyArea'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'BodyArea'), directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'RequiredEquipments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Equipment'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'SelectableEquipments'),
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
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
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class StandardMovesQuery
    extends GraphQLQuery<StandardMoves$Query, JsonSerializable> {
  StandardMovesQuery();

  @override
  final DocumentNode document = STANDARD_MOVES_QUERY_DOCUMENT;

  @override
  final String operationName = 'standardMoves';

  @override
  List<Object?> get props => [document, operationName];
  @override
  StandardMoves$Query parse(Map<String, dynamic> json) =>
      StandardMoves$Query.fromJson(json);
}

final WORKOUT_GOALS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'workoutGoals'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'workoutGoals'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutGoal'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutGoal'), isNonNull: false)),
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

class WorkoutGoalsQuery
    extends GraphQLQuery<WorkoutGoals$Query, JsonSerializable> {
  WorkoutGoalsQuery();

  @override
  final DocumentNode document = WORKOUT_GOALS_QUERY_DOCUMENT;

  @override
  final String operationName = 'workoutGoals';

  @override
  List<Object?> get props => [document, operationName];
  @override
  WorkoutGoals$Query parse(Map<String, dynamic> json) =>
      WorkoutGoals$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CheckUniqueDisplayNameArguments extends JsonSerializable
    with EquatableMixin {
  CheckUniqueDisplayNameArguments({required this.displayName});

  @override
  factory CheckUniqueDisplayNameArguments.fromJson(Map<String, dynamic> json) =>
      _$CheckUniqueDisplayNameArgumentsFromJson(json);

  late String displayName;

  @override
  List<Object?> get props => [displayName];
  @override
  Map<String, dynamic> toJson() =>
      _$CheckUniqueDisplayNameArgumentsToJson(this);
}

final CHECK_UNIQUE_DISPLAY_NAME_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'checkUniqueDisplayName'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'displayName')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
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

class CheckUniqueDisplayNameQuery extends GraphQLQuery<
    CheckUniqueDisplayName$Query, CheckUniqueDisplayNameArguments> {
  CheckUniqueDisplayNameQuery({required this.variables});

  @override
  final DocumentNode document = CHECK_UNIQUE_DISPLAY_NAME_QUERY_DOCUMENT;

  @override
  final String operationName = 'checkUniqueDisplayName';

  @override
  final CheckUniqueDisplayNameArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CheckUniqueDisplayName$Query parse(Map<String, dynamic> json) =>
      CheckUniqueDisplayName$Query.fromJson(json);
}

final WORKOUT_SECTION_TYPES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'workoutSectionTypes'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'workoutSectionTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutSectionType'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSectionType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSectionType'), isNonNull: false)),
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

class WorkoutSectionTypesQuery
    extends GraphQLQuery<WorkoutSectionTypes$Query, JsonSerializable> {
  WorkoutSectionTypesQuery();

  @override
  final DocumentNode document = WORKOUT_SECTION_TYPES_QUERY_DOCUMENT;

  @override
  final String operationName = 'workoutSectionTypes';

  @override
  List<Object?> get props => [document, operationName];
  @override
  WorkoutSectionTypes$Query parse(Map<String, dynamic> json) =>
      WorkoutSectionTypes$Query.fromJson(json);
}

final BODY_AREAS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'bodyAreas'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'bodyAreas'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'BodyArea'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class BodyAreasQuery extends GraphQLQuery<BodyAreas$Query, JsonSerializable> {
  BodyAreasQuery();

  @override
  final DocumentNode document = BODY_AREAS_QUERY_DOCUMENT;

  @override
  final String operationName = 'bodyAreas';

  @override
  List<Object?> get props => [document, operationName];
  @override
  BodyAreas$Query parse(Map<String, dynamic> json) =>
      BodyAreas$Query.fromJson(json);
}

final EQUIPMENTS_QUERY_DOCUMENT = DocumentNode(definitions: [
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

class EquipmentsQuery extends GraphQLQuery<Equipments$Query, JsonSerializable> {
  EquipmentsQuery();

  @override
  final DocumentNode document = EQUIPMENTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'equipments';

  @override
  List<Object?> get props => [document, operationName];
  @override
  Equipments$Query parse(Map<String, dynamic> json) =>
      Equipments$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutSectionArguments extends JsonSerializable
    with EquatableMixin {
  UpdateWorkoutSectionArguments({required this.data});

  @override
  factory UpdateWorkoutSectionArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutSectionArgumentsFromJson(json);

  late UpdateWorkoutSectionInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateWorkoutSectionArgumentsToJson(this);
}

final UPDATE_WORKOUT_SECTION_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateWorkoutSection'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateWorkoutSectionInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateWorkoutSection'),
            alias: NameNode(value: 'updateWorkoutSection'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutSection'), directives: []),
              FieldNode(
                  name: NameNode(value: 'WorkoutSectionType'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutSectionType'),
                        directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSectionType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSectionType'), isNonNull: false)),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSection'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSection'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timecap'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'sortPosition'),
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
            name: NameNode(value: 'introAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateWorkoutSectionMutation extends GraphQLQuery<
    UpdateWorkoutSection$Mutation, UpdateWorkoutSectionArguments> {
  UpdateWorkoutSectionMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_WORKOUT_SECTION_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateWorkoutSection';

  @override
  final UpdateWorkoutSectionArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateWorkoutSection$Mutation parse(Map<String, dynamic> json) =>
      UpdateWorkoutSection$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutSectionArguments extends JsonSerializable
    with EquatableMixin {
  CreateWorkoutSectionArguments({required this.data});

  @override
  factory CreateWorkoutSectionArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutSectionArgumentsFromJson(json);

  late CreateWorkoutSectionInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkoutSectionArgumentsToJson(this);
}

final CREATE_WORKOUT_SECTION_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createWorkoutSection'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateWorkoutSectionInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createWorkoutSection'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutSection'), directives: []),
              FieldNode(
                  name: NameNode(value: 'WorkoutSectionType'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutSectionType'),
                        directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutSets'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutSet'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'WorkoutMoves'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutMove'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: 'Equipment'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Equipment'),
                                    directives: [])
                              ])),
                          FieldNode(
                              name: NameNode(value: 'Move'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Move'),
                                    directives: []),
                                FieldNode(
                                    name: NameNode(value: 'MoveType'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'MoveType'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'BodyAreaMoveScores'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FieldNode(
                                          name: NameNode(value: 'score'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: null),
                                      FieldNode(
                                          name: NameNode(value: 'BodyArea'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FragmentSpreadNode(
                                                name:
                                                    NameNode(value: 'BodyArea'),
                                                directives: [])
                                          ]))
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'RequiredEquipments'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'Equipment'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name:
                                        NameNode(value: 'SelectableEquipments'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'Equipment'),
                                          directives: [])
                                    ]))
                              ]))
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSectionType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSectionType'), isNonNull: false)),
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reps'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadAmount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSection'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSection'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timecap'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'sortPosition'),
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
            name: NameNode(value: 'introAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateWorkoutSectionMutation extends GraphQLQuery<
    CreateWorkoutSection$Mutation, CreateWorkoutSectionArguments> {
  CreateWorkoutSectionMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_WORKOUT_SECTION_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createWorkoutSection';

  @override
  final CreateWorkoutSectionArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateWorkoutSection$Mutation parse(Map<String, dynamic> json) =>
      CreateWorkoutSection$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ReorderWorkoutSectionsArguments extends JsonSerializable
    with EquatableMixin {
  ReorderWorkoutSectionsArguments({required this.data});

  @override
  factory ReorderWorkoutSectionsArguments.fromJson(Map<String, dynamic> json) =>
      _$ReorderWorkoutSectionsArgumentsFromJson(json);

  late List<UpdateSortPositionInput> data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$ReorderWorkoutSectionsArgumentsToJson(this);
}

final REORDER_WORKOUT_SECTIONS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'reorderWorkoutSections'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'UpdateSortPositionInput'),
                    isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'reorderWorkoutSections'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
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
                  name: NameNode(value: 'sortPosition'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class ReorderWorkoutSectionsMutation extends GraphQLQuery<
    ReorderWorkoutSections$Mutation, ReorderWorkoutSectionsArguments> {
  ReorderWorkoutSectionsMutation({required this.variables});

  @override
  final DocumentNode document = REORDER_WORKOUT_SECTIONS_MUTATION_DOCUMENT;

  @override
  final String operationName = 'reorderWorkoutSections';

  @override
  final ReorderWorkoutSectionsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ReorderWorkoutSections$Mutation parse(Map<String, dynamic> json) =>
      ReorderWorkoutSections$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkoutSectionByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteWorkoutSectionByIdArguments({required this.id});

  @override
  factory DeleteWorkoutSectionByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteWorkoutSectionByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteWorkoutSectionByIdArgumentsToJson(this);
}

final DELETE_WORKOUT_SECTION_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteWorkoutSectionById'),
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
            name: NameNode(value: 'deleteWorkoutSectionById'),
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

class DeleteWorkoutSectionByIdMutation extends GraphQLQuery<
    DeleteWorkoutSectionById$Mutation, DeleteWorkoutSectionByIdArguments> {
  DeleteWorkoutSectionByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_WORKOUT_SECTION_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteWorkoutSectionById';

  @override
  final DeleteWorkoutSectionByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteWorkoutSectionById$Mutation parse(Map<String, dynamic> json) =>
      DeleteWorkoutSectionById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutArguments extends JsonSerializable with EquatableMixin {
  UpdateWorkoutArguments({required this.data});

  @override
  factory UpdateWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutArgumentsFromJson(json);

  late UpdateWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateWorkoutArgumentsToJson(this);
}

final UPDATE_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
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
            alias: NameNode(value: 'updateWorkout'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutFields'), directives: []),
              FieldNode(
                  name: NameNode(value: 'WorkoutGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutGoal'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutTags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutTag'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutGoal'), isNonNull: false)),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutTag'), isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutFields'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Workout'), isNonNull: false)),
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
            name: NameNode(value: 'createdAt'),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'difficultyLevel'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'coverImageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'contentAccessScope'),
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
            name: NameNode(value: 'introAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateWorkoutMutation
    extends GraphQLQuery<UpdateWorkout$Mutation, UpdateWorkoutArguments> {
  UpdateWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateWorkout';

  @override
  final UpdateWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateWorkout$Mutation parse(Map<String, dynamic> json) =>
      UpdateWorkout$Mutation.fromJson(json);
}

final USER_WORKOUTS_QUERY_DOCUMENT = DocumentNode(definitions: [
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
                  name: NameNode(value: 'createdAt'),
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
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'difficultyLevel'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'coverImageUri'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'User'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserSummary'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutGoal'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutTags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutTag'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutSections'),
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
                        name: NameNode(value: 'sortPosition'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'timecap'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'WorkoutSectionType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutSectionType'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutSets'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'WorkoutMoves'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'Equipment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'Equipment'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'Move'),
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
                                          name: NameNode(
                                              value: 'RequiredEquipments'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value: 'Equipment'),
                                                    directives: [])
                                              ]))
                                    ]))
                              ]))
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserSummary'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserSummary'), isNonNull: false)),
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
            name: NameNode(value: 'displayName'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutGoal'), isNonNull: false)),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutTag'), isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSectionType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSectionType'), isNonNull: false)),
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

class UserWorkoutsQuery
    extends GraphQLQuery<UserWorkouts$Query, JsonSerializable> {
  UserWorkoutsQuery();

  @override
  final DocumentNode document = USER_WORKOUTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'userWorkouts';

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserWorkouts$Query parse(Map<String, dynamic> json) =>
      UserWorkouts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutArguments extends JsonSerializable with EquatableMixin {
  CreateWorkoutArguments({required this.data});

  @override
  factory CreateWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutArgumentsFromJson(json);

  late CreateWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkoutArgumentsToJson(this);
}

final CREATE_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
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
            alias: NameNode(value: 'createWorkout'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutFields'), directives: []),
              FieldNode(
                  name: NameNode(value: 'WorkoutGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutGoal'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutTags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutTag'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutGoal'), isNonNull: false)),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutTag'), isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutFields'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Workout'), isNonNull: false)),
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
            name: NameNode(value: 'createdAt'),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'difficultyLevel'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'coverImageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'contentAccessScope'),
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
            name: NameNode(value: 'introAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateWorkoutMutation
    extends GraphQLQuery<CreateWorkout$Mutation, CreateWorkoutArguments> {
  CreateWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createWorkout';

  @override
  final CreateWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateWorkout$Mutation parse(Map<String, dynamic> json) =>
      CreateWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class WorkoutByIdArguments extends JsonSerializable with EquatableMixin {
  WorkoutByIdArguments({required this.id});

  @override
  factory WorkoutByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$WorkoutByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$WorkoutByIdArgumentsToJson(this);
}

final WORKOUT_BY_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
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
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutFields'), directives: []),
              FieldNode(
                  name: NameNode(value: 'User'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserSummary'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutGoal'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutTags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutTag'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutSections'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutSection'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'WorkoutSectionType'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutSectionType'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutSets'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutSet'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: 'WorkoutMoves'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'WorkoutMove'),
                                    directives: []),
                                FieldNode(
                                    name: NameNode(value: 'Equipment'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'Equipment'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'Move'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'Move'),
                                          directives: []),
                                      FieldNode(
                                          name: NameNode(value: 'MoveType'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FragmentSpreadNode(
                                                name:
                                                    NameNode(value: 'MoveType'),
                                                directives: [])
                                          ])),
                                      FieldNode(
                                          name: NameNode(
                                              value: 'BodyAreaMoveScores'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FieldNode(
                                                name: NameNode(value: 'score'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: null),
                                            FieldNode(
                                                name:
                                                    NameNode(value: 'BodyArea'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'BodyArea'),
                                                          directives: [])
                                                    ]))
                                          ])),
                                      FieldNode(
                                          name: NameNode(
                                              value: 'RequiredEquipments'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value: 'Equipment'),
                                                    directives: [])
                                              ])),
                                      FieldNode(
                                          name: NameNode(
                                              value: 'SelectableEquipments'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value: 'Equipment'),
                                                    directives: [])
                                              ]))
                                    ]))
                              ]))
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserSummary'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserSummary'), isNonNull: false)),
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
            name: NameNode(value: 'displayName'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutGoal'), isNonNull: false)),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutTag'), isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSectionType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSectionType'), isNonNull: false)),
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
      name: NameNode(value: 'MoveType'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'MoveType'), isNonNull: false)),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'imageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'BodyArea'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'BodyArea'), isNonNull: false)),
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
            name: NameNode(value: 'frontBack'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'upperLower'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'Move'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'Move'), isNonNull: false)),
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
            name: NameNode(value: 'searchTerms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'demoVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'scope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'validRepTypes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'reps'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadAmount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'loadUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutSection'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutSection'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'rounds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timecap'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'sortPosition'),
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
            name: NameNode(value: 'introAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'classAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroVideoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroVideoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'outroAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutFields'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Workout'), isNonNull: false)),
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
            name: NameNode(value: 'createdAt'),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'difficultyLevel'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'coverImageUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'contentAccessScope'),
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
            name: NameNode(value: 'introAudioUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class WorkoutByIdQuery
    extends GraphQLQuery<WorkoutById$Query, WorkoutByIdArguments> {
  WorkoutByIdQuery({required this.variables});

  @override
  final DocumentNode document = WORKOUT_BY_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'workoutById';

  @override
  final WorkoutByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  WorkoutById$Query parse(Map<String, dynamic> json) =>
      WorkoutById$Query.fromJson(json);
}
