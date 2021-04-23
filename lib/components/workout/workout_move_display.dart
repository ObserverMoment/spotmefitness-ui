import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutMoveDisplay extends StatelessWidget {
  final WorkoutMove workoutMove;
  final bool showReps;
  final bool isLast;
  WorkoutMoveDisplay(this.workoutMove,
      {this.isLast = false, this.showReps = true});

  Widget _buildRepDisplay() {
    return Column(
      children: [
        MyText(
          workoutMove.reps.stringMyDouble(),
          lineHeight: 1.2,
          weight: FontWeight.bold,
        ),
        MyText(
          workoutMove.repType == WorkoutMoveRepType.time
              ? workoutMove.timeUnit.shortDisplay
              : workoutMove.repType == WorkoutMoveRepType.distance
                  ? workoutMove.distanceUnit.shortDisplay
                  : describeEnum(workoutMove.repType),
          size: FONTSIZE.TINY,
          weight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildLoadDisplay() {
    return Column(
      children: [
        MyText(
          workoutMove.loadAmount.stringMyDouble(),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
              if (Utils.hasLoad(workoutMove.loadAmount) && showReps)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyText([
                    WorkoutMoveRepType.distance,
                    WorkoutMoveRepType.time
                  ].contains(workoutMove.repType)
                      ? 'for'
                      : 'x'),
                ),
              if (showReps) _buildRepDisplay(),
            ],
          )
        ],
      ),
    );
  }
}
