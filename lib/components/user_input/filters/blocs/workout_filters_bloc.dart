import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:supercharged/supercharged.dart';
import 'package:collection/collection.dart';

class WorkoutFiltersBloc extends ChangeNotifier {
  late WorkoutFilters _workoutFilters;
  WorkoutFiltersBloc() {
    // Open Hive box and check if there are filter settings saved.
    // Initialise them from Hive box.
    final workoutFiltersFromDevice =
        Hive.box(kSettingsHiveBoxName).get(kSettingsHiveBoxWorkoutFiltersKey);

    _workoutFilters = workoutFiltersFromDevice != null
        ? WorkoutFilters.fromJson(
            Map<String, dynamic>.from(workoutFiltersFromDevice))
        : WorkoutFilters();
  }

  WorkoutFilters get filters => _workoutFilters;
  bool get activeFilters => _workoutFilters.activeFilters;
  int get numActiveFilters => _workoutFilters.numActiveFilters;

  bool filtersHaveChanged(WorkoutFilters prev) {
    return !_workoutFilters.areSameFilters(prev);
  }

  void clearAllFilters() {
    updateFilters(WorkoutFilters());
  }

  void updateWorkoutSectionTypes(List<WorkoutSectionType> types) {
    _workoutFilters.workoutSectionTypes = types;
    updateFilters(_workoutFilters);
  }

  Future<void> updateFilters(WorkoutFilters workoutFilters) async {
    await Hive.box(kSettingsHiveBoxName)
        .put(kSettingsHiveBoxWorkoutFiltersKey, workoutFilters.toJson());
    _workoutFilters = workoutFilters;
    notifyListeners();
  }

  /// Filter methods.
  List<Workout> filterYourWorkouts(List<Workout> allWorkouts) {
    return _workoutFilters.filter(allWorkouts);
  }

  Future<List<Workout>> filterPublicWorkouts(int take, int offset) async {
    /// Call the api for [take] number of results, starting from result [offset]
    return [];
  }
}

class WorkoutFilters {
  /// Require that at least one section is of one of these types.
  List<WorkoutSectionType> workoutSectionTypes = [];

  /// Require all of these goals to be in the workout.
  List<WorkoutGoal> workoutGoals = [];

  /// Must match this difficulty level.
  DifficultyLevel? difficultyLevel;

  /// Show workouts with / without class videos.
  bool? hasClassVideo;

  /// [Workout.lengthMinutes] is between these two values. If null then ignore.
  Duration? minLength;
  Duration? maxLength;

  /// Equipment filters
  /// If false, ignore.
  /// This will take precedence over [availableEquipments]
  bool bodyweightOnly = false;

  /// Exclude any workouts that need equipments not in this list.
  /// Ignore if list is empty.
  List<Equipment> availableEquipments = [];

  /// Moves filters. If empty, ignore.
  /// Workouts must have all of these moves.
  List<Move> requiredMoves = [];

  /// Workouts must not contain any of these moves.
  List<Move> excludedMoves = [];

  /// BodyArea filters.
  /// Workout must target all of these body areas.
  List<BodyArea> targetedBodyAreas = [];

  WorkoutFilters();

  /// Think this is worth doing to avoid recalling the API whenever possible...
  bool areSameFilters(WorkoutFilters o) {
    final e = UnorderedIterableEquality();
    return e.equals(workoutSectionTypes, o.workoutSectionTypes) &&
        e.equals(workoutGoals, o.workoutGoals) &&
        difficultyLevel == o.difficultyLevel &&
        hasClassVideo == o.hasClassVideo &&
        minLength?.inMinutes == o.minLength?.inMinutes &&
        maxLength?.inMinutes == o.maxLength?.inMinutes &&
        bodyweightOnly == o.bodyweightOnly &&
        e.equals(availableEquipments, o.availableEquipments) &&
        e.equals(requiredMoves, o.requiredMoves) &&
        e.equals(excludedMoves, o.excludedMoves) &&
        e.equals(targetedBodyAreas, o.targetedBodyAreas);
  }

  bool get activeFilters =>
      workoutSectionTypes.isNotEmpty ||
      workoutGoals.isNotEmpty ||
      difficultyLevel != null ||
      hasClassVideo != null ||
      minLength != null ||
      maxLength != null ||
      bodyweightOnly ||
      availableEquipments.isNotEmpty ||
      requiredMoves.isNotEmpty ||
      excludedMoves.isNotEmpty ||
      targetedBodyAreas.isNotEmpty;

  int get numActiveFilters {
    int active = 0;
    if (workoutSectionTypes.isNotEmpty) active++;
    if (workoutGoals.isNotEmpty) active++;
    if (difficultyLevel != null) active++;
    if (hasClassVideo != null) active++;
    if (minLength != null) active++;
    if (maxLength != null) active++;
    if (bodyweightOnly) active++;
    if (availableEquipments.isNotEmpty) active++;
    if (requiredMoves.isNotEmpty) active++;
    if (excludedMoves.isNotEmpty) active++;
    if (targetedBodyAreas.isNotEmpty) active++;

    return active;
  }

  // Based on the user selected available equipments. Is this exercise valid?
  bool _checkWorkoutMoveEquipment(WorkoutMove workoutMove) {
    final bool selectedEquipmentIsOk = (workoutMove.equipment == null ||
        workoutMove.equipment!.id == kBodyweightEquipmentId ||
        availableEquipments.contains(workoutMove.equipment));

    final bool requiredEquipmentsAreOk =
        (workoutMove.move.requiredEquipments.isEmpty ||
            workoutMove.move.requiredEquipments
                .every((Equipment e) => availableEquipments.contains(e)));

    return selectedEquipmentIsOk && requiredEquipmentsAreOk;
  }

  bool _workoutMoveNeedsEquipment(WorkoutMove workoutMove) {
    return workoutMove.move.requiredEquipments.length > 0 ||
        (workoutMove.equipment != null &&
            workoutMove.equipment!.id != kBodyweightEquipmentId);
  }

  List<Workout> filter(List<Workout> workouts) {
    Iterable<Workout> byWorkoutSectionTypes = workoutSectionTypes.isEmpty
        ? [...workouts]
        : workouts.where((w) => w.workoutSections.any((WorkoutSection ws) =>
            workoutSectionTypes.contains(ws.workoutSectionType)));

    Iterable<Workout> byWorkoutGoals = workoutGoals.isEmpty
        ? byWorkoutSectionTypes
        : byWorkoutSectionTypes.where(
            (w) => workoutGoals.every((g) => w.workoutGoals.contains(g)));

    Iterable<Workout> byDifficultyLevel = difficultyLevel == null
        ? byWorkoutGoals
        : byWorkoutGoals.where((w) => w.difficultyLevel == difficultyLevel);

    Iterable<Workout> byHasClassVideo = hasClassVideo == null
        ? byDifficultyLevel
        : byDifficultyLevel.where((w) => w.workoutSections
            .any((WorkoutSection ws) => ws.classVideoUri != null));

    Iterable<Workout> byMinLength = minLength == null
        ? byHasClassVideo
        : byHasClassVideo.where((w) =>
            w.lengthMinutes != null &&
            (w.lengthMinutes!.minutes >= minLength!));

    Iterable<Workout> byMaxLength = maxLength == null
        ? byMinLength
        : byMinLength.where((w) =>
            w.lengthMinutes != null &&
            (w.lengthMinutes!.minutes <= minLength!));

    Iterable<Workout> byBodyweightOnly = !bodyweightOnly
        ? byMaxLength
        : byMaxLength.where((w) => w.workoutSections.every(
            (WorkoutSection ws) => ws.workoutSets.every((WorkoutSet ws) => ws
                .workoutMoves
                .every((WorkoutMove wm) => !_workoutMoveNeedsEquipment(wm)))));

    /// if [bodyweightOnly] = true then available equipments is skipped / ignored.
    Iterable<Workout> byAvailableEquipments = (bodyweightOnly ||
            availableEquipments.isEmpty)
        ? byBodyweightOnly
        : byBodyweightOnly.where((w) => w.workoutSections.every(
            (WorkoutSection ws) => ws.workoutSets.every((WorkoutSet ws) => ws
                .workoutMoves
                .every((WorkoutMove wm) => _checkWorkoutMoveEquipment(wm)))));

    Iterable<Workout> byRequiredMoves = requiredMoves.isEmpty
        ? byAvailableEquipments
        : byAvailableEquipments.where((w) => w.workoutSections.any(
            (WorkoutSection ws) => ws.workoutSets.any((WorkoutSet ws) => ws
                .workoutMoves
                .any((WorkoutMove wm) => requiredMoves.contains(wm.move)))));

    Iterable<Workout> byExcludedMoves = excludedMoves.isEmpty
        ? byRequiredMoves
        : byRequiredMoves.where((w) => w.workoutSections.every(
            (WorkoutSection ws) => ws.workoutSets.every((WorkoutSet ws) => ws
                .workoutMoves
                .every((WorkoutMove wm) => !excludedMoves.contains(wm.move)))));

    Iterable<Workout> byTargetedBodyAreas = targetedBodyAreas.isEmpty
        ? byExcludedMoves
        : byExcludedMoves.where((w) => w.workoutSections.any(
            (WorkoutSection ws) => ws.workoutSets.any((WorkoutSet ws) => ws
                .workoutMoves
                .any((WorkoutMove wm) => wm.move.bodyAreaMoveScores.any(
                    (bams) => targetedBodyAreas.contains(bams.bodyArea))))));

    return byTargetedBodyAreas.toList();
  }

  WorkoutFilters.fromJson(Map<String, dynamic> json)
      : workoutSectionTypes = json['workoutSectionTypes'] != null
            ? (json['workoutSectionTypes'] as List)
                .map((e) =>
                    WorkoutSectionType.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <WorkoutSectionType>[],
        workoutGoals = json['workoutGoals'] != null
            ? (json['workoutGoals'] as List)
                .map((e) => WorkoutGoal.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <WorkoutGoal>[],
        difficultyLevel = json['difficultyLevel'] != null
            ? (json['difficultyLevel'] as String).toDifficultyLevel()
            : null,
        hasClassVideo = json['hasClassVideo'] != null
            ? (json['hasClassVideo'] as bool?)
            : null,
        minLength = json['minLength'] != null
            ? Duration(minutes: (json['minLength'] as int))
            : null,
        maxLength = json['maxLength'] != null
            ? Duration(minutes: (json['maxLength'] as int))
            : null,
        bodyweightOnly = (json['bodyweightOnly'] as bool?) ?? false,
        availableEquipments = json['availableEquipments'] != null
            ? (json['availableEquipments'] as List)
                .map((e) => Equipment.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <Equipment>[],
        requiredMoves = json['requiredMoves'] != null
            ? (json['requiredMoves'] as List)
                .map((e) => Move.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <Move>[],
        excludedMoves = json['excludedMoves'] != null
            ? (json['excludedMoves'] as List)
                .map((e) => Move.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <Move>[],
        targetedBodyAreas = json['targetedBodyAreas'] != null
            ? (json['targetedBodyAreas'] as List)
                .map((e) => BodyArea.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : <BodyArea>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'workoutSectionTypes':
            this.workoutSectionTypes.map((o) => o.toJson()).toList(),
        'workoutGoals': this.workoutGoals.map((o) => o.toJson()).toList(),
        'difficultyLevel': this.difficultyLevel?.apiValue,
        'hasClassVideo': this.hasClassVideo,
        'minLength': this.minLength?.inMinutes,
        'maxLength': this.maxLength?.inMinutes,
        'bodyweightOnly': this.bodyweightOnly,
        'availableEquipments':
            this.availableEquipments.map((o) => o.toJson()).toList(),
        'requiredMoves': this.requiredMoves.map((o) => o.toJson()).toList(),
        'excludedMoves': this.excludedMoves.map((o) => o.toJson()).toList(),
        'targetedBodyAreas':
            this.targetedBodyAreas.map((o) => o.toJson()).toList(),
      };
}
