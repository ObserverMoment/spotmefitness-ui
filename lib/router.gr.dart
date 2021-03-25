// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import 'pages/authed/app.dart' as _i2;
import 'pages/authed/discover/discover_page.dart' as _i4;
import 'pages/authed/home/home_page.dart' as _i3;
import 'pages/authed/journal/journal_page.dart' as _i6;
import 'pages/authed/profile/friends_page.dart' as _i9;
import 'pages/authed/profile/gym_profiles.dart' as _i10;
import 'pages/authed/profile/personal_page.dart' as _i8;
import 'pages/authed/profile/profile_page.dart' as _i7;
import 'pages/authed/social/social_page.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    GlobalRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i2.GlobalPage());
    },
    HomeRouter.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i3.HomePage());
    },
    DiscoverRouter.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i4.DiscoverPage());
    },
    SocialRouter.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i5.SocialPage());
    },
    JournalRouter.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i6.JournalPage());
    },
    ProfileRouter.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i7.ProfilePage());
    },
    ProfilePersonalRouter.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i8.ProfilePersonalPage());
    },
    ProfileFriendsRouter.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i9.ProfileFriendsPage());
    },
    ProfileGymProfilesRouter.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry, child: _i10.ProfileGymProfilesPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(GlobalRoute.name,
            path: '/',
            usesTabsRouter: true,
            children: [
              _i1.RouteConfig(HomeRouter.name, path: 'home'),
              _i1.RouteConfig(DiscoverRouter.name, path: 'discover'),
              _i1.RouteConfig(SocialRouter.name, path: 'social'),
              _i1.RouteConfig(JournalRouter.name, path: 'journal'),
              _i1.RouteConfig(ProfileRouter.name,
                  path: 'profile',
                  usesTabsRouter: true,
                  children: [
                    _i1.RouteConfig(ProfilePersonalRouter.name,
                        path: 'personal'),
                    _i1.RouteConfig(ProfileFriendsRouter.name, path: 'friends'),
                    _i1.RouteConfig(ProfileGymProfilesRouter.name,
                        path: 'gym-profiles'),
                    _i1.RouteConfig('*#redirect',
                        path: '*', redirectTo: 'personal', fullMatch: true)
                  ]),
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
  const ProfileRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileRouter';
}

class ProfilePersonalRouter extends _i1.PageRouteInfo {
  const ProfilePersonalRouter() : super(name, path: 'personal');

  static const String name = 'ProfilePersonalRouter';
}

class ProfileFriendsRouter extends _i1.PageRouteInfo {
  const ProfileFriendsRouter() : super(name, path: 'friends');

  static const String name = 'ProfileFriendsRouter';
}

class ProfileGymProfilesRouter extends _i1.PageRouteInfo {
  const ProfileGymProfilesRouter() : super(name, path: 'gym-profiles');

  static const String name = 'ProfileGymProfilesRouter';
}
