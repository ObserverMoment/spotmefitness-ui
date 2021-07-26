import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/pages/authed/welcome_modal.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Scaffold for the main top level tabs view.
class MainTabsPage extends StatefulWidget {
  @override
  _MainTabsPageState createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {
  @override
  void initState() {
    super.initState();
    if (!GetIt.I<AuthBloc>().authedUser!.hasOnboarded) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        await showCupertinoModalPopup(
            context: context, builder: (_) => WelcomeModal());
      });
    }
  }

  Widget _buildTabItem(
      {required TabsRouter tabsRouter,
      required int tabIndex,
      required int activeIndex,
      required String label,
      required IconData iconData,
      required Color inActiveColor,
      required Color activeColor}) {
    return TabIcon(
        icon: Icon(
          iconData,
          color: inActiveColor,
        ),
        activeIcon: Icon(
          iconData,
          color: activeColor,
        ),
        inactiveColor: inActiveColor,
        activeColor: activeColor,
        label: label,
        isActive: activeIndex == tabIndex,
        onTap: () => tabsRouter.setActiveIndex(tabIndex));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: AutoTabsRouter(
          routes: [
            HomeStack(),
            DiscoverStack(),
            SocialRoute(),
            ProgressStack(),
            ProfileRoute(),
          ],
          builder: (context, child, animation) {
            final _mediaQuery = MediaQuery.of(context);
            final _tabsRouter = context.tabsRouter;
            final _activeIndex = _tabsRouter.activeIndex;
            final _activeColor = context.theme.activeIcon;
            final _inActiveColor = context.theme.primary;

            return Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                // Similar to how CupertinoTabScaffold handles non opaque bottom nav bar.
                FadeTransition(
                    child: MediaQuery(
                        data: _mediaQuery.copyWith(
                            padding: _mediaQuery.padding.copyWith(
                                bottom:
                                    EnvironmentConfig.bottomNavBarHeight + 4)),
                        child: child),
                    opacity: animation),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                              color: context.theme.primary.withOpacity(0.07),
                            )),
                            color:
                                context.theme.cardBackground.withOpacity(0.75),
                          ),
                          height: EnvironmentConfig.bottomNavBarHeight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  activeColor: _activeColor,
                                  inActiveColor: _inActiveColor,
                                  tabIndex: 0,
                                  label: 'Home',
                                  iconData:
                                      CupertinoIcons.square_grid_2x2_fill),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  activeColor: _activeColor,
                                  inActiveColor: _inActiveColor,
                                  tabIndex: 1,
                                  label: 'Discover',
                                  iconData: CupertinoIcons.compass_fill),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  activeColor: _activeColor,
                                  inActiveColor: _inActiveColor,
                                  tabIndex: 2,
                                  label: 'Social',
                                  iconData:
                                      CupertinoIcons.person_2_square_stack),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  activeColor: _activeColor,
                                  inActiveColor: _inActiveColor,
                                  tabIndex: 3,
                                  label: 'Progress',
                                  iconData: CupertinoIcons.graph_square),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  activeColor: _activeColor,
                                  inActiveColor: _inActiveColor,
                                  tabIndex: 4,
                                  label: 'Profile',
                                  iconData: CupertinoIcons.profile_circled),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}

class TabIcon extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final Color activeColor;
  final Color inactiveColor;
  final String label;
  final bool isActive;
  final void Function() onTap;
  TabIcon(
      {required this.icon,
      required this.activeIcon,
      required this.inactiveColor,
      required this.activeColor,
      required this.label,
      required this.isActive,
      required this.onTap});

  final kAnimationDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      pressedOpacity: 0.9,
      onPressed: onTap,
      child: AnimatedOpacity(
        duration: kAnimationDuration,
        opacity: isActive ? 1 : 0.75,
        child: AnimatedSwitcher(
            duration: kAnimationDuration,
            child: isActive
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      icon,
                      SizedBox(height: 1),
                      MyText(label, size: FONTSIZE.TINY, color: inactiveColor)
                    ],
                  )),
      ),
    );
  }
}
