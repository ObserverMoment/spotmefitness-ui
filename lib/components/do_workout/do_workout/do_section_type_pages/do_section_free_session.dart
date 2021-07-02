import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/free_session/free_session_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/free_session/free_session_progress.dart';
import 'package:spotmefitness_ui/components/timers/countdown_timer.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_with_laps.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

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
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        FreeSessionMovesList(workoutSection: workoutSection),
        FreeSessionProgress(),
        _StopwatchLapTimer()
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
                child: Icon(CupertinoIcons.stopwatch),
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
          child: _activeTabIndex == 0 ? StopwatchWithLaps() : CountdownTimer(),
        ))
      ],
    );
  }
}
