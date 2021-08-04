import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutBottomNavBar extends StatelessWidget {
  final int activePageIndex;
  final void Function(int pageIndex) goToPage;
  final bool showAudioTab;
  final bool muteAudio;
  final void Function() toggleMuteAudio;
  const DoWorkoutBottomNavBar({
    Key? key,
    required this.showAudioTab,
    required this.goToPage,
    required this.muteAudio,
    required this.activePageIndex,
    required this.toggleMuteAudio,
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
            height: EnvironmentConfig.bottomNavBarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavbarItem(
                  inactiveIconData: CupertinoIcons.layers_alt,
                  activeIconData: CupertinoIcons.layers_alt_fill,
                  label: 'Moves',
                  onTap: () => goToPage(0),
                  isActive: activePageIndex == 0,
                ),
                BottomNavbarItem(
                  inactiveIconData: CupertinoIcons.chart_bar,
                  activeIconData: CupertinoIcons.chart_bar_fill,
                  label: 'Progress',
                  onTap: () => goToPage(1),
                  isActive: activePageIndex == 1,
                ),
                BottomNavbarItem(
                  inactiveIconData: CupertinoIcons.timer,
                  activeIconData: CupertinoIcons.timer_fill,
                  label: 'Timer',
                  onTap: () => goToPage(2),
                  isActive: activePageIndex == 2,
                ),
                if (showAudioTab)
                  BottomNavbarItem(
                    inactiveIconData: CupertinoIcons.volume_up,
                    activeIconData: CupertinoIcons.volume_mute,
                    label: 'Audio',
                    onTap: toggleMuteAudio,
                    isActive: !muteAudio,
                  ),
              ],
            )),
      ),
    );
  }
}

class BottomNavbarItem extends StatelessWidget {
  final IconData activeIconData;
  final IconData inactiveIconData;
  final String label;
  final bool isActive;
  final void Function() onTap;
  const BottomNavbarItem(
      {Key? key,
      required this.activeIconData,
      required this.inactiveIconData,
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
        opacity: isActive ? 1 : 0.6,
        child: AnimatedSwitcher(
            duration: kStandardAnimationDuration,
            child: isActive
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        activeIconData,
                      ),
                      SizedBox(height: 1),
                      MyText(
                        label,
                        size: FONTSIZE.TINY,
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        inactiveIconData,
                      ),
                      SizedBox(height: 1),
                      MyText(
                        label,
                        size: FONTSIZE.TINY,
                      )
                    ],
                  )),
      ),
    );
  }
}
