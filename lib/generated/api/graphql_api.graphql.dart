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
mixin ProgressJournalGoalTagMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  late String tag;
  late String hexColor;
}
mixin ProgressJournalEntryMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  String? note;
  String? voiceNoteUri;
  double? bodyweight;
  @JsonKey(unknownEnumValue: BodyweightUnit.artemisUnknown)
  late BodyweightUnit bodyweightUnit;
  double? moodScore;
  double? energyScore;
  double? stressScore;
  double? motivationScore;
  late List<String> progressPhotoUris;
}
mixin ProgressJournalGoalMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  late String name;
  String? description;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? deadline;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? completedDate;
}
mixin ProgressJournalMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  late String name;
  String? description;
}
mixin GymProfileMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  String? description;
}
mixin WorkoutSectionTypeMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  late String description;
}
mixin LoggedWorkoutMoveMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? note;
  late int sortPosition;
  late double reps;
  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late WorkoutMoveRepType repType;
  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  late DistanceUnit distanceUnit;
  double? loadAmount;
  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  late LoadUnit loadUnit;
  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  late TimeUnit timeUnit;
}
mixin LoggedWorkoutSetMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? note;
  late int roundsCompleted;
  int? duration;
  late int sortPosition;
}
mixin LoggedWorkoutSectionMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? name;
  String? note;
  int? timecap;
  late int roundsCompleted;
  int? repScore;
  int? timeTakenMs;
  @JsonKey(fromJson: fromGraphQLJsonToDartMap, toJson: fromDartMapToGraphQLJson)
  late Map roundTimesMs;
  late int sortPosition;
}
mixin LoggedWorkoutMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime completedOn;
  String? note;
  late String name;
}
mixin UserSummaryMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? avatarUri;
  late String displayName;
}
mixin WorkoutGoalMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String name;
  late String description;
  late String hexColor;
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
  late DateTime createdAt;
  late bool archived;
  late String name;
  String? description;
  int? lengthMinutes;
  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  late DifficultyLevel difficultyLevel;
  String? coverImageUri;
  @JsonKey(unknownEnumValue: ContentAccessScope.artemisUnknown)
  late ContentAccessScope contentAccessScope;
  String? introVideoUri;
  String? introVideoThumbUri;
  String? introAudioUri;
}
mixin WorkoutPlanDayWorkoutMixin {
  late String id;
  @JsonKey(name: '__typename')
  String? $$typename;
  String? note;
  late int sortPosition;
}
mixin WorkoutPlanDayMixin {
  late String id;
  @JsonKey(name: '__typename')
  String? $$typename;
  String? note;
  late int dayNumber;
}
mixin WorkoutPlanEnrolmentMixin {
  late String id;
  @JsonKey(name: '__typename')
  String? $$typename;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime startDate;
  late List<String> completedPlanDayWorkoutIds;
}
mixin WorkoutPlanReviewMixin {
  late String id;
  @JsonKey(name: '__typename')
  String? $$typename;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  late double score;
  String? comment;
}
mixin WorkoutPlanMixin {
  late String id;
  @JsonKey(name: '__typename')
  String? $$typename;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  late bool archived;
  late String name;
  String? description;
  late int lengthWeeks;
  String? coverImageUri;
  String? introVideoUri;
  String? introVideoThumbUri;
  String? introAudioUri;
  @JsonKey(unknownEnumValue: ContentAccessScope.artemisUnknown)
  late ContentAccessScope contentAccessScope;
}
mixin UserMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  String? avatarUri;
  String? bio;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? birthdate;
  String? countryCode;
  String? displayName;
  String? introVideoUri;
  String? introVideoThumbUri;
  @JsonKey(unknownEnumValue: Gender.artemisUnknown)
  Gender? gender;
}
mixin UserBenchmarkEntryMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime completedOn;
  late double score;
  String? note;
  String? videoUri;
  String? videoThumbUri;
}
mixin UserBenchmarkMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime createdAt;
  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime lastEntryAt;
  late String name;
  String? description;
  double? reps;
  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late WorkoutMoveRepType repType;
  double? load;
  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  late LoadUnit loadUnit;
  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  late TimeUnit timeUnit;
  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  late DistanceUnit distanceUnit;
  @JsonKey(unknownEnumValue: BenchmarkType.artemisUnknown)
  late BenchmarkType benchmarkType;
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
class ProgressJournalGoalTag extends JsonSerializable
    with EquatableMixin, ProgressJournalGoalTagMixin {
  ProgressJournalGoalTag();

  factory ProgressJournalGoalTag.fromJson(Map<String, dynamic> json) =>
      _$ProgressJournalGoalTagFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, createdAt, tag, hexColor];
  Map<String, dynamic> toJson() => _$ProgressJournalGoalTagToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalGoalTag$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalGoalTag$Mutation();

  factory UpdateProgressJournalGoalTag$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateProgressJournalGoalTag$MutationFromJson(json);

  late ProgressJournalGoalTag updateProgressJournalGoalTag;

  @override
  List<Object?> get props => [updateProgressJournalGoalTag];
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalGoalTag$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalGoalTagInput extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalGoalTagInput(
      {required this.id, this.tag, this.hexColor});

  factory UpdateProgressJournalGoalTagInput.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateProgressJournalGoalTagInputFromJson(json);

  late String id;

  String? tag;

  String? hexColor;

  @override
  List<Object?> get props => [id, tag, hexColor];
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalGoalTagInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProgressJournalEntry extends JsonSerializable
    with EquatableMixin, ProgressJournalEntryMixin {
  ProgressJournalEntry();

  factory ProgressJournalEntry.fromJson(Map<String, dynamic> json) =>
      _$ProgressJournalEntryFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        note,
        voiceNoteUri,
        bodyweight,
        bodyweightUnit,
        moodScore,
        energyScore,
        stressScore,
        motivationScore,
        progressPhotoUris
      ];
  Map<String, dynamic> toJson() => _$ProgressJournalEntryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProgressJournalGoal extends JsonSerializable
    with EquatableMixin, ProgressJournalGoalMixin {
  ProgressJournalGoal();

  factory ProgressJournalGoal.fromJson(Map<String, dynamic> json) =>
      _$ProgressJournalGoalFromJson(json);

  @JsonKey(name: 'ProgressJournalGoalTags')
  late List<ProgressJournalGoalTag> progressJournalGoalTags;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        name,
        description,
        deadline,
        completedDate,
        progressJournalGoalTags
      ];
  Map<String, dynamic> toJson() => _$ProgressJournalGoalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProgressJournal extends JsonSerializable
    with EquatableMixin, ProgressJournalMixin {
  ProgressJournal();

  factory ProgressJournal.fromJson(Map<String, dynamic> json) =>
      _$ProgressJournalFromJson(json);

  @JsonKey(name: 'ProgressJournalEntries')
  late List<ProgressJournalEntry> progressJournalEntries;

  @JsonKey(name: 'ProgressJournalGoals')
  late List<ProgressJournalGoal> progressJournalGoals;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        name,
        description,
        progressJournalEntries,
        progressJournalGoals
      ];
  Map<String, dynamic> toJson() => _$ProgressJournalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProgressJournalById$Query extends JsonSerializable with EquatableMixin {
  ProgressJournalById$Query();

  factory ProgressJournalById$Query.fromJson(Map<String, dynamic> json) =>
      _$ProgressJournalById$QueryFromJson(json);

  late ProgressJournal progressJournalById;

  @override
  List<Object?> get props => [progressJournalById];
  Map<String, dynamic> toJson() => _$ProgressJournalById$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalEntry$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalEntry$Mutation();

  factory CreateProgressJournalEntry$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$CreateProgressJournalEntry$MutationFromJson(json);

  late ProgressJournalEntry createProgressJournalEntry;

  @override
  List<Object?> get props => [createProgressJournalEntry];
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalEntry$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalEntryInput extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalEntryInput(
      {this.note,
      this.voiceNoteUri,
      this.bodyweight,
      this.bodyweightUnit,
      this.moodScore,
      this.energyScore,
      this.stressScore,
      this.motivationScore,
      required this.progressPhotoUris,
      required this.progressJournal});

  factory CreateProgressJournalEntryInput.fromJson(Map<String, dynamic> json) =>
      _$CreateProgressJournalEntryInputFromJson(json);

  String? note;

  String? voiceNoteUri;

  double? bodyweight;

  @JsonKey(unknownEnumValue: BodyweightUnit.artemisUnknown)
  BodyweightUnit? bodyweightUnit;

  double? moodScore;

  double? energyScore;

  double? stressScore;

  double? motivationScore;

  late List<String> progressPhotoUris;

  @JsonKey(name: 'ProgressJournal')
  late ConnectRelationInput progressJournal;

  @override
  List<Object?> get props => [
        note,
        voiceNoteUri,
        bodyweight,
        bodyweightUnit,
        moodScore,
        energyScore,
        stressScore,
        motivationScore,
        progressPhotoUris,
        progressJournal
      ];
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalEntryInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalById$Mutation();

  factory DeleteProgressJournalById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalById$MutationFromJson(json);

  late String deleteProgressJournalById;

  @override
  List<Object?> get props => [deleteProgressJournalById];
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournal$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournal$Mutation();

  factory CreateProgressJournal$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateProgressJournal$MutationFromJson(json);

  late ProgressJournal createProgressJournal;

  @override
  List<Object?> get props => [createProgressJournal];
  Map<String, dynamic> toJson() => _$CreateProgressJournal$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalInput extends JsonSerializable with EquatableMixin {
  CreateProgressJournalInput({required this.name, this.description});

  factory CreateProgressJournalInput.fromJson(Map<String, dynamic> json) =>
      _$CreateProgressJournalInputFromJson(json);

  late String name;

  String? description;

  @override
  List<Object?> get props => [name, description];
  Map<String, dynamic> toJson() => _$CreateProgressJournalInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournal$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournal$Mutation();

  factory UpdateProgressJournal$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateProgressJournal$MutationFromJson(json);

  late ProgressJournal updateProgressJournal;

  @override
  List<Object?> get props => [updateProgressJournal];
  Map<String, dynamic> toJson() => _$UpdateProgressJournal$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalInput extends JsonSerializable with EquatableMixin {
  UpdateProgressJournalInput({required this.id, this.name, this.description});

  factory UpdateProgressJournalInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateProgressJournalInputFromJson(json);

  late String id;

  String? name;

  String? description;

  @override
  List<Object?> get props => [id, name, description];
  Map<String, dynamic> toJson() => _$UpdateProgressJournalInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalEntryById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalEntryById$Mutation();

  factory DeleteProgressJournalEntryById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalEntryById$MutationFromJson(json);

  late String deleteProgressJournalEntryById;

  @override
  List<Object?> get props => [deleteProgressJournalEntryById];
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalEntryById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalEntry$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalEntry$Mutation();

  factory UpdateProgressJournalEntry$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateProgressJournalEntry$MutationFromJson(json);

  late ProgressJournalEntry updateProgressJournalEntry;

  @override
  List<Object?> get props => [updateProgressJournalEntry];
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalEntry$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalEntryInput extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalEntryInput(
      {required this.id,
      this.note,
      this.voiceNoteUri,
      this.bodyweight,
      this.bodyweightUnit,
      this.moodScore,
      this.energyScore,
      this.stressScore,
      this.motivationScore,
      required this.progressPhotoUris});

  factory UpdateProgressJournalEntryInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateProgressJournalEntryInputFromJson(json);

  late String id;

  String? note;

  String? voiceNoteUri;

  double? bodyweight;

  @JsonKey(unknownEnumValue: BodyweightUnit.artemisUnknown)
  BodyweightUnit? bodyweightUnit;

  double? moodScore;

  double? energyScore;

  double? stressScore;

  double? motivationScore;

  late List<String> progressPhotoUris;

  @override
  List<Object?> get props => [
        id,
        note,
        voiceNoteUri,
        bodyweight,
        bodyweightUnit,
        moodScore,
        energyScore,
        stressScore,
        motivationScore,
        progressPhotoUris
      ];
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalEntryInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalGoal$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalGoal$Mutation();

  factory CreateProgressJournalGoal$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$CreateProgressJournalGoal$MutationFromJson(json);

  late ProgressJournalGoal createProgressJournalGoal;

  @override
  List<Object?> get props => [createProgressJournalGoal];
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalGoal$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalGoalInput extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalGoalInput(
      {required this.name,
      this.description,
      this.deadline,
      required this.progressJournal,
      this.progressJournalGoalTags});

  factory CreateProgressJournalGoalInput.fromJson(Map<String, dynamic> json) =>
      _$CreateProgressJournalGoalInputFromJson(json);

  late String name;

  String? description;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? deadline;

  @JsonKey(name: 'ProgressJournal')
  late ConnectRelationInput progressJournal;

  @JsonKey(name: 'ProgressJournalGoalTags')
  List<ConnectRelationInput>? progressJournalGoalTags;

  @override
  List<Object?> get props =>
      [name, description, deadline, progressJournal, progressJournalGoalTags];
  Map<String, dynamic> toJson() => _$CreateProgressJournalGoalInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserProgressJournals$Query extends JsonSerializable with EquatableMixin {
  UserProgressJournals$Query();

  factory UserProgressJournals$Query.fromJson(Map<String, dynamic> json) =>
      _$UserProgressJournals$QueryFromJson(json);

  late List<ProgressJournal> userProgressJournals;

  @override
  List<Object?> get props => [userProgressJournals];
  Map<String, dynamic> toJson() => _$UserProgressJournals$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalGoal$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalGoal$Mutation();

  factory UpdateProgressJournalGoal$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateProgressJournalGoal$MutationFromJson(json);

  late ProgressJournalGoal updateProgressJournalGoal;

  @override
  List<Object?> get props => [updateProgressJournalGoal];
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalGoal$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalGoalInput extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalGoalInput(
      {required this.id,
      this.name,
      this.description,
      this.completedDate,
      this.deadline,
      this.progressJournalGoalTags});

  factory UpdateProgressJournalGoalInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateProgressJournalGoalInputFromJson(json);

  late String id;

  String? name;

  String? description;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? completedDate;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? deadline;

  @JsonKey(name: 'ProgressJournalGoalTags')
  List<ConnectRelationInput>? progressJournalGoalTags;

  @override
  List<Object?> get props =>
      [id, name, description, completedDate, deadline, progressJournalGoalTags];
  Map<String, dynamic> toJson() => _$UpdateProgressJournalGoalInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalGoalTag$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalGoalTag$Mutation();

  factory CreateProgressJournalGoalTag$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$CreateProgressJournalGoalTag$MutationFromJson(json);

  late ProgressJournalGoalTag createProgressJournalGoalTag;

  @override
  List<Object?> get props => [createProgressJournalGoalTag];
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalGoalTag$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalGoalTagInput extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalGoalTagInput(
      {required this.tag, required this.hexColor});

  factory CreateProgressJournalGoalTagInput.fromJson(
          Map<String, dynamic> json) =>
      _$CreateProgressJournalGoalTagInputFromJson(json);

  late String tag;

  late String hexColor;

  @override
  List<Object?> get props => [tag, hexColor];
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalGoalTagInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalGoalById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalGoalById$Mutation();

  factory DeleteProgressJournalGoalById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalGoalById$MutationFromJson(json);

  late String deleteProgressJournalGoalById;

  @override
  List<Object?> get props => [deleteProgressJournalGoalById];
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalGoalById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalGoalTagById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalGoalTagById$Mutation();

  factory DeleteProgressJournalGoalTagById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalGoalTagById$MutationFromJson(json);

  late String deleteProgressJournalGoalTagById;

  @override
  List<Object?> get props => [deleteProgressJournalGoalTagById];
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalGoalTagById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProgressJournalGoalTags$Query extends JsonSerializable
    with EquatableMixin {
  ProgressJournalGoalTags$Query();

  factory ProgressJournalGoalTags$Query.fromJson(Map<String, dynamic> json) =>
      _$ProgressJournalGoalTags$QueryFromJson(json);

  late List<ProgressJournalGoalTag> progressJournalGoalTags;

  @override
  List<Object?> get props => [progressJournalGoalTags];
  Map<String, dynamic> toJson() => _$ProgressJournalGoalTags$QueryToJson(this);
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
class LoggedWorkoutMove extends JsonSerializable
    with EquatableMixin, LoggedWorkoutMoveMixin {
  LoggedWorkoutMove();

  factory LoggedWorkoutMove.fromJson(Map<String, dynamic> json) =>
      _$LoggedWorkoutMoveFromJson(json);

  @JsonKey(name: 'Equipment')
  Equipment? equipment;

  @JsonKey(name: 'Move')
  late Move move;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        note,
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
  Map<String, dynamic> toJson() => _$LoggedWorkoutMoveToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoggedWorkoutSet extends JsonSerializable
    with EquatableMixin, LoggedWorkoutSetMixin {
  LoggedWorkoutSet();

  factory LoggedWorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$LoggedWorkoutSetFromJson(json);

  @JsonKey(name: 'LoggedWorkoutMoves')
  late List<LoggedWorkoutMove> loggedWorkoutMoves;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        note,
        roundsCompleted,
        duration,
        sortPosition,
        loggedWorkoutMoves
      ];
  Map<String, dynamic> toJson() => _$LoggedWorkoutSetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoggedWorkoutSection extends JsonSerializable
    with EquatableMixin, LoggedWorkoutSectionMixin {
  LoggedWorkoutSection();

  factory LoggedWorkoutSection.fromJson(Map<String, dynamic> json) =>
      _$LoggedWorkoutSectionFromJson(json);

  @JsonKey(name: 'WorkoutSectionType')
  late WorkoutSectionType workoutSectionType;

  @JsonKey(name: 'LoggedWorkoutSets')
  late List<LoggedWorkoutSet> loggedWorkoutSets;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        name,
        note,
        timecap,
        roundsCompleted,
        repScore,
        timeTakenMs,
        roundTimesMs,
        sortPosition,
        workoutSectionType,
        loggedWorkoutSets
      ];
  Map<String, dynamic> toJson() => _$LoggedWorkoutSectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoggedWorkout extends JsonSerializable
    with EquatableMixin, LoggedWorkoutMixin {
  LoggedWorkout();

  factory LoggedWorkout.fromJson(Map<String, dynamic> json) =>
      _$LoggedWorkoutFromJson(json);

  @JsonKey(name: 'GymProfile')
  GymProfile? gymProfile;

  @JsonKey(name: 'LoggedWorkoutSections')
  late List<LoggedWorkoutSection> loggedWorkoutSections;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        completedOn,
        note,
        name,
        gymProfile,
        loggedWorkoutSections
      ];
  Map<String, dynamic> toJson() => _$LoggedWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoggedWorkoutById$Query extends JsonSerializable with EquatableMixin {
  LoggedWorkoutById$Query();

  factory LoggedWorkoutById$Query.fromJson(Map<String, dynamic> json) =>
      _$LoggedWorkoutById$QueryFromJson(json);

  late LoggedWorkout loggedWorkoutById;

  @override
  List<Object?> get props => [loggedWorkoutById];
  Map<String, dynamic> toJson() => _$LoggedWorkoutById$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteLoggedWorkoutById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutById$Mutation();

  factory DeleteLoggedWorkoutById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutById$MutationFromJson(json);

  late String deleteLoggedWorkoutById;

  @override
  List<Object?> get props => [deleteLoggedWorkoutById];
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserLoggedWorkouts$Query extends JsonSerializable with EquatableMixin {
  UserLoggedWorkouts$Query();

  factory UserLoggedWorkouts$Query.fromJson(Map<String, dynamic> json) =>
      _$UserLoggedWorkouts$QueryFromJson(json);

  late List<LoggedWorkout> userLoggedWorkouts;

  @override
  List<Object?> get props => [userLoggedWorkouts];
  Map<String, dynamic> toJson() => _$UserLoggedWorkouts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkout extends JsonSerializable
    with EquatableMixin, LoggedWorkoutMixin {
  UpdateLoggedWorkout();

  factory UpdateLoggedWorkout.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, completedOn, note, name];
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkout$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkout$Mutation();

  factory UpdateLoggedWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkout$MutationFromJson(json);

  late UpdateLoggedWorkout updateLoggedWorkout;

  @override
  List<Object?> get props => [updateLoggedWorkout];
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutInput extends JsonSerializable with EquatableMixin {
  UpdateLoggedWorkoutInput(
      {required this.id,
      this.completedOn,
      this.name,
      this.note,
      this.gymProfile});

  factory UpdateLoggedWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutInputFromJson(json);

  late String id;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? completedOn;

  String? name;

  String? note;

  @JsonKey(name: 'GymProfile')
  ConnectRelationInput? gymProfile;

  @override
  List<Object?> get props => [id, completedOn, name, note, gymProfile];
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkout$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkout$Mutation();

  factory CreateLoggedWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkout$MutationFromJson(json);

  late LoggedWorkout createLoggedWorkout;

  @override
  List<Object?> get props => [createLoggedWorkout];
  Map<String, dynamic> toJson() => _$CreateLoggedWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutInput extends JsonSerializable with EquatableMixin {
  CreateLoggedWorkoutInput(
      {required this.completedOn,
      required this.name,
      this.note,
      required this.loggedWorkoutSections,
      this.workout,
      this.scheduledWorkout,
      this.gymProfile});

  factory CreateLoggedWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutInputFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime completedOn;

  late String name;

  String? note;

  @JsonKey(name: 'LoggedWorkoutSections')
  late List<CreateLoggedWorkoutSectionInLoggedWorkoutInput>
      loggedWorkoutSections;

  @JsonKey(name: 'Workout')
  ConnectRelationInput? workout;

  @JsonKey(name: 'ScheduledWorkout')
  ConnectRelationInput? scheduledWorkout;

  @JsonKey(name: 'GymProfile')
  ConnectRelationInput? gymProfile;

  @override
  List<Object?> get props => [
        completedOn,
        name,
        note,
        loggedWorkoutSections,
        workout,
        scheduledWorkout,
        gymProfile
      ];
  Map<String, dynamic> toJson() => _$CreateLoggedWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutMoveInLoggedSetInput extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutMoveInLoggedSetInput(
      {required this.sortPosition,
      this.note,
      required this.repType,
      required this.reps,
      this.distanceUnit,
      this.loadAmount,
      this.loadUnit,
      this.timeUnit,
      required this.move,
      this.equipment});

  factory CreateLoggedWorkoutMoveInLoggedSetInput.fromJson(
          Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutMoveInLoggedSetInputFromJson(json);

  late int sortPosition;

  String? note;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late WorkoutMoveRepType repType;

  late double reps;

  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  DistanceUnit? distanceUnit;

  double? loadAmount;

  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  LoadUnit? loadUnit;

  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  TimeUnit? timeUnit;

  @JsonKey(name: 'Move')
  late ConnectRelationInput move;

  @JsonKey(name: 'Equipment')
  ConnectRelationInput? equipment;

  @override
  List<Object?> get props => [
        sortPosition,
        note,
        repType,
        reps,
        distanceUnit,
        loadAmount,
        loadUnit,
        timeUnit,
        move,
        equipment
      ];
  Map<String, dynamic> toJson() =>
      _$CreateLoggedWorkoutMoveInLoggedSetInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutSectionInLoggedWorkoutInput extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutSectionInLoggedWorkoutInput(
      {this.name,
      this.note,
      required this.sortPosition,
      required this.roundsCompleted,
      this.timeTakenMs,
      this.roundTimesMs,
      this.repScore,
      this.timecap,
      required this.workoutSectionType,
      required this.loggedWorkoutSets});

  factory CreateLoggedWorkoutSectionInLoggedWorkoutInput.fromJson(
          Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutSectionInLoggedWorkoutInputFromJson(json);

  String? name;

  String? note;

  late int sortPosition;

  late int roundsCompleted;

  int? timeTakenMs;

  @JsonKey(
      fromJson: fromGraphQLJsonToDartMapNullable,
      toJson: fromDartMapToGraphQLJsonNullable)
  Map? roundTimesMs;

  int? repScore;

  int? timecap;

  @JsonKey(name: 'WorkoutSectionType')
  late ConnectRelationInput workoutSectionType;

  @JsonKey(name: 'LoggedWorkoutSets')
  late List<CreateLoggedWorkoutSetInLoggedSectionInput> loggedWorkoutSets;

  @override
  List<Object?> get props => [
        name,
        note,
        sortPosition,
        roundsCompleted,
        timeTakenMs,
        roundTimesMs,
        repScore,
        timecap,
        workoutSectionType,
        loggedWorkoutSets
      ];
  Map<String, dynamic> toJson() =>
      _$CreateLoggedWorkoutSectionInLoggedWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutSetInLoggedSectionInput extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutSetInLoggedSectionInput(
      {required this.sortPosition,
      this.note,
      required this.roundsCompleted,
      this.duration,
      required this.loggedWorkoutMoves});

  factory CreateLoggedWorkoutSetInLoggedSectionInput.fromJson(
          Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutSetInLoggedSectionInputFromJson(json);

  late int sortPosition;

  String? note;

  late int roundsCompleted;

  int? duration;

  @JsonKey(name: 'LoggedWorkoutMoves')
  late List<CreateLoggedWorkoutMoveInLoggedSetInput> loggedWorkoutMoves;

  @override
  List<Object?> get props =>
      [sortPosition, note, roundsCompleted, duration, loggedWorkoutMoves];
  Map<String, dynamic> toJson() =>
      _$CreateLoggedWorkoutSetInLoggedSectionInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteLoggedWorkoutSetById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutSetById$Mutation();

  factory DeleteLoggedWorkoutSetById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutSetById$MutationFromJson(json);

  late String deleteLoggedWorkoutSetById;

  @override
  List<Object?> get props => [deleteLoggedWorkoutSetById];
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutSetById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutSet extends JsonSerializable
    with EquatableMixin, LoggedWorkoutSetMixin {
  CreateLoggedWorkoutSet();

  factory CreateLoggedWorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutSetFromJson(json);

  @override
  List<Object?> get props =>
      [$$typename, id, note, roundsCompleted, duration, sortPosition];
  Map<String, dynamic> toJson() => _$CreateLoggedWorkoutSetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutSet$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutSet$Mutation();

  factory CreateLoggedWorkoutSet$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutSet$MutationFromJson(json);

  late CreateLoggedWorkoutSet createLoggedWorkoutSet;

  @override
  List<Object?> get props => [createLoggedWorkoutSet];
  Map<String, dynamic> toJson() =>
      _$CreateLoggedWorkoutSet$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutSetInput extends JsonSerializable with EquatableMixin {
  CreateLoggedWorkoutSetInput(
      {required this.sortPosition,
      this.note,
      required this.roundsCompleted,
      this.duration,
      required this.loggedWorkoutSection});

  factory CreateLoggedWorkoutSetInput.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutSetInputFromJson(json);

  late int sortPosition;

  String? note;

  late int roundsCompleted;

  int? duration;

  @JsonKey(name: 'LoggedWorkoutSection')
  late ConnectRelationInput loggedWorkoutSection;

  @override
  List<Object?> get props =>
      [sortPosition, note, roundsCompleted, duration, loggedWorkoutSection];
  Map<String, dynamic> toJson() => _$CreateLoggedWorkoutSetInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSet extends JsonSerializable
    with EquatableMixin, LoggedWorkoutSetMixin {
  UpdateLoggedWorkoutSet();

  factory UpdateLoggedWorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSetFromJson(json);

  @override
  List<Object?> get props =>
      [$$typename, id, note, roundsCompleted, duration, sortPosition];
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkoutSetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSet$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutSet$Mutation();

  factory UpdateLoggedWorkoutSet$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSet$MutationFromJson(json);

  late UpdateLoggedWorkoutSet updateLoggedWorkoutSet;

  @override
  List<Object?> get props => [updateLoggedWorkoutSet];
  Map<String, dynamic> toJson() =>
      _$UpdateLoggedWorkoutSet$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSetInput extends JsonSerializable with EquatableMixin {
  UpdateLoggedWorkoutSetInput(
      {required this.id, this.note, this.duration, this.roundsCompleted});

  factory UpdateLoggedWorkoutSetInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSetInputFromJson(json);

  late String id;

  String? note;

  int? duration;

  int? roundsCompleted;

  @override
  List<Object?> get props => [id, note, duration, roundsCompleted];
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkoutSetInputToJson(this);
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
class WorkoutGoal extends JsonSerializable
    with EquatableMixin, WorkoutGoalMixin {
  WorkoutGoal();

  factory WorkoutGoal.fromJson(Map<String, dynamic> json) =>
      _$WorkoutGoalFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, name, description, hexColor];
  Map<String, dynamic> toJson() => _$WorkoutGoalToJson(this);
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

  @JsonKey(name: 'User')
  late UserSummary user;

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
        archived,
        name,
        description,
        lengthMinutes,
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
class WorkoutPlanDayWorkout extends JsonSerializable
    with EquatableMixin, WorkoutPlanDayWorkoutMixin {
  WorkoutPlanDayWorkout();

  factory WorkoutPlanDayWorkout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanDayWorkoutFromJson(json);

  @JsonKey(name: 'Workout')
  late Workout workout;

  @override
  List<Object?> get props => [id, $$typename, note, sortPosition, workout];
  Map<String, dynamic> toJson() => _$WorkoutPlanDayWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutPlanDay extends JsonSerializable
    with EquatableMixin, WorkoutPlanDayMixin {
  WorkoutPlanDay();

  factory WorkoutPlanDay.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanDayFromJson(json);

  @JsonKey(name: 'WorkoutPlanDayWorkouts')
  late List<WorkoutPlanDayWorkout> workoutPlanDayWorkouts;

  @override
  List<Object?> get props =>
      [id, $$typename, note, dayNumber, workoutPlanDayWorkouts];
  Map<String, dynamic> toJson() => _$WorkoutPlanDayToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutPlanEnrolment extends JsonSerializable
    with EquatableMixin, WorkoutPlanEnrolmentMixin {
  WorkoutPlanEnrolment();

  factory WorkoutPlanEnrolment.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanEnrolmentFromJson(json);

  @JsonKey(name: 'User')
  late UserSummary user;

  @override
  List<Object?> get props =>
      [id, $$typename, startDate, completedPlanDayWorkoutIds, user];
  Map<String, dynamic> toJson() => _$WorkoutPlanEnrolmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutPlanReview extends JsonSerializable
    with EquatableMixin, WorkoutPlanReviewMixin {
  WorkoutPlanReview();

  factory WorkoutPlanReview.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanReviewFromJson(json);

  @JsonKey(name: 'User')
  late UserSummary user;

  @override
  List<Object?> get props => [id, $$typename, createdAt, score, comment, user];
  Map<String, dynamic> toJson() => _$WorkoutPlanReviewToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutPlan extends JsonSerializable
    with EquatableMixin, WorkoutPlanMixin {
  WorkoutPlan();

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanFromJson(json);

  @JsonKey(name: 'User')
  late UserSummary user;

  @JsonKey(name: 'WorkoutPlanDays')
  late List<WorkoutPlanDay> workoutPlanDays;

  @JsonKey(name: 'Enrolments')
  late List<WorkoutPlanEnrolment> enrolments;

  @JsonKey(name: 'WorkoutPlanReviews')
  late List<WorkoutPlanReview> workoutPlanReviews;

  @JsonKey(name: 'WorkoutTags')
  late List<WorkoutTag> workoutTags;

  @override
  List<Object?> get props => [
        id,
        $$typename,
        createdAt,
        archived,
        name,
        description,
        lengthWeeks,
        coverImageUri,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        contentAccessScope,
        user,
        workoutPlanDays,
        enrolments,
        workoutPlanReviews,
        workoutTags
      ];
  Map<String, dynamic> toJson() => _$WorkoutPlanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserWorkoutPlans$Query extends JsonSerializable with EquatableMixin {
  UserWorkoutPlans$Query();

  factory UserWorkoutPlans$Query.fromJson(Map<String, dynamic> json) =>
      _$UserWorkoutPlans$QueryFromJson(json);

  late List<WorkoutPlan> userWorkoutPlans;

  @override
  List<Object?> get props => [userWorkoutPlans];
  Map<String, dynamic> toJson() => _$UserWorkoutPlans$QueryToJson(this);
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
      this.townCity,
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
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? birthdate;

  String? townCity;

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
        townCity,
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
      {required this.name, this.description, this.equipments});

  factory CreateGymProfileInput.fromJson(Map<String, dynamic> json) =>
      _$CreateGymProfileInputFromJson(json);

  late String name;

  String? description;

  @JsonKey(name: 'Equipments')
  List<ConnectRelationInput>? equipments;

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
  List<ConnectRelationInput>? equipments;

  @override
  List<Object?> get props => [id, name, description, equipments];
  Map<String, dynamic> toJson() => _$UpdateGymProfileInputToJson(this);
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
class DeleteLoggedWorkoutSectionById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutSectionById$Mutation();

  factory DeleteLoggedWorkoutSectionById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutSectionById$MutationFromJson(json);

  late String deleteLoggedWorkoutSectionById;

  @override
  List<Object?> get props => [deleteLoggedWorkoutSectionById];
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutSectionById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSection extends JsonSerializable
    with EquatableMixin, LoggedWorkoutSectionMixin {
  UpdateLoggedWorkoutSection();

  factory UpdateLoggedWorkoutSection.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSectionFromJson(json);

  @JsonKey(name: 'WorkoutSectionType')
  late WorkoutSectionType workoutSectionType;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        name,
        note,
        timecap,
        roundsCompleted,
        repScore,
        timeTakenMs,
        roundTimesMs,
        sortPosition,
        workoutSectionType
      ];
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkoutSectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSection$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutSection$Mutation();

  factory UpdateLoggedWorkoutSection$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSection$MutationFromJson(json);

  late UpdateLoggedWorkoutSection updateLoggedWorkoutSection;

  @override
  List<Object?> get props => [updateLoggedWorkoutSection];
  Map<String, dynamic> toJson() =>
      _$UpdateLoggedWorkoutSection$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSectionInput extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutSectionInput(
      {required this.id,
      this.name,
      this.roundsCompleted,
      this.timeTakenMs,
      this.roundTimesMs,
      this.timecap,
      this.repScore,
      this.note});

  factory UpdateLoggedWorkoutSectionInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSectionInputFromJson(json);

  late String id;

  String? name;

  int? roundsCompleted;

  int? timeTakenMs;

  @JsonKey(
      fromJson: fromGraphQLJsonToDartMapNullable,
      toJson: fromDartMapToGraphQLJsonNullable)
  Map? roundTimesMs;

  int? timecap;

  int? repScore;

  String? note;

  @override
  List<Object?> get props => [
        id,
        name,
        roundsCompleted,
        timeTakenMs,
        roundTimesMs,
        timecap,
        repScore,
        note
      ];
  Map<String, dynamic> toJson() =>
      _$UpdateLoggedWorkoutSectionInputToJson(this);
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
class UserBenchmarkEntry extends JsonSerializable
    with EquatableMixin, UserBenchmarkEntryMixin {
  UserBenchmarkEntry();

  factory UserBenchmarkEntry.fromJson(Map<String, dynamic> json) =>
      _$UserBenchmarkEntryFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        completedOn,
        score,
        note,
        videoUri,
        videoThumbUri
      ];
  Map<String, dynamic> toJson() => _$UserBenchmarkEntryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserBenchmarkEntry$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateUserBenchmarkEntry$Mutation();

  factory CreateUserBenchmarkEntry$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserBenchmarkEntry$MutationFromJson(json);

  late UserBenchmarkEntry createUserBenchmarkEntry;

  @override
  List<Object?> get props => [createUserBenchmarkEntry];
  Map<String, dynamic> toJson() =>
      _$CreateUserBenchmarkEntry$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserBenchmarkEntryInput extends JsonSerializable
    with EquatableMixin {
  CreateUserBenchmarkEntryInput(
      {required this.completedOn,
      required this.score,
      this.note,
      this.videoUri,
      this.videoThumbUri,
      required this.userBenchmark});

  factory CreateUserBenchmarkEntryInput.fromJson(Map<String, dynamic> json) =>
      _$CreateUserBenchmarkEntryInputFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime completedOn;

  late double score;

  String? note;

  String? videoUri;

  String? videoThumbUri;

  @JsonKey(name: 'UserBenchmark')
  late ConnectRelationInput userBenchmark;

  @override
  List<Object?> get props =>
      [completedOn, score, note, videoUri, videoThumbUri, userBenchmark];
  Map<String, dynamic> toJson() => _$CreateUserBenchmarkEntryInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserBenchmarkEntry$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateUserBenchmarkEntry$Mutation();

  factory UpdateUserBenchmarkEntry$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateUserBenchmarkEntry$MutationFromJson(json);

  late UserBenchmarkEntry updateUserBenchmarkEntry;

  @override
  List<Object?> get props => [updateUserBenchmarkEntry];
  Map<String, dynamic> toJson() =>
      _$UpdateUserBenchmarkEntry$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserBenchmarkEntryInput extends JsonSerializable
    with EquatableMixin {
  UpdateUserBenchmarkEntryInput(
      {required this.id,
      this.completedOn,
      this.score,
      this.note,
      this.videoUri,
      this.videoThumbUri});

  factory UpdateUserBenchmarkEntryInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserBenchmarkEntryInputFromJson(json);

  late String id;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? completedOn;

  double? score;

  String? note;

  String? videoUri;

  String? videoThumbUri;

  @override
  List<Object?> get props =>
      [id, completedOn, score, note, videoUri, videoThumbUri];
  Map<String, dynamic> toJson() => _$UpdateUserBenchmarkEntryInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteUserBenchmarkEntryById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteUserBenchmarkEntryById$Mutation();

  factory DeleteUserBenchmarkEntryById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteUserBenchmarkEntryById$MutationFromJson(json);

  late String deleteUserBenchmarkEntryById;

  @override
  List<Object?> get props => [deleteUserBenchmarkEntryById];
  Map<String, dynamic> toJson() =>
      _$DeleteUserBenchmarkEntryById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserBenchmark extends JsonSerializable
    with EquatableMixin, UserBenchmarkMixin {
  UserBenchmark();

  factory UserBenchmark.fromJson(Map<String, dynamic> json) =>
      _$UserBenchmarkFromJson(json);

  @JsonKey(name: 'Equipment')
  Equipment? equipment;

  @JsonKey(name: 'Move')
  late Move move;

  @JsonKey(name: 'UserBenchmarkEntries')
  late List<UserBenchmarkEntry> userBenchmarkEntries;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        lastEntryAt,
        name,
        description,
        reps,
        repType,
        load,
        loadUnit,
        timeUnit,
        distanceUnit,
        benchmarkType,
        equipment,
        move,
        userBenchmarkEntries
      ];
  Map<String, dynamic> toJson() => _$UserBenchmarkToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserBenchmark$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateUserBenchmark$Mutation();

  factory UpdateUserBenchmark$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserBenchmark$MutationFromJson(json);

  late UserBenchmark updateUserBenchmark;

  @override
  List<Object?> get props => [updateUserBenchmark];
  Map<String, dynamic> toJson() => _$UpdateUserBenchmark$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserBenchmarkInput extends JsonSerializable with EquatableMixin {
  UpdateUserBenchmarkInput(
      {required this.id,
      this.name,
      this.description,
      this.reps,
      this.repType,
      this.load,
      this.loadUnit,
      this.timeUnit,
      this.distanceUnit,
      required this.benchmarkType,
      this.equipment,
      this.move});

  factory UpdateUserBenchmarkInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserBenchmarkInputFromJson(json);

  late String id;

  String? name;

  String? description;

  double? reps;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  WorkoutMoveRepType? repType;

  double? load;

  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  LoadUnit? loadUnit;

  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  TimeUnit? timeUnit;

  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  DistanceUnit? distanceUnit;

  @JsonKey(unknownEnumValue: BenchmarkType.artemisUnknown)
  late BenchmarkType benchmarkType;

  @JsonKey(name: 'Equipment')
  ConnectRelationInput? equipment;

  @JsonKey(name: 'Move')
  ConnectRelationInput? move;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        reps,
        repType,
        load,
        loadUnit,
        timeUnit,
        distanceUnit,
        benchmarkType,
        equipment,
        move
      ];
  Map<String, dynamic> toJson() => _$UpdateUserBenchmarkInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserBenchmark$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateUserBenchmark$Mutation();

  factory CreateUserBenchmark$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateUserBenchmark$MutationFromJson(json);

  late UserBenchmark createUserBenchmark;

  @override
  List<Object?> get props => [createUserBenchmark];
  Map<String, dynamic> toJson() => _$CreateUserBenchmark$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserBenchmarkInput extends JsonSerializable with EquatableMixin {
  CreateUserBenchmarkInput(
      {required this.name,
      this.description,
      this.reps,
      this.repType,
      this.load,
      this.loadUnit,
      this.timeUnit,
      this.distanceUnit,
      required this.benchmarkType,
      this.equipment,
      required this.move});

  factory CreateUserBenchmarkInput.fromJson(Map<String, dynamic> json) =>
      _$CreateUserBenchmarkInputFromJson(json);

  late String name;

  String? description;

  double? reps;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  WorkoutMoveRepType? repType;

  double? load;

  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  LoadUnit? loadUnit;

  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  TimeUnit? timeUnit;

  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  DistanceUnit? distanceUnit;

  @JsonKey(unknownEnumValue: BenchmarkType.artemisUnknown)
  late BenchmarkType benchmarkType;

  @JsonKey(name: 'Equipment')
  ConnectRelationInput? equipment;

  @JsonKey(name: 'Move')
  late ConnectRelationInput move;

  @override
  List<Object?> get props => [
        name,
        description,
        reps,
        repType,
        load,
        loadUnit,
        timeUnit,
        distanceUnit,
        benchmarkType,
        equipment,
        move
      ];
  Map<String, dynamic> toJson() => _$CreateUserBenchmarkInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteUserBenchmarkById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteUserBenchmarkById$Mutation();

  factory DeleteUserBenchmarkById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteUserBenchmarkById$MutationFromJson(json);

  late String deleteUserBenchmarkById;

  @override
  List<Object?> get props => [deleteUserBenchmarkById];
  Map<String, dynamic> toJson() =>
      _$DeleteUserBenchmarkById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserBenchmarks$Query extends JsonSerializable with EquatableMixin {
  UserBenchmarks$Query();

  factory UserBenchmarks$Query.fromJson(Map<String, dynamic> json) =>
      _$UserBenchmarks$QueryFromJson(json);

  late List<UserBenchmark> userBenchmarks;

  @override
  List<Object?> get props => [userBenchmarks];
  Map<String, dynamic> toJson() => _$UserBenchmarks$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserBenchmarkById$Query extends JsonSerializable with EquatableMixin {
  UserBenchmarkById$Query();

  factory UserBenchmarkById$Query.fromJson(Map<String, dynamic> json) =>
      _$UserBenchmarkById$QueryFromJson(json);

  late UserBenchmark userBenchmarkById;

  @override
  List<Object?> get props => [userBenchmarkById];
  Map<String, dynamic> toJson() => _$UserBenchmarkById$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TextSearchWorkouts$Query extends JsonSerializable with EquatableMixin {
  TextSearchWorkouts$Query();

  factory TextSearchWorkouts$Query.fromJson(Map<String, dynamic> json) =>
      _$TextSearchWorkouts$QueryFromJson(json);

  List<Workout>? textSearchWorkouts;

  @override
  List<Object?> get props => [textSearchWorkouts];
  Map<String, dynamic> toJson() => _$TextSearchWorkouts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TextSearchResult extends JsonSerializable with EquatableMixin {
  TextSearchResult();

  factory TextSearchResult.fromJson(Map<String, dynamic> json) =>
      _$TextSearchResultFromJson(json);

  late String id;

  @JsonKey(name: '__typename')
  String? $$typename;

  late String name;

  @override
  List<Object?> get props => [id, $$typename, name];
  Map<String, dynamic> toJson() => _$TextSearchResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TextSearchWorkoutNames$Query extends JsonSerializable
    with EquatableMixin {
  TextSearchWorkoutNames$Query();

  factory TextSearchWorkoutNames$Query.fromJson(Map<String, dynamic> json) =>
      _$TextSearchWorkoutNames$QueryFromJson(json);

  List<TextSearchResult>? textSearchWorkoutNames;

  @override
  List<Object?> get props => [textSearchWorkoutNames];
  Map<String, dynamic> toJson() => _$TextSearchWorkoutNames$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteLoggedWorkoutMoveById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutMoveById$Mutation();

  factory DeleteLoggedWorkoutMoveById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutMoveById$MutationFromJson(json);

  late String deleteLoggedWorkoutMoveById;

  @override
  List<Object?> get props => [deleteLoggedWorkoutMoveById];
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutMoveById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutMove$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutMove$Mutation();

  factory UpdateLoggedWorkoutMove$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutMove$MutationFromJson(json);

  late LoggedWorkoutMove updateLoggedWorkoutMove;

  @override
  List<Object?> get props => [updateLoggedWorkoutMove];
  Map<String, dynamic> toJson() =>
      _$UpdateLoggedWorkoutMove$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutMoveInput extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutMoveInput(
      {required this.id,
      this.note,
      this.reps,
      this.distanceUnit,
      this.loadAmount,
      this.loadUnit,
      this.timeUnit,
      this.move,
      this.equipment});

  factory UpdateLoggedWorkoutMoveInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutMoveInputFromJson(json);

  late String id;

  String? note;

  double? reps;

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
        note,
        reps,
        distanceUnit,
        loadAmount,
        loadUnit,
        timeUnit,
        move,
        equipment
      ];
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkoutMoveInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutMove$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutMove$Mutation();

  factory CreateLoggedWorkoutMove$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutMove$MutationFromJson(json);

  late LoggedWorkoutMove createLoggedWorkoutMove;

  @override
  List<Object?> get props => [createLoggedWorkoutMove];
  Map<String, dynamic> toJson() =>
      _$CreateLoggedWorkoutMove$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutMoveInput extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutMoveInput(
      {required this.sortPosition,
      this.note,
      required this.repType,
      required this.reps,
      this.distanceUnit,
      this.loadAmount,
      this.loadUnit,
      this.timeUnit,
      required this.move,
      this.equipment,
      required this.loggedWorkoutSet});

  factory CreateLoggedWorkoutMoveInput.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutMoveInputFromJson(json);

  late int sortPosition;

  String? note;

  @JsonKey(unknownEnumValue: WorkoutMoveRepType.artemisUnknown)
  late WorkoutMoveRepType repType;

  late double reps;

  @JsonKey(unknownEnumValue: DistanceUnit.artemisUnknown)
  DistanceUnit? distanceUnit;

  double? loadAmount;

  @JsonKey(unknownEnumValue: LoadUnit.artemisUnknown)
  LoadUnit? loadUnit;

  @JsonKey(unknownEnumValue: TimeUnit.artemisUnknown)
  TimeUnit? timeUnit;

  @JsonKey(name: 'Move')
  late ConnectRelationInput move;

  @JsonKey(name: 'Equipment')
  ConnectRelationInput? equipment;

  @JsonKey(name: 'LoggedWorkoutSet')
  late ConnectRelationInput loggedWorkoutSet;

  @override
  List<Object?> get props => [
        sortPosition,
        note,
        repType,
        reps,
        distanceUnit,
        loadAmount,
        loadUnit,
        timeUnit,
        move,
        equipment,
        loggedWorkoutSet
      ];
  Map<String, dynamic> toJson() => _$CreateLoggedWorkoutMoveInputToJson(this);
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
class LoggedWorkoutSummary extends JsonSerializable
    with EquatableMixin, LoggedWorkoutMixin {
  LoggedWorkoutSummary();

  factory LoggedWorkoutSummary.fromJson(Map<String, dynamic> json) =>
      _$LoggedWorkoutSummaryFromJson(json);

  @override
  List<Object?> get props => [$$typename, id, completedOn, note, name];
  Map<String, dynamic> toJson() => _$LoggedWorkoutSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScheduledWorkout extends JsonSerializable with EquatableMixin {
  ScheduledWorkout();

  factory ScheduledWorkout.fromJson(Map<String, dynamic> json) =>
      _$ScheduledWorkoutFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime scheduledAt;

  String? note;

  @JsonKey(name: 'Workout')
  Workout? workout;

  @JsonKey(name: 'LoggedWorkoutSummary')
  LoggedWorkoutSummary? loggedWorkoutSummary;

  @JsonKey(name: 'GymProfile')
  GymProfile? gymProfile;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        scheduledAt,
        note,
        workout,
        loggedWorkoutSummary,
        gymProfile
      ];
  Map<String, dynamic> toJson() => _$ScheduledWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateScheduledWorkout$Mutation extends JsonSerializable
    with EquatableMixin {
  UpdateScheduledWorkout$Mutation();

  factory UpdateScheduledWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateScheduledWorkout$MutationFromJson(json);

  late ScheduledWorkout updateScheduledWorkout;

  @override
  List<Object?> get props => [updateScheduledWorkout];
  Map<String, dynamic> toJson() =>
      _$UpdateScheduledWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateScheduledWorkoutInput extends JsonSerializable with EquatableMixin {
  UpdateScheduledWorkoutInput(
      {required this.id,
      this.scheduledAt,
      this.note,
      this.workout,
      this.loggedWorkout,
      this.gymProfile});

  factory UpdateScheduledWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateScheduledWorkoutInputFromJson(json);

  late String id;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTimeNullable,
      toJson: fromDartDateTimeToGraphQLDateTimeNullable)
  DateTime? scheduledAt;

  String? note;

  @JsonKey(name: 'Workout')
  ConnectRelationInput? workout;

  @JsonKey(name: 'LoggedWorkout')
  ConnectRelationInput? loggedWorkout;

  @JsonKey(name: 'GymProfile')
  ConnectRelationInput? gymProfile;

  @override
  List<Object?> get props =>
      [id, scheduledAt, note, workout, loggedWorkout, gymProfile];
  Map<String, dynamic> toJson() => _$UpdateScheduledWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateScheduledWorkout$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateScheduledWorkout$Mutation();

  factory CreateScheduledWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateScheduledWorkout$MutationFromJson(json);

  late ScheduledWorkout createScheduledWorkout;

  @override
  List<Object?> get props => [createScheduledWorkout];
  Map<String, dynamic> toJson() =>
      _$CreateScheduledWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateScheduledWorkoutInput extends JsonSerializable with EquatableMixin {
  CreateScheduledWorkoutInput(
      {required this.scheduledAt,
      this.note,
      required this.workout,
      this.gymProfile});

  factory CreateScheduledWorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$CreateScheduledWorkoutInputFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDateTime)
  late DateTime scheduledAt;

  String? note;

  @JsonKey(name: 'Workout')
  late ConnectRelationInput workout;

  @JsonKey(name: 'GymProfile')
  ConnectRelationInput? gymProfile;

  @override
  List<Object?> get props => [scheduledAt, note, workout, gymProfile];
  Map<String, dynamic> toJson() => _$CreateScheduledWorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserScheduledWorkouts$Query extends JsonSerializable with EquatableMixin {
  UserScheduledWorkouts$Query();

  factory UserScheduledWorkouts$Query.fromJson(Map<String, dynamic> json) =>
      _$UserScheduledWorkouts$QueryFromJson(json);

  late List<ScheduledWorkout> userScheduledWorkouts;

  @override
  List<Object?> get props => [userScheduledWorkouts];
  Map<String, dynamic> toJson() => _$UserScheduledWorkouts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteScheduledWorkoutById$Mutation extends JsonSerializable
    with EquatableMixin {
  DeleteScheduledWorkoutById$Mutation();

  factory DeleteScheduledWorkoutById$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteScheduledWorkoutById$MutationFromJson(json);

  late String deleteScheduledWorkoutById;

  @override
  List<Object?> get props => [deleteScheduledWorkoutById];
  Map<String, dynamic> toJson() =>
      _$DeleteScheduledWorkoutById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PublicWorkouts$Query extends JsonSerializable with EquatableMixin {
  PublicWorkouts$Query();

  factory PublicWorkouts$Query.fromJson(Map<String, dynamic> json) =>
      _$PublicWorkouts$QueryFromJson(json);

  late List<Workout> publicWorkouts;

  @override
  List<Object?> get props => [publicWorkouts];
  Map<String, dynamic> toJson() => _$PublicWorkouts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutFiltersInput extends JsonSerializable with EquatableMixin {
  WorkoutFiltersInput(
      {this.difficultyLevel,
      this.hasClassVideo,
      this.maxLength,
      this.minLength,
      required this.workoutSectionTypes,
      required this.workoutGoals,
      this.bodyweightOnly,
      required this.availableEquipments,
      required this.requiredMoves,
      required this.excludedMoves,
      required this.targetedBodyAreas});

  factory WorkoutFiltersInput.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFiltersInputFromJson(json);

  @JsonKey(unknownEnumValue: DifficultyLevel.artemisUnknown)
  DifficultyLevel? difficultyLevel;

  bool? hasClassVideo;

  int? maxLength;

  int? minLength;

  late List<String> workoutSectionTypes;

  late List<String> workoutGoals;

  bool? bodyweightOnly;

  late List<String> availableEquipments;

  late List<String> requiredMoves;

  late List<String> excludedMoves;

  late List<String> targetedBodyAreas;

  @override
  List<Object?> get props => [
        difficultyLevel,
        hasClassVideo,
        maxLength,
        minLength,
        workoutSectionTypes,
        workoutGoals,
        bodyweightOnly,
        availableEquipments,
        requiredMoves,
        excludedMoves,
        targetedBodyAreas
      ];
  Map<String, dynamic> toJson() => _$WorkoutFiltersInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkout extends JsonSerializable with EquatableMixin, WorkoutMixin {
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
        archived,
        name,
        description,
        lengthMinutes,
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
      this.archived,
      this.name,
      this.description,
      this.lengthMinutes,
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

  bool? archived;

  String? name;

  String? description;

  int? lengthMinutes;

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
        archived,
        name,
        description,
        lengthMinutes,
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
class DuplicateWorkoutById$Mutation extends JsonSerializable
    with EquatableMixin {
  DuplicateWorkoutById$Mutation();

  factory DuplicateWorkoutById$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DuplicateWorkoutById$MutationFromJson(json);

  late Workout duplicateWorkoutById;

  @override
  List<Object?> get props => [duplicateWorkoutById];
  Map<String, dynamic> toJson() => _$DuplicateWorkoutById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SoftDeleteWorkoutById$Mutation extends JsonSerializable
    with EquatableMixin {
  SoftDeleteWorkoutById$Mutation();

  factory SoftDeleteWorkoutById$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SoftDeleteWorkoutById$MutationFromJson(json);

  String? softDeleteWorkoutById;

  @override
  List<Object?> get props => [softDeleteWorkoutById];
  Map<String, dynamic> toJson() => _$SoftDeleteWorkoutById$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkout extends JsonSerializable with EquatableMixin, WorkoutMixin {
  CreateWorkout();

  factory CreateWorkout.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutFromJson(json);

  @JsonKey(name: 'User')
  late UserSummary user;

  @JsonKey(name: 'WorkoutGoals')
  late List<WorkoutGoal> workoutGoals;

  @JsonKey(name: 'WorkoutTags')
  late List<WorkoutTag> workoutTags;

  @override
  List<Object?> get props => [
        $$typename,
        id,
        createdAt,
        archived,
        name,
        description,
        lengthMinutes,
        difficultyLevel,
        coverImageUri,
        contentAccessScope,
        introVideoUri,
        introVideoThumbUri,
        introAudioUri,
        user,
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
class WorkoutPlanById$Query extends JsonSerializable with EquatableMixin {
  WorkoutPlanById$Query();

  factory WorkoutPlanById$Query.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanById$QueryFromJson(json);

  late WorkoutPlan workoutPlanById;

  @override
  List<Object?> get props => [workoutPlanById];
  Map<String, dynamic> toJson() => _$WorkoutPlanById$QueryToJson(this);
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
  @JsonValue('PERCENTMAX')
  percentmax,
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
enum BodyweightUnit {
  @JsonValue('KG')
  kg,
  @JsonValue('LB')
  lb,
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
enum BenchmarkType {
  @JsonValue('MAXLOAD')
  maxload,
  @JsonValue('FASTESTTIME')
  fastesttime,
  @JsonValue('UNBROKENREPS')
  unbrokenreps,
  @JsonValue('UNBROKENTIME')
  unbrokentime,
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

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalGoalTagArguments extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalGoalTagArguments({required this.data});

  @override
  factory UpdateProgressJournalGoalTagArguments.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateProgressJournalGoalTagArgumentsFromJson(json);

  late UpdateProgressJournalGoalTagInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalGoalTagArgumentsToJson(this);
}

final UPDATE_PROGRESS_JOURNAL_GOAL_TAG_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateProgressJournalGoalTag'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateProgressJournalGoalTagInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateProgressJournalGoalTag'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournalGoalTag'),
                  directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateProgressJournalGoalTagMutation extends GraphQLQuery<
    UpdateProgressJournalGoalTag$Mutation,
    UpdateProgressJournalGoalTagArguments> {
  UpdateProgressJournalGoalTagMutation({required this.variables});

  @override
  final DocumentNode document =
      UPDATE_PROGRESS_JOURNAL_GOAL_TAG_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateProgressJournalGoalTag';

  @override
  final UpdateProgressJournalGoalTagArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateProgressJournalGoalTag$Mutation parse(Map<String, dynamic> json) =>
      UpdateProgressJournalGoalTag$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ProgressJournalByIdArguments extends JsonSerializable
    with EquatableMixin {
  ProgressJournalByIdArguments({required this.id});

  @override
  factory ProgressJournalByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$ProgressJournalByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$ProgressJournalByIdArgumentsToJson(this);
}

final PROGRESS_JOURNAL_BY_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'progressJournalById'),
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
            name: NameNode(value: 'progressJournalById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournal'), directives: []),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalEntry'),
                        directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalGoal'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'ProgressJournalGoalTags'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'ProgressJournalGoalTag'),
                              directives: [])
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalEntry'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'voiceNoteUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweightUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'moodScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'energyScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'stressScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'motivationScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'progressPhotoUris'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoal'), isNonNull: false)),
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
            name: NameNode(value: 'deadline'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournal'), isNonNull: false)),
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
            selectionSet: null)
      ]))
]);

class ProgressJournalByIdQuery extends GraphQLQuery<ProgressJournalById$Query,
    ProgressJournalByIdArguments> {
  ProgressJournalByIdQuery({required this.variables});

  @override
  final DocumentNode document = PROGRESS_JOURNAL_BY_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'progressJournalById';

  @override
  final ProgressJournalByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ProgressJournalById$Query parse(Map<String, dynamic> json) =>
      ProgressJournalById$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalEntryArguments extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalEntryArguments({required this.data});

  @override
  factory CreateProgressJournalEntryArguments.fromJson(
          Map<String, dynamic> json) =>
      _$CreateProgressJournalEntryArgumentsFromJson(json);

  late CreateProgressJournalEntryInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalEntryArgumentsToJson(this);
}

final CREATE_PROGRESS_JOURNAL_ENTRY_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createProgressJournalEntry'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateProgressJournalEntryInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createProgressJournalEntry'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournalEntry'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalEntry'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'voiceNoteUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweightUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'moodScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'energyScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'stressScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'motivationScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'progressPhotoUris'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateProgressJournalEntryMutation extends GraphQLQuery<
    CreateProgressJournalEntry$Mutation, CreateProgressJournalEntryArguments> {
  CreateProgressJournalEntryMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_PROGRESS_JOURNAL_ENTRY_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createProgressJournalEntry';

  @override
  final CreateProgressJournalEntryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateProgressJournalEntry$Mutation parse(Map<String, dynamic> json) =>
      CreateProgressJournalEntry$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalByIdArguments({required this.id});

  @override
  factory DeleteProgressJournalByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalByIdArgumentsToJson(this);
}

final DELETE_PROGRESS_JOURNAL_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteProgressJournalById'),
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
            name: NameNode(value: 'deleteProgressJournalById'),
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

class DeleteProgressJournalByIdMutation extends GraphQLQuery<
    DeleteProgressJournalById$Mutation, DeleteProgressJournalByIdArguments> {
  DeleteProgressJournalByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_PROGRESS_JOURNAL_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteProgressJournalById';

  @override
  final DeleteProgressJournalByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteProgressJournalById$Mutation parse(Map<String, dynamic> json) =>
      DeleteProgressJournalById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalArguments extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalArguments({required this.data});

  @override
  factory CreateProgressJournalArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateProgressJournalArgumentsFromJson(json);

  late CreateProgressJournalInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateProgressJournalArgumentsToJson(this);
}

final CREATE_PROGRESS_JOURNAL_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createProgressJournal'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateProgressJournalInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createProgressJournal'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournal'), directives: []),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalEntry'),
                        directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalGoal'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'ProgressJournalGoalTags'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'ProgressJournalGoalTag'),
                              directives: [])
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalEntry'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'voiceNoteUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweightUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'moodScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'energyScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'stressScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'motivationScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'progressPhotoUris'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoal'), isNonNull: false)),
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
            name: NameNode(value: 'deadline'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournal'), isNonNull: false)),
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
            selectionSet: null)
      ]))
]);

class CreateProgressJournalMutation extends GraphQLQuery<
    CreateProgressJournal$Mutation, CreateProgressJournalArguments> {
  CreateProgressJournalMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_PROGRESS_JOURNAL_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createProgressJournal';

  @override
  final CreateProgressJournalArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateProgressJournal$Mutation parse(Map<String, dynamic> json) =>
      CreateProgressJournal$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalArguments extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalArguments({required this.data});

  @override
  factory UpdateProgressJournalArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateProgressJournalArgumentsFromJson(json);

  late UpdateProgressJournalInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateProgressJournalArgumentsToJson(this);
}

final UPDATE_PROGRESS_JOURNAL_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateProgressJournal'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateProgressJournalInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateProgressJournal'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournal'), directives: []),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalEntry'),
                        directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalGoal'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'ProgressJournalGoalTags'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'ProgressJournalGoalTag'),
                              directives: [])
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalEntry'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'voiceNoteUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweightUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'moodScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'energyScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'stressScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'motivationScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'progressPhotoUris'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoal'), isNonNull: false)),
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
            name: NameNode(value: 'deadline'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournal'), isNonNull: false)),
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
            selectionSet: null)
      ]))
]);

class UpdateProgressJournalMutation extends GraphQLQuery<
    UpdateProgressJournal$Mutation, UpdateProgressJournalArguments> {
  UpdateProgressJournalMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_PROGRESS_JOURNAL_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateProgressJournal';

  @override
  final UpdateProgressJournalArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateProgressJournal$Mutation parse(Map<String, dynamic> json) =>
      UpdateProgressJournal$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalEntryByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalEntryByIdArguments({required this.id});

  @override
  factory DeleteProgressJournalEntryByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalEntryByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalEntryByIdArgumentsToJson(this);
}

final DELETE_PROGRESS_JOURNAL_ENTRY_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteProgressJournalEntryById'),
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
            name: NameNode(value: 'deleteProgressJournalEntryById'),
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

class DeleteProgressJournalEntryByIdMutation extends GraphQLQuery<
    DeleteProgressJournalEntryById$Mutation,
    DeleteProgressJournalEntryByIdArguments> {
  DeleteProgressJournalEntryByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_PROGRESS_JOURNAL_ENTRY_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteProgressJournalEntryById';

  @override
  final DeleteProgressJournalEntryByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteProgressJournalEntryById$Mutation parse(Map<String, dynamic> json) =>
      DeleteProgressJournalEntryById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalEntryArguments extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalEntryArguments({required this.data});

  @override
  factory UpdateProgressJournalEntryArguments.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateProgressJournalEntryArgumentsFromJson(json);

  late UpdateProgressJournalEntryInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalEntryArgumentsToJson(this);
}

final UPDATE_PROGRESS_JOURNAL_ENTRY_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateProgressJournalEntry'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateProgressJournalEntryInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateProgressJournalEntry'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournalEntry'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalEntry'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'voiceNoteUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweightUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'moodScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'energyScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'stressScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'motivationScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'progressPhotoUris'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateProgressJournalEntryMutation extends GraphQLQuery<
    UpdateProgressJournalEntry$Mutation, UpdateProgressJournalEntryArguments> {
  UpdateProgressJournalEntryMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_PROGRESS_JOURNAL_ENTRY_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateProgressJournalEntry';

  @override
  final UpdateProgressJournalEntryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateProgressJournalEntry$Mutation parse(Map<String, dynamic> json) =>
      UpdateProgressJournalEntry$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalGoalArguments extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalGoalArguments({required this.data});

  @override
  factory CreateProgressJournalGoalArguments.fromJson(
          Map<String, dynamic> json) =>
      _$CreateProgressJournalGoalArgumentsFromJson(json);

  late CreateProgressJournalGoalInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalGoalArgumentsToJson(this);
}

final CREATE_PROGRESS_JOURNAL_GOAL_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createProgressJournalGoal'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateProgressJournalGoalInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createProgressJournalGoal'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournalGoal'), directives: []),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalGoalTags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalGoalTag'),
                        directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoal'), isNonNull: false)),
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
            name: NameNode(value: 'deadline'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateProgressJournalGoalMutation extends GraphQLQuery<
    CreateProgressJournalGoal$Mutation, CreateProgressJournalGoalArguments> {
  CreateProgressJournalGoalMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_PROGRESS_JOURNAL_GOAL_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createProgressJournalGoal';

  @override
  final CreateProgressJournalGoalArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateProgressJournalGoal$Mutation parse(Map<String, dynamic> json) =>
      CreateProgressJournalGoal$Mutation.fromJson(json);
}

final USER_PROGRESS_JOURNALS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userProgressJournals'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userProgressJournals'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournal'), directives: []),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalEntry'),
                        directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalGoals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalGoal'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'ProgressJournalGoalTags'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'ProgressJournalGoalTag'),
                              directives: [])
                        ]))
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalEntry'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'voiceNoteUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweight'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bodyweightUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'moodScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'energyScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'stressScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'motivationScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'progressPhotoUris'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoal'), isNonNull: false)),
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
            name: NameNode(value: 'deadline'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournal'), isNonNull: false)),
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
            selectionSet: null)
      ]))
]);

class UserProgressJournalsQuery
    extends GraphQLQuery<UserProgressJournals$Query, JsonSerializable> {
  UserProgressJournalsQuery();

  @override
  final DocumentNode document = USER_PROGRESS_JOURNALS_QUERY_DOCUMENT;

  @override
  final String operationName = 'userProgressJournals';

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserProgressJournals$Query parse(Map<String, dynamic> json) =>
      UserProgressJournals$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateProgressJournalGoalArguments extends JsonSerializable
    with EquatableMixin {
  UpdateProgressJournalGoalArguments({required this.data});

  @override
  factory UpdateProgressJournalGoalArguments.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateProgressJournalGoalArgumentsFromJson(json);

  late UpdateProgressJournalGoalInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateProgressJournalGoalArgumentsToJson(this);
}

final UPDATE_PROGRESS_JOURNAL_GOAL_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateProgressJournalGoal'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateProgressJournalGoalInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateProgressJournalGoal'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournalGoal'), directives: []),
              FieldNode(
                  name: NameNode(value: 'ProgressJournalGoalTags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'ProgressJournalGoalTag'),
                        directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoal'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoal'), isNonNull: false)),
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
            name: NameNode(value: 'deadline'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateProgressJournalGoalMutation extends GraphQLQuery<
    UpdateProgressJournalGoal$Mutation, UpdateProgressJournalGoalArguments> {
  UpdateProgressJournalGoalMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_PROGRESS_JOURNAL_GOAL_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateProgressJournalGoal';

  @override
  final UpdateProgressJournalGoalArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateProgressJournalGoal$Mutation parse(Map<String, dynamic> json) =>
      UpdateProgressJournalGoal$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateProgressJournalGoalTagArguments extends JsonSerializable
    with EquatableMixin {
  CreateProgressJournalGoalTagArguments({required this.data});

  @override
  factory CreateProgressJournalGoalTagArguments.fromJson(
          Map<String, dynamic> json) =>
      _$CreateProgressJournalGoalTagArgumentsFromJson(json);

  late CreateProgressJournalGoalTagInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateProgressJournalGoalTagArgumentsToJson(this);
}

final CREATE_PROGRESS_JOURNAL_GOAL_TAG_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createProgressJournalGoalTag'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateProgressJournalGoalTagInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createProgressJournalGoalTag'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournalGoalTag'),
                  directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateProgressJournalGoalTagMutation extends GraphQLQuery<
    CreateProgressJournalGoalTag$Mutation,
    CreateProgressJournalGoalTagArguments> {
  CreateProgressJournalGoalTagMutation({required this.variables});

  @override
  final DocumentNode document =
      CREATE_PROGRESS_JOURNAL_GOAL_TAG_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createProgressJournalGoalTag';

  @override
  final CreateProgressJournalGoalTagArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateProgressJournalGoalTag$Mutation parse(Map<String, dynamic> json) =>
      CreateProgressJournalGoalTag$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalGoalByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalGoalByIdArguments({required this.id});

  @override
  factory DeleteProgressJournalGoalByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalGoalByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalGoalByIdArgumentsToJson(this);
}

final DELETE_PROGRESS_JOURNAL_GOAL_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteProgressJournalGoalById'),
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
            name: NameNode(value: 'deleteProgressJournalGoalById'),
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

class DeleteProgressJournalGoalByIdMutation extends GraphQLQuery<
    DeleteProgressJournalGoalById$Mutation,
    DeleteProgressJournalGoalByIdArguments> {
  DeleteProgressJournalGoalByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_PROGRESS_JOURNAL_GOAL_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteProgressJournalGoalById';

  @override
  final DeleteProgressJournalGoalByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteProgressJournalGoalById$Mutation parse(Map<String, dynamic> json) =>
      DeleteProgressJournalGoalById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteProgressJournalGoalTagByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteProgressJournalGoalTagByIdArguments({required this.id});

  @override
  factory DeleteProgressJournalGoalTagByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteProgressJournalGoalTagByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteProgressJournalGoalTagByIdArgumentsToJson(this);
}

final DELETE_PROGRESS_JOURNAL_GOAL_TAG_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteProgressJournalGoalTagById'),
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
            name: NameNode(value: 'deleteProgressJournalGoalTagById'),
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

class DeleteProgressJournalGoalTagByIdMutation extends GraphQLQuery<
    DeleteProgressJournalGoalTagById$Mutation,
    DeleteProgressJournalGoalTagByIdArguments> {
  DeleteProgressJournalGoalTagByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_PROGRESS_JOURNAL_GOAL_TAG_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteProgressJournalGoalTagById';

  @override
  final DeleteProgressJournalGoalTagByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteProgressJournalGoalTagById$Mutation parse(Map<String, dynamic> json) =>
      DeleteProgressJournalGoalTagById$Mutation.fromJson(json);
}

final PROGRESS_JOURNAL_GOAL_TAGS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'progressJournalGoalTags'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'progressJournalGoalTags'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'ProgressJournalGoalTag'),
                  directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'ProgressJournalGoalTag'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'ProgressJournalGoalTag'),
              isNonNull: false)),
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
            name: NameNode(value: 'tag'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class ProgressJournalGoalTagsQuery
    extends GraphQLQuery<ProgressJournalGoalTags$Query, JsonSerializable> {
  ProgressJournalGoalTagsQuery();

  @override
  final DocumentNode document = PROGRESS_JOURNAL_GOAL_TAGS_QUERY_DOCUMENT;

  @override
  final String operationName = 'progressJournalGoalTags';

  @override
  List<Object?> get props => [document, operationName];
  @override
  ProgressJournalGoalTags$Query parse(Map<String, dynamic> json) =>
      ProgressJournalGoalTags$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class LoggedWorkoutByIdArguments extends JsonSerializable with EquatableMixin {
  LoggedWorkoutByIdArguments({required this.id});

  @override
  factory LoggedWorkoutByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$LoggedWorkoutByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$LoggedWorkoutByIdArgumentsToJson(this);
}

final LOGGED_WORKOUT_BY_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'loggedWorkoutById'),
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
            name: NameNode(value: 'loggedWorkoutById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkout'), directives: []),
              FieldNode(
                  name: NameNode(value: 'GymProfile'),
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
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'LoggedWorkoutSections'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'LoggedWorkoutSection'),
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
                        name: NameNode(value: 'LoggedWorkoutSets'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'LoggedWorkoutSet'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: 'LoggedWorkoutMoves'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'LoggedWorkoutMove'),
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
      name: NameNode(value: 'LoggedWorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
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
      name: NameNode(value: 'LoggedWorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkoutSection'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSection'), isNonNull: false)),
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
            name: NameNode(value: 'timecap'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeTakenMs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundTimesMs'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkout'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
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
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class LoggedWorkoutByIdQuery
    extends GraphQLQuery<LoggedWorkoutById$Query, LoggedWorkoutByIdArguments> {
  LoggedWorkoutByIdQuery({required this.variables});

  @override
  final DocumentNode document = LOGGED_WORKOUT_BY_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'loggedWorkoutById';

  @override
  final LoggedWorkoutByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  LoggedWorkoutById$Query parse(Map<String, dynamic> json) =>
      LoggedWorkoutById$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteLoggedWorkoutByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutByIdArguments({required this.id});

  @override
  factory DeleteLoggedWorkoutByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutByIdArgumentsToJson(this);
}

final DELETE_LOGGED_WORKOUT_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteLoggedWorkoutById'),
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
            name: NameNode(value: 'deleteLoggedWorkoutById'),
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

class DeleteLoggedWorkoutByIdMutation extends GraphQLQuery<
    DeleteLoggedWorkoutById$Mutation, DeleteLoggedWorkoutByIdArguments> {
  DeleteLoggedWorkoutByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_LOGGED_WORKOUT_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteLoggedWorkoutById';

  @override
  final DeleteLoggedWorkoutByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteLoggedWorkoutById$Mutation parse(Map<String, dynamic> json) =>
      DeleteLoggedWorkoutById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserLoggedWorkoutsArguments extends JsonSerializable with EquatableMixin {
  UserLoggedWorkoutsArguments({this.take});

  @override
  factory UserLoggedWorkoutsArguments.fromJson(Map<String, dynamic> json) =>
      _$UserLoggedWorkoutsArgumentsFromJson(json);

  final int? take;

  @override
  List<Object?> get props => [take];
  @override
  Map<String, dynamic> toJson() => _$UserLoggedWorkoutsArgumentsToJson(this);
}

final USER_LOGGED_WORKOUTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userLoggedWorkouts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'take')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userLoggedWorkouts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'take'),
                  value: VariableNode(name: NameNode(value: 'take')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkout'), directives: []),
              FieldNode(
                  name: NameNode(value: 'GymProfile'),
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
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'LoggedWorkoutSections'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'LoggedWorkoutSection'),
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
                        name: NameNode(value: 'LoggedWorkoutSets'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'LoggedWorkoutSet'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: 'LoggedWorkoutMoves'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'LoggedWorkoutMove'),
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
      name: NameNode(value: 'LoggedWorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
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
      name: NameNode(value: 'LoggedWorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkoutSection'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSection'), isNonNull: false)),
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
            name: NameNode(value: 'timecap'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeTakenMs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundTimesMs'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkout'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
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
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UserLoggedWorkoutsQuery extends GraphQLQuery<UserLoggedWorkouts$Query,
    UserLoggedWorkoutsArguments> {
  UserLoggedWorkoutsQuery({required this.variables});

  @override
  final DocumentNode document = USER_LOGGED_WORKOUTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'userLoggedWorkouts';

  @override
  final UserLoggedWorkoutsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserLoggedWorkouts$Query parse(Map<String, dynamic> json) =>
      UserLoggedWorkouts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutArguments extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutArguments({required this.data});

  @override
  factory UpdateLoggedWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutArgumentsFromJson(json);

  late UpdateLoggedWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateLoggedWorkoutArgumentsToJson(this);
}

final UPDATE_LOGGED_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateLoggedWorkout'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateLoggedWorkoutInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateLoggedWorkout'),
            alias: NameNode(value: 'updateLoggedWorkout'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkout'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkout'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
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
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateLoggedWorkoutMutation extends GraphQLQuery<
    UpdateLoggedWorkout$Mutation, UpdateLoggedWorkoutArguments> {
  UpdateLoggedWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_LOGGED_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateLoggedWorkout';

  @override
  final UpdateLoggedWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateLoggedWorkout$Mutation parse(Map<String, dynamic> json) =>
      UpdateLoggedWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutArguments extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutArguments({required this.data});

  @override
  factory CreateLoggedWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutArgumentsFromJson(json);

  late CreateLoggedWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateLoggedWorkoutArgumentsToJson(this);
}

final CREATE_LOGGED_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createLoggedWorkout'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateLoggedWorkoutInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createLoggedWorkout'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkout'), directives: []),
              FieldNode(
                  name: NameNode(value: 'GymProfile'),
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
                              name: NameNode(value: 'Equipment'),
                              directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'LoggedWorkoutSections'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'LoggedWorkoutSection'),
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
                        name: NameNode(value: 'LoggedWorkoutSets'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'LoggedWorkoutSet'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: 'LoggedWorkoutMoves'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'LoggedWorkoutMove'),
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
      name: NameNode(value: 'LoggedWorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
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
      name: NameNode(value: 'LoggedWorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkoutSection'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSection'), isNonNull: false)),
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
            name: NameNode(value: 'timecap'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeTakenMs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundTimesMs'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkout'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
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
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateLoggedWorkoutMutation extends GraphQLQuery<
    CreateLoggedWorkout$Mutation, CreateLoggedWorkoutArguments> {
  CreateLoggedWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_LOGGED_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createLoggedWorkout';

  @override
  final CreateLoggedWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateLoggedWorkout$Mutation parse(Map<String, dynamic> json) =>
      CreateLoggedWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteLoggedWorkoutSetByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutSetByIdArguments({required this.id});

  @override
  factory DeleteLoggedWorkoutSetByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutSetByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutSetByIdArgumentsToJson(this);
}

final DELETE_LOGGED_WORKOUT_SET_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteLoggedWorkoutSetById'),
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
            name: NameNode(value: 'deleteLoggedWorkoutSetById'),
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

class DeleteLoggedWorkoutSetByIdMutation extends GraphQLQuery<
    DeleteLoggedWorkoutSetById$Mutation, DeleteLoggedWorkoutSetByIdArguments> {
  DeleteLoggedWorkoutSetByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_LOGGED_WORKOUT_SET_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteLoggedWorkoutSetById';

  @override
  final DeleteLoggedWorkoutSetByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteLoggedWorkoutSetById$Mutation parse(Map<String, dynamic> json) =>
      DeleteLoggedWorkoutSetById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutSetArguments extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutSetArguments({required this.data});

  @override
  factory CreateLoggedWorkoutSetArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutSetArgumentsFromJson(json);

  late CreateLoggedWorkoutSetInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateLoggedWorkoutSetArgumentsToJson(this);
}

final CREATE_LOGGED_WORKOUT_SET_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createLoggedWorkoutSet'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateLoggedWorkoutSetInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createLoggedWorkoutSet'),
            alias: NameNode(value: 'createLoggedWorkoutSet'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkoutSet'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
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
]);

class CreateLoggedWorkoutSetMutation extends GraphQLQuery<
    CreateLoggedWorkoutSet$Mutation, CreateLoggedWorkoutSetArguments> {
  CreateLoggedWorkoutSetMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_LOGGED_WORKOUT_SET_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createLoggedWorkoutSet';

  @override
  final CreateLoggedWorkoutSetArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateLoggedWorkoutSet$Mutation parse(Map<String, dynamic> json) =>
      CreateLoggedWorkoutSet$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSetArguments extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutSetArguments({required this.data});

  @override
  factory UpdateLoggedWorkoutSetArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSetArgumentsFromJson(json);

  late UpdateLoggedWorkoutSetInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateLoggedWorkoutSetArgumentsToJson(this);
}

final UPDATE_LOGGED_WORKOUT_SET_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateLoggedWorkoutSet'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateLoggedWorkoutSetInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateLoggedWorkoutSet'),
            alias: NameNode(value: 'updateLoggedWorkoutSet'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkoutSet'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkoutSet'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSet'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'duration'),
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
]);

class UpdateLoggedWorkoutSetMutation extends GraphQLQuery<
    UpdateLoggedWorkoutSet$Mutation, UpdateLoggedWorkoutSetArguments> {
  UpdateLoggedWorkoutSetMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_LOGGED_WORKOUT_SET_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateLoggedWorkoutSet';

  @override
  final UpdateLoggedWorkoutSetArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateLoggedWorkoutSet$Mutation parse(Map<String, dynamic> json) =>
      UpdateLoggedWorkoutSet$Mutation.fromJson(json);
}

final USER_WORKOUT_PLANS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userWorkoutPlans'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userWorkoutPlans'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutPlan'), directives: []),
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
                  name: NameNode(value: 'WorkoutPlanDays'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutPlanDay'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'WorkoutPlanDayWorkouts'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutPlanDayWorkout'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: 'Workout'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Workout'),
                                    directives: []),
                                FieldNode(
                                    name: NameNode(value: 'User'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'UserSummary'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'WorkoutGoals'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'WorkoutGoal'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'WorkoutTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'WorkoutTag'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'WorkoutSections'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name:
                                              NameNode(value: 'WorkoutSection'),
                                          directives: []),
                                      FieldNode(
                                          name: NameNode(
                                              value: 'WorkoutSectionType'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value:
                                                            'WorkoutSectionType'),
                                                    directives: [])
                                              ])),
                                      FieldNode(
                                          name: NameNode(value: 'WorkoutSets'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FragmentSpreadNode(
                                                name: NameNode(
                                                    value: 'WorkoutSet'),
                                                directives: []),
                                            FieldNode(
                                                name: NameNode(
                                                    value: 'WorkoutMoves'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'WorkoutMove'),
                                                          directives: []),
                                                      FieldNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet:
                                                              SelectionSetNode(
                                                                  selections: [
                                                                FragmentSpreadNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'Equipment'),
                                                                    directives: [])
                                                              ])),
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'Move'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet:
                                                              SelectionSetNode(
                                                                  selections: [
                                                                FragmentSpreadNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'Move'),
                                                                    directives: []),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'MoveType'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FragmentSpreadNode(
                                                                              name: NameNode(value: 'MoveType'),
                                                                              directives: [])
                                                                        ])),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'BodyAreaMoveScores'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FieldNode(
                                                                              name: NameNode(value: 'score'),
                                                                              alias: null,
                                                                              arguments: [],
                                                                              directives: [],
                                                                              selectionSet: null),
                                                                          FieldNode(
                                                                              name: NameNode(
                                                                                  value:
                                                                                      'BodyArea'),
                                                                              alias:
                                                                                  null,
                                                                              arguments: [],
                                                                              directives: [],
                                                                              selectionSet: SelectionSetNode(selections: [
                                                                                FragmentSpreadNode(name: NameNode(value: 'BodyArea'), directives: [])
                                                                              ]))
                                                                        ])),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'RequiredEquipments'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FragmentSpreadNode(
                                                                              name: NameNode(value: 'Equipment'),
                                                                              directives: [])
                                                                        ])),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'SelectableEquipments'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FragmentSpreadNode(
                                                                              name: NameNode(value: 'Equipment'),
                                                                              directives: [])
                                                                        ]))
                                                              ]))
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'Enrolments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutPlanEnrolment'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'User'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'UserSummary'),
                              directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutPlanReviews'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutPlanReview'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'User'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'UserSummary'),
                              directives: [])
                        ]))
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanDayWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanDayWorkout'),
              isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanDay'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanDay'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'dayNumber'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanEnrolment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanEnrolment'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'startDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedPlanDayWorkoutIds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanReview'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanReview'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'score'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'comment'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlan'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlan'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthWeeks'),
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
            name: NameNode(value: 'contentAccessScope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UserWorkoutPlansQuery
    extends GraphQLQuery<UserWorkoutPlans$Query, JsonSerializable> {
  UserWorkoutPlansQuery();

  @override
  final DocumentNode document = USER_WORKOUT_PLANS_QUERY_DOCUMENT;

  @override
  final String operationName = 'userWorkoutPlans';

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserWorkoutPlans$Query parse(Map<String, dynamic> json) =>
      UserWorkoutPlans$Query.fromJson(json);
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
class DeleteLoggedWorkoutSectionByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutSectionByIdArguments({required this.id});

  @override
  factory DeleteLoggedWorkoutSectionByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutSectionByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutSectionByIdArgumentsToJson(this);
}

final DELETE_LOGGED_WORKOUT_SECTION_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteLoggedWorkoutSectionById'),
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
            name: NameNode(value: 'deleteLoggedWorkoutSectionById'),
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

class DeleteLoggedWorkoutSectionByIdMutation extends GraphQLQuery<
    DeleteLoggedWorkoutSectionById$Mutation,
    DeleteLoggedWorkoutSectionByIdArguments> {
  DeleteLoggedWorkoutSectionByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_LOGGED_WORKOUT_SECTION_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteLoggedWorkoutSectionById';

  @override
  final DeleteLoggedWorkoutSectionByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteLoggedWorkoutSectionById$Mutation parse(Map<String, dynamic> json) =>
      DeleteLoggedWorkoutSectionById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutSectionArguments extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutSectionArguments({required this.data});

  @override
  factory UpdateLoggedWorkoutSectionArguments.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutSectionArgumentsFromJson(json);

  late UpdateLoggedWorkoutSectionInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateLoggedWorkoutSectionArgumentsToJson(this);
}

final UPDATE_LOGGED_WORKOUT_SECTION_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateLoggedWorkoutSection'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateLoggedWorkoutSectionInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateLoggedWorkoutSection'),
            alias: NameNode(value: 'updateLoggedWorkoutSection'),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkoutSection'),
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
      name: NameNode(value: 'LoggedWorkoutSection'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutSection'), isNonNull: false)),
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
            name: NameNode(value: 'timecap'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundsCompleted'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'repScore'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'timeTakenMs'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'roundTimesMs'),
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
]);

class UpdateLoggedWorkoutSectionMutation extends GraphQLQuery<
    UpdateLoggedWorkoutSection$Mutation, UpdateLoggedWorkoutSectionArguments> {
  UpdateLoggedWorkoutSectionMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_LOGGED_WORKOUT_SECTION_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateLoggedWorkoutSection';

  @override
  final UpdateLoggedWorkoutSectionArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateLoggedWorkoutSection$Mutation parse(Map<String, dynamic> json) =>
      UpdateLoggedWorkoutSection$Mutation.fromJson(json);
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
class CreateUserBenchmarkEntryArguments extends JsonSerializable
    with EquatableMixin {
  CreateUserBenchmarkEntryArguments({required this.data});

  @override
  factory CreateUserBenchmarkEntryArguments.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserBenchmarkEntryArgumentsFromJson(json);

  late CreateUserBenchmarkEntryInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUserBenchmarkEntryArgumentsToJson(this);
}

final CREATE_USER_BENCHMARK_ENTRY_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createUserBenchmarkEntry'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateUserBenchmarkEntryInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createUserBenchmarkEntry'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'UserBenchmarkEntry'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserBenchmarkEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmarkEntry'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'score'),
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
            name: NameNode(value: 'videoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'videoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateUserBenchmarkEntryMutation extends GraphQLQuery<
    CreateUserBenchmarkEntry$Mutation, CreateUserBenchmarkEntryArguments> {
  CreateUserBenchmarkEntryMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_USER_BENCHMARK_ENTRY_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createUserBenchmarkEntry';

  @override
  final CreateUserBenchmarkEntryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateUserBenchmarkEntry$Mutation parse(Map<String, dynamic> json) =>
      CreateUserBenchmarkEntry$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserBenchmarkEntryArguments extends JsonSerializable
    with EquatableMixin {
  UpdateUserBenchmarkEntryArguments({required this.data});

  @override
  factory UpdateUserBenchmarkEntryArguments.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateUserBenchmarkEntryArgumentsFromJson(json);

  late UpdateUserBenchmarkEntryInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateUserBenchmarkEntryArgumentsToJson(this);
}

final UPDATE_USER_BENCHMARK_ENTRY_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateUserBenchmarkEntry'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateUserBenchmarkEntryInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateUserBenchmarkEntry'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'UserBenchmarkEntry'), directives: [])
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserBenchmarkEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmarkEntry'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'score'),
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
            name: NameNode(value: 'videoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'videoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateUserBenchmarkEntryMutation extends GraphQLQuery<
    UpdateUserBenchmarkEntry$Mutation, UpdateUserBenchmarkEntryArguments> {
  UpdateUserBenchmarkEntryMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_USER_BENCHMARK_ENTRY_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateUserBenchmarkEntry';

  @override
  final UpdateUserBenchmarkEntryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateUserBenchmarkEntry$Mutation parse(Map<String, dynamic> json) =>
      UpdateUserBenchmarkEntry$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteUserBenchmarkEntryByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteUserBenchmarkEntryByIdArguments({required this.id});

  @override
  factory DeleteUserBenchmarkEntryByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteUserBenchmarkEntryByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteUserBenchmarkEntryByIdArgumentsToJson(this);
}

final DELETE_USER_BENCHMARK_ENTRY_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteUserBenchmarkEntryById'),
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
            name: NameNode(value: 'deleteUserBenchmarkEntryById'),
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

class DeleteUserBenchmarkEntryByIdMutation extends GraphQLQuery<
    DeleteUserBenchmarkEntryById$Mutation,
    DeleteUserBenchmarkEntryByIdArguments> {
  DeleteUserBenchmarkEntryByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_USER_BENCHMARK_ENTRY_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteUserBenchmarkEntryById';

  @override
  final DeleteUserBenchmarkEntryByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteUserBenchmarkEntryById$Mutation parse(Map<String, dynamic> json) =>
      DeleteUserBenchmarkEntryById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserBenchmarkArguments extends JsonSerializable
    with EquatableMixin {
  UpdateUserBenchmarkArguments({required this.data});

  @override
  factory UpdateUserBenchmarkArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserBenchmarkArgumentsFromJson(json);

  late UpdateUserBenchmarkInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$UpdateUserBenchmarkArgumentsToJson(this);
}

final UPDATE_USER_BENCHMARK_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateUserBenchmark'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateUserBenchmarkInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateUserBenchmark'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'UserBenchmark'), directives: []),
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
                  ])),
              FieldNode(
                  name: NameNode(value: 'UserBenchmarkEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserBenchmarkEntry'),
                        directives: [])
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
      name: NameNode(value: 'UserBenchmarkEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmarkEntry'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'score'),
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
            name: NameNode(value: 'videoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'videoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserBenchmark'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmark'), isNonNull: false)),
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
            name: NameNode(value: 'lastEntryAt'),
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
            name: NameNode(value: 'load'),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'benchmarkType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UpdateUserBenchmarkMutation extends GraphQLQuery<
    UpdateUserBenchmark$Mutation, UpdateUserBenchmarkArguments> {
  UpdateUserBenchmarkMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_USER_BENCHMARK_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateUserBenchmark';

  @override
  final UpdateUserBenchmarkArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateUserBenchmark$Mutation parse(Map<String, dynamic> json) =>
      UpdateUserBenchmark$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateUserBenchmarkArguments extends JsonSerializable
    with EquatableMixin {
  CreateUserBenchmarkArguments({required this.data});

  @override
  factory CreateUserBenchmarkArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateUserBenchmarkArgumentsFromJson(json);

  late CreateUserBenchmarkInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() => _$CreateUserBenchmarkArgumentsToJson(this);
}

final CREATE_USER_BENCHMARK_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createUserBenchmark'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateUserBenchmarkInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createUserBenchmark'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'UserBenchmark'), directives: []),
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
                  ])),
              FieldNode(
                  name: NameNode(value: 'UserBenchmarkEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserBenchmarkEntry'),
                        directives: [])
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
      name: NameNode(value: 'UserBenchmarkEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmarkEntry'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'score'),
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
            name: NameNode(value: 'videoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'videoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserBenchmark'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmark'), isNonNull: false)),
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
            name: NameNode(value: 'lastEntryAt'),
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
            name: NameNode(value: 'load'),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'benchmarkType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class CreateUserBenchmarkMutation extends GraphQLQuery<
    CreateUserBenchmark$Mutation, CreateUserBenchmarkArguments> {
  CreateUserBenchmarkMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_USER_BENCHMARK_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createUserBenchmark';

  @override
  final CreateUserBenchmarkArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateUserBenchmark$Mutation parse(Map<String, dynamic> json) =>
      CreateUserBenchmark$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteUserBenchmarkByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteUserBenchmarkByIdArguments({required this.id});

  @override
  factory DeleteUserBenchmarkByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteUserBenchmarkByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteUserBenchmarkByIdArgumentsToJson(this);
}

final DELETE_USER_BENCHMARK_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteUserBenchmarkById'),
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
            name: NameNode(value: 'deleteUserBenchmarkById'),
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

class DeleteUserBenchmarkByIdMutation extends GraphQLQuery<
    DeleteUserBenchmarkById$Mutation, DeleteUserBenchmarkByIdArguments> {
  DeleteUserBenchmarkByIdMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_USER_BENCHMARK_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteUserBenchmarkById';

  @override
  final DeleteUserBenchmarkByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteUserBenchmarkById$Mutation parse(Map<String, dynamic> json) =>
      DeleteUserBenchmarkById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserBenchmarksArguments extends JsonSerializable with EquatableMixin {
  UserBenchmarksArguments({this.first});

  @override
  factory UserBenchmarksArguments.fromJson(Map<String, dynamic> json) =>
      _$UserBenchmarksArgumentsFromJson(json);

  final int? first;

  @override
  List<Object?> get props => [first];
  @override
  Map<String, dynamic> toJson() => _$UserBenchmarksArgumentsToJson(this);
}

final USER_BENCHMARKS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userBenchmarks'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'first')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userBenchmarks'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'first'),
                  value: VariableNode(name: NameNode(value: 'first')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'UserBenchmark'), directives: []),
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
                  ])),
              FieldNode(
                  name: NameNode(value: 'UserBenchmarkEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserBenchmarkEntry'),
                        directives: [])
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
      name: NameNode(value: 'UserBenchmarkEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmarkEntry'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'score'),
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
            name: NameNode(value: 'videoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'videoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserBenchmark'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmark'), isNonNull: false)),
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
            name: NameNode(value: 'lastEntryAt'),
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
            name: NameNode(value: 'load'),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'benchmarkType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UserBenchmarksQuery
    extends GraphQLQuery<UserBenchmarks$Query, UserBenchmarksArguments> {
  UserBenchmarksQuery({required this.variables});

  @override
  final DocumentNode document = USER_BENCHMARKS_QUERY_DOCUMENT;

  @override
  final String operationName = 'userBenchmarks';

  @override
  final UserBenchmarksArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserBenchmarks$Query parse(Map<String, dynamic> json) =>
      UserBenchmarks$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserBenchmarkByIdArguments extends JsonSerializable with EquatableMixin {
  UserBenchmarkByIdArguments({required this.id});

  @override
  factory UserBenchmarkByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$UserBenchmarkByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$UserBenchmarkByIdArgumentsToJson(this);
}

final USER_BENCHMARK_BY_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userBenchmarkById'),
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
            name: NameNode(value: 'userBenchmarkById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'UserBenchmark'), directives: []),
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
                  ])),
              FieldNode(
                  name: NameNode(value: 'UserBenchmarkEntries'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserBenchmarkEntry'),
                        directives: [])
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
      name: NameNode(value: 'UserBenchmarkEntry'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmarkEntry'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'score'),
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
            name: NameNode(value: 'videoUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'videoThumbUri'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserBenchmark'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'UserBenchmark'), isNonNull: false)),
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
            name: NameNode(value: 'lastEntryAt'),
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
            name: NameNode(value: 'load'),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'distanceUnit'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'benchmarkType'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class UserBenchmarkByIdQuery
    extends GraphQLQuery<UserBenchmarkById$Query, UserBenchmarkByIdArguments> {
  UserBenchmarkByIdQuery({required this.variables});

  @override
  final DocumentNode document = USER_BENCHMARK_BY_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'userBenchmarkById';

  @override
  final UserBenchmarkByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserBenchmarkById$Query parse(Map<String, dynamic> json) =>
      UserBenchmarkById$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class TextSearchWorkoutsArguments extends JsonSerializable with EquatableMixin {
  TextSearchWorkoutsArguments({required this.text});

  @override
  factory TextSearchWorkoutsArguments.fromJson(Map<String, dynamic> json) =>
      _$TextSearchWorkoutsArgumentsFromJson(json);

  late String text;

  @override
  List<Object?> get props => [text];
  @override
  Map<String, dynamic> toJson() => _$TextSearchWorkoutsArgumentsToJson(this);
}

final TEXT_SEARCH_WORKOUTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'textSearchWorkouts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'text')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'textSearchWorkouts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'text'),
                  value: VariableNode(name: NameNode(value: 'text')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'Workout'), directives: []),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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

class TextSearchWorkoutsQuery extends GraphQLQuery<TextSearchWorkouts$Query,
    TextSearchWorkoutsArguments> {
  TextSearchWorkoutsQuery({required this.variables});

  @override
  final DocumentNode document = TEXT_SEARCH_WORKOUTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'textSearchWorkouts';

  @override
  final TextSearchWorkoutsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  TextSearchWorkouts$Query parse(Map<String, dynamic> json) =>
      TextSearchWorkouts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class TextSearchWorkoutNamesArguments extends JsonSerializable
    with EquatableMixin {
  TextSearchWorkoutNamesArguments({required this.text});

  @override
  factory TextSearchWorkoutNamesArguments.fromJson(Map<String, dynamic> json) =>
      _$TextSearchWorkoutNamesArgumentsFromJson(json);

  late String text;

  @override
  List<Object?> get props => [text];
  @override
  Map<String, dynamic> toJson() =>
      _$TextSearchWorkoutNamesArgumentsToJson(this);
}

final TEXT_SEARCH_WORKOUT_NAMES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'textSearchWorkoutNames'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'text')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'textSearchWorkoutNames'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'text'),
                  value: VariableNode(name: NameNode(value: 'text')))
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
                  name: NameNode(value: '__typename'),
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

class TextSearchWorkoutNamesQuery extends GraphQLQuery<
    TextSearchWorkoutNames$Query, TextSearchWorkoutNamesArguments> {
  TextSearchWorkoutNamesQuery({required this.variables});

  @override
  final DocumentNode document = TEXT_SEARCH_WORKOUT_NAMES_QUERY_DOCUMENT;

  @override
  final String operationName = 'textSearchWorkoutNames';

  @override
  final TextSearchWorkoutNamesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  TextSearchWorkoutNames$Query parse(Map<String, dynamic> json) =>
      TextSearchWorkoutNames$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteLoggedWorkoutMoveByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteLoggedWorkoutMoveByIdArguments({required this.id});

  @override
  factory DeleteLoggedWorkoutMoveByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteLoggedWorkoutMoveByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteLoggedWorkoutMoveByIdArgumentsToJson(this);
}

final DELETE_LOGGED_WORKOUT_MOVE_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteLoggedWorkoutMoveById'),
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
            name: NameNode(value: 'deleteLoggedWorkoutMoveById'),
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

class DeleteLoggedWorkoutMoveByIdMutation extends GraphQLQuery<
    DeleteLoggedWorkoutMoveById$Mutation,
    DeleteLoggedWorkoutMoveByIdArguments> {
  DeleteLoggedWorkoutMoveByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_LOGGED_WORKOUT_MOVE_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteLoggedWorkoutMoveById';

  @override
  final DeleteLoggedWorkoutMoveByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteLoggedWorkoutMoveById$Mutation parse(Map<String, dynamic> json) =>
      DeleteLoggedWorkoutMoveById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateLoggedWorkoutMoveArguments extends JsonSerializable
    with EquatableMixin {
  UpdateLoggedWorkoutMoveArguments({required this.data});

  @override
  factory UpdateLoggedWorkoutMoveArguments.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateLoggedWorkoutMoveArgumentsFromJson(json);

  late UpdateLoggedWorkoutMoveInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateLoggedWorkoutMoveArgumentsToJson(this);
}

final UPDATE_LOGGED_WORKOUT_MOVE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateLoggedWorkoutMove'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateLoggedWorkoutMoveInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateLoggedWorkoutMove'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkoutMove'), directives: []),
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
      name: NameNode(value: 'LoggedWorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
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

class UpdateLoggedWorkoutMoveMutation extends GraphQLQuery<
    UpdateLoggedWorkoutMove$Mutation, UpdateLoggedWorkoutMoveArguments> {
  UpdateLoggedWorkoutMoveMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_LOGGED_WORKOUT_MOVE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateLoggedWorkoutMove';

  @override
  final UpdateLoggedWorkoutMoveArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateLoggedWorkoutMove$Mutation parse(Map<String, dynamic> json) =>
      UpdateLoggedWorkoutMove$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateLoggedWorkoutMoveArguments extends JsonSerializable
    with EquatableMixin {
  CreateLoggedWorkoutMoveArguments({required this.data});

  @override
  factory CreateLoggedWorkoutMoveArguments.fromJson(
          Map<String, dynamic> json) =>
      _$CreateLoggedWorkoutMoveArgumentsFromJson(json);

  late CreateLoggedWorkoutMoveInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateLoggedWorkoutMoveArgumentsToJson(this);
}

final CREATE_LOGGED_WORKOUT_MOVE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createLoggedWorkoutMove'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateLoggedWorkoutMoveInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createLoggedWorkoutMove'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'LoggedWorkoutMove'), directives: []),
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
      name: NameNode(value: 'LoggedWorkoutMove'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkoutMove'), isNonNull: false)),
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
            name: NameNode(value: 'note'),
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

class CreateLoggedWorkoutMoveMutation extends GraphQLQuery<
    CreateLoggedWorkoutMove$Mutation, CreateLoggedWorkoutMoveArguments> {
  CreateLoggedWorkoutMoveMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_LOGGED_WORKOUT_MOVE_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createLoggedWorkoutMove';

  @override
  final CreateLoggedWorkoutMoveArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateLoggedWorkoutMove$Mutation parse(Map<String, dynamic> json) =>
      CreateLoggedWorkoutMove$Mutation.fromJson(json);
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
class UpdateScheduledWorkoutArguments extends JsonSerializable
    with EquatableMixin {
  UpdateScheduledWorkoutArguments({required this.data});

  @override
  factory UpdateScheduledWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateScheduledWorkoutArgumentsFromJson(json);

  late UpdateScheduledWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateScheduledWorkoutArgumentsToJson(this);
}

final UPDATE_SCHEDULED_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'updateScheduledWorkout'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateScheduledWorkoutInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateScheduledWorkout'),
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
                  name: NameNode(value: 'scheduledAt'),
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
                  name: NameNode(value: 'Workout'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Workout'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'User'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'UserSummary'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutGoals'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutGoal'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutTags'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutTag'),
                              directives: [])
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
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value: 'Equipment'),
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
                                                name:
                                                    NameNode(value: 'MoveType'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'MoveType'),
                                                          directives: [])
                                                    ])),
                                            FieldNode(
                                                name: NameNode(
                                                    value:
                                                        'BodyAreaMoveScores'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'score'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null),
                                                      FieldNode(
                                                          name: NameNode(
                                                              value:
                                                                  'BodyArea'),
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
                                                    value:
                                                        'RequiredEquipments'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          directives: [])
                                                    ])),
                                            FieldNode(
                                                name: NameNode(
                                                    value:
                                                        'SelectableEquipments'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          directives: [])
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'LoggedWorkout'),
                  alias: NameNode(value: 'LoggedWorkoutSummary'),
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'LoggedWorkout'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'GymProfile'),
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
                              name: NameNode(value: 'Equipment'),
                              directives: [])
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkout'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
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
            name: NameNode(value: 'name'),
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

class UpdateScheduledWorkoutMutation extends GraphQLQuery<
    UpdateScheduledWorkout$Mutation, UpdateScheduledWorkoutArguments> {
  UpdateScheduledWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_SCHEDULED_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'updateScheduledWorkout';

  @override
  final UpdateScheduledWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateScheduledWorkout$Mutation parse(Map<String, dynamic> json) =>
      UpdateScheduledWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateScheduledWorkoutArguments extends JsonSerializable
    with EquatableMixin {
  CreateScheduledWorkoutArguments({required this.data});

  @override
  factory CreateScheduledWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateScheduledWorkoutArgumentsFromJson(json);

  late CreateScheduledWorkoutInput data;

  @override
  List<Object?> get props => [data];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateScheduledWorkoutArgumentsToJson(this);
}

final CREATE_SCHEDULED_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createScheduledWorkout'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'CreateScheduledWorkoutInput'),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createScheduledWorkout'),
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
                  name: NameNode(value: 'scheduledAt'),
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
                  name: NameNode(value: 'Workout'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Workout'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'User'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'UserSummary'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutGoals'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutGoal'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutTags'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutTag'),
                              directives: [])
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
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value: 'Equipment'),
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
                                                name:
                                                    NameNode(value: 'MoveType'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'MoveType'),
                                                          directives: [])
                                                    ])),
                                            FieldNode(
                                                name: NameNode(
                                                    value:
                                                        'BodyAreaMoveScores'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'score'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null),
                                                      FieldNode(
                                                          name: NameNode(
                                                              value:
                                                                  'BodyArea'),
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
                                                    value:
                                                        'RequiredEquipments'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          directives: [])
                                                    ])),
                                            FieldNode(
                                                name: NameNode(
                                                    value:
                                                        'SelectableEquipments'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          directives: [])
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'LoggedWorkout'),
                  alias: NameNode(value: 'LoggedWorkoutSummary'),
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'LoggedWorkout'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'GymProfile'),
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
                              name: NameNode(value: 'Equipment'),
                              directives: [])
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkout'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
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
            name: NameNode(value: 'name'),
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

class CreateScheduledWorkoutMutation extends GraphQLQuery<
    CreateScheduledWorkout$Mutation, CreateScheduledWorkoutArguments> {
  CreateScheduledWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_SCHEDULED_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createScheduledWorkout';

  @override
  final CreateScheduledWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateScheduledWorkout$Mutation parse(Map<String, dynamic> json) =>
      CreateScheduledWorkout$Mutation.fromJson(json);
}

final USER_SCHEDULED_WORKOUTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'userScheduledWorkouts'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userScheduledWorkouts'),
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
                  name: NameNode(value: 'scheduledAt'),
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
                  name: NameNode(value: 'Workout'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'Workout'), directives: []),
                    FieldNode(
                        name: NameNode(value: 'User'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'UserSummary'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutGoals'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutGoal'),
                              directives: [])
                        ])),
                    FieldNode(
                        name: NameNode(value: 'WorkoutTags'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutTag'),
                              directives: [])
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
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value: 'Equipment'),
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
                                                name:
                                                    NameNode(value: 'MoveType'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'MoveType'),
                                                          directives: [])
                                                    ])),
                                            FieldNode(
                                                name: NameNode(
                                                    value:
                                                        'BodyAreaMoveScores'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'score'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet: null),
                                                      FieldNode(
                                                          name: NameNode(
                                                              value:
                                                                  'BodyArea'),
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
                                                    value:
                                                        'RequiredEquipments'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          directives: [])
                                                    ])),
                                            FieldNode(
                                                name: NameNode(
                                                    value:
                                                        'SelectableEquipments'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          directives: [])
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'LoggedWorkout'),
                  alias: NameNode(value: 'LoggedWorkoutSummary'),
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'LoggedWorkout'), directives: [])
                  ])),
              FieldNode(
                  name: NameNode(value: 'GymProfile'),
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
                              name: NameNode(value: 'Equipment'),
                              directives: [])
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'LoggedWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'LoggedWorkout'), isNonNull: false)),
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
            name: NameNode(value: 'completedOn'),
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
            name: NameNode(value: 'name'),
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

class UserScheduledWorkoutsQuery
    extends GraphQLQuery<UserScheduledWorkouts$Query, JsonSerializable> {
  UserScheduledWorkoutsQuery();

  @override
  final DocumentNode document = USER_SCHEDULED_WORKOUTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'userScheduledWorkouts';

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserScheduledWorkouts$Query parse(Map<String, dynamic> json) =>
      UserScheduledWorkouts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteScheduledWorkoutByIdArguments extends JsonSerializable
    with EquatableMixin {
  DeleteScheduledWorkoutByIdArguments({required this.id});

  @override
  factory DeleteScheduledWorkoutByIdArguments.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteScheduledWorkoutByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteScheduledWorkoutByIdArgumentsToJson(this);
}

final DELETE_SCHEDULED_WORKOUT_BY_ID_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'deleteScheduledWorkoutById'),
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
            name: NameNode(value: 'deleteScheduledWorkoutById'),
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

class DeleteScheduledWorkoutByIdMutation extends GraphQLQuery<
    DeleteScheduledWorkoutById$Mutation, DeleteScheduledWorkoutByIdArguments> {
  DeleteScheduledWorkoutByIdMutation({required this.variables});

  @override
  final DocumentNode document =
      DELETE_SCHEDULED_WORKOUT_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'deleteScheduledWorkoutById';

  @override
  final DeleteScheduledWorkoutByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteScheduledWorkoutById$Mutation parse(Map<String, dynamic> json) =>
      DeleteScheduledWorkoutById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class PublicWorkoutsArguments extends JsonSerializable with EquatableMixin {
  PublicWorkoutsArguments({this.take, this.cursor, this.filters});

  @override
  factory PublicWorkoutsArguments.fromJson(Map<String, dynamic> json) =>
      _$PublicWorkoutsArgumentsFromJson(json);

  final int? take;

  final String? cursor;

  final WorkoutFiltersInput? filters;

  @override
  List<Object?> get props => [take, cursor, filters];
  @override
  Map<String, dynamic> toJson() => _$PublicWorkoutsArgumentsToJson(this);
}

final PUBLIC_WORKOUTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'publicWorkouts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'take')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'cursor')),
            type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'filters')),
            type: NamedTypeNode(
                name: NameNode(value: 'WorkoutFiltersInput'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'publicWorkouts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'take'),
                  value: VariableNode(name: NameNode(value: 'take'))),
              ArgumentNode(
                  name: NameNode(value: 'cursor'),
                  value: VariableNode(name: NameNode(value: 'cursor'))),
              ArgumentNode(
                  name: NameNode(value: 'filters'),
                  value: VariableNode(name: NameNode(value: 'filters')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'Workout'), directives: []),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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

class PublicWorkoutsQuery
    extends GraphQLQuery<PublicWorkouts$Query, PublicWorkoutsArguments> {
  PublicWorkoutsQuery({required this.variables});

  @override
  final DocumentNode document = PUBLIC_WORKOUTS_QUERY_DOCUMENT;

  @override
  final String operationName = 'publicWorkouts';

  @override
  final PublicWorkoutsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  PublicWorkouts$Query parse(Map<String, dynamic> json) =>
      PublicWorkouts$Query.fromJson(json);
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
                  name: NameNode(value: 'Workout'), directives: []),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
              FragmentSpreadNode(
                  name: NameNode(value: 'Workout'), directives: []),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
class DuplicateWorkoutByIdArguments extends JsonSerializable
    with EquatableMixin {
  DuplicateWorkoutByIdArguments({required this.id});

  @override
  factory DuplicateWorkoutByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$DuplicateWorkoutByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DuplicateWorkoutByIdArgumentsToJson(this);
}

final DUPLICATE_WORKOUT_BY_ID_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'duplicateWorkoutById'),
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
            name: NameNode(value: 'duplicateWorkoutById'),
            alias: null,
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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

class DuplicateWorkoutByIdMutation extends GraphQLQuery<
    DuplicateWorkoutById$Mutation, DuplicateWorkoutByIdArguments> {
  DuplicateWorkoutByIdMutation({required this.variables});

  @override
  final DocumentNode document = DUPLICATE_WORKOUT_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'duplicateWorkoutById';

  @override
  final DuplicateWorkoutByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DuplicateWorkoutById$Mutation parse(Map<String, dynamic> json) =>
      DuplicateWorkoutById$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SoftDeleteWorkoutByIdArguments extends JsonSerializable
    with EquatableMixin {
  SoftDeleteWorkoutByIdArguments({required this.id});

  @override
  factory SoftDeleteWorkoutByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$SoftDeleteWorkoutByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$SoftDeleteWorkoutByIdArgumentsToJson(this);
}

final SOFT_DELETE_WORKOUT_BY_ID_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'softDeleteWorkoutById'),
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
            name: NameNode(value: 'softDeleteWorkoutById'),
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

class SoftDeleteWorkoutByIdMutation extends GraphQLQuery<
    SoftDeleteWorkoutById$Mutation, SoftDeleteWorkoutByIdArguments> {
  SoftDeleteWorkoutByIdMutation({required this.variables});

  @override
  final DocumentNode document = SOFT_DELETE_WORKOUT_BY_ID_MUTATION_DOCUMENT;

  @override
  final String operationName = 'softDeleteWorkoutById';

  @override
  final SoftDeleteWorkoutByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SoftDeleteWorkoutById$Mutation parse(Map<String, dynamic> json) =>
      SoftDeleteWorkoutById$Mutation.fromJson(json);
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
                  name: NameNode(value: 'Workout'), directives: []),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
                  name: NameNode(value: 'Workout'), directives: []),
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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

@JsonSerializable(explicitToJson: true)
class WorkoutPlanByIdArguments extends JsonSerializable with EquatableMixin {
  WorkoutPlanByIdArguments({required this.id});

  @override
  factory WorkoutPlanByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$WorkoutPlanByIdArgumentsToJson(this);
}

final WORKOUT_PLAN_BY_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'workoutPlanById'),
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
            name: NameNode(value: 'workoutPlanById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutPlan'), directives: []),
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
                  name: NameNode(value: 'WorkoutPlanDays'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutPlanDay'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'WorkoutPlanDayWorkouts'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'WorkoutPlanDayWorkout'),
                              directives: []),
                          FieldNode(
                              name: NameNode(value: 'Workout'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FragmentSpreadNode(
                                    name: NameNode(value: 'Workout'),
                                    directives: []),
                                FieldNode(
                                    name: NameNode(value: 'User'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'UserSummary'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'WorkoutGoals'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'WorkoutGoal'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'WorkoutTags'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name: NameNode(value: 'WorkoutTag'),
                                          directives: [])
                                    ])),
                                FieldNode(
                                    name: NameNode(value: 'WorkoutSections'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: SelectionSetNode(selections: [
                                      FragmentSpreadNode(
                                          name:
                                              NameNode(value: 'WorkoutSection'),
                                          directives: []),
                                      FieldNode(
                                          name: NameNode(
                                              value: 'WorkoutSectionType'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet: SelectionSetNode(
                                              selections: [
                                                FragmentSpreadNode(
                                                    name: NameNode(
                                                        value:
                                                            'WorkoutSectionType'),
                                                    directives: [])
                                              ])),
                                      FieldNode(
                                          name: NameNode(value: 'WorkoutSets'),
                                          alias: null,
                                          arguments: [],
                                          directives: [],
                                          selectionSet:
                                              SelectionSetNode(selections: [
                                            FragmentSpreadNode(
                                                name: NameNode(
                                                    value: 'WorkoutSet'),
                                                directives: []),
                                            FieldNode(
                                                name: NameNode(
                                                    value: 'WorkoutMoves'),
                                                alias: null,
                                                arguments: [],
                                                directives: [],
                                                selectionSet: SelectionSetNode(
                                                    selections: [
                                                      FragmentSpreadNode(
                                                          name: NameNode(
                                                              value:
                                                                  'WorkoutMove'),
                                                          directives: []),
                                                      FieldNode(
                                                          name: NameNode(
                                                              value:
                                                                  'Equipment'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet:
                                                              SelectionSetNode(
                                                                  selections: [
                                                                FragmentSpreadNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'Equipment'),
                                                                    directives: [])
                                                              ])),
                                                      FieldNode(
                                                          name: NameNode(
                                                              value: 'Move'),
                                                          alias: null,
                                                          arguments: [],
                                                          directives: [],
                                                          selectionSet:
                                                              SelectionSetNode(
                                                                  selections: [
                                                                FragmentSpreadNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'Move'),
                                                                    directives: []),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'MoveType'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FragmentSpreadNode(
                                                                              name: NameNode(value: 'MoveType'),
                                                                              directives: [])
                                                                        ])),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'BodyAreaMoveScores'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FieldNode(
                                                                              name: NameNode(value: 'score'),
                                                                              alias: null,
                                                                              arguments: [],
                                                                              directives: [],
                                                                              selectionSet: null),
                                                                          FieldNode(
                                                                              name: NameNode(
                                                                                  value:
                                                                                      'BodyArea'),
                                                                              alias:
                                                                                  null,
                                                                              arguments: [],
                                                                              directives: [],
                                                                              selectionSet: SelectionSetNode(selections: [
                                                                                FragmentSpreadNode(name: NameNode(value: 'BodyArea'), directives: [])
                                                                              ]))
                                                                        ])),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'RequiredEquipments'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FragmentSpreadNode(
                                                                              name: NameNode(value: 'Equipment'),
                                                                              directives: [])
                                                                        ])),
                                                                FieldNode(
                                                                    name: NameNode(
                                                                        value:
                                                                            'SelectableEquipments'),
                                                                    alias: null,
                                                                    arguments: [],
                                                                    directives: [],
                                                                    selectionSet:
                                                                        SelectionSetNode(
                                                                            selections: [
                                                                          FragmentSpreadNode(
                                                                              name: NameNode(value: 'Equipment'),
                                                                              directives: [])
                                                                        ]))
                                                              ]))
                                                    ]))
                                          ]))
                                    ]))
                              ]))
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'Enrolments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutPlanEnrolment'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'User'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'UserSummary'),
                              directives: [])
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'WorkoutPlanReviews'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'WorkoutPlanReview'),
                        directives: []),
                    FieldNode(
                        name: NameNode(value: 'User'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FragmentSpreadNode(
                              name: NameNode(value: 'UserSummary'),
                              directives: [])
                        ]))
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
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'hexColor'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthMinutes'),
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
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanDayWorkout'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanDayWorkout'),
              isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'sortPosition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanDay'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanDay'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'dayNumber'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanEnrolment'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanEnrolment'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'startDate'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'completedPlanDayWorkoutIds'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlanReview'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlanReview'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'score'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'comment'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutPlan'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'WorkoutPlan'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: '__typename'),
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
            name: NameNode(value: 'archived'),
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
            name: NameNode(value: 'lengthWeeks'),
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
            name: NameNode(value: 'contentAccessScope'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class WorkoutPlanByIdQuery
    extends GraphQLQuery<WorkoutPlanById$Query, WorkoutPlanByIdArguments> {
  WorkoutPlanByIdQuery({required this.variables});

  @override
  final DocumentNode document = WORKOUT_PLAN_BY_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'workoutPlanById';

  @override
  final WorkoutPlanByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  WorkoutPlanById$Query parse(Map<String, dynamic> json) =>
      WorkoutPlanById$Query.fromJson(json);
}
