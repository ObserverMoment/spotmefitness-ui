import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Builds a sentence explaining if the section as a whole should be repeated, how many times, and for how long.
/// Based on [WorkoutSectionType], [Rounds], [Timecap]
/// E.g AMRAP: Repeat this as many times as you can for [timecap].
class WorkoutSectionInstructions extends StatelessWidget {
  final String typeName;
  final int rounds;
  final int? timecap;
  WorkoutSectionInstructions(
      {required this.typeName, required this.rounds, this.timecap})
      : assert(
            (typeName == kAMRAPName && timecap != null) ||
                typeName != kAMRAPName,
            'AMRAP requires a timecap, so it cannot be null.');

  String _getRoundsText() => '$rounds time${rounds == 1 ? "" : "s"}';

  String _buildInstructionText() {
    switch (typeName) {
      case kFreeSessionName:
      case kEMOMName:
      case kHIITCircuitName:
      case kTabataName:
        return 'Complete all sets ${_getRoundsText()}.';
      case kForTimeName:
        return 'Complete all sets ${_getRoundsText()}, as fast as possible.';
      case kAMRAPName:
        return 'Complete as many reps as possible in ${timecap!.secondsToTimeDisplay()}.';
      case kLastStandingName:
        return timecap != null
            ? 'Complete sets within the timecaps for ${timecap!.secondsToTimeDisplay()}...if you can!'
            : 'Complete sets within the timecaps for as long as you can!';
      default:
        throw Exception(
            'WorkoutSectionInstructions: $typeName is not a valid typename.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: MyText(
            _buildInstructionText(),
            maxLines: 3,
            textAlign: TextAlign.center,
            lineHeight: 1.4,
          ),
        )
      ],
    );
  }
}
