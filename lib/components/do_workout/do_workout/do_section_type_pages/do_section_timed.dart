import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/timed/timed_section_lap_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/timed/timed_section_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/timed/timed_section_progress_summary.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class DoWorkoutSectionTimed extends StatelessWidget {
  final PageController pageController;
  final int activePageIndex;
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState progressState;
  const DoWorkoutSectionTimed(
      {Key? key,
      required this.workoutSection,
      required this.pageController,
      required this.progressState,
      required this.activePageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearPercentIndicator(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          lineHeight: 6,
          percent: progressState.percentComplete,
          backgroundColor: context.theme.primary.withOpacity(0.07),
          linearGradient: Styles.pinkGradient,
          linearStrokeCap: LinearStrokeCap.roundAll,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(workoutSection.workoutSectionType.name,
                weight: FontWeight.bold),
            InfoPopupButton(
                infoWidget: MyText(
                    'Info about the wokout type ${workoutSection.workoutSectionType.name}'))
          ],
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              TimedSectionMovesList(
                  workoutSection: workoutSection, state: progressState),
              TimedSectionProgressSummary(
                  workoutSection: workoutSection, state: progressState),
              TimedSectionLapTimer(
                  workoutSection: workoutSection, state: progressState),
            ],
          ),
        )
      ],
    );
  }
}
