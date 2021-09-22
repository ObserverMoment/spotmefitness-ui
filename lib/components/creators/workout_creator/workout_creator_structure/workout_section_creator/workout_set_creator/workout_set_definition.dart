import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/data_type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

/// [set], [superset], [giantset] etc.
class WorkoutSetDefinition extends StatelessWidget {
  final WorkoutSet workoutSet;
  const WorkoutSetDefinition({Key? key, required this.workoutSet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int length = workoutSet.workoutMoves.length;
    const color = Styles.colorTwo;

    return length == 1
        ? workoutSet.isRestSet
            ? const MyText(
                'REST',
              )
            : Container()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: length > 3
                ? const MyText(
                    'GIANTSET',
                    color: color,
                    size: FONTSIZE.one,
                    weight: FontWeight.bold,
                  )
                : length == 3
                    ? const MyText(
                        'TRISET',
                        color: color,
                        size: FONTSIZE.one,
                        weight: FontWeight.bold,
                      )
                    : length == 2
                        ? const MyText(
                            'SUPERSET',
                            color: color,
                            size: FONTSIZE.one,
                            weight: FontWeight.bold,
                          )
                        : Container(),
          );
  }
}
