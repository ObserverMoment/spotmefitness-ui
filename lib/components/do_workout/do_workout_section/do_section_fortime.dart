import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/animated/animated_submit_button.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/scored_section_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/fortime/fortime_section_timer.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

class DoWorkoutSectionForTime extends StatelessWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState progressState;
  final int activePageIndex;
  const DoWorkoutSectionForTime(
      {Key? key,
      required this.workoutSection,
      required this.progressState,
      required this.activePageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IndexedStack(
              index: activePageIndex,
              children: [
                ScoredSectionMovesList(
                    workoutSection: workoutSection, state: progressState),
                MyText('Video display'),
                ForTimeSectionTimer(
                    workoutSection: workoutSection, state: progressState),
              ],
            ),
          ),
        ),
        AnimatedSubmitButton(
          text: 'set Complete',
          onSubmit: () => context
              .read<DoWorkoutBloc>()
              .markCurrentWorkoutSetAsComplete(workoutSection.sortPosition),
          borderRadius: 2,
        ),
      ],
    );
  }
}
