import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Single line of text describing the move.
/// Eg. 40kg Bench Press x 10 (Barbell)
class LoggedWorkoutMoveMinimalDisplay extends StatelessWidget {
  final LoggedWorkoutMove loggedWorkoutMove;
  final bool showReps;
  const LoggedWorkoutMoveMinimalDisplay(
      {Key? key, required this.loggedWorkoutMove, this.showReps = true})
      : super(key: key);

  final lineHeight = 1.3;

  Widget _buildMoveRepDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          ' - ${loggedWorkoutMove.reps.stringMyDouble()}',
          lineHeight: lineHeight,
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          loggedWorkoutMove.repType == WorkoutMoveRepType.distance
              ? loggedWorkoutMove.distanceUnit.shortDisplay
              : loggedWorkoutMove.repType == WorkoutMoveRepType.time
                  ? loggedWorkoutMove.timeUnit.shortDisplay
                  : describeEnum(loggedWorkoutMove.repType),
          lineHeight: lineHeight,
        ),
      ],
    );
  }

  Widget _buildLoadDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          ' - ${loggedWorkoutMove.loadAmount!.stringMyDouble()}',
          lineHeight: lineHeight,
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          loggedWorkoutMove.loadUnit.display,
          lineHeight: lineHeight,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyText(
              loggedWorkoutMove.move.name,
              lineHeight: lineHeight,
            ),
            if (showReps) _buildMoveRepDisplay(),
            if (loggedWorkoutMove.loadAmount != null &&
                loggedWorkoutMove.loadAmount != 0)
              _buildLoadDisplay(),
          ],
        ),
        if (loggedWorkoutMove.equipment != null)
          MyText(
            '${loggedWorkoutMove.equipment!.name}',
            size: FONTSIZE.SMALL,
            color: Styles.colorTwo,
            lineHeight: lineHeight,
          )
      ],
    );
  }
}
