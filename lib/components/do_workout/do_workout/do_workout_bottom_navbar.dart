import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutBottomNavBar extends StatelessWidget {
  const DoWorkoutBottomNavBar({Key? key}) : super(key: key);

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
                _DoWorkoutBottomNavbarItem(
                  iconData: CupertinoIcons.list_number,
                  label: 'Moves',
                  onTap: () {
                    print('0');
                  },
                  isActive: true,
                ),
                _DoWorkoutBottomNavbarItem(
                  iconData: CupertinoIcons.chart_bar_fill,
                  label: 'Progress',
                  onTap: () {
                    print('1');
                  },
                  isActive: false,
                ),
                _DoWorkoutBottomNavbarItem(
                  iconData: CupertinoIcons.timer_fill,
                  label: 'Timer',
                  onTap: () {
                    print('2');
                  },
                  isActive: false,
                ),
                _DoWorkoutBottomNavbarItem(
                  iconData: CupertinoIcons.film_fill,
                  label: 'Video',
                  onTap: () {
                    print('3');
                  },
                  isActive: false,
                ),
                _DoWorkoutBottomNavbarItem(
                  iconData: CupertinoIcons.volume_up,
                  label: 'Audio',
                  onTap: () {
                    print('4');
                  },
                  isActive: true,
                ),
              ],
            )),
      ),
    );
  }
}

class _DoWorkoutBottomNavbarItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool isActive;
  final void Function() onTap;
  const _DoWorkoutBottomNavbarItem(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      pressedOpacity: 0.9,
      onPressed: onTap,
      child: AnimatedOpacity(
        duration: kStandardAnimationDuration,
        opacity: isActive ? 1 : 0.75,
        child: AnimatedSwitcher(
            duration: kStandardAnimationDuration,
            child: isActive
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        color: context.theme.activeIcon,
                      ),
                      SizedBox(height: 1),
                      MyText(
                        label,
                        size: FONTSIZE.TINY,
                        color: context.theme.activeIcon,
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        color: context.theme.primary.withOpacity(0.7),
                      ),
                      SizedBox(height: 1),
                      MyText(label,
                          size: FONTSIZE.TINY,
                          color: context.theme.primary.withOpacity(0.7))
                    ],
                  )),
      ),
    );
  }
}

class TabIcon extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final Color activeColor;
  final Color inActiveColor;
  final String label;
  final bool isActive;
  final void Function() onTap;
  TabIcon(
      {required this.icon,
      required this.activeIcon,
      required this.inActiveColor,
      required this.activeColor,
      required this.label,
      required this.isActive,
      required this.onTap});

  final kAnimationDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      pressedOpacity: 0.9,
      onPressed: onTap,
      child: AnimatedOpacity(
        duration: kAnimationDuration,
        opacity: isActive ? 1 : 0.75,
        child: AnimatedSwitcher(
            duration: kAnimationDuration,
            child: isActive
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      activeIcon,
                      SizedBox(height: 1),
                      MyText(
                        label,
                        size: FONTSIZE.TINY,
                        color: activeColor,
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      SizedBox(height: 1),
                      MyText(label, size: FONTSIZE.TINY, color: inActiveColor)
                    ],
                  )),
      ),
    );
  }
}
