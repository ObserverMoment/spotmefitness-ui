import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  const WorkoutMoveMinimalDisplay({Key? key, required this.workoutMove})
      : super(key: key);

  Widget _buildMoveRepDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          workoutMove.reps.stringMyDouble(),
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          workoutMove.repType == WorkoutMoveRepType.distance
              ? workoutMove.distanceUnit.shortDisplay
              : describeEnum(workoutMove.repType),
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
        ),
        SizedBox(
          width: 4,
        ),
        MyText(
          workoutMove.loadUnit.display,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(workoutMove.move.name),
            MyText(' - '),
            _buildMoveRepDisplay(),
          ],
        ),
        if (workoutMove.loadAmount != 0 || workoutMove.equipment != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (workoutMove.loadAmount != 0) _buildLoadDisplay(),
              if (workoutMove.equipment != null)
                Padding(
                  padding: EdgeInsets.only(
                      left: workoutMove.loadAmount != 0 ? 6.0 : 0.0),
                  child: MyText(
                    workoutMove.equipment!.name,
                    subtext: true,
                  ),
                )
            ],
          ),
      ],
    );
  }
}
