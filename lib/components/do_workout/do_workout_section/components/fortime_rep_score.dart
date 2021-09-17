import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/fortime_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';

/// Will error if section at [sectionIndex] is not of the type ForTime!
class ForTimeRepsScore extends StatelessWidget {
  final int sectionIndex;
  const ForTimeRepsScore({Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final score = context.select<DoWorkoutBloc, int>((b) =>
        (b.getControllerForSection(sectionIndex) as ForTimeSectionController)
            .repsCompleted);
    final total = context.select<DoWorkoutBloc, int>((b) =>
        (b.getControllerForSection(sectionIndex) as ForTimeSectionController)
            .totalRepsToComplete);

    return Container(
      child: SizeFadeIn(
          key: Key(score.toString()),
          child: MyHeaderText(
            '$score / $total',
            size: FONTSIZE.BIG,
          )),
    );
  }
}
