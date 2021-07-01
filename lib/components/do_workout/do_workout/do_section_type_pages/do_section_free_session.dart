import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/animated/slider_button.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_countdown_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_section_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/amrap/amrap_section_progress_summary.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/free_session/free_session_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/free_session/free_session_progress.dart';
import 'package:spotmefitness_ui/components/stopwatch_lap_timer.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class DoWorkoutSectionFreeSession extends StatelessWidget {
  final PageController pageController;
  final WorkoutSection workoutSection;
  final int activePageIndex;
  const DoWorkoutSectionFreeSession(
      {Key? key,
      required this.pageController,
      required this.workoutSection,
      required this.activePageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                H3(
                  'Free Session',
                ),
                InfoPopupButton(
                    infoWidget: MyText(
                        'Info about the wokout type ${workoutSection.workoutSectionType.name}'))
              ],
            ),
          ],
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              FreeSessionMovesList(),
              FreeSessionProgress(),
              _StopwatchLapTimer()
            ],
          ),
        ),
      ],
    );
  }
}

class _StopwatchLapTimer extends StatefulWidget {
  const _StopwatchLapTimer({Key? key}) : super(key: key);

  @override
  __StopwatchLapTimerState createState() => __StopwatchLapTimerState();
}

class __StopwatchLapTimerState extends State<_StopwatchLapTimer> {
  /// 0 = Stopwatch.
  /// 1 = Timer
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlidingSelect<int>(
            value: _activeTabIndex,
            updateValue: (i) => setState(() => _activeTabIndex = i),
            children: {
              0: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Icon(CupertinoIcons.stopwatch_fill),
              ),
              1: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Icon(CupertinoIcons.timer),
              ),
            }),
        SizedBox(height: 24),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: kBottomNavBarHeight),
          child: _activeTabIndex == 0 ? StopwatchLapTimer() : CountdownTimer(),
        ))
      ],
    );
  }
}
