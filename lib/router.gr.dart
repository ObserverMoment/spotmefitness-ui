// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import 'pages/authed/app.dart' as _i2;
import 'pages/authed/discover/discover_page.dart' as _i3;
import 'pages/authed/discover/plans.dart' as _i14;
import 'pages/authed/discover/workouts.dart' as _i13;
import 'pages/authed/discover/you.dart' as _i12;
import 'pages/authed/home/home_page.dart' as _i7;
import 'pages/authed/home/your_collections.dart' as _i8;
import 'pages/authed/home/your_events.dart' as _i11;
import 'pages/authed/home/your_plans.dart' as _i10;
import 'pages/authed/home/your_workouts.dart' as _i9;
import 'pages/authed/journal/journal_page.dart' as _i5;
import 'pages/authed/profile/gym_profiles.dart' as _i16;
import 'pages/authed/profile/personal_page.dart' as _i15;
import 'pages/authed/profile/profile_page.dart' as _i6;
import 'pages/authed/social/social_page.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    GlobalRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i2.GlobalPage());
    },
    HomeStack.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry, child: const _i1.EmptyRouterPage());
    },
    DiscoverRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i3.DiscoverPage());
    },
    SocialRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i4.SocialPage());
    },
    JournalRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i5.JournalPage());
    },
    ProfileRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i6.ProfilePage());
    },
    HomeRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i7.HomePage());
    },
    YourCollectionsRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i8.YourCollectionsPage());
    },
    YourWorkoutsRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i9.YourWorkoutsPage());
    },
    YourPlansRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i10.YourPlansPage());
    },
    YourEventsRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i11.YourEventsPage());
    },
    DiscoverYouRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i12.DiscoverYouPage());
    },
    DiscoverWorkoutsRoute.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry, child: _i13.DiscoverWorkoutsPage());
    },
    DiscoverPlansRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i14.DiscoverPlansPage());
    },
    ProfilePersonalRoute.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry, child: _i15.ProfilePersonalPage());
    },
    ProfileGymProfilesRoute.name: (entry) {
      return _i1.CupertinoPageX(
          entry: entry, child: _i16.ProfileGymProfilesPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(GlobalRoute.name,
            path: '/',
            usesTabsRouter: true,
            children: [
              _i1.RouteConfig(HomeStack.name, path: 'home', children: [
                _i1.RouteConfig(HomeRoute.name, path: ''),
                _i1.RouteConfig(YourCollectionsRoute.name,
                    path: 'your-collections'),
                _i1.RouteConfig(YourWorkoutsRoute.name, path: 'your-workouts'),
                _i1.RouteConfig(YourPlansRoute.name, path: 'your-plans'),
                _i1.RouteConfig(YourEventsRoute.name, path: 'your-events'),
                _i1.RouteConfig('*#redirect',
                    path: '*', redirectTo: '', fullMatch: true)
              ]),
              _i1.RouteConfig(DiscoverRoute.name,
                  path: 'discover',
                  usesTabsRouter: true,
                  children: [
                    _i1.RouteConfig(DiscoverYouRoute.name, path: 'you'),
                    _i1.RouteConfig(DiscoverWorkoutsRoute.name,
                        path: 'workouts'),
                    _i1.RouteConfig(DiscoverPlansRoute.name, path: 'plans'),
                    _i1.RouteConfig('*#redirect',
                        path: '*', redirectTo: 'personal', fullMatch: true)
                  ]),
              _i1.RouteConfig(SocialRoute.name, path: 'social'),
              _i1.RouteConfig(JournalRoute.name, path: 'journal'),
              _i1.RouteConfig(ProfileRoute.name,
                  path: 'profile',
                  usesTabsRouter: true,
                  children: [
                    _i1.RouteConfig(ProfilePersonalRoute.name,
                        path: 'personal'),
                    _i1.RouteConfig(ProfileGymProfilesRoute.name,
                        path: 'gym-profiles'),
                    _i1.RouteConfig('*#redirect',
                        path: '*', redirectTo: 'personal', fullMatch: true)
                  ])
            ]),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class GlobalRoute extends _i1.PageRouteInfo {
  const GlobalRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'GlobalRoute';
}

class HomeStack extends _i1.PageRouteInfo {
  const HomeStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'home', initialChildren: children);

  static const String name = 'HomeStack';
}

class DiscoverRoute extends _i1.PageRouteInfo {
  const DiscoverRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'discover', initialChildren: children);

  static const String name = 'DiscoverRoute';
}

class SocialRoute extends _i1.PageRouteInfo {
  const SocialRoute() : super(name, path: 'social');

  static const String name = 'SocialRoute';
}

class JournalRoute extends _i1.PageRouteInfo {
  const JournalRoute() : super(name, path: 'journal');

  static const String name = 'JournalRoute';
}

class ProfileRoute extends _i1.PageRouteInfo {
  const ProfileRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '');

  static const String name = 'HomeRoute';
}

class YourCollectionsRoute extends _i1.PageRouteInfo {
  const YourCollectionsRoute() : super(name, path: 'your-collections');

  static const String name = 'YourCollectionsRoute';
}

class YourWorkoutsRoute extends _i1.PageRouteInfo {
  const YourWorkoutsRoute() : super(name, path: 'your-workouts');

  static const String name = 'YourWorkoutsRoute';
}

class YourPlansRoute extends _i1.PageRouteInfo {
  const YourPlansRoute() : super(name, path: 'your-plans');

  static const String name = 'YourPlansRoute';
}

class YourEventsRoute extends _i1.PageRouteInfo {
  const YourEventsRoute() : super(name, path: 'your-events');

  static const String name = 'YourEventsRoute';
}

class DiscoverYouRoute extends _i1.PageRouteInfo {
  const DiscoverYouRoute() : super(name, path: 'you');

  static const String name = 'DiscoverYouRoute';
}

class DiscoverWorkoutsRoute extends _i1.PageRouteInfo {
  const DiscoverWorkoutsRoute() : super(name, path: 'workouts');

  static const String name = 'DiscoverWorkoutsRoute';
}

class DiscoverPlansRoute extends _i1.PageRouteInfo {
  const DiscoverPlansRoute() : super(name, path: 'plans');

  static const String name = 'DiscoverPlansRoute';
}

class ProfilePersonalRoute extends _i1.PageRouteInfo {
  const ProfilePersonalRoute() : super(name, path: 'personal');

  static const String name = 'ProfilePersonalRoute';
}

class ProfileGymProfilesRoute extends _i1.PageRouteInfo {
  const ProfileGymProfilesRoute() : super(name, path: 'gym-profiles');

  static const String name = 'ProfileGymProfilesRoute';
}
