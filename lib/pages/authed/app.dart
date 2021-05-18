import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/move_filters_bloc.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/pages/authed/welcome_modal.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';

class App extends StatelessWidget {
  final AuthedUser authedUser;
  App(this.authedUser);

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GraphQLStore()),
        ChangeNotifierProvider(create: (_) => ThemeBloc()),
        ChangeNotifierProvider(create: (_) => MoveFiltersBloc()),
      ],
      child: Builder(
          builder: (context) => CupertinoApp.router(
                debugShowCheckedModeBanner: false,
                theme: context.theme.cupertinoThemeData,
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
                localizationsDelegates: [
                  DefaultMaterialLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en', 'US'),
                  const Locale('en', 'GB'),
                ],
              )),
    );
  }
}

/// Scaffold for the main top level tabs view.
class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
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
        inActiveColor: inActiveColor,
        activeColor: activeColor,
        label: label,
        isActive: activeIndex == tabIndex,
        onTap: () => tabsRouter.setActiveIndex(tabIndex));
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
        duration: Duration(milliseconds: 0),
        routes: [
          HomeStack(),
          DiscoverRoute(),
          SocialRoute(),
          JournalStack(),
          ProfileRoute()
        ],
        builder: (context, child, animation) {
          final _mediaQuery = MediaQuery.of(context);
          final _size = _mediaQuery.size;
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
                          padding: _mediaQuery.padding
                              .copyWith(bottom: kBottomNavBarHeight + 4)),
                      child: child),
                  opacity: animation),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 14, right: 14, bottom: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: context.theme.background.withOpacity(0.7),
                              border: Border.all(
                                  color:
                                      context.theme.primary.withOpacity(0.15))),
                          height: kBottomNavBarHeight,
                          width: _size.width - 28,
                          child: Row(
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
                                  label: 'Journal',
                                  iconData: CupertinoIcons.doc_plaintext),
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
                ),
              )
            ],
          );
        });
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

  final _animationDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      pressedOpacity: 0.9,
      onPressed: onTap,
      child: AnimatedOpacity(
        duration: _animationDuration,
        opacity: isActive ? 1 : 0.75,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: AnimatedSwitcher(
              duration: _animationDuration,
              child: isActive
                  ? Column(
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
                      children: [
                        icon,
                        SizedBox(height: 1),
                        MyText(label, size: FONTSIZE.TINY, color: inActiveColor)
                      ],
                    )),
        ),
      ),
    );
  }
}
