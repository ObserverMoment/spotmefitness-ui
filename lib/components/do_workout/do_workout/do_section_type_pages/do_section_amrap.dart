import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/slider_button.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_countdown_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_section_moves_list.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutSectionAMRAP extends StatelessWidget {
  final PageController pageController;
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState progressState;
  final int activePageIndex;
  const DoWorkoutSectionAMRAP(
      {Key? key,
      required this.pageController,
      required this.workoutSection,
      required this.progressState,
      required this.activePageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  H3(
                    'AMRAP in ${Duration(seconds: workoutSection.timecap!).compactDisplay()}',
                  ),
                  InfoPopupButton(
                      infoWidget: MyText(
                          'Info about the wokout type ${workoutSection.workoutSectionType.name}'))
                ],
              ),
              H2('Reps: 65'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SliderButton(
            text: 'Set complete',
            sliderRotate: false,
            innerColor: context.theme.background,
            height: 60,
            sliderButtonIconSize: 20,
            outerColor: context.theme.primary,
            onSubmit: () => print('go to next set'),
          ),
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              AMRAPSectionMovesList(
                  workoutSection: workoutSection, state: progressState),
              AMRAPSectionMovesList(
                  workoutSection: workoutSection, state: progressState),
              AMRAPCountdownTimer(
                  workoutSection: workoutSection, state: progressState),
            ],
          ),
        ),
      ],
    );
  }
}
