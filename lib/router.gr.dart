// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'pages/authed/app.dart' as _i3;
import 'pages/authed/details_pages/workout_details_page.dart' as _i4;
import 'pages/authed/discover/discover_page.dart' as _i6;
import 'pages/authed/discover/plans.dart' as _i19;
import 'pages/authed/discover/workouts.dart' as _i18;
import 'pages/authed/discover/you.dart' as _i17;
import 'pages/authed/home/home_page.dart' as _i10;
import 'pages/authed/home/your_clubs.dart' as _i15;
import 'pages/authed/home/your_collections.dart' as _i11;
import 'pages/authed/home/your_events.dart' as _i14;
import 'pages/authed/home/your_moves.dart' as _i16;
import 'pages/authed/home/your_plans.dart' as _i13;
import 'pages/authed/home/your_schedule.dart' as _i5;
import 'pages/authed/home/your_workouts.dart' as _i12;
import 'pages/authed/journal/journal_page.dart' as _i8;
import 'pages/authed/profile/gym_profiles.dart' as _i21;
import 'pages/authed/profile/personal_page.dart' as _i20;
import 'pages/authed/profile/profile_page.dart' as _i9;
import 'pages/authed/social/social_page.dart' as _i7;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    GlobalRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.GlobalPage();
        }),
    WorkoutDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<WorkoutDetailsRouteArgs>(
              orElse: () =>
                  WorkoutDetailsRouteArgs(id: pathParams.getString('id')));
          return _i4.WorkoutDetailsPage(id: args.id);
        }),
    YourScheduleRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.YourSchedulePage();
        }),
    HomeStack.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    DiscoverRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.DiscoverPage();
        }),
    SocialRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.SocialPage();
        }),
    JournalRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.JournalPage();
        }),
    ProfileRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.ProfilePage();
        }),
    HomeRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i10.HomePage();
        }),
    YourCollectionsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i11.YourCollectionsPage();
        }),
    YourWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.YourWorkoutsPage();
        }),
    YourPlansRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i13.YourPlansPage();
        }),
    YourEventsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i14.YourEventsPage();
        }),
    YourClubsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i15.YourClubsPage();
        }),
    YourMovesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i16.YourMovesPage();
        }),
    DiscoverYouRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i17.DiscoverYouPage();
        }),
    DiscoverWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i18.DiscoverWorkoutsPage();
        }),
    DiscoverPlansRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i19.DiscoverPlansPage();
        }),
    ProfilePersonalRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i20.ProfilePersonalPage();
        }),
    ProfileGymProfilesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i21.ProfileGymProfilesPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(GlobalRoute.name, path: '/', children: [
          _i1.RouteConfig(HomeStack.name, path: 'home', children: [
            _i1.RouteConfig(HomeRoute.name, path: ''),
            _i1.RouteConfig(YourCollectionsRoute.name,
                path: 'your-collections'),
            _i1.RouteConfig(YourWorkoutsRoute.name, path: 'your-workouts'),
            _i1.RouteConfig(YourPlansRoute.name, path: 'your-plans'),
            _i1.RouteConfig(YourEventsRoute.name, path: 'your-events'),
            _i1.RouteConfig(YourClubsRoute.name, path: 'your-clubs'),
            _i1.RouteConfig(YourMovesRoute.name, path: 'your-moves'),
            _i1.RouteConfig('*#redirect',
                path: '*', redirectTo: '', fullMatch: true)
          ]),
          _i1.RouteConfig(DiscoverRoute.name, path: 'discover', children: [
            _i1.RouteConfig(DiscoverYouRoute.name, path: 'you'),
            _i1.RouteConfig(DiscoverWorkoutsRoute.name, path: 'workouts'),
            _i1.RouteConfig(DiscoverPlansRoute.name, path: 'plans'),
            _i1.RouteConfig('*#redirect',
                path: '*', redirectTo: 'personal', fullMatch: true)
          ]),
          _i1.RouteConfig(SocialRoute.name, path: 'social'),
          _i1.RouteConfig(JournalRoute.name, path: 'journal'),
          _i1.RouteConfig(ProfileRoute.name, path: 'profile', children: [
            _i1.RouteConfig(ProfilePersonalRoute.name, path: 'personal'),
            _i1.RouteConfig(ProfileGymProfilesRoute.name, path: 'gym-profiles'),
            _i1.RouteConfig('*#redirect',
                path: '*', redirectTo: 'personal', fullMatch: true)
          ])
        ]),
        _i1.RouteConfig(WorkoutDetailsRoute.name, path: '/workout/:id'),
        _i1.RouteConfig(YourScheduleRoute.name, path: 'your-schedule'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class GlobalRoute extends _i1.PageRouteInfo {
  const GlobalRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'GlobalRoute';
}

class WorkoutDetailsRoute extends _i1.PageRouteInfo<WorkoutDetailsRouteArgs> {
  WorkoutDetailsRoute({required String id})
      : super(name,
            path: '/workout/:id',
            args: WorkoutDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'WorkoutDetailsRoute';
}

class WorkoutDetailsRouteArgs {
  const WorkoutDetailsRouteArgs({required this.id});

  final String id;
}

class YourScheduleRoute extends _i1.PageRouteInfo {
  const YourScheduleRoute() : super(name, path: 'your-schedule');

  static const String name = 'YourScheduleRoute';
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

class YourClubsRoute extends _i1.PageRouteInfo {
  const YourClubsRoute() : super(name, path: 'your-clubs');

  static const String name = 'YourClubsRoute';
}

class YourMovesRoute extends _i1.PageRouteInfo {
  const YourMovesRoute() : super(name, path: 'your-moves');

  static const String name = 'YourMovesRoute';
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
