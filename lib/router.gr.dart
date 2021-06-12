// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i38;
import 'package:flutter/material.dart' as _i2;

import 'components/user_input/creators/benchmark_creator/benchmark_creator.dart'
    as _i14;
import 'components/user_input/creators/logged_workout_creator/logged_workout_creator.dart'
    as _i15;
import 'components/user_input/creators/progress_journal/progress_journal_creator.dart'
    as _i13;
import 'components/user_input/creators/workout_creator/workout_creator.dart'
    as _i11;
import 'components/user_input/creators/workout_plan_creator/workout_plan_creator.dart'
    as _i12;
import 'components/workout/workout_finder/workout_finder.dart' as _i16;
import 'generated/api/graphql_api.dart' as _i37;
import 'pages/authed/app.dart' as _i5;
import 'pages/authed/details_pages/benchmark_details_page.dart' as _i10;
import 'pages/authed/details_pages/logged_workout_details_page.dart' as _i8;
import 'pages/authed/details_pages/progress_journal_details_page.dart' as _i9;
import 'pages/authed/details_pages/workout_details_page.dart' as _i6;
import 'pages/authed/details_pages/workout_plan_details_page.dart' as _i7;
import 'pages/authed/discover/discover_page.dart' as _i18;
import 'pages/authed/discover/plans.dart' as _i30;
import 'pages/authed/discover/workouts.dart' as _i29;
import 'pages/authed/home/home_page.dart' as _i21;
import 'pages/authed/home/your_clubs.dart' as _i26;
import 'pages/authed/home/your_collections.dart' as _i22;
import 'pages/authed/home/your_events.dart' as _i25;
import 'pages/authed/home/your_moves.dart' as _i27;
import 'pages/authed/home/your_plans.dart' as _i24;
import 'pages/authed/home/your_schedule.dart' as _i28;
import 'pages/authed/home/your_workouts.dart' as _i23;
import 'pages/authed/journal/journal_page.dart' as _i31;
import 'pages/authed/journal/your_benchmarks.dart' as _i32;
import 'pages/authed/journal/your_logged_workouts.dart' as _i33;
import 'pages/authed/journal/your_progress_journals.dart' as _i34;
import 'pages/authed/profile/gym_profiles.dart' as _i36;
import 'pages/authed/profile/personal_page.dart' as _i35;
import 'pages/authed/profile/profile_page.dart' as _i20;
import 'pages/authed/profile/settings.dart' as _i17;
import 'pages/authed/social/social_page.dart' as _i19;
import 'pages/unauthed/unauthed_landing.dart' as _i3;
import 'router.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    UnauthedLandingRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.UnauthedLandingPage();
        }),
    AuthedRouter.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HeroEmptyRouterPage();
        }),
    MainTabsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.MainTabsPage();
        }),
    WorkoutDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<WorkoutDetailsRouteArgs>(
              orElse: () =>
                  WorkoutDetailsRouteArgs(id: pathParams.getString('id')));
          return _i6.WorkoutDetailsPage(id: args.id);
        }),
    WorkoutPlanDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<WorkoutPlanDetailsRouteArgs>(
              orElse: () =>
                  WorkoutPlanDetailsRouteArgs(id: pathParams.getString('id')));
          return _i7.WorkoutPlanDetailsPage(id: args.id);
        }),
    LoggedWorkoutDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<LoggedWorkoutDetailsRouteArgs>(
              orElse: () => LoggedWorkoutDetailsRouteArgs(
                  id: pathParams.getString('id')));
          return _i8.LoggedWorkoutDetailsPage(id: args.id);
        }),
    ProgressJournalDetailsRoute.name: (routeData) =>
        _i1.CupertinoPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final pathParams = data.pathParams;
              final args = data.argsAs<ProgressJournalDetailsRouteArgs>(
                  orElse: () => ProgressJournalDetailsRouteArgs(
                      id: pathParams.getString('id')));
              return _i9.ProgressJournalDetailsPage(id: args.id);
            }),
    BenchmarkDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<BenchmarkDetailsRouteArgs>(
              orElse: () =>
                  BenchmarkDetailsRouteArgs(id: pathParams.getString('id')));
          return _i10.BenchmarkDetailsPage(id: args.id);
        }),
    WorkoutCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WorkoutCreatorRouteArgs>(
              orElse: () => const WorkoutCreatorRouteArgs());
          return _i11.WorkoutCreatorPage(workout: args.workout);
        }),
    WorkoutPlanCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WorkoutPlanCreatorRouteArgs>(
              orElse: () => const WorkoutPlanCreatorRouteArgs());
          return _i12.WorkoutPlanCreatorPage(
              key: args.key, workoutPlan: args.workoutPlan);
        }),
    ProgressJournalCreatorRoute.name: (routeData) =>
        _i1.CupertinoPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<ProgressJournalCreatorRouteArgs>(
                  orElse: () => const ProgressJournalCreatorRouteArgs());
              return _i13.ProgressJournalCreatorPage(
                  progressJournal: args.progressJournal);
            }),
    BenchmarkCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<BenchmarkCreatorRouteArgs>(
              orElse: () => const BenchmarkCreatorRouteArgs());
          return _i14.BenchmarkCreatorPage(userBenchmark: args.userBenchmark);
        }),
    LoggedWorkoutCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<LoggedWorkoutCreatorRouteArgs>();
          return _i15.LoggedWorkoutCreatorPage(
              workout: args.workout, scheduledWorkout: args.scheduledWorkout);
        }),
    WorkoutFinderRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WorkoutFinderRouteArgs>();
          return _i16.WorkoutFinderPage(selectWorkout: args.selectWorkout);
        }),
    SettingsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i17.SettingsPage();
        }),
    HomeStack.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HeroEmptyRouterPage();
        }),
    DiscoverRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i18.DiscoverPage();
        }),
    SocialRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i19.SocialPage();
        }),
    JournalStack.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HeroEmptyRouterPage();
        }),
    ProfileRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i20.ProfilePage();
        }),
    HomeRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i21.HomePage();
        }),
    YourCollectionsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i22.YourCollectionsPage();
        }),
    YourWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i23.YourWorkoutsPage();
        }),
    YourPlansRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i24.YourPlansPage();
        }),
    YourEventsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i25.YourEventsPage();
        }),
    YourClubsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i26.YourClubsPage();
        }),
    YourMovesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i27.YourMovesPage();
        }),
    YourScheduleRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<YourScheduleRouteArgs>(
              orElse: () => const YourScheduleRouteArgs());
          return _i28.YourSchedulePage(openAtDate: args.openAtDate);
        }),
    DiscoverWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i29.DiscoverWorkoutsPage();
        }),
    DiscoverPlansRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i30.DiscoverPlansPage();
        }),
    JournalRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i31.JournalPage();
        }),
    YourBenchmarksRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i32.YourBenchmarksPage();
        }),
    YourLoggedWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i33.YourLoggedWorkoutsPage();
        }),
    YourProgressJournalsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i34.YourProgressJournalsPage();
        }),
    ProfilePersonalRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i35.ProfilePersonalPage();
        }),
    ProfileGymProfilesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i36.ProfileGymProfilesPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(UnauthedLandingRoute.name, path: '/auth'),
        _i1.RouteConfig(AuthedRouter.name, path: '/', children: [
          _i1.RouteConfig(MainTabsRoute.name, path: '', children: [
            _i1.RouteConfig(HomeStack.name, path: '', children: [
              _i1.RouteConfig(HomeRoute.name, path: ''),
              _i1.RouteConfig(YourCollectionsRoute.name,
                  path: 'your-collections'),
              _i1.RouteConfig(YourWorkoutsRoute.name, path: 'your-workouts'),
              _i1.RouteConfig(YourPlansRoute.name, path: 'your-plans'),
              _i1.RouteConfig(YourEventsRoute.name, path: 'your-events'),
              _i1.RouteConfig(YourClubsRoute.name, path: 'your-clubs'),
              _i1.RouteConfig(YourMovesRoute.name, path: 'your-moves'),
              _i1.RouteConfig(YourScheduleRoute.name, path: 'your-schedule'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: '', fullMatch: true)
            ]),
            _i1.RouteConfig(DiscoverRoute.name, path: 'discover', children: [
              _i1.RouteConfig(DiscoverWorkoutsRoute.name, path: 'workouts'),
              _i1.RouteConfig(DiscoverPlansRoute.name, path: 'plans'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: 'you', fullMatch: true)
            ]),
            _i1.RouteConfig(SocialRoute.name, path: 'social'),
            _i1.RouteConfig(JournalStack.name, path: 'journal', children: [
              _i1.RouteConfig(JournalRoute.name, path: ''),
              _i1.RouteConfig(YourBenchmarksRoute.name,
                  path: 'your-benchmarks'),
              _i1.RouteConfig(YourLoggedWorkoutsRoute.name,
                  path: 'your-logged-workouts'),
              _i1.RouteConfig(YourProgressJournalsRoute.name,
                  path: 'your-progress-journals'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: '', fullMatch: true)
            ]),
            _i1.RouteConfig(ProfileRoute.name, path: 'profile', children: [
              _i1.RouteConfig(ProfilePersonalRoute.name, path: 'personal'),
              _i1.RouteConfig(ProfileGymProfilesRoute.name,
                  path: 'gym-profiles'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: 'personal', fullMatch: true)
            ])
          ]),
          _i1.RouteConfig(WorkoutDetailsRoute.name, path: 'workout/:id'),
          _i1.RouteConfig(WorkoutPlanDetailsRoute.name,
              path: 'workout-plan/:id'),
          _i1.RouteConfig(LoggedWorkoutDetailsRoute.name,
              path: 'logged-workout/:id'),
          _i1.RouteConfig(ProgressJournalDetailsRoute.name,
              path: 'progress-journal/:id'),
          _i1.RouteConfig(BenchmarkDetailsRoute.name, path: 'benchmark/:id'),
          _i1.RouteConfig(WorkoutCreatorRoute.name, path: 'create-workout'),
          _i1.RouteConfig(WorkoutPlanCreatorRoute.name,
              path: 'create-workout-plan'),
          _i1.RouteConfig(ProgressJournalCreatorRoute.name,
              path: 'create-journal'),
          _i1.RouteConfig(BenchmarkCreatorRoute.name, path: 'create-benchmark'),
          _i1.RouteConfig(LoggedWorkoutCreatorRoute.name, path: 'log-workout'),
          _i1.RouteConfig(WorkoutFinderRoute.name, path: 'find-workout'),
          _i1.RouteConfig(SettingsRoute.name, path: 'settings'),
          _i1.RouteConfig('*#redirect',
              path: '*', redirectTo: '/', fullMatch: true)
        ])
      ];
}

class UnauthedLandingRoute extends _i1.PageRouteInfo {
  const UnauthedLandingRoute() : super(name, path: '/auth');

  static const String name = 'UnauthedLandingRoute';
}

class AuthedRouter extends _i1.PageRouteInfo {
  const AuthedRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'AuthedRouter';
}

class MainTabsRoute extends _i1.PageRouteInfo {
  const MainTabsRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '', initialChildren: children);

  static const String name = 'MainTabsRoute';
}

class WorkoutDetailsRoute extends _i1.PageRouteInfo<WorkoutDetailsRouteArgs> {
  WorkoutDetailsRoute({required String id})
      : super(name,
            path: 'workout/:id',
            args: WorkoutDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'WorkoutDetailsRoute';
}

class WorkoutDetailsRouteArgs {
  const WorkoutDetailsRouteArgs({required this.id});

  final String id;
}

class WorkoutPlanDetailsRoute
    extends _i1.PageRouteInfo<WorkoutPlanDetailsRouteArgs> {
  WorkoutPlanDetailsRoute({required String id})
      : super(name,
            path: 'workout-plan/:id',
            args: WorkoutPlanDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'WorkoutPlanDetailsRoute';
}

class WorkoutPlanDetailsRouteArgs {
  const WorkoutPlanDetailsRouteArgs({required this.id});

  final String id;
}

class LoggedWorkoutDetailsRoute
    extends _i1.PageRouteInfo<LoggedWorkoutDetailsRouteArgs> {
  LoggedWorkoutDetailsRoute({required String id})
      : super(name,
            path: 'logged-workout/:id',
            args: LoggedWorkoutDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'LoggedWorkoutDetailsRoute';
}

class LoggedWorkoutDetailsRouteArgs {
  const LoggedWorkoutDetailsRouteArgs({required this.id});

  final String id;
}

class ProgressJournalDetailsRoute
    extends _i1.PageRouteInfo<ProgressJournalDetailsRouteArgs> {
  ProgressJournalDetailsRoute({required String id})
      : super(name,
            path: 'progress-journal/:id',
            args: ProgressJournalDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'ProgressJournalDetailsRoute';
}

class ProgressJournalDetailsRouteArgs {
  const ProgressJournalDetailsRouteArgs({required this.id});

  final String id;
}

class BenchmarkDetailsRoute
    extends _i1.PageRouteInfo<BenchmarkDetailsRouteArgs> {
  BenchmarkDetailsRoute({required String id})
      : super(name,
            path: 'benchmark/:id',
            args: BenchmarkDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'BenchmarkDetailsRoute';
}

class BenchmarkDetailsRouteArgs {
  const BenchmarkDetailsRouteArgs({required this.id});

  final String id;
}

class WorkoutCreatorRoute extends _i1.PageRouteInfo<WorkoutCreatorRouteArgs> {
  WorkoutCreatorRoute({_i37.Workout? workout})
      : super(name,
            path: 'create-workout',
            args: WorkoutCreatorRouteArgs(workout: workout));

  static const String name = 'WorkoutCreatorRoute';
}

class WorkoutCreatorRouteArgs {
  const WorkoutCreatorRouteArgs({this.workout});

  final _i37.Workout? workout;
}

class WorkoutPlanCreatorRoute
    extends _i1.PageRouteInfo<WorkoutPlanCreatorRouteArgs> {
  WorkoutPlanCreatorRoute({_i38.Key? key, _i37.WorkoutPlan? workoutPlan})
      : super(name,
            path: 'create-workout-plan',
            args: WorkoutPlanCreatorRouteArgs(
                key: key, workoutPlan: workoutPlan));

  static const String name = 'WorkoutPlanCreatorRoute';
}

class WorkoutPlanCreatorRouteArgs {
  const WorkoutPlanCreatorRouteArgs({this.key, this.workoutPlan});

  final _i38.Key? key;

  final _i37.WorkoutPlan? workoutPlan;
}

class ProgressJournalCreatorRoute
    extends _i1.PageRouteInfo<ProgressJournalCreatorRouteArgs> {
  ProgressJournalCreatorRoute({_i37.ProgressJournal? progressJournal})
      : super(name,
            path: 'create-journal',
            args: ProgressJournalCreatorRouteArgs(
                progressJournal: progressJournal));

  static const String name = 'ProgressJournalCreatorRoute';
}

class ProgressJournalCreatorRouteArgs {
  const ProgressJournalCreatorRouteArgs({this.progressJournal});

  final _i37.ProgressJournal? progressJournal;
}

class BenchmarkCreatorRoute
    extends _i1.PageRouteInfo<BenchmarkCreatorRouteArgs> {
  BenchmarkCreatorRoute({_i37.UserBenchmark? userBenchmark})
      : super(name,
            path: 'create-benchmark',
            args: BenchmarkCreatorRouteArgs(userBenchmark: userBenchmark));

  static const String name = 'BenchmarkCreatorRoute';
}

class BenchmarkCreatorRouteArgs {
  const BenchmarkCreatorRouteArgs({this.userBenchmark});

  final _i37.UserBenchmark? userBenchmark;
}

class LoggedWorkoutCreatorRoute
    extends _i1.PageRouteInfo<LoggedWorkoutCreatorRouteArgs> {
  LoggedWorkoutCreatorRoute(
      {required _i37.Workout workout, _i37.ScheduledWorkout? scheduledWorkout})
      : super(name,
            path: 'log-workout',
            args: LoggedWorkoutCreatorRouteArgs(
                workout: workout, scheduledWorkout: scheduledWorkout));

  static const String name = 'LoggedWorkoutCreatorRoute';
}

class LoggedWorkoutCreatorRouteArgs {
  const LoggedWorkoutCreatorRouteArgs(
      {required this.workout, this.scheduledWorkout});

  final _i37.Workout workout;

  final _i37.ScheduledWorkout? scheduledWorkout;
}

class WorkoutFinderRoute extends _i1.PageRouteInfo<WorkoutFinderRouteArgs> {
  WorkoutFinderRoute({required void Function(_i37.Workout) selectWorkout})
      : super(name,
            path: 'find-workout',
            args: WorkoutFinderRouteArgs(selectWorkout: selectWorkout));

  static const String name = 'WorkoutFinderRoute';
}

class WorkoutFinderRouteArgs {
  const WorkoutFinderRouteArgs({required this.selectWorkout});

  final void Function(_i37.Workout) selectWorkout;
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: 'settings');

  static const String name = 'SettingsRoute';
}

class HomeStack extends _i1.PageRouteInfo {
  const HomeStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: '', initialChildren: children);

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

class JournalStack extends _i1.PageRouteInfo {
  const JournalStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'journal', initialChildren: children);

  static const String name = 'JournalStack';
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

class YourScheduleRoute extends _i1.PageRouteInfo<YourScheduleRouteArgs> {
  YourScheduleRoute({DateTime? openAtDate})
      : super(name,
            path: 'your-schedule',
            args: YourScheduleRouteArgs(openAtDate: openAtDate));

  static const String name = 'YourScheduleRoute';
}

class YourScheduleRouteArgs {
  const YourScheduleRouteArgs({this.openAtDate});

  final DateTime? openAtDate;
}

class DiscoverWorkoutsRoute extends _i1.PageRouteInfo {
  const DiscoverWorkoutsRoute() : super(name, path: 'workouts');

  static const String name = 'DiscoverWorkoutsRoute';
}

class DiscoverPlansRoute extends _i1.PageRouteInfo {
  const DiscoverPlansRoute() : super(name, path: 'plans');

  static const String name = 'DiscoverPlansRoute';
}

class JournalRoute extends _i1.PageRouteInfo {
  const JournalRoute() : super(name, path: '');

  static const String name = 'JournalRoute';
}

class YourBenchmarksRoute extends _i1.PageRouteInfo {
  const YourBenchmarksRoute() : super(name, path: 'your-benchmarks');

  static const String name = 'YourBenchmarksRoute';
}

class YourLoggedWorkoutsRoute extends _i1.PageRouteInfo {
  const YourLoggedWorkoutsRoute() : super(name, path: 'your-logged-workouts');

  static const String name = 'YourLoggedWorkoutsRoute';
}

class YourProgressJournalsRoute extends _i1.PageRouteInfo {
  const YourProgressJournalsRoute()
      : super(name, path: 'your-progress-journals');

  static const String name = 'YourProgressJournalsRoute';
}

class ProfilePersonalRoute extends _i1.PageRouteInfo {
  const ProfilePersonalRoute() : super(name, path: 'personal');

  static const String name = 'ProfilePersonalRoute';
}

class ProfileGymProfilesRoute extends _i1.PageRouteInfo {
  const ProfileGymProfilesRoute() : super(name, path: 'gym-profiles');

  static const String name = 'ProfileGymProfilesRoute';
}
