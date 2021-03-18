import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/pages/authed/welcome_modal.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';

class App extends StatelessWidget {
  final AuthedUser authedUser;
  App(this.authedUser);

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
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
              final _inActiveColor = context
                  .read<ThemeBloc>()
                  .theme
                  .cupertinoThemeData
                  .primaryColor;
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  FadeTransition(child: child, opacity: animation),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 14, right: 14, bottom: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                          child: Container(
                              decoration: BoxDecoration(
                                color: context
                                    .read<ThemeBloc>()
                                    .theme
                                    .cupertinoThemeData
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.6),
                              ),
                              height: 66,
                              width: _size.width - 28,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
            }),
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
                        SizedBox(height: 4),
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
                        SizedBox(height: 4),
                        MyText(label, size: FONTSIZE.TINY, color: inActiveColor)
                      ],
                    )),
        ),
      ),
    );
  }
}
