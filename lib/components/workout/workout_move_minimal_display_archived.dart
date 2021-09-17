import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Just text describing the move. Laid out in a column
/// Eg.
/// Bench Press
/// 10 reps
/// 40kg
/// Barbell
class WorkoutMoveMinimalDisplay extends StatelessWidget {
  final WorkoutMove workoutMove;
  final FONTSIZE fontSize;
  final bool showReps;
  const WorkoutMoveMinimalDisplay(
      {Key? key,
      required this.workoutMove,
      this.fontSize = FONTSIZE.MAIN,
      this.showReps = true})
      : super(key: key);

  Widget _buildMoveRepDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          workoutMove.reps.stringMyDouble(),
          size: fontSize,
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          workoutMove.repType == WorkoutMoveRepType.distance
              ? workoutMove.distanceUnit.shortDisplay
              : describeEnum(workoutMove.repType),
          size: fontSize,
        ),
      ],
    );
  }

  Widget _buildLoadDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          workoutMove.loadAmount.stringMyDouble(),
          size: fontSize,
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          workoutMove.loadUnit.display,
          size: fontSize,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(workoutMove.move.name, size: fontSize),
            if (showReps) MyText(' - '),
            if (showReps) _buildMoveRepDisplay(),
          ],
        ),
        if (workoutMove.loadAmount != 0 || workoutMove.equipment != null)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (workoutMove.loadAmount != 0) _buildLoadDisplay(),
                if (workoutMove.equipment != null)
                  Padding(
                    padding: EdgeInsets.only(
                        left: workoutMove.loadAmount != 0 ? 8.0 : 0.0),
                    child: MyText(workoutMove.equipment!.name,
                        size: fontSize, color: Styles.colorTwo),
                  )
              ],
            ),
          ),
      ],
    );
  }
}
