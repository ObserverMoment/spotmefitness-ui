import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Single line of text describing the move.
/// Eg. 40kg Bench Press x 10 (Barbell)
class LoggedWorkoutMoveMinimalDisplay extends StatelessWidget {
  final LoggedWorkoutMove loggedWorkoutMove;
  const LoggedWorkoutMoveMinimalDisplay(
      {Key? key, required this.loggedWorkoutMove})
      : super(key: key);

  Widget _buildMoveRepDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          loggedWorkoutMove.reps.stringMyDouble(),
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          loggedWorkoutMove.repType == WorkoutMoveRepType.distance
              ? loggedWorkoutMove.distanceUnit.shortDisplay
              : describeEnum(loggedWorkoutMove.repType),
        ),
      ],
    );
  }

  Widget _buildLoadDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          loggedWorkoutMove.loadAmount!.stringMyDouble(),
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          loggedWorkoutMove.loadUnit.display,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyText(loggedWorkoutMove.move.name),
        MyText(' - '),
        _buildMoveRepDisplay(),
        if (loggedWorkoutMove.loadAmount != null &&
            loggedWorkoutMove.loadAmount != 0)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: _buildLoadDisplay(),
          ),
        if (loggedWorkoutMove.equipment != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: MyText(
              '(${loggedWorkoutMove.equipment!.name})',
              subtext: true,
            ),
          )
      ],
    );
  }
}
