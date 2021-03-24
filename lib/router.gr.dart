// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import 'pages/authed/app.dart' as _i2;
import 'pages/authed/discover/discover_page.dart' as _i4;
import 'pages/authed/home/home_page.dart' as _i3;
import 'pages/authed/journal/journal_page.dart' as _i6;
import 'pages/authed/profile/profile_page.dart' as _i7;
import 'pages/authed/social/social_page.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    GlobalRoute.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry,
          child: _i2.GlobalPage(),
          maintainState: true,
          fullscreenDialog: false);
    },
    HomeRouter.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry,
          child: _i3.HomePage(),
          maintainState: true,
          fullscreenDialog: false);
    },
    DiscoverRouter.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry,
          child: _i4.DiscoverPage(),
          maintainState: true,
          fullscreenDialog: false);
    },
    SocialRouter.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry,
          child: _i5.SocialPage(),
          maintainState: true,
          fullscreenDialog: false);
    },
    JournalRouter.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry,
          child: _i6.JournalPage(),
          maintainState: true,
          fullscreenDialog: false);
    },
    ProfileRouter.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry,
          child: _i7.ProfilePage(),
          maintainState: true,
          fullscreenDialog: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(GlobalRoute.name,
            path: '/',
            fullMatch: false,
            usesTabsRouter: true,
            children: [
              _i1.RouteConfig(HomeRouter.name,
                  path: 'home', fullMatch: false, usesTabsRouter: false),
              _i1.RouteConfig(DiscoverRouter.name,
                  path: 'discover', fullMatch: false, usesTabsRouter: false),
              _i1.RouteConfig(SocialRouter.name,
                  path: 'social', fullMatch: false, usesTabsRouter: false),
              _i1.RouteConfig(JournalRouter.name,
                  path: 'journal', fullMatch: false, usesTabsRouter: false),
              _i1.RouteConfig(ProfileRouter.name,
                  path: 'profile', fullMatch: false, usesTabsRouter: false),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: '/', fullMatch: true)
            ])
      ];
}

class GlobalRoute extends _i1.PageRouteInfo {
  const GlobalRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'GlobalRoute';
}

class HomeRouter extends _i1.PageRouteInfo {
  const HomeRouter() : super(name, path: 'home');

  static const String name = 'HomeRouter';
}

class DiscoverRouter extends _i1.PageRouteInfo {
  const DiscoverRouter() : super(name, path: 'discover');

  static const String name = 'DiscoverRouter';
}

class SocialRouter extends _i1.PageRouteInfo {
  const SocialRouter() : super(name, path: 'social');

  static const String name = 'SocialRouter';
}

class JournalRouter extends _i1.PageRouteInfo {
  const JournalRouter() : super(name, path: 'journal');

  static const String name = 'JournalRouter';
}

class ProfileRouter extends _i1.PageRouteInfo {
  const ProfileRouter() : super(name, path: 'profile');

  static const String name = 'ProfileRouter';
}
