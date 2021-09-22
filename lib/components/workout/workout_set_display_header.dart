import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_creator/workout_set_definition.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/data_type_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

/// Builds a header for instructions for the set based on the section type and attributes.
class WorkoutSetDisplayHeader extends StatelessWidget {
  final WorkoutSectionType workoutSectionType;
  final WorkoutSet workoutSet;
  const WorkoutSetDisplayHeader(
      {Key? key, required this.workoutSet, required this.workoutSectionType})
      : super(key: key);

  String _buildMainText() {
    switch (workoutSectionType.name) {
      case kEMOMName:
      case kHIITCircuitName:
      case kTabataName:
        return workoutSet.duration.secondsToTimeDisplay();
      case kFreeSessionName:
      case kForTimeName:
      case kAMRAPName:
        return '${workoutSet.rounds} x';
      default:
        throw Exception(
            'WorkoutSetDisplayHeader: ${workoutSectionType.name} is not a valid section type name.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final showRoundOrTimeInfo = workoutSet.rounds > 1 ||
        workoutSet.isRestSet ||
        workoutSectionType.isTimed;

    return Row(
      mainAxisAlignment: !showRoundOrTimeInfo
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      children: [
        if (showRoundOrTimeInfo)
          Padding(
            padding: const EdgeInsets.only(bottom: 2, top: 2),
            child: MyText(
              _buildMainText(),
              lineHeight: 1,
            ),
          ),
        WorkoutSetDefinition(workoutSet: workoutSet)
      ],
    );
  }
}
