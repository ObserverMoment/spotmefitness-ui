import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.graphql.dart';
import 'package:sofie_ui/services/utils.dart';

class WorkoutMoveDisplay extends StatelessWidget {
  final WorkoutMove workoutMove;
  final bool showReps;
  final bool isLast;
  const WorkoutMoveDisplay(this.workoutMove,
      {Key? key, this.isLast = false, this.showReps = true})
      : super(key: key);

  Widget _buildRepDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          workoutMove.reps.stringMyDouble(),
          lineHeight: 1,
          size: FONTSIZE.four,
        ),
        MyText(
          workoutMove.repType == WorkoutMoveRepType.time
              ? workoutMove.timeUnit.shortDisplay
              : workoutMove.repType == WorkoutMoveRepType.distance
                  ? workoutMove.distanceUnit.shortDisplay
                  : describeEnum(workoutMove.repType),
          size: FONTSIZE.one,
        ),
      ],
    );
  }

  Widget _buildLoadDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          workoutMove.loadAmount.stringMyDouble(),
          lineHeight: 1.2,
          size: FONTSIZE.four,
        ),
        MyText(
          workoutMove.loadUnit.display,
          size: FONTSIZE.one,
        ),
      ],
    );
  }

  Widget _buildEquipmentNames() {
    final List<String> equipmentNames = [
      if (Utils.textNotNull(workoutMove.equipment?.name))
        workoutMove.equipment!.name,
      ...workoutMove.move.requiredEquipments.map((e) => e.name).toList()
    ];

    return MyText(
      equipmentNames.join(', '),
      size: FONTSIZE.two,
      color: Styles.colorTwo,
      lineHeight: 1.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                      color: context.theme.primary.withOpacity(0.06)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(workoutMove.move.name),
                if (workoutMove.equipment != null ||
                    workoutMove.move.requiredEquipments.isNotEmpty)
                  _buildEquipmentNames(),
              ],
            ),
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
