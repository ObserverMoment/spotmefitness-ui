import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_creator/workout_set_definition.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Builds a header for instructions for the set based on the section type and attributes.
class WorkoutSetDisplayHeader extends StatelessWidget {
  final WorkoutSectionType workoutSectionType;
  final WorkoutSet workoutSet;
  WorkoutSetDisplayHeader(
      {required this.workoutSet, required this.workoutSectionType});

  String _buildMainText() {
    switch (workoutSectionType.name) {
      case kEMOMName:
      case kLastStandingName:
        return workoutSet.rounds == 1
            ? 'Within ${workoutSet.duration.secondsToTimeDisplay()}'
            : 'Repeat ${workoutSet.rounds} ${workoutSet.rounds == 1 ? "time" : "times"} within ${workoutSet.duration.secondsToTimeDisplay()}';
      case kHIITCircuitName:
      case kTabataName:
        return 'For ${workoutSet.duration.secondsToTimeDisplay()}';
      case kFreeSessionName:
      case kForTimeName:
      case kAMRAPName:
        return 'Repeat ${workoutSet.rounds} ${workoutSet.rounds == 1 ? "time" : "times"}';
      default:
        throw Exception(
            'WorkoutSetDisplayHeader: ${workoutSectionType.name} is not a valid section type name.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final showRounds = (workoutSet.rounds > 1 ||
        [kEMOMName, kLastStandingName, kHIITCircuitName, kTabataName]
            .contains(workoutSectionType.name));

    return Row(
      mainAxisAlignment:
          !showRounds ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
      children: [
        if (showRounds) MyText(_buildMainText()),
        if (workoutSet.workoutMoves.length > 1) WorkoutSetDefinition(workoutSet)
      ],
    );
  }
}
