import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/free_session_section_controller.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/free_session/free_session_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_section_type_pages/free_session/free_session_progress.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/countdown_timer.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_with_laps.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

class DoWorkoutSectionFreeSession extends StatefulWidget {
  final PageController pageController;

  /// The user can make updates to this object as they progress and before saving them into a log.
  final WorkoutSection workoutSection;
  final int activePageIndex;
  const DoWorkoutSectionFreeSession({
    Key? key,
    required this.pageController,
    required this.workoutSection,
    required this.activePageIndex,
  }) : super(key: key);

  @override
  _DoWorkoutSectionFreeSessionState createState() =>
      _DoWorkoutSectionFreeSessionState();
}

class _DoWorkoutSectionFreeSessionState
    extends State<DoWorkoutSectionFreeSession> {
  late FreeSessionSectionController _freeSessionController;

  @override
  void initState() {
    _freeSessionController = context
            .read<DoWorkoutBloc>()
            .controllers[widget.workoutSection.sortPosition]
        as FreeSessionSectionController;

    /// We need to listen for user updates that they can make during doing a FreeSession. So we need to trigger rebuilds on [notifyListeners()]
    _freeSessionController.addListener(_listener);
    super.initState();
  }

  void _listener() {
    setState(() {});
  }

  /// If this is the only section in the workout then this will move you to the log workout screen.
  void _markSectionComplete() {
    _freeSessionController.markSectionComplete();
  }

  @override
  void dispose() {
    _freeSessionController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GrowInOut(
            show: _freeSessionController
                .loggedWorkoutSection.loggedWorkoutSets.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SecondaryButton(
                          prefix: Icon(
                            CupertinoIcons.doc_chart,
                            color: Styles.white,
                            size: 20,
                          ),
                          withMinWidth: false,
                          text: 'Log this section',
                          onPressed: _markSectionComplete),
                    ],
                  ),
                  Positioned(
                      right: 0,
                      child: InfoPopupButton(
                          infoWidget: MyText(
                        'Explain that pressing this button will log the work you have done so far in this free session - you do not need to "complete" a free session',
                        maxLines: 6,
                      ))),
                ],
              ),
            )),
        Expanded(
          child: PageView(
            controller: widget.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              FreeSessionMovesList(
                  freeSessionController: _freeSessionController),
              FreeSessionProgress(
                  freeSessionController: _freeSessionController),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _StopwatchLapTimer(),
              )
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
          padding:
              EdgeInsets.only(bottom: EnvironmentConfig.bottomNavBarHeight),
          child: _activeTabIndex == 0 ? StopwatchWithLaps() : CountdownTimer(),
        ))
      ],
    );
  }
}
