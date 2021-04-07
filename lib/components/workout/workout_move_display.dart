import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/move_details.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutMoveDisplay extends StatelessWidget {
  final WorkoutMove workoutMove;
  final bool isLast;
  final bool openInfoPageOnTap;
  WorkoutMoveDisplay(this.workoutMove,
      {this.isLast = false, this.openInfoPageOnTap = false});

  Widget _buildRepDisplay() {
    switch (workoutMove.repType) {
      case WorkoutMoveRepType.reps:
        return Column(
          children: [
            MyText(
              '${workoutMove.reps.toInt().toString()}',
              lineHeight: 1.2,
              weight: FontWeight.bold,
            ),
            MyText(
              'reps',
              size: FONTSIZE.TINY,
              weight: FontWeight.bold,
            ),
          ],
        );
      case WorkoutMoveRepType.calories:
        return Column(
          children: [
            MyText(
              '${workoutMove.reps.toInt().toString()}',
              lineHeight: 1.2,
            ),
            MyText(
              'calories',
              size: FONTSIZE.TINY,
              weight: FontWeight.bold,
            ),
          ],
        );
      case WorkoutMoveRepType.distance:
        return Column(
          children: [
            MyText(
              '${workoutMove.reps.roundMyDouble(2).toString()}',
              lineHeight: 1.2,
              weight: FontWeight.bold,
            ),
            MyText(
              workoutMove.distanceUnit.display,
              size: FONTSIZE.TINY,
            ),
          ],
        );
      case WorkoutMoveRepType.time:
        return Duration(seconds: workoutMove.reps.toInt())
            .display(direction: Axis.vertical);
      default:
        throw Exception('${workoutMove.repType} is not a valid rep type.');
    }
  }

  Widget _buildLoadDisplay() {
    return Column(
      children: [
        MyText(
          '${workoutMove.loadAmount!.roundMyDouble(2).toString()}',
          lineHeight: 1.2,
          weight: FontWeight.bold,
        ),
        MyText(
          workoutMove.loadUnit.display,
          size: FONTSIZE.TINY,
          weight: FontWeight.bold,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _equipmentNames = [
      if (Utils.textNotNull(workoutMove.equipment?.name))
        workoutMove.equipment!.name,
      ...workoutMove.move.requiredEquipments.map((e) => e.name).toList()
    ];
    return GestureDetector(
      onTap: () => context.push(
          fullscreenDialog: true, child: MoveDetails(workoutMove.move)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        decoration: BoxDecoration(
            border: isLast
                ? null
                : Border(
                    bottom: BorderSide(
                        color: context.theme.primary.withOpacity(0.06)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(workoutMove.move.name),
                Row(
                    children: _equipmentNames
                        .asMap()
                        .map((index, name) => MapEntry(
                            index,
                            MyText(
                              index == _equipmentNames.length - 1
                                  ? name
                                  : '$name, ',
                              size: FONTSIZE.SMALL,
                              color: Styles.colorTwo,
                            )))
                        .values
                        .toList())
              ],
            ),
            Row(
              children: [
                if (Utils.hasLoad(workoutMove.loadAmount)) _buildLoadDisplay(),
                if (Utils.hasLoad(workoutMove.loadAmount))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MyText([
                      WorkoutMoveRepType.distance,
                      WorkoutMoveRepType.time
                    ].contains(workoutMove.repType)
                        ? 'for'
                        : 'x'),
                  ),
                _buildRepDisplay(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
