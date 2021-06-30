import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/section_components/section_modal_container.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/start_workout_countdown_button.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

class StartSectionModal extends StatelessWidget {
  final WorkoutSection workoutSection;
  const StartSectionModal({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionModalContainer(
        child: Column(
      children: [
        H2(workoutSection.workoutSectionType.name),
        StartWorkoutCountdownButton(
          startSectionAfterCountdown: () => context
              .read<DoWorkoutBloc>()
              .startSection(workoutSection.sortPosition),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: WorkoutDetailsSection(
              workoutSection,
              showMediaThumbs: false,
              showSectionTypeTag: false,
            ),
          ),
        ),
      ],
    ));
  }
}
