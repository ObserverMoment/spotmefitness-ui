import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

/// [set], [superset], [giantset] etc.
class WorkoutSetDefinition extends StatelessWidget {
  final WorkoutSet workoutSet;
  WorkoutSetDefinition(this.workoutSet);
  @override
  Widget build(BuildContext context) {
    final int length = workoutSet.workoutMoves.length;
    final color = Styles.colorTwo;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: length > 3
          ? MyText(
              'GIANTSET',
              color: color,
              size: FONTSIZE.TINY,
              weight: FontWeight.bold,
            )
          : length == 3
              ? MyText(
                  'TRISET',
                  color: color,
                  size: FONTSIZE.TINY,
                  weight: FontWeight.bold,
                )
              : length == 2
                  ? MyText(
                      'SUPERSET',
                      color: color,
                      size: FONTSIZE.TINY,
                      weight: FontWeight.bold,
                    )
                  : Container(),
    );
  }
}
