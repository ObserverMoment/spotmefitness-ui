import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_set_definition.dart';
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
    if ([kEMOMName, kLastStandingName, kHIITCircuitName]
            .contains(workoutSectionType.name) &&
        workoutSet.duration == null) {
      throw Exception(
          'WorkoutSetDisplayHeader: workoutSet.duration cannot be null for workout type ${workoutSectionType.name}.');
    }

    switch (workoutSectionType.name) {
      case kEMOMName:
      case kLastStandingName:
        return workoutSet.rounds == 1
            ? 'Within ${workoutSet.duration!.secondsToTimeDisplay()}'
            : 'Repeat ${workoutSet.rounds} ${workoutSet.rounds == 1 ? "time" : "times"} within ${workoutSet.duration!.secondsToTimeDisplay()}';
      case kHIITCircuitName:
        return 'Repeat for ${workoutSet.duration!.secondsToTimeDisplay()}';
      case kFreeSessionName:
      case kForTimeName:
      case kAMRAPName:
      case kTabataName:
        return 'Repeat ${workoutSet.rounds} ${workoutSet.rounds == 1 ? "time" : "times"}';
      default:
        throw Exception(
            'WorkoutSetDisplayHeader: ${workoutSectionType.name} is not a valid section type name.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final showRounds = (workoutSet.rounds > 1 ||
        [kEMOMName, kLastStandingName, kHIITCircuitName]
            .contains(workoutSectionType.name));

    final showSetDef = (![kTabataName].contains(workoutSectionType.name));

    return Row(
      mainAxisAlignment: showSetDef && !showRounds
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      children: [
        if (showRounds) MyText(_buildMainText()),
        if (showSetDef) WorkoutSetDefinition(workoutSet)
      ],
    );
  }
}
