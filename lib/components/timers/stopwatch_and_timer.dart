import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/countdown_timer.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_with_laps.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class StopwathAndTimerPage extends StatelessWidget {
  const StopwathAndTimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// Full screen widget with bottom navigation bar.
/// Navigate between [StopwatchWithLaps] and [CountdownTimer]
class StopwatchAndTimer extends StatefulWidget {
  const StopwatchAndTimer({Key? key}) : super(key: key);

  @override
  _StopwatchAndTimerState createState() => _StopwatchAndTimerState();
}

class _StopwatchAndTimerState extends State<StopwatchAndTimer> {
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 12,
              left: 16,
              right: 16,
              bottom: EnvironmentConfig.bottomNavBarHeight),
          child: IndexedStack(
            index: _activeTabIndex,
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
          child: _TimersBottomNavBar(
            activePageIndex: _activeTabIndex,
            goToPage: (i) => setState(() => _activeTabIndex = i),
          ),
        ),
      ],
    );
  }
}

class _TimersBottomNavBar extends StatelessWidget {
  final int activePageIndex;
  final void Function(int pageIndex) goToPage;
  const _TimersBottomNavBar({
    Key? key,
    required this.goToPage,
    required this.activePageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: context.theme.primary.withOpacity(0.1),
        ),
        height: EnvironmentConfig.bottomNavBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TimersNavItem(
              activeIconData: CupertinoIcons.stopwatch_fill,
              inactiveIconData: CupertinoIcons.stopwatch,
              label: 'Stopwatch',
              onTap: () => goToPage(0),
              isActive: activePageIndex == 0,
            ),
            _TimersNavItem(
              activeIconData: CupertinoIcons.timer_fill,
              inactiveIconData: CupertinoIcons.timer,
              label: 'Timer',
              onTap: () => goToPage(1),
              isActive: activePageIndex == 1,
            ),
          ],
        ));
  }
}

class _TimersNavItem extends StatelessWidget {
  final IconData activeIconData;
  final IconData inactiveIconData;
  final String label;
  final bool isActive;
  final void Function() onTap;
  const _TimersNavItem(
      {Key? key,
      required this.activeIconData,
      required this.inactiveIconData,
      required this.label,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  final iconSize = 22.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        pressedOpacity: 0.9,
        onPressed: onTap,
        child: AnimatedOpacity(
          duration: kStandardAnimationDuration,
          opacity: isActive ? 1 : 0.6,
          child: AnimatedSwitcher(
              duration: kStandardAnimationDuration,
              child: isActive
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          activeIconData,
                          size: iconSize,
                        ),
                        SizedBox(height: 1),
                        MyText(
                          label,
                          size: FONTSIZE.TINY,
                        )
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          inactiveIconData,
                          size: iconSize,
                        ),
                        SizedBox(height: 1),
                        MyText(
                          label,
                          size: FONTSIZE.TINY,
                        )
                      ],
                    )),
        ),
      ),
    );
  }
}
