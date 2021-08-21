// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i57;
import 'package:flutter/material.dart' as _i2;

import 'components/creators/club_creator/club_creator.dart' as _i22;
import 'components/creators/logged_workout_creator/logged_workout_creator.dart'
    as _i29;
import 'components/creators/personal_best_creator/personal_best_creator.dart'
    as _i24;
import 'components/creators/post_creator/post_creator.dart' as _i25;
import 'components/creators/post_creator/post_editor.dart' as _i26;
import 'components/creators/progress_journal_creator/progress_journal_creator.dart'
    as _i23;
import 'components/creators/workout_creator/workout_creator.dart' as _i27;
import 'components/creators/workout_plan_creator/workout_plan_creator.dart'
    as _i28;
import 'components/do_workout/do_workout/do_workout_do_workout_page.dart'
    as _i55;
import 'components/do_workout/do_workout_log_workout_page.dart' as _i56;
import 'components/do_workout/do_workout_wrapper_page.dart' as _i10;
import 'components/social/chats_overview_page.dart' as _i6;
import 'components/social/feeds_and_follows/model.dart' as _i59;
import 'components/social/one_to_one_chat_page.dart' as _i7;
import 'components/workout/workout_finder/workout_finder.dart' as _i12;
import 'components/workout_plan/workout_plan_finder/workout_plan_finder.dart'
    as _i13;
import 'generated/api/graphql_api.dart' as _i58;
import 'pages/authed/authed_routes_wrapper_page.dart' as _i4;
import 'pages/authed/details_pages/club_details_page.dart' as _i14;
import 'pages/authed/details_pages/collection_details_page.dart' as _i9;
import 'pages/authed/details_pages/logged_workout_details_page.dart' as _i15;
import 'pages/authed/details_pages/personal_best_details_page.dart' as _i16;
import 'pages/authed/details_pages/progress_journal_details_page.dart' as _i18;
import 'pages/authed/details_pages/user_public_profile_details_page.dart'
    as _i17;
import 'pages/authed/details_pages/workout_details_page.dart' as _i19;
import 'pages/authed/details_pages/workout_plan_details_page.dart' as _i20;
import 'pages/authed/details_pages/workout_plan_enrolment_details_page.dart'
    as _i21;
import 'pages/authed/discover/discover_challenges_page.dart' as _i43;
import 'pages/authed/discover/discover_clubs_page.dart' as _i44;
import 'pages/authed/discover/discover_page.dart' as _i40;
import 'pages/authed/discover/discover_plans_page.dart' as _i42;
import 'pages/authed/discover/discover_workouts_page.dart' as _i41;
import 'pages/authed/home/home_page.dart' as _i32;
import 'pages/authed/home/your_challenges.dart' as _i34;
import 'pages/authed/home/your_clubs.dart' as _i35;
import 'pages/authed/home/your_collections.dart' as _i33;
import 'pages/authed/home/your_events.dart' as _i36;
import 'pages/authed/home/your_plans/your_plans.dart' as _i37;
import 'pages/authed/home/your_schedule.dart' as _i38;
import 'pages/authed/home/your_workouts/your_workouts.dart' as _i39;
import 'pages/authed/landing_pages/club_invite_landing_page.dart' as _i8;
import 'pages/authed/main_tabs_page.dart' as _i5;
import 'pages/authed/profile/custom_moves_page.dart' as _i54;
import 'pages/authed/profile/gym_profiles.dart' as _i53;
import 'pages/authed/profile/personal_page.dart' as _i52;
import 'pages/authed/profile/profile_page.dart' as _i31;
import 'pages/authed/profile/settings.dart' as _i11;
import 'pages/authed/progress/body_transformation_page.dart' as _i50;
import 'pages/authed/progress/journals_page.dart' as _i49;
import 'pages/authed/progress/logged_workouts_page.dart' as _i51;
import 'pages/authed/progress/personal_bests_page.dart' as _i48;
import 'pages/authed/progress/progress_page.dart' as _i47;
import 'pages/authed/social/discover_people_page.dart' as _i46;
import 'pages/authed/social/social_page.dart' as _i45;
import 'pages/unauthed/unauthed_landing.dart' as _i3;
import 'router.dart' as _i30;

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
          return _i4.AuthedRoutesWrapperPage();
        }),
    MainTabsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.MainTabsPage();
        }),
    ChatsOverviewRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.ChatsOverviewPage();
        }),
    OneToOneChatRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<OneToOneChatRouteArgs>();
          return _i7.OneToOneChatPage(
              key: args.key, otherUserId: args.otherUserId);
        }),
    ClubInviteLandingRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ClubInviteLandingRouteArgs>(
              orElse: () =>
                  ClubInviteLandingRouteArgs(id: pathParams.getString('id')));
          return _i8.ClubInviteLandingPage(id: args.id);
        }),
    CollectionDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<CollectionDetailsRouteArgs>(
              orElse: () =>
                  CollectionDetailsRouteArgs(id: pathParams.getString('id')));
          return _i9.CollectionDetailsPage(key: args.key, id: args.id);
        }),
    DoWorkoutWrapperRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<DoWorkoutWrapperRouteArgs>(
              orElse: () =>
                  DoWorkoutWrapperRouteArgs(id: pathParams.getString('id')));
          return _i10.DoWorkoutWrapperPage(
              key: args.key,
              id: args.id,
              scheduledWorkoutId: args.scheduledWorkoutId);
        }),
    SettingsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i11.SettingsPage();
        }),
    WorkoutFinderRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WorkoutFinderRouteArgs>(
              orElse: () => const WorkoutFinderRouteArgs());
          return _i12.WorkoutFinderPage(
              selectWorkout: args.selectWorkout,
              initialOpenPublicTab: args.initialOpenPublicTab);
        }),
    WorkoutPlanFinderRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WorkoutPlanFinderRouteArgs>(
              orElse: () => const WorkoutPlanFinderRouteArgs());
          return _i13.WorkoutPlanFinderPage(
              initialOpenPublicTab: args.initialOpenPublicTab,
              selectWorkoutPlan: args.selectWorkoutPlan);
        }),
    ClubDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ClubDetailsRouteArgs>(
              orElse: () =>
                  ClubDetailsRouteArgs(id: pathParams.getString('id')));
          return _i14.ClubDetailsPage(id: args.id);
        }),
    LoggedWorkoutDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<LoggedWorkoutDetailsRouteArgs>(
              orElse: () => LoggedWorkoutDetailsRouteArgs(
                  id: pathParams.getString('id')));
          return _i15.LoggedWorkoutDetailsPage(id: args.id);
        }),
    PersonalBestDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<PersonalBestDetailsRouteArgs>(
              orElse: () =>
                  PersonalBestDetailsRouteArgs(id: pathParams.getString('id')));
          return _i16.PersonalBestDetailsPage(id: args.id);
        }),
    UserPublicProfileDetailsRoute.name: (routeData) =>
        _i1.CupertinoPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final pathParams = data.pathParams;
              final args = data.argsAs<UserPublicProfileDetailsRouteArgs>(
                  orElse: () => UserPublicProfileDetailsRouteArgs(
                      userId: pathParams.getString('userId')));
              return _i17.UserPublicProfileDetailsPage(userId: args.userId);
            }),
    ProgressJournalDetailsRoute.name: (routeData) =>
        _i1.CupertinoPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final pathParams = data.pathParams;
              final args = data.argsAs<ProgressJournalDetailsRouteArgs>(
                  orElse: () => ProgressJournalDetailsRouteArgs(
                      id: pathParams.getString('id')));
              return _i18.ProgressJournalDetailsPage(id: args.id);
            }),
    WorkoutDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<WorkoutDetailsRouteArgs>(
              orElse: () =>
                  WorkoutDetailsRouteArgs(id: pathParams.getString('id')));
          return _i19.WorkoutDetailsPage(id: args.id);
        }),
    WorkoutPlanDetailsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<WorkoutPlanDetailsRouteArgs>(
              orElse: () =>
                  WorkoutPlanDetailsRouteArgs(id: pathParams.getString('id')));
          return _i20.WorkoutPlanDetailsPage(id: args.id);
        }),
    WorkoutPlanEnrolmentDetailsRoute.name: (routeData) =>
        _i1.CupertinoPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final pathParams = data.pathParams;
              final args = data.argsAs<WorkoutPlanEnrolmentDetailsRouteArgs>(
                  orElse: () => WorkoutPlanEnrolmentDetailsRouteArgs(
                      id: pathParams.getString('id')));
              return _i21.WorkoutPlanEnrolmentDetailsPage(
                  key: args.key, id: args.id);
            }),
    ClubCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ClubCreatorRouteArgs>(
              orElse: () => const ClubCreatorRouteArgs());
          return _i22.ClubCreatorPage(key: args.key, club: args.club);
        }),
    ProgressJournalCreatorRoute.name: (routeData) =>
        _i1.CupertinoPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<ProgressJournalCreatorRouteArgs>(
                  orElse: () => const ProgressJournalCreatorRouteArgs());
              return _i23.ProgressJournalCreatorPage(
                  progressJournal: args.progressJournal);
            }),
    PersonalBestCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PersonalBestCreatorRouteArgs>(
              orElse: () => const PersonalBestCreatorRouteArgs());
          return _i24.PersonalBestCreatorPage(
              userBenchmark: args.userBenchmark);
        }),
    PostCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i25.PostCreatorPage();
        }),
    PostEditorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PostEditorRouteArgs>();
          return _i26.PostEditorPage(
              key: args.key,
              activityWithObjectData: args.activityWithObjectData);
        }),
    WorkoutCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WorkoutCreatorRouteArgs>(
              orElse: () => const WorkoutCreatorRouteArgs());
          return _i27.WorkoutCreatorPage(workout: args.workout);
        }),
    WorkoutPlanCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WorkoutPlanCreatorRouteArgs>(
              orElse: () => const WorkoutPlanCreatorRouteArgs());
          return _i28.WorkoutPlanCreatorPage(
              key: args.key, workoutPlan: args.workoutPlan);
        }),
    LoggedWorkoutCreatorRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<LoggedWorkoutCreatorRouteArgs>();
          return _i29.LoggedWorkoutCreatorPage(
              workout: args.workout, scheduledWorkout: args.scheduledWorkout);
        }),
    HomeStack.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i30.HeroEmptyRouterPage();
        }),
    DiscoverStack.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i30.HeroEmptyRouterPage();
        }),
    SocialStack.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i30.HeroEmptyRouterPage();
        }),
    ProgressStack.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i30.HeroEmptyRouterPage();
        }),
    ProfileRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i31.ProfilePage();
        }),
    HomeRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i32.HomePage();
        }),
    YourCollectionsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i33.YourCollectionsPage();
        }),
    YourChallengesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i34.YourChallengesPage();
        }),
    YourClubsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i35.YourClubsPage();
        }),
    YourEventsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i36.YourEventsPage();
        }),
    YourPlansRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i37.YourPlansPage();
        }),
    YourScheduleRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<YourScheduleRouteArgs>(
              orElse: () => const YourScheduleRouteArgs());
          return _i38.YourSchedulePage(openAtDate: args.openAtDate);
        }),
    YourWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i39.YourWorkoutsPage();
        }),
    DiscoverRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i40.DiscoverPage();
        }),
    DiscoverWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i41.DiscoverWorkoutsPage();
        }),
    DiscoverPlansRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i42.DiscoverPlansPage();
        }),
    DiscoverChallengesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i43.DiscoverChallengesPage();
        }),
    DiscoverClubsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i44.DiscoverClubsPage();
        }),
    SocialRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i45.SocialPage();
        }),
    DiscoverPeopleRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i46.DiscoverPeoplePage();
        }),
    ProgressRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i47.ProgressPage();
        }),
    PersonalBestsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i48.PersonalBestsPage();
        }),
    JournalsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i49.JournalsPage();
        }),
    BodyTransformationRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i50.BodyTransformationPage();
        }),
    LoggedWorkoutsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i51.LoggedWorkoutsPage();
        }),
    ProfilePersonalRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i52.ProfilePersonalPage();
        }),
    ProfileGymProfilesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i53.ProfileGymProfilesPage();
        }),
    ProfileCustomMovesRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i54.ProfileCustomMovesPage();
        }),
    DoWorkoutDoWorkoutRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DoWorkoutDoWorkoutRouteArgs>();
          return _i55.DoWorkoutDoWorkoutPage(
              key: args.key, workout: args.workout);
        }),
    DoWorkoutLogWorkoutRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DoWorkoutLogWorkoutRouteArgs>(
              orElse: () => const DoWorkoutLogWorkoutRouteArgs());
          return _i56.DoWorkoutLogWorkoutPage(
              key: args.key, scheduledWorkoutId: args.scheduledWorkoutId);
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
              _i1.RouteConfig(YourChallengesRoute.name,
                  path: 'your-challenges'),
              _i1.RouteConfig(YourClubsRoute.name, path: 'your-clubs'),
              _i1.RouteConfig(YourEventsRoute.name, path: 'your-events'),
              _i1.RouteConfig(YourPlansRoute.name, path: 'your-plans'),
              _i1.RouteConfig(YourScheduleRoute.name, path: 'your-schedule'),
              _i1.RouteConfig(YourWorkoutsRoute.name, path: 'your-workouts'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: '', fullMatch: true)
            ]),
            _i1.RouteConfig(DiscoverStack.name, path: 'discover', children: [
              _i1.RouteConfig(DiscoverRoute.name, path: ''),
              _i1.RouteConfig(DiscoverWorkoutsRoute.name,
                  path: 'discover-workouts'),
              _i1.RouteConfig(DiscoverPlansRoute.name, path: 'discover-plans'),
              _i1.RouteConfig(DiscoverChallengesRoute.name,
                  path: 'discover-challenges'),
              _i1.RouteConfig(DiscoverClubsRoute.name, path: 'discover-clubs'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: '', fullMatch: true)
            ]),
            _i1.RouteConfig(SocialStack.name, path: 'social', children: [
              _i1.RouteConfig(SocialRoute.name, path: ''),
              _i1.RouteConfig(DiscoverPeopleRoute.name,
                  path: 'discover-people'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: '', fullMatch: true)
            ]),
            _i1.RouteConfig(ProgressStack.name, path: 'progress', children: [
              _i1.RouteConfig(ProgressRoute.name, path: ''),
              _i1.RouteConfig(PersonalBestsRoute.name, path: 'personal-bests'),
              _i1.RouteConfig(JournalsRoute.name, path: 'journals'),
              _i1.RouteConfig(BodyTransformationRoute.name,
                  path: 'transformation'),
              _i1.RouteConfig(LoggedWorkoutsRoute.name, path: 'workout-logs'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: '', fullMatch: true)
            ]),
            _i1.RouteConfig(ProfileRoute.name, path: 'profile', children: [
              _i1.RouteConfig(ProfilePersonalRoute.name, path: 'personal'),
              _i1.RouteConfig(ProfileGymProfilesRoute.name,
                  path: 'gym-profiles'),
              _i1.RouteConfig(ProfileCustomMovesRoute.name,
                  path: 'custom-moves'),
              _i1.RouteConfig('*#redirect',
                  path: '*', redirectTo: 'personal', fullMatch: true)
            ])
          ]),
          _i1.RouteConfig(ChatsOverviewRoute.name, path: 'chats'),
          _i1.RouteConfig(OneToOneChatRoute.name, path: 'chat'),
          _i1.RouteConfig(ClubInviteLandingRoute.name, path: 'club-invite/:id'),
          _i1.RouteConfig(CollectionDetailsRoute.name, path: 'collection/:id'),
          _i1.RouteConfig(DoWorkoutWrapperRoute.name,
              path: 'do-workout/:id',
              children: [
                _i1.RouteConfig(DoWorkoutDoWorkoutRoute.name,
                    path: 'do-workout-do-workout-page'),
                _i1.RouteConfig(DoWorkoutLogWorkoutRoute.name,
                    path: 'do-workout-log-workout-page')
              ]),
          _i1.RouteConfig(SettingsRoute.name, path: 'settings'),
          _i1.RouteConfig(WorkoutFinderRoute.name, path: 'find-workout'),
          _i1.RouteConfig(WorkoutPlanFinderRoute.name, path: 'find-plan'),
          _i1.RouteConfig(ClubDetailsRoute.name, path: 'club/:id'),
          _i1.RouteConfig(LoggedWorkoutDetailsRoute.name,
              path: 'logged-workout/:id'),
          _i1.RouteConfig(PersonalBestDetailsRoute.name,
              path: 'personal-best/:id'),
          _i1.RouteConfig(UserPublicProfileDetailsRoute.name,
              path: 'profile/:userId'),
          _i1.RouteConfig(ProgressJournalDetailsRoute.name,
              path: 'progress-journal/:id'),
          _i1.RouteConfig(WorkoutDetailsRoute.name, path: 'workout/:id'),
          _i1.RouteConfig(WorkoutPlanDetailsRoute.name,
              path: 'workout-plan/:id'),
          _i1.RouteConfig(WorkoutPlanEnrolmentDetailsRoute.name,
              path: 'workout-plan-progress/:id'),
          _i1.RouteConfig(ClubCreatorRoute.name, path: 'create-club'),
          _i1.RouteConfig(ProgressJournalCreatorRoute.name,
              path: 'create-journal'),
          _i1.RouteConfig(PersonalBestCreatorRoute.name,
              path: 'create-personal-best'),
          _i1.RouteConfig(PostCreatorRoute.name, path: 'create-post'),
          _i1.RouteConfig(PostEditorRoute.name, path: 'edit-post'),
          _i1.RouteConfig(WorkoutCreatorRoute.name, path: 'create-workout'),
          _i1.RouteConfig(WorkoutPlanCreatorRoute.name,
              path: 'create-workout-plan'),
          _i1.RouteConfig(LoggedWorkoutCreatorRoute.name, path: 'log-workout'),
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

class ChatsOverviewRoute extends _i1.PageRouteInfo {
  const ChatsOverviewRoute() : super(name, path: 'chats');

  static const String name = 'ChatsOverviewRoute';
}

class OneToOneChatRoute extends _i1.PageRouteInfo<OneToOneChatRouteArgs> {
  OneToOneChatRoute({_i57.Key? key, required String otherUserId})
      : super(name,
            path: 'chat',
            args: OneToOneChatRouteArgs(key: key, otherUserId: otherUserId));

  static const String name = 'OneToOneChatRoute';
}

class OneToOneChatRouteArgs {
  const OneToOneChatRouteArgs({this.key, required this.otherUserId});

  final _i57.Key? key;

  final String otherUserId;
}

class ClubInviteLandingRoute
    extends _i1.PageRouteInfo<ClubInviteLandingRouteArgs> {
  ClubInviteLandingRoute({required String id})
      : super(name,
            path: 'club-invite/:id',
            args: ClubInviteLandingRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'ClubInviteLandingRoute';
}

class ClubInviteLandingRouteArgs {
  const ClubInviteLandingRouteArgs({required this.id});

  final String id;
}

class CollectionDetailsRoute
    extends _i1.PageRouteInfo<CollectionDetailsRouteArgs> {
  CollectionDetailsRoute({_i57.Key? key, required String id})
      : super(name,
            path: 'collection/:id',
            args: CollectionDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'CollectionDetailsRoute';
}

class CollectionDetailsRouteArgs {
  const CollectionDetailsRouteArgs({this.key, required this.id});

  final _i57.Key? key;

  final String id;
}

class DoWorkoutWrapperRoute
    extends _i1.PageRouteInfo<DoWorkoutWrapperRouteArgs> {
  DoWorkoutWrapperRoute(
      {_i57.Key? key,
      required String id,
      String? scheduledWorkoutId,
      List<_i1.PageRouteInfo>? children})
      : super(name,
            path: 'do-workout/:id',
            args: DoWorkoutWrapperRouteArgs(
                key: key, id: id, scheduledWorkoutId: scheduledWorkoutId),
            rawPathParams: {'id': id},
            initialChildren: children);

  static const String name = 'DoWorkoutWrapperRoute';
}

class DoWorkoutWrapperRouteArgs {
  const DoWorkoutWrapperRouteArgs(
      {this.key, required this.id, this.scheduledWorkoutId});

  final _i57.Key? key;

  final String id;

  final String? scheduledWorkoutId;
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: 'settings');

  static const String name = 'SettingsRoute';
}

class WorkoutFinderRoute extends _i1.PageRouteInfo<WorkoutFinderRouteArgs> {
  WorkoutFinderRoute(
      {void Function(_i58.Workout)? selectWorkout, bool? initialOpenPublicTab})
      : super(name,
            path: 'find-workout',
            args: WorkoutFinderRouteArgs(
                selectWorkout: selectWorkout,
                initialOpenPublicTab: initialOpenPublicTab));

  static const String name = 'WorkoutFinderRoute';
}

class WorkoutFinderRouteArgs {
  const WorkoutFinderRouteArgs({this.selectWorkout, this.initialOpenPublicTab});

  final void Function(_i58.Workout)? selectWorkout;

  final bool? initialOpenPublicTab;
}

class WorkoutPlanFinderRoute
    extends _i1.PageRouteInfo<WorkoutPlanFinderRouteArgs> {
  WorkoutPlanFinderRoute(
      {bool? initialOpenPublicTab,
      void Function(_i58.WorkoutPlan)? selectWorkoutPlan})
      : super(name,
            path: 'find-plan',
            args: WorkoutPlanFinderRouteArgs(
                initialOpenPublicTab: initialOpenPublicTab,
                selectWorkoutPlan: selectWorkoutPlan));

  static const String name = 'WorkoutPlanFinderRoute';
}

class WorkoutPlanFinderRouteArgs {
  const WorkoutPlanFinderRouteArgs(
      {this.initialOpenPublicTab, this.selectWorkoutPlan});

  final bool? initialOpenPublicTab;

  final void Function(_i58.WorkoutPlan)? selectWorkoutPlan;
}

class ClubDetailsRoute extends _i1.PageRouteInfo<ClubDetailsRouteArgs> {
  ClubDetailsRoute({required String id})
      : super(name,
            path: 'club/:id',
            args: ClubDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'ClubDetailsRoute';
}

class ClubDetailsRouteArgs {
  const ClubDetailsRouteArgs({required this.id});

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

class PersonalBestDetailsRoute
    extends _i1.PageRouteInfo<PersonalBestDetailsRouteArgs> {
  PersonalBestDetailsRoute({required String id})
      : super(name,
            path: 'personal-best/:id',
            args: PersonalBestDetailsRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'PersonalBestDetailsRoute';
}

class PersonalBestDetailsRouteArgs {
  const PersonalBestDetailsRouteArgs({required this.id});

  final String id;
}

class UserPublicProfileDetailsRoute
    extends _i1.PageRouteInfo<UserPublicProfileDetailsRouteArgs> {
  UserPublicProfileDetailsRoute({required String userId})
      : super(name,
            path: 'profile/:userId',
            args: UserPublicProfileDetailsRouteArgs(userId: userId),
            rawPathParams: {'userId': userId});

  static const String name = 'UserPublicProfileDetailsRoute';
}

class UserPublicProfileDetailsRouteArgs {
  const UserPublicProfileDetailsRouteArgs({required this.userId});

  final String userId;
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

class WorkoutPlanEnrolmentDetailsRoute
    extends _i1.PageRouteInfo<WorkoutPlanEnrolmentDetailsRouteArgs> {
  WorkoutPlanEnrolmentDetailsRoute({_i57.Key? key, required String id})
      : super(name,
            path: 'workout-plan-progress/:id',
            args: WorkoutPlanEnrolmentDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'WorkoutPlanEnrolmentDetailsRoute';
}

class WorkoutPlanEnrolmentDetailsRouteArgs {
  const WorkoutPlanEnrolmentDetailsRouteArgs({this.key, required this.id});

  final _i57.Key? key;

  final String id;
}

class ClubCreatorRoute extends _i1.PageRouteInfo<ClubCreatorRouteArgs> {
  ClubCreatorRoute({_i57.Key? key, _i58.Club? club})
      : super(name,
            path: 'create-club',
            args: ClubCreatorRouteArgs(key: key, club: club));

  static const String name = 'ClubCreatorRoute';
}

class ClubCreatorRouteArgs {
  const ClubCreatorRouteArgs({this.key, this.club});

  final _i57.Key? key;

  final _i58.Club? club;
}

class ProgressJournalCreatorRoute
    extends _i1.PageRouteInfo<ProgressJournalCreatorRouteArgs> {
  ProgressJournalCreatorRoute({_i58.ProgressJournal? progressJournal})
      : super(name,
            path: 'create-journal',
            args: ProgressJournalCreatorRouteArgs(
                progressJournal: progressJournal));

  static const String name = 'ProgressJournalCreatorRoute';
}

class ProgressJournalCreatorRouteArgs {
  const ProgressJournalCreatorRouteArgs({this.progressJournal});

  final _i58.ProgressJournal? progressJournal;
}

class PersonalBestCreatorRoute
    extends _i1.PageRouteInfo<PersonalBestCreatorRouteArgs> {
  PersonalBestCreatorRoute({_i58.UserBenchmark? userBenchmark})
      : super(name,
            path: 'create-personal-best',
            args: PersonalBestCreatorRouteArgs(userBenchmark: userBenchmark));

  static const String name = 'PersonalBestCreatorRoute';
}

class PersonalBestCreatorRouteArgs {
  const PersonalBestCreatorRouteArgs({this.userBenchmark});

  final _i58.UserBenchmark? userBenchmark;
}

class PostCreatorRoute extends _i1.PageRouteInfo {
  const PostCreatorRoute() : super(name, path: 'create-post');

  static const String name = 'PostCreatorRoute';
}

class PostEditorRoute extends _i1.PageRouteInfo<PostEditorRouteArgs> {
  PostEditorRoute(
      {_i57.Key? key,
      required _i59.ActivityWithObjectData activityWithObjectData})
      : super(name,
            path: 'edit-post',
            args: PostEditorRouteArgs(
                key: key, activityWithObjectData: activityWithObjectData));

  static const String name = 'PostEditorRoute';
}

class PostEditorRouteArgs {
  const PostEditorRouteArgs({this.key, required this.activityWithObjectData});

  final _i57.Key? key;

  final _i59.ActivityWithObjectData activityWithObjectData;
}

class WorkoutCreatorRoute extends _i1.PageRouteInfo<WorkoutCreatorRouteArgs> {
  WorkoutCreatorRoute({_i58.Workout? workout})
      : super(name,
            path: 'create-workout',
            args: WorkoutCreatorRouteArgs(workout: workout));

  static const String name = 'WorkoutCreatorRoute';
}

class WorkoutCreatorRouteArgs {
  const WorkoutCreatorRouteArgs({this.workout});

  final _i58.Workout? workout;
}

class WorkoutPlanCreatorRoute
    extends _i1.PageRouteInfo<WorkoutPlanCreatorRouteArgs> {
  WorkoutPlanCreatorRoute({_i57.Key? key, _i58.WorkoutPlan? workoutPlan})
      : super(name,
            path: 'create-workout-plan',
            args: WorkoutPlanCreatorRouteArgs(
                key: key, workoutPlan: workoutPlan));

  static const String name = 'WorkoutPlanCreatorRoute';
}

class WorkoutPlanCreatorRouteArgs {
  const WorkoutPlanCreatorRouteArgs({this.key, this.workoutPlan});

  final _i57.Key? key;

  final _i58.WorkoutPlan? workoutPlan;
}

class LoggedWorkoutCreatorRoute
    extends _i1.PageRouteInfo<LoggedWorkoutCreatorRouteArgs> {
  LoggedWorkoutCreatorRoute(
      {required _i58.Workout workout, _i58.ScheduledWorkout? scheduledWorkout})
      : super(name,
            path: 'log-workout',
            args: LoggedWorkoutCreatorRouteArgs(
                workout: workout, scheduledWorkout: scheduledWorkout));

  static const String name = 'LoggedWorkoutCreatorRoute';
}

class LoggedWorkoutCreatorRouteArgs {
  const LoggedWorkoutCreatorRouteArgs(
      {required this.workout, this.scheduledWorkout});

  final _i58.Workout workout;

  final _i58.ScheduledWorkout? scheduledWorkout;
}

class HomeStack extends _i1.PageRouteInfo {
  const HomeStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: '', initialChildren: children);

  static const String name = 'HomeStack';
}

class DiscoverStack extends _i1.PageRouteInfo {
  const DiscoverStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'discover', initialChildren: children);

  static const String name = 'DiscoverStack';
}

class SocialStack extends _i1.PageRouteInfo {
  const SocialStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'social', initialChildren: children);

  static const String name = 'SocialStack';
}

class ProgressStack extends _i1.PageRouteInfo {
  const ProgressStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'progress', initialChildren: children);

  static const String name = 'ProgressStack';
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

class YourChallengesRoute extends _i1.PageRouteInfo {
  const YourChallengesRoute() : super(name, path: 'your-challenges');

  static const String name = 'YourChallengesRoute';
}

class YourClubsRoute extends _i1.PageRouteInfo {
  const YourClubsRoute() : super(name, path: 'your-clubs');

  static const String name = 'YourClubsRoute';
}

class YourEventsRoute extends _i1.PageRouteInfo {
  const YourEventsRoute() : super(name, path: 'your-events');

  static const String name = 'YourEventsRoute';
}

class YourPlansRoute extends _i1.PageRouteInfo {
  const YourPlansRoute() : super(name, path: 'your-plans');

  static const String name = 'YourPlansRoute';
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

class YourWorkoutsRoute extends _i1.PageRouteInfo {
  const YourWorkoutsRoute() : super(name, path: 'your-workouts');

  static const String name = 'YourWorkoutsRoute';
}

class DiscoverRoute extends _i1.PageRouteInfo {
  const DiscoverRoute() : super(name, path: '');

  static const String name = 'DiscoverRoute';
}

class DiscoverWorkoutsRoute extends _i1.PageRouteInfo {
  const DiscoverWorkoutsRoute() : super(name, path: 'discover-workouts');

  static const String name = 'DiscoverWorkoutsRoute';
}

class DiscoverPlansRoute extends _i1.PageRouteInfo {
  const DiscoverPlansRoute() : super(name, path: 'discover-plans');

  static const String name = 'DiscoverPlansRoute';
}

class DiscoverChallengesRoute extends _i1.PageRouteInfo {
  const DiscoverChallengesRoute() : super(name, path: 'discover-challenges');

  static const String name = 'DiscoverChallengesRoute';
}

class DiscoverClubsRoute extends _i1.PageRouteInfo {
  const DiscoverClubsRoute() : super(name, path: 'discover-clubs');

  static const String name = 'DiscoverClubsRoute';
}

class SocialRoute extends _i1.PageRouteInfo {
  const SocialRoute() : super(name, path: '');

  static const String name = 'SocialRoute';
}

class DiscoverPeopleRoute extends _i1.PageRouteInfo {
  const DiscoverPeopleRoute() : super(name, path: 'discover-people');

  static const String name = 'DiscoverPeopleRoute';
}

class ProgressRoute extends _i1.PageRouteInfo {
  const ProgressRoute() : super(name, path: '');

  static const String name = 'ProgressRoute';
}

class PersonalBestsRoute extends _i1.PageRouteInfo {
  const PersonalBestsRoute() : super(name, path: 'personal-bests');

  static const String name = 'PersonalBestsRoute';
}

class JournalsRoute extends _i1.PageRouteInfo {
  const JournalsRoute() : super(name, path: 'journals');

  static const String name = 'JournalsRoute';
}

class BodyTransformationRoute extends _i1.PageRouteInfo {
  const BodyTransformationRoute() : super(name, path: 'transformation');

  static const String name = 'BodyTransformationRoute';
}

class LoggedWorkoutsRoute extends _i1.PageRouteInfo {
  const LoggedWorkoutsRoute() : super(name, path: 'workout-logs');

  static const String name = 'LoggedWorkoutsRoute';
}

class ProfilePersonalRoute extends _i1.PageRouteInfo {
  const ProfilePersonalRoute() : super(name, path: 'personal');

  static const String name = 'ProfilePersonalRoute';
}

class ProfileGymProfilesRoute extends _i1.PageRouteInfo {
  const ProfileGymProfilesRoute() : super(name, path: 'gym-profiles');

  static const String name = 'ProfileGymProfilesRoute';
}

class ProfileCustomMovesRoute extends _i1.PageRouteInfo {
  const ProfileCustomMovesRoute() : super(name, path: 'custom-moves');

  static const String name = 'ProfileCustomMovesRoute';
}

class DoWorkoutDoWorkoutRoute
    extends _i1.PageRouteInfo<DoWorkoutDoWorkoutRouteArgs> {
  DoWorkoutDoWorkoutRoute({_i57.Key? key, required _i58.Workout workout})
      : super(name,
            path: 'do-workout-do-workout-page',
            args: DoWorkoutDoWorkoutRouteArgs(key: key, workout: workout));

  static const String name = 'DoWorkoutDoWorkoutRoute';
}

class DoWorkoutDoWorkoutRouteArgs {
  const DoWorkoutDoWorkoutRouteArgs({this.key, required this.workout});

  final _i57.Key? key;

  final _i58.Workout workout;
}

class DoWorkoutLogWorkoutRoute
    extends _i1.PageRouteInfo<DoWorkoutLogWorkoutRouteArgs> {
  DoWorkoutLogWorkoutRoute({_i57.Key? key, String? scheduledWorkoutId})
      : super(name,
            path: 'do-workout-log-workout-page',
            args: DoWorkoutLogWorkoutRouteArgs(
                key: key, scheduledWorkoutId: scheduledWorkoutId));

  static const String name = 'DoWorkoutLogWorkoutRoute';
}

class DoWorkoutLogWorkoutRouteArgs {
  const DoWorkoutLogWorkoutRouteArgs({this.key, this.scheduledWorkoutId});

  final _i57.Key? key;

  final String? scheduledWorkoutId;
}
