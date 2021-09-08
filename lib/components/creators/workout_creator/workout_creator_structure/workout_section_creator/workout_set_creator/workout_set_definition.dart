import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

/// [set], [superset], [giantset] etc.
class WorkoutSetDefinition extends StatelessWidget {
  final WorkoutSet workoutSet;
  WorkoutSetDefinition(this.workoutSet);
  @override
  Widget build(BuildContext context) {
    final int length = workoutSet.workoutMoves.length;
    final color = Styles.colorTwo;

    return length == 1
        ? workoutSet.isRestSet
            ? MyText(
                'REST',
              )
            : Container()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
