import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class LoggedWorkoutMoveDisplay extends StatelessWidget {
  final LoggedWorkoutMove loggedWorkoutMove;
  final bool isLast;
  LoggedWorkoutMoveDisplay(this.loggedWorkoutMove, {this.isLast = false});

  Widget _buildRepDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          loggedWorkoutMove.reps.stringMyDouble(),
          lineHeight: 1.2,
          weight: FontWeight.bold,
        ),
        MyText(
          loggedWorkoutMove.repType == WorkoutMoveRepType.distance
              ? loggedWorkoutMove.distanceUnit.shortDisplay
              : describeEnum(loggedWorkoutMove.repType),
          size: FONTSIZE.TINY,
          weight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildLoadDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          loggedWorkoutMove.loadAmount!.stringMyDouble(),
          lineHeight: 1.2,
          weight: FontWeight.bold,
        ),
        MyText(
          loggedWorkoutMove.loadUnit.display,
          size: FONTSIZE.TINY,
          weight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildEquipmentNames() {
    final List<String> equipmentNames = [
      if (Utils.textNotNull(loggedWorkoutMove.equipment?.name))
        loggedWorkoutMove.equipment!.name,
      ...loggedWorkoutMove.move.requiredEquipments.map((e) => e.name).toList()
    ];

    return MyText(
      equipmentNames.join(', '),
      size: FONTSIZE.SMALL,
      color: Styles.colorTwo,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(loggedWorkoutMove.move.name),
                if (loggedWorkoutMove.equipment != null ||
                    loggedWorkoutMove.move.requiredEquipments.isNotEmpty)
                  _buildEquipmentNames(),
              ],
            ),
          ),
          Row(
            children: [
              if (Utils.hasLoad(loggedWorkoutMove.loadAmount))
                _buildLoadDisplay(),
              if (Utils.hasLoad(loggedWorkoutMove.loadAmount))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyText([
                    WorkoutMoveRepType.distance,
                    WorkoutMoveRepType.time
                  ].contains(loggedWorkoutMove.repType)
                      ? 'for'
                      : 'x'),
                ),

              /// Timed moves show no rep info as this is handled by [timeTakenMs] field in the loggedWorkoutMove.
              if (loggedWorkoutMove.repType != WorkoutMoveRepType.time)
                _buildRepDisplay()
              else
                MyText(
                  '${loggedWorkoutMove.reps.toInt().secondsToTimeDisplay()}',
                  weight: FontWeight.bold,
                )
            ],
          )
        ],
      ),
    );
  }
}
