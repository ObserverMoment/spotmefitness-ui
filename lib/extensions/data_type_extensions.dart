import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';

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
  bool get isAMRAP => this.workoutSectionType.name == kAMRAPName;

  bool get isTimed => [
        kHIITCircuitName,
        kTabataName,
        kEMOMName,
        kLastStandingName
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

  /// Retuns all the equipment needed for completing the section and also removes [bodyweight]
  List<Equipment> get uniqueEquipments {
    final Set<Equipment> equipments =
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

    return equipments.where((e) => e.id != kBodyweightEquipmentId).toList();
  }
}

extension WorkoutSectionTypeExtension on WorkoutSectionType {
  bool get canPyramid => ![kHIITCircuitName, kTabataName].contains(this.name);

  bool get isAMRAP => this.name == kAMRAPName;

  bool get isTimed => [
        kHIITCircuitName,
        kTabataName,
        kEMOMName,
        kLastStandingName
      ].contains(this.name);

  bool get roundsInputAllowed =>
      [kForTimeName, kFreeSessionName].contains(this.name);
}

extension WorkoutSetExtension on WorkoutSet {
  bool get isRestSet =>
      this.workoutMoves.length == 1 &&
      this.workoutMoves[0].move.id == kRestMoveId;
}
