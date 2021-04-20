// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:spotmefitness_ui/coercers.dart';
part 'graphql_api.graphql.g.dart';

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
  String? displayName;
  String? introVideoUri;
  String? introVideoThumbUri;
  @JsonKey(unknownEnumValue: Gender.artemisUnknown)
  Gender? gender;
}
mixin EquipmentMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  late bool loadAdjustable;
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
  String? description;
  String? demoVideoUri;
  String? demoVideoThumbUri;
  @JsonKey(unknownEnumValue: MoveScope.artemisUnknown)
  late MoveScope scope;
  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late List<WorkoutMoveRepType> validRepTypes;
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
mixin UserInfoMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? avatarUri;
  String? displayName;
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
mixin WorkoutSetMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late int sortPosition;
  late int rounds;
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
mixin WorkoutMixin {
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

  String? description;

  @JsonKey(name: 'Equipments')
  late List<String> equipments;

  @override
  List<Object?> get props => [name, description, equipments];
  Map<String, dynamic> toJson() => _$CreateGymProfileInputToJson(this);
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

  late double score;

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
class AllMoves$Query extends JsonSerializable with EquatableMixin {
  AllMoves$Query();

  factory AllMoves$Query.fromJson(Map<String, dynamic> json) =>
      _$AllMoves$QueryFromJson(json);

  late List<Move> standardMoves;

  late List<Move> userCustomMoves;

  @override
  List<Object?> get props => [standardMoves, userCustomMoves];
  Map<String, dynamic> toJson() => _$AllMoves$QueryToJson(this);
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
class UserInfo extends JsonSerializable with EquatableMixin, UserInfoMixin {
  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, avatarUri, displayName];
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
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
class WorkoutSet extends JsonSerializable with EquatableMixin, WorkoutSetMixin {
  WorkoutSet();

  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  @JsonKey(name: 'WorkoutMoves')
  late List<WorkoutMove> workoutMoves;

  @override
  List<Object?> get props =>
      [$$typename, id, sortPosition, rounds, workoutMoves];
  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);
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
class Workout extends JsonSerializable with EquatableMixin, WorkoutMixin {
  Workout();

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  @JsonKey(name: 'UserInfo')
  UserInfo? userInfo;

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
        userInfo,
        workoutGoals,
        workoutTags,
        workoutSections
      ];
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
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
  List<String>? workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  List<String>? workoutTags;

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
class WorkoutSummaryMove extends JsonSerializable with EquatableMixin {
  WorkoutSummaryMove();

  factory WorkoutSummaryMove.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSummaryMoveFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  late String name;

  @JsonKey(name: 'RequiredEquipments')
  late List<Equipment> requiredEquipments;

  @override
  List<Object?> get props => [$$typename, id, name, requiredEquipments];
  Map<String, dynamic> toJson() => _$WorkoutSummaryMoveToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSummaryWorkoutMoves extends JsonSerializable with EquatableMixin {
  WorkoutSummaryWorkoutMoves();

  factory WorkoutSummaryWorkoutMoves.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSummaryWorkoutMovesFromJson(json);

  @JsonKey(name: 'Equipment')
  Equipment? equipment;

  @JsonKey(name: 'WorkoutSummaryMove')
  late WorkoutSummaryMove workoutSummaryMove;

  @override
  List<Object?> get props => [equipment, workoutSummaryMove];
  Map<String, dynamic> toJson() => _$WorkoutSummaryWorkoutMovesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSummarySets extends JsonSerializable with EquatableMixin {
  WorkoutSummarySets();

  factory WorkoutSummarySets.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSummarySetsFromJson(json);

  @JsonKey(name: 'WorkoutSummaryWorkoutMoves')
  late List<WorkoutSummaryWorkoutMoves> workoutSummaryWorkoutMoves;

  @override
  List<Object?> get props => [workoutSummaryWorkoutMoves];
  Map<String, dynamic> toJson() => _$WorkoutSummarySetsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutSummarySections extends JsonSerializable with EquatableMixin {
  WorkoutSummarySections();

  factory WorkoutSummarySections.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSummarySectionsFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  int? timecap;

  @JsonKey(name: 'WorkoutSectionType')
  late WorkoutSectionType workoutSectionType;

  @JsonKey(name: 'WorkoutSummarySets')
  late List<WorkoutSummarySets> workoutSummarySets;

  @override
  List<Object?> get props =>
      [$$typename, id, timecap, workoutSectionType, workoutSummarySets];
  Map<String, dynamic> toJson() => _$WorkoutSummarySectionsToJson(this);
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

  @JsonKey(name: 'UserInfo')
  UserInfo? userInfo;

  @JsonKey(name: 'WorkoutGoals')
  late List<WorkoutGoal> workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  late List<WorkoutTag> workoutTags;

  @JsonKey(name: 'WorkoutSummarySections')
  late List<WorkoutSummarySections> workoutSummarySections;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        name,
        description,
        difficultyLevel,
        coverImageUri,
        userInfo,
        workoutGoals,
        workoutTags,
        workoutSummarySections
      ];
  Map<String, dynamic> toJson() => _$WorkoutSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserWorkouts$Query extends JsonSerializable with EquatableMixin {
  UserWorkouts$Query();

  factory UserWorkouts$Query.fromJson(Map<String, dynamic> json) =>
      _$UserWorkouts$QueryFromJson(json);

  @JsonKey(name: 'WorkoutSummary')
  late List<WorkoutSummary> workoutSummary;

  @override
  List<Object?> get props => [workoutSummary];
  Map<String, dynamic> toJson() => _$UserWorkouts$QueryToJson(this);
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
class WorkoutData extends JsonSerializable with EquatableMixin, WorkoutMixin {
  WorkoutData();

  factory WorkoutData.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDataFromJson(json);

  @JsonKey(name: 'UserInfo')
  UserInfo? userInfo;

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
        userInfo,
        workoutGoals,
        workoutTags,
        workoutSections
      ];
  Map<String, dynamic> toJson() => _$WorkoutDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutById$Query extends JsonSerializable with EquatableMixin {
  WorkoutById$Query();

  factory WorkoutById$Query.fromJson(Map<String, dynamic> json) =>
      _$WorkoutById$QueryFromJson(json);

  @JsonKey(name: 'WorkoutData')
  late WorkoutData workoutData;

  @override
  List<Object?> get props => [workoutData];
  Map<String, dynamic> toJson() => _$WorkoutById$QueryToJson(this);
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
enum MoveScope {
  @JsonValue('STANDARD')
  standard,
  @JsonValue('CUSTOM')
  custom,
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

  late UpdateUserInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateUserArgumentsToJson(this);
}

class UpdateUserMutation
    extends GraphQLQuery<UpdateUser$Mutation, UpdateUserArguments> {
  UpdateUserMutation({required this.variables});

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
  final UpdateUserArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateUser$Mutation parse(Map<String, dynamic> json) =>
      UpdateUser$Mutation.fromJson(json);
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

class DeleteGymProfileByIdMutation extends GraphQLQuery<
    DeleteGymProfileById$Mutation, DeleteGymProfileByIdArguments> {
  DeleteGymProfileByIdMutation({required this.variables});

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

class CreateGymProfileMutation
    extends GraphQLQuery<CreateGymProfile$Mutation, CreateGymProfileArguments> {
  CreateGymProfileMutation({required this.variables});

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
  final CreateGymProfileArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateGymProfile$Mutation parse(Map<String, dynamic> json) =>
      CreateGymProfile$Mutation.fromJson(json);
}

class UserWorkoutTagsQuery
    extends GraphQLQuery<UserWorkoutTags$Query, JsonSerializable> {
  UserWorkoutTagsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

class CreateWorkoutTagMutation
    extends GraphQLQuery<CreateWorkoutTag$Mutation, CreateWorkoutTagArguments> {
  CreateWorkoutTagMutation({required this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

class UpdateGymProfileMutation
    extends GraphQLQuery<UpdateGymProfile$Mutation, UpdateGymProfileArguments> {
  UpdateGymProfileMutation({required this.variables});

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
  final UpdateGymProfileArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateGymProfile$Mutation parse(Map<String, dynamic> json) =>
      UpdateGymProfile$Mutation.fromJson(json);
}

class AllMovesQuery extends GraphQLQuery<AllMoves$Query, JsonSerializable> {
  AllMovesQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'allMoves'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'standardMoves'),
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
              ])),
          FieldNode(
              name: NameNode(value: 'userCustomMoves'),
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

  @override
  final String operationName = 'allMoves';

  @override
  List<Object?> get props => [document, operationName];
  @override
  AllMoves$Query parse(Map<String, dynamic> json) =>
      AllMoves$Query.fromJson(json);
}

class WorkoutGoalsQuery
    extends GraphQLQuery<WorkoutGoals$Query, JsonSerializable> {
  WorkoutGoalsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

class CheckUniqueDisplayNameQuery extends GraphQLQuery<
    CheckUniqueDisplayName$Query, CheckUniqueDisplayNameArguments> {
  CheckUniqueDisplayNameQuery({required this.variables});

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
  final CheckUniqueDisplayNameArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CheckUniqueDisplayName$Query parse(Map<String, dynamic> json) =>
      CheckUniqueDisplayName$Query.fromJson(json);
}

class WorkoutSectionTypesQuery
    extends GraphQLQuery<WorkoutSectionTypes$Query, JsonSerializable> {
  WorkoutSectionTypesQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

  @override
  final String operationName = 'workoutSectionTypes';

  @override
  List<Object?> get props => [document, operationName];
  @override
  WorkoutSectionTypes$Query parse(Map<String, dynamic> json) =>
      WorkoutSectionTypes$Query.fromJson(json);
}

class BodyAreasQuery extends GraphQLQuery<BodyAreas$Query, JsonSerializable> {
  BodyAreasQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

  @override
  final String operationName = 'bodyAreas';

  @override
  List<Object?> get props => [document, operationName];
  @override
  BodyAreas$Query parse(Map<String, dynamic> json) =>
      BodyAreas$Query.fromJson(json);
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

class UpdateWorkoutMutation
    extends GraphQLQuery<UpdateWorkout$Mutation, UpdateWorkoutArguments> {
  UpdateWorkoutMutation({required this.variables});

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
                FragmentSpreadNode(
                    name: NameNode(value: 'Workout'), directives: []),
                FieldNode(
                    name: NameNode(value: 'User'),
                    alias: NameNode(value: 'UserInfo'),
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'UserInfo'), directives: [])
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
                                      selectionSet:
                                          SelectionSetNode(selections: [
                                        FragmentSpreadNode(
                                            name: NameNode(value: 'Equipment'),
                                            directives: [])
                                      ])),
                                  FieldNode(
                                      name: NameNode(value: 'Move'),
                                      alias: null,
                                      arguments: [],
                                      directives: [],
                                      selectionSet:
                                          SelectionSetNode(selections: [
                                        FragmentSpreadNode(
                                            name: NameNode(value: 'Move'),
                                            directives: []),
                                        FieldNode(
                                            name: NameNode(value: 'MoveType'),
                                            alias: null,
                                            arguments: [],
                                            directives: [],
                                            selectionSet: SelectionSetNode(
                                                selections: [
                                                  FragmentSpreadNode(
                                                      name: NameNode(
                                                          value: 'MoveType'),
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
                                                  name:
                                                      NameNode(value: 'score'),
                                                  alias: null,
                                                  arguments: [],
                                                  directives: [],
                                                  selectionSet: null),
                                              FieldNode(
                                                  name: NameNode(
                                                      value: 'BodyArea'),
                                                  alias: null,
                                                  arguments: [],
                                                  directives: [],
                                                  selectionSet:
                                                      SelectionSetNode(
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
        name: NameNode(value: 'UserInfo'),
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
        name: NameNode(value: 'Workout'),
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
              alias: NameNode(value: 'WorkoutSummary'),
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
                    alias: NameNode(value: 'UserInfo'),
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'UserInfo'), directives: [])
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
                    alias: NameNode(value: 'WorkoutSummarySections'),
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
                          alias: NameNode(value: 'WorkoutSummarySets'),
                          arguments: [],
                          directives: [],
                          selectionSet: SelectionSetNode(selections: [
                            FieldNode(
                                name: NameNode(value: 'WorkoutMoves'),
                                alias: NameNode(
                                    value: 'WorkoutSummaryWorkoutMoves'),
                                arguments: [],
                                directives: [],
                                selectionSet: SelectionSetNode(selections: [
                                  FieldNode(
                                      name: NameNode(value: 'Equipment'),
                                      alias: null,
                                      arguments: [],
                                      directives: [],
                                      selectionSet:
                                          SelectionSetNode(selections: [
                                        FragmentSpreadNode(
                                            name: NameNode(value: 'Equipment'),
                                            directives: [])
                                      ])),
                                  FieldNode(
                                      name: NameNode(value: 'Move'),
                                      alias:
                                          NameNode(value: 'WorkoutSummaryMove'),
                                      arguments: [],
                                      directives: [],
                                      selectionSet:
                                          SelectionSetNode(selections: [
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
        name: NameNode(value: 'UserInfo'),
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

class CreateWorkoutMutation
    extends GraphQLQuery<CreateWorkout$Mutation, CreateWorkoutArguments> {
  CreateWorkoutMutation({required this.variables});

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
                FragmentSpreadNode(
                    name: NameNode(value: 'Workout'), directives: []),
                FieldNode(
                    name: NameNode(value: 'User'),
                    alias: NameNode(value: 'UserInfo'),
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'UserInfo'), directives: [])
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
                                      selectionSet:
                                          SelectionSetNode(selections: [
                                        FragmentSpreadNode(
                                            name: NameNode(value: 'Equipment'),
                                            directives: [])
                                      ])),
                                  FieldNode(
                                      name: NameNode(value: 'Move'),
                                      alias: null,
                                      arguments: [],
                                      directives: [],
                                      selectionSet:
                                          SelectionSetNode(selections: [
                                        FragmentSpreadNode(
                                            name: NameNode(value: 'Move'),
                                            directives: []),
                                        FieldNode(
                                            name: NameNode(value: 'MoveType'),
                                            alias: null,
                                            arguments: [],
                                            directives: [],
                                            selectionSet: SelectionSetNode(
                                                selections: [
                                                  FragmentSpreadNode(
                                                      name: NameNode(
                                                          value: 'MoveType'),
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
                                                  name:
                                                      NameNode(value: 'score'),
                                                  alias: null,
                                                  arguments: [],
                                                  directives: [],
                                                  selectionSet: null),
                                              FieldNode(
                                                  name: NameNode(
                                                      value: 'BodyArea'),
                                                  alias: null,
                                                  arguments: [],
                                                  directives: [],
                                                  selectionSet:
                                                      SelectionSetNode(
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
        name: NameNode(value: 'UserInfo'),
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
        name: NameNode(value: 'Workout'),
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

class WorkoutByIdQuery
    extends GraphQLQuery<WorkoutById$Query, WorkoutByIdArguments> {
  WorkoutByIdQuery({required this.variables});

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
              alias: NameNode(value: 'WorkoutData'),
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'id'),
                    value: VariableNode(name: NameNode(value: 'id')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'Workout'), directives: []),
                FieldNode(
                    name: NameNode(value: 'User'),
                    alias: NameNode(value: 'UserInfo'),
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'UserInfo'), directives: [])
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
                                      selectionSet:
                                          SelectionSetNode(selections: [
                                        FragmentSpreadNode(
                                            name: NameNode(value: 'Equipment'),
                                            directives: [])
                                      ])),
                                  FieldNode(
                                      name: NameNode(value: 'Move'),
                                      alias: null,
                                      arguments: [],
                                      directives: [],
                                      selectionSet:
                                          SelectionSetNode(selections: [
                                        FragmentSpreadNode(
                                            name: NameNode(value: 'Move'),
                                            directives: []),
                                        FieldNode(
                                            name: NameNode(value: 'MoveType'),
                                            alias: null,
                                            arguments: [],
                                            directives: [],
                                            selectionSet: SelectionSetNode(
                                                selections: [
                                                  FragmentSpreadNode(
                                                      name: NameNode(
                                                          value: 'MoveType'),
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
                                                  name:
                                                      NameNode(value: 'score'),
                                                  alias: null,
                                                  arguments: [],
                                                  directives: [],
                                                  selectionSet: null),
                                              FieldNode(
                                                  name: NameNode(
                                                      value: 'BodyArea'),
                                                  alias: null,
                                                  arguments: [],
                                                  directives: [],
                                                  selectionSet:
                                                      SelectionSetNode(
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
        name: NameNode(value: 'UserInfo'),
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
        name: NameNode(value: 'Workout'),
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
