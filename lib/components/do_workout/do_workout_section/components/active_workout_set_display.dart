import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_minimal_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Based on the current state for [sectionIndex] section, which set is the user doing, or about to do.
/// See future sets via [offset]. "Next Set" offset would be 1.
class ActiveSetDisplay extends StatelessWidget {
  final int sectionIndex;
  final int offset;
  final WorkoutSectionType workoutSectionType;
  const ActiveSetDisplay(
      {Key? key,
      required this.sectionIndex,
      required this.offset,
      required this.workoutSectionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutSet = context.select<DoWorkoutBloc, WorkoutSet>(
        (b) => b.getActiveSetForSection(sectionIndex, offset));

    return SizeFadeIn(
      key: Key(workoutSet.id),
      child: WorkoutSetMinimalDisplay(
          backgroundColor: context.theme.cardBackground.withOpacity(0.6),
          workoutSet: workoutSet,
          workoutSectionType: workoutSectionType),
    );
  }
}
