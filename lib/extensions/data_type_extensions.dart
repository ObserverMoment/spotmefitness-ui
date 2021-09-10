import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/model/client_only_model.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// Extensions which pertain to the processing of fitness related data (i.e. the graphql types.)
extension ClubExtension on Club {
  int get totalMembers => 1 + this.admins.length + this.members.length;
}

extension WorkoutExtension on Workout {
  /// Returns a copy of the workout with all child lists, ([workoutSections], [workoutSets], [workoutMoves]) sorted by [sortPosition].
  Workout get copyAndSortAllChildren {
    final copy = Workout.fromJson(this.toJson());

    copy.workoutSections
        .sortBy<num>((workoutSection) => workoutSection.sortPosition);

    for (final workoutSection in copy.workoutSections) {
      workoutSection.workoutSets
          .sortBy<num>((workoutSets) => workoutSets.sortPosition);

      for (final workoutSet in workoutSection.workoutSets) {
        workoutSet.workoutMoves
            .sortBy<num>((workoutMove) => workoutMove.sortPosition);
      }
    }

    return copy;
  }
}

extension WorkoutSectionExtension on WorkoutSection {
  /// If there is a name, display the name, otherwise just display the type.
  String get nameOrTypeForDisplay =>
      Utils.textNotNull(this.name) ? this.name! : this.workoutSectionType.name;

  bool get isAMRAP => this.workoutSectionType.name == kAMRAPName;

  bool get isTimed => [
        kHIITCircuitName,
        kTabataName,
        kEMOMName,
      ].contains(this.workoutSectionType.name);

  Duration get timedSectionDuration =>
      DataUtils.calculateTimedSectionDuration(this);

  /// For AMRAP - returns the timecap.
  /// For Timed / Fixed length workouts calculate length based on contents.
  int? get timecapIfValid => isAMRAP
      ? this.timecap
      : isTimed
          ? DataUtils.calculateTimedSectionDuration(this).inSeconds
          : null;

  /// These section types ignore rounds input - generally it should be forced to be [1] when these sections are being used.
  bool get roundsInputAllowed =>
      ![kAMRAPName, kFreeSessionName].contains(this.workoutSectionType.name);

  /// Retuns all the equipment needed for completing the section and also removes [bodyweight] if present.
  List<Equipment> get uniqueEquipments {
    final Set<Equipment> sectionEquipments =
        this.workoutSets.fold({}, (acum1, workoutSet) {
      final Set<Equipment> setEquipments =
          workoutSet.workoutMoves.fold({}, (acum2, workoutMove) {
        if (workoutMove.equipment != null) {
          acum2.add(workoutMove.equipment!);
        }
        if (workoutMove.move.requiredEquipments.isNotEmpty) {
          acum2.addAll(workoutMove.move.requiredEquipments);
        }
        return acum2;
      });

      acum1.addAll(setEquipments);

      return acum1;
    });

    return sectionEquipments
        .where((e) => e.id != kBodyweightEquipmentId)
        .toList();
  }

  /// Retuns all the equipment needed for completing the section along with the load needed for each. Also removes [bodyweight] if present.
  List<EquipmentWithLoad> get equipmentsWithLoad {
    final Set<EquipmentWithLoad> sectionEquipmentsWithLoad =
        this.workoutSets.fold({}, (acum1, workoutSet) {
      final Set<EquipmentWithLoad> setEquipments =
          workoutSet.workoutMoves.fold({}, (acum2, workoutMove) {
        if (workoutMove.equipment != null) {
          acum2.add(EquipmentWithLoad(
              equipment: workoutMove.equipment!,
              loadAmount: workoutMove.equipment!.loadAdjustable
                  ? workoutMove.loadAmount
                  : null,
              loadUnit: workoutMove.loadUnit));
        }
        if (workoutMove.move.requiredEquipments.isNotEmpty) {
          acum2.addAll(workoutMove.move.requiredEquipments.map((e) =>
              EquipmentWithLoad(
                  equipment: e,
                  loadAmount: e.loadAdjustable ? workoutMove.loadAmount : null,
                  loadUnit: workoutMove.loadUnit)));
        }
        return acum2;
      });

      acum1.addAll(setEquipments);

      return acum1;
    });

    return sectionEquipmentsWithLoad
        .where((e) => e.equipment.id != kBodyweightEquipmentId)
        .toList();
  }
}

extension WorkoutSectionTypeExtension on WorkoutSectionType {
  bool get canPyramid => ![kHIITCircuitName, kTabataName].contains(this.name);

  bool get isAMRAP => this.name == kAMRAPName;

  bool get isTimed => [
        kHIITCircuitName,
        kTabataName,
        kEMOMName,
      ].contains(this.name);

  bool get roundsInputAllowed =>
      [kForTimeName, kFreeSessionName].contains(this.name);
}

extension WorkoutSetExtension on WorkoutSet {
  bool get isRestSet =>
      this.workoutMoves.length == 1 &&
      this.workoutMoves[0].move.id == kRestMoveId;
}
