import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutSectionNav extends StatelessWidget {
  final int activePageIndex;
  final void Function(int pageIndex) goToPage;
  final bool showVideoTab;
  final bool showAudioTab;
  final bool muteAudio;
  final void Function() toggleMuteAudio;
  const DoWorkoutSectionNav({
    Key? key,
    required this.showAudioTab,
    required this.goToPage,
    required this.muteAudio,
    required this.activePageIndex,
    required this.toggleMuteAudio,
    required this.showVideoTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        NavItem(
          inactiveIconData: CupertinoIcons.layers_alt,
          activeIconData: CupertinoIcons.layers_alt_fill,
          onTap: () => goToPage(0),
          isActive: activePageIndex == 0,
        ),
        NavItem(
          inactiveIconData: CupertinoIcons.timer,
          activeIconData: CupertinoIcons.timer_fill,
          onTap: () => goToPage(1),
          isActive: activePageIndex == 1,
        ),
        if (showVideoTab)
          NavItem(
            inactiveIconData: CupertinoIcons.tv,
            activeIconData: CupertinoIcons.tv_fill,
            onTap: () => goToPage(2),
            isActive: activePageIndex == 2,
          ),
        if (showAudioTab)
          NavItem(
            inactiveIconData: CupertinoIcons.volume_up,
            activeIconData: CupertinoIcons.volume_mute,
            onTap: toggleMuteAudio,
            isActive: !muteAudio,
          ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData activeIconData;
  final IconData inactiveIconData;
  final bool isActive;
  final void Function() onTap;
  const NavItem(
      {Key? key,
      required this.activeIconData,
      required this.inactiveIconData,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  final iconSize = 23.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            color: context.theme.cardBackground.withOpacity(0.8),
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
                        ? Icon(
                            activeIconData,
                            size: iconSize,
                          )
                        : Icon(
                            inactiveIconData,
                            size: iconSize,
                          )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
