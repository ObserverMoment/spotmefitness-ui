import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_bottom_navbar.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/countdown_timer.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_with_laps.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Full screen widget with bottom navigation bar.
/// Navigate between [StopwatchWithLaps] and [CountdownTimer]
/// very similar to iOS.
class StopwatchAndTimer extends StatefulWidget {
  const StopwatchAndTimer({Key? key}) : super(key: key);

  @override
  _StopwatchAndTimerState createState() => _StopwatchAndTimerState();
}

class _StopwatchAndTimerState extends State<StopwatchAndTimer> {
  int _activeTabIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle('Timer'),
      ),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16, left: 16, right: 16, bottom: kBottomNavBarHeight),
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _activeTabIndex = i),
              children: [
                StopwatchWithLaps(
                  fullScreenDisplay: true,
                ),
                CountdownTimer(
                  fullScreenDisplay: true,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TimersBottomNavBar(
              activePageIndex: _activeTabIndex,
              goToPage: (i) {
                _pageController.jumpToPage(i);
                setState(() => _activeTabIndex = i);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TimersBottomNavBar extends StatelessWidget {
  final int activePageIndex;
  final void Function(int pageIndex) goToPage;
  const TimersBottomNavBar({
    Key? key,
    required this.goToPage,
    required this.activePageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
            decoration: BoxDecoration(
              color: context.theme.background.withOpacity(0.2),
            ),
            height: kBottomNavBarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavbarItem(
                  iconData: CupertinoIcons.stopwatch,
                  label: 'Stopwatch',
                  onTap: () => goToPage(0),
                  isActive: activePageIndex == 0,
                ),
                BottomNavbarItem(
                  iconData: CupertinoIcons.timer,
                  label: 'Timer',
                  onTap: () => goToPage(1),
                  isActive: activePageIndex == 1,
                ),
              ],
            )),
      ),
    );
  }
}
