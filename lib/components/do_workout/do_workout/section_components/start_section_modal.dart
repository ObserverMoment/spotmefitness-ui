import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/section_components/section_modal_container.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/start_workout_countdown_button.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class StartSectionModal extends StatelessWidget {
  final WorkoutSection workoutSection;
  const StartSectionModal({Key? key, required this.workoutSection})
      : super(key: key);

  void _startSection(BuildContext context) {
    context.read<DoWorkoutBloc>().startSection(workoutSection.sortPosition);
  }

  @override
  Widget build(BuildContext context) {
    return SectionModalContainer(
        child: Column(
      children: [
        H2(workoutSection.workoutSectionType.name),

        /// Free session does not require a countdown.
        workoutSection.workoutSectionType.name == kFreeSessionName
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: PrimaryButton(
                    suffix: Icon(
                      CupertinoIcons.arrow_right_circle,
                      color: context.theme.background,
                    ),
                    text: 'Get Started',
                    onPressed: () => _startSection(context)),
              )
            : StartWorkoutCountdownButton(
                startSectionAfterCountdown: () => _startSection(context),
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
