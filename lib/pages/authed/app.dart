import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';

class App extends StatelessWidget {
  final AuthedUser authedUser;
  App(this.authedUser);

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    print('app');
    final _graphql = GraphQL();
    return GraphQLProvider(
        client: _graphql.clientNotifier,
        child: ChangeNotifierProvider(
          create: (_) => ThemeBloc(
              themeName: authedUser.themeName, graphqlClient: _graphql.client),
          builder: (context, child) => CupertinoApp.router(
            debugShowCheckedModeBanner: false,
            theme: context.read<ThemeBloc>().theme.cupertinoThemeData,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          ),
        ));
  }
}

/// Scaffold for the main top level tabs view.
class GlobalPage extends StatelessWidget {
  Widget _buildTabItem(
      {required TabsRouter tabsRouter,
      required int tabIndex,
      required int activeIndex,
      required String label,
      required IconData iconData,
      required Color activeColor}) {
    return TabIcon(
        icon: Icon(iconData),
        activeIcon: Icon(
          iconData,
          color: activeColor,
        ),
        activeColor: activeColor,
        label: label,
        isActive: activeIndex == tabIndex,
        onTap: () => tabsRouter.setActiveIndex(tabIndex));
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: SizedBox.expand(
        child: AutoTabsRouter(
            routes: [
              HomeRouter(),
              DiscoverRouter(),
              SocialRouter(),
              JournalRouter(),
              ProfileRouter()
            ],
            builder: (context, child, animation) {
              final _tabsRouter = context.tabsRouter;
              final _activeIndex = _tabsRouter.activeIndex;
              final _activeColor = Styles.difficultyLevelThree;
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      FadeTransition(child: child, opacity: animation),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                        height: 66,
                        width: _size.width,
                        color: context
                            .read<ThemeBloc>()
                            .theme
                            .customThemeData
                            .bottomNavigationBackground,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTabItem(
                                tabsRouter: _tabsRouter,
                                activeIndex: _activeIndex,
                                activeColor: _activeColor,
                                tabIndex: 0,
                                label: 'Home',
                                iconData: CupertinoIcons.square_grid_2x2_fill),
                            _buildTabItem(
                                tabsRouter: _tabsRouter,
                                activeIndex: _activeIndex,
                                activeColor: _activeColor,
                                tabIndex: 1,
                                label: 'Discover',
                                iconData: CupertinoIcons.compass_fill),
                            _buildTabItem(
                                tabsRouter: _tabsRouter,
                                activeIndex: _activeIndex,
                                activeColor: _activeColor,
                                tabIndex: 2,
                                label: 'Social',
                                iconData: CupertinoIcons.person_2_square_stack),
                            _buildTabItem(
                                tabsRouter: _tabsRouter,
                                activeIndex: _activeIndex,
                                activeColor: _activeColor,
                                tabIndex: 3,
                                label: 'Journal',
                                iconData: CupertinoIcons.chart_bar_alt_fill),
                            _buildTabItem(
                                tabsRouter: _tabsRouter,
                                activeIndex: _activeIndex,
                                activeColor: _activeColor,
                                tabIndex: 4,
                                label: 'Profile',
                                iconData: CupertinoIcons.profile_circled),
                          ],
                        )),
                  )
                ],
              );
            }),
      ),
    );
  }
}

class TabIcon extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final Color activeColor;
  final String label;
  final bool isActive;
  final void Function() onTap;
  TabIcon(
      {required this.icon,
      required this.activeIcon,
      required this.activeColor,
      required this.label,
      required this.isActive,
      required this.onTap});

  final _animationDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    final _color = isActive
        ? Styles.difficultyLevelThree
        : context.read<ThemeBloc>().theme.cupertinoThemeData.primaryColor;
    return GestureDetector(
      onTap: onTap,
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
                        SizedBox(height: 2),
                        MyText(
                          label,
                          size: FONTSIZE.SMALL,
                          weight: FONTWEIGHT.BOLD,
                          color: _color,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        icon,
                        SizedBox(height: 2),
                        MyText(label, size: FONTSIZE.SMALL, color: _color)
                      ],
                    )),
        ),
      ),
    );
  }
}
