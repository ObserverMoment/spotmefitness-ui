import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/pages/authed/welcome_modal.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uni_links/uni_links.dart';

/// Scaffold for the main top level tabs view.
class MainTabsPage extends StatefulWidget {
  @override
  _MainTabsPageState createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {
  late StreamSubscription _linkStreamSub;
  late StreamChatClient _getStreamChatClient;

  @override
  void initState() {
    super.initState();

    /// Setup [uni_links]
    /// https://pub.dev/packages/uni_links
    _handleInitialUri();
    _handleIncomingLinks();

    /// Setup GetStreamChatClient as a global singleton.
    _getStreamChatClient = StreamChatClient(
      EnvironmentConfig.getStreamPublicKey,
    );
    GetIt.I.registerSingleton<StreamChatClient>(_getStreamChatClient);

    /// If user has not yet onboarded then show them the welcome flow.
    if (!GetIt.I<AuthBloc>().authedUser!.hasOnboarded) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        await showCupertinoModalPopup(
            context: context, builder: (_) => WelcomeModal());
      });
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    try {
      final uri = await getInitialUri();
      if (uri == null) {
        print('Uni_links: no initial uri');
      } else {
        if (!mounted) return;
        _extractRouterPathNameAndPush(uri);
      }
    } on PlatformException {
      // Platform messages may fail but we ignore the exception
      print('Uni_links: falied to get initial uri');
    } on FormatException catch (err) {
      if (!mounted) return;
      print('Uni_links: malformed initial uri');
      print(err);
    }
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _linkStreamSub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        if (uri != null) {
          _extractRouterPathNameAndPush(uri);
        }
      }, onError: (Object err) {
        if (!mounted) return;
        print('Uni_links._handleIncomingLinks: got err: $err');
      });
    }
  }

  void _extractRouterPathNameAndPush(Uri uri) {
    context.navigateNamedTo(uri.toString().replaceFirst(kDeepLinkSchema, ''));
  }

  @override
  void dispose() {
    // Cancel listening to incoming links.
    _linkStreamSub.cancel();
    // Close and dispose GetStreamChatClient.
    GetIt.I.unregister<StreamChatClient>(
      instance: _getStreamChatClient,
      disposingFunction: (client) => client.dispose(),
    );
    super.dispose();
  }

  Widget _buildTabItem({
    required TabsRouter tabsRouter,
    required int tabIndex,
    required int activeIndex,
    required String label,
    required IconData inactiveIconData,
    required IconData activeIconData,
  }) {
    return TabIcon(
        inactiveIcon: Icon(
          inactiveIconData,
        ),
        activeIcon: Icon(
          activeIconData,
        ),
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
                                  tabIndex: 0,
                                  label: 'Home',
                                  inactiveIconData:
                                      CupertinoIcons.square_grid_2x2,
                                  activeIconData:
                                      CupertinoIcons.square_grid_2x2_fill),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  tabIndex: 1,
                                  label: 'Discover',
                                  inactiveIconData: CupertinoIcons.compass,
                                  activeIconData: CupertinoIcons.compass_fill),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  tabIndex: 2,
                                  label: 'Social',
                                  inactiveIconData:
                                      CupertinoIcons.person_2_square_stack,
                                  activeIconData: CupertinoIcons
                                      .person_2_square_stack_fill),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  tabIndex: 3,
                                  label: 'Progress',
                                  inactiveIconData: CupertinoIcons.graph_square,
                                  activeIconData:
                                      CupertinoIcons.graph_square_fill),
                              _buildTabItem(
                                  tabsRouter: _tabsRouter,
                                  activeIndex: _activeIndex,
                                  tabIndex: 4,
                                  label: 'Profile',
                                  inactiveIconData:
                                      CupertinoIcons.profile_circled,
                                  activeIconData:
                                      CupertinoIcons.profile_circled),
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
  final Widget activeIcon;
  final Widget inactiveIcon;
  final String label;
  final bool isActive;
  final void Function() onTap;
  TabIcon(
      {required this.activeIcon,
      required this.inactiveIcon,
      required this.label,
      required this.isActive,
      required this.onTap});

  final kAnimationDuration = Duration(milliseconds: 400);
  final kLabelSpacerHeight = 3.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      pressedOpacity: 0.9,
      onPressed: onTap,
      child: AnimatedOpacity(
        duration: kAnimationDuration,
        opacity: isActive ? 1 : 0.6,
        child: AnimatedSwitcher(
            duration: kAnimationDuration,
            child: isActive
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      activeIcon,
                      SizedBox(height: kLabelSpacerHeight),
                      MyText(
                        label,
                        size: FONTSIZE.TINY,
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      inactiveIcon,
                      SizedBox(height: kLabelSpacerHeight),
                      MyText(label, size: FONTSIZE.TINY)
                    ],
                  )),
      ),
    );
  }
}
