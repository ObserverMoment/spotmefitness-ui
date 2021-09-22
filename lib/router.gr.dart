// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i63;
import 'package:flutter/material.dart' as _i2;

import 'components/creators/club_creator/club_creator.dart' as _i23;
import 'components/creators/collection_creator.dart' as _i24;
import 'components/creators/custom_move_creator/custom_move_creator.dart'
    as _i25;
import 'components/creators/gym_profile_creator.dart' as _i26;
import 'components/creators/logged_workout_creator/logged_workout_creator.dart'
    as _i33;
import 'components/creators/personal_best_creator/personal_best_creator.dart'
    as _i28;
import 'components/creators/post_creator/club_post_creator.dart' as _i30;
import 'components/creators/post_creator/post_creator.dart' as _i29;
import 'components/creators/progress_journal_creator/progress_journal_creator.dart'
    as _i27;
import 'components/creators/scheduled_workout_creator.dart' as _i31;
import 'components/creators/workout_creator/workout_creator.dart' as _i32;
import 'components/creators/workout_plan_creator/workout_plan_creator.dart'
    as _i34;
import 'components/creators/workout_plan_review_creator.dart' as _i35;
import 'components/do_workout/do_workout_do_workout_page.dart' as _i61;
import 'components/do_workout/do_workout_post_workout_page.dart' as _i62;
import 'components/do_workout/do_workout_wrapper_page.dart' as _i11;
import 'components/social/chat/chats_overview_page.dart' as _i6;
import 'components/social/chat/club_members_chat_page.dart' as _i8;
import 'components/social/chat/one_to_one_chat_page.dart' as _i7;
import 'components/workout/workout_finder/workout_finder.dart' as _i13;
import 'components/workout_plan/workout_plan_finder/workout_plan_finder.dart'
    as _i14;
import 'generated/api/graphql_api.dart' as _i64;
import 'pages/authed/authed_routes_wrapper_page.dart' as _i4;
import 'pages/authed/details_pages/club_details_page.dart' as _i15;
import 'pages/authed/details_pages/collection_details_page.dart' as _i10;
import 'pages/authed/details_pages/logged_workout_details_page.dart' as _i16;
import 'pages/authed/details_pages/personal_best_details_page.dart' as _i17;
import 'pages/authed/details_pages/progress_journal_details_page.dart' as _i19;
import 'pages/authed/details_pages/user_public_profile_details_page.dart'
    as _i18;
import 'pages/authed/details_pages/workout_details_page.dart' as _i20;
import 'pages/authed/details_pages/workout_plan_details_page.dart' as _i21;
import 'pages/authed/details_pages/workout_plan_enrolment_details_page.dart'
    as _i22;
import 'pages/authed/discover/discover_challenges_page.dart' as _i49;
import 'pages/authed/discover/discover_clubs_page.dart' as _i50;
import 'pages/authed/discover/discover_page.dart' as _i46;
import 'pages/authed/discover/discover_plans_page.dart' as _i48;
import 'pages/authed/discover/discover_workouts_page.dart' as _i47;
import 'pages/authed/home/home_page.dart' as _i38;
import 'pages/authed/home/your_challenges.dart' as _i40;
import 'pages/authed/home/your_clubs.dart' as _i41;
import 'pages/authed/home/your_collections.dart' as _i39;
import 'pages/authed/home/your_events.dart' as _i42;
import 'pages/authed/home/your_plans/your_plans.dart' as _i43;
import 'pages/authed/home/your_schedule.dart' as _i44;
import 'pages/authed/home/your_workouts/your_workouts.dart' as _i45;
import 'pages/authed/landing_pages/club_invite_landing_page.dart' as _i9;
import 'pages/authed/main_tabs_page.dart' as _i5;
import 'pages/authed/profile/custom_moves_page.dart' as _i60;
import 'pages/authed/profile/gym_profiles.dart' as _i59;
import 'pages/authed/profile/personal_page.dart' as _i58;
import 'pages/authed/profile/profile_page.dart' as _i37;
import 'pages/authed/profile/settings.dart' as _i12;
import 'pages/authed/progress/body_transformation_page.dart' as _i56;
import 'pages/authed/progress/journals_page.dart' as _i55;
import 'pages/authed/progress/logged_workouts_page.dart' as _i57;
import 'pages/authed/progress/personal_bests_page.dart' as _i54;
import 'pages/authed/progress/progress_page.dart' as _i53;
import 'pages/authed/social/discover_people_page.dart' as _i52;
import 'pages/authed/social/social_page.dart' as _i51;
import 'pages/unauthed/unauthed_landing.dart' as _i3;
import 'router.dart' as _i36;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    UnauthedLandingRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i3.UnauthedLandingPage());
    },
    AuthedRouter.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i4.AuthedRoutesWrapperPage());
    },
    MainTabsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.MainTabsPage());
    },
    ChatsOverviewRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.ChatsOverviewPage());
    },
    OneToOneChatRoute.name: (routeData) {
      final args = routeData.argsAs<OneToOneChatRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i7.OneToOneChatPage(
              key: args.key, otherUserId: args.otherUserId));
    },
    ClubMembersChatRoute.name: (routeData) {
      final args = routeData.argsAs<ClubMembersChatRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i8.ClubMembersChatPage(key: args.key, clubId: args.clubId));
    },
    ClubInviteLandingRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<ClubInviteLandingRouteArgs>(
          orElse: () =>
              ClubInviteLandingRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i9.ClubInviteLandingPage(key: args.key, id: args.id));
    },
    CollectionDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<CollectionDetailsRouteArgs>(
          orElse: () =>
              CollectionDetailsRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i10.CollectionDetailsPage(key: args.key, id: args.id));
    },
    DoWorkoutWrapperRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<DoWorkoutWrapperRouteArgs>(
          orElse: () =>
              DoWorkoutWrapperRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i11.DoWorkoutWrapperPage(
              key: args.key,
              id: args.id,
              scheduledWorkout: args.scheduledWorkout));
    },
    SettingsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i12.SettingsPage());
    },
    WorkoutFinderRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutFinderRouteArgs>(
          orElse: () => const WorkoutFinderRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i13.WorkoutFinderPage(
              key: args.key,
              selectWorkout: args.selectWorkout,
              initialOpenPublicTab: args.initialOpenPublicTab));
    },
    WorkoutPlanFinderRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutPlanFinderRouteArgs>(
          orElse: () => const WorkoutPlanFinderRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i14.WorkoutPlanFinderPage(
              key: args.key,
              initialOpenPublicTab: args.initialOpenPublicTab,
              selectWorkoutPlan: args.selectWorkoutPlan));
    },
    ClubDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<ClubDetailsRouteArgs>(
          orElse: () => ClubDetailsRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i15.ClubDetailsPage(key: args.key, id: args.id));
    },
    LoggedWorkoutDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<LoggedWorkoutDetailsRouteArgs>(
          orElse: () =>
              LoggedWorkoutDetailsRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i16.LoggedWorkoutDetailsPage(key: args.key, id: args.id));
    },
    PersonalBestDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<PersonalBestDetailsRouteArgs>(
          orElse: () =>
              PersonalBestDetailsRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i17.PersonalBestDetailsPage(key: args.key, id: args.id));
    },
    UserPublicProfileDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<UserPublicProfileDetailsRouteArgs>(
          orElse: () => UserPublicProfileDetailsRouteArgs(
              userId: pathParams.getString('userId')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i18.UserPublicProfileDetailsPage(
              key: args.key, userId: args.userId));
    },
    ProgressJournalDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<ProgressJournalDetailsRouteArgs>(
          orElse: () =>
              ProgressJournalDetailsRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i19.ProgressJournalDetailsPage(key: args.key, id: args.id));
    },
    WorkoutDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<WorkoutDetailsRouteArgs>(
          orElse: () =>
              WorkoutDetailsRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i20.WorkoutDetailsPage(key: args.key, id: args.id));
    },
    WorkoutPlanDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<WorkoutPlanDetailsRouteArgs>(
          orElse: () =>
              WorkoutPlanDetailsRouteArgs(id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i21.WorkoutPlanDetailsPage(key: args.key, id: args.id));
    },
    WorkoutPlanEnrolmentDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<WorkoutPlanEnrolmentDetailsRouteArgs>(
          orElse: () => WorkoutPlanEnrolmentDetailsRouteArgs(
              id: pathParams.getString('id')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child:
              _i22.WorkoutPlanEnrolmentDetailsPage(key: args.key, id: args.id));
    },
    ClubCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<ClubCreatorRouteArgs>(
          orElse: () => const ClubCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i23.ClubCreatorPage(key: args.key, club: args.club));
    },
    CollectionCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<CollectionCreatorRouteArgs>(
          orElse: () => const CollectionCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i24.CollectionCreatorPage(
              key: args.key,
              collection: args.collection,
              onComplete: args.onComplete));
    },
    CustomMoveCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<CustomMoveCreatorRouteArgs>(
          orElse: () => const CustomMoveCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i25.CustomMoveCreatorPage(key: args.key, move: args.move));
    },
    GymProfileCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<GymProfileCreatorRouteArgs>(
          orElse: () => const GymProfileCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i26.GymProfileCreatorPage(
              key: args.key, gymProfile: args.gymProfile));
    },
    ProgressJournalCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<ProgressJournalCreatorRouteArgs>(
          orElse: () => const ProgressJournalCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i27.ProgressJournalCreatorPage(
              key: args.key, progressJournal: args.progressJournal));
    },
    PersonalBestCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<PersonalBestCreatorRouteArgs>(
          orElse: () => const PersonalBestCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i28.PersonalBestCreatorPage(
              key: args.key, userBenchmark: args.userBenchmark));
    },
    PostCreatorRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i29.PostCreatorPage());
    },
    ClubPostCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<ClubPostCreatorRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i30.ClubPostCreatorPage(key: args.key, clubId: args.clubId));
    },
    ScheduledWorkoutCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<ScheduledWorkoutCreatorRouteArgs>(
          orElse: () => const ScheduledWorkoutCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i31.ScheduledWorkoutCreatorPage(
              key: args.key,
              scheduledWorkout: args.scheduledWorkout,
              workout: args.workout,
              scheduleOn: args.scheduleOn,
              workoutPlanEnrolmentId: args.workoutPlanEnrolmentId));
    },
    WorkoutCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutCreatorRouteArgs>(
          orElse: () => const WorkoutCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i32.WorkoutCreatorPage(key: args.key, workout: args.workout));
    },
    LoggedWorkoutCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<LoggedWorkoutCreatorRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i33.LoggedWorkoutCreatorPage(
              key: args.key,
              workout: args.workout,
              scheduledWorkout: args.scheduledWorkout));
    },
    WorkoutPlanCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutPlanCreatorRouteArgs>(
          orElse: () => const WorkoutPlanCreatorRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i34.WorkoutPlanCreatorPage(
              key: args.key, workoutPlan: args.workoutPlan));
    },
    WorkoutPlanReviewCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutPlanReviewCreatorRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i35.WorkoutPlanReviewCreatorPage(
              key: args.key,
              workoutPlanReview: args.workoutPlanReview,
              parentWorkoutPlanId: args.parentWorkoutPlanId,
              parentWorkoutPlanEnrolmentId: args.parentWorkoutPlanEnrolmentId));
    },
    HomeStack.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i36.HeroEmptyRouterPage());
    },
    DiscoverStack.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i36.HeroEmptyRouterPage());
    },
    SocialStack.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i36.HeroEmptyRouterPage());
    },
    ProgressStack.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i36.HeroEmptyRouterPage());
    },
    ProfileRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i37.ProfilePage());
    },
    HomeRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i38.HomePage());
    },
    YourCollectionsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i39.YourCollectionsPage());
    },
    YourChallengesRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i40.YourChallengesPage());
    },
    YourClubsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i41.YourClubsPage());
    },
    YourEventsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i42.YourEventsPage());
    },
    YourPlansRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i43.YourPlansPage());
    },
    YourScheduleRoute.name: (routeData) {
      final args = routeData.argsAs<YourScheduleRouteArgs>(
          orElse: () => const YourScheduleRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i44.YourSchedulePage(
              key: args.key, openAtDate: args.openAtDate));
    },
    YourWorkoutsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i45.YourWorkoutsPage());
    },
    DiscoverRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i46.DiscoverPage());
    },
    DiscoverWorkoutsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i47.DiscoverWorkoutsPage());
    },
    DiscoverPlansRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i48.DiscoverPlansPage());
    },
    DiscoverChallengesRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i49.DiscoverChallengesPage());
    },
    DiscoverClubsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i50.DiscoverClubsPage());
    },
    SocialRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i51.SocialPage());
    },
    DiscoverPeopleRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i52.DiscoverPeoplePage());
    },
    ProgressRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i53.ProgressPage());
    },
    PersonalBestsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i54.PersonalBestsPage());
    },
    JournalsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i55.JournalsPage());
    },
    BodyTransformationRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i56.BodyTransformationPage());
    },
    LoggedWorkoutsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i57.LoggedWorkoutsPage());
    },
    ProfilePersonalRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i58.ProfilePersonalPage());
    },
    ProfileGymProfilesRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i59.ProfileGymProfilesPage());
    },
    ProfileCustomMovesRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i60.ProfileCustomMovesPage());
    },
    DoWorkoutDoWorkoutRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i61.DoWorkoutDoWorkoutPage());
    },
    DoWorkoutPostWorkoutRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i62.DoWorkoutPostWorkoutPage());
    }
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
          _i1.RouteConfig(ClubMembersChatRoute.name, path: 'club-chat'),
          _i1.RouteConfig(ClubInviteLandingRoute.name, path: 'club-invite/:id'),
          _i1.RouteConfig(CollectionDetailsRoute.name, path: 'collection/:id'),
          _i1.RouteConfig(DoWorkoutWrapperRoute.name,
              path: 'do-workout/:id',
              children: [
                _i1.RouteConfig(DoWorkoutDoWorkoutRoute.name,
                    path: 'do-workout-do-workout-page'),
                _i1.RouteConfig(DoWorkoutPostWorkoutRoute.name,
                    path: 'do-workout-post-workout-page')
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
          _i1.RouteConfig(ClubCreatorRoute.name, path: 'create/club'),
          _i1.RouteConfig(CollectionCreatorRoute.name,
              path: 'create/collection'),
          _i1.RouteConfig(CustomMoveCreatorRoute.name,
              path: 'create/custom-move'),
          _i1.RouteConfig(GymProfileCreatorRoute.name,
              path: 'create/gym-profile'),
          _i1.RouteConfig(ProgressJournalCreatorRoute.name,
              path: 'create/journal'),
          _i1.RouteConfig(PersonalBestCreatorRoute.name,
              path: 'create/personal-best'),
          _i1.RouteConfig(PostCreatorRoute.name, path: 'create/post'),
          _i1.RouteConfig(ClubPostCreatorRoute.name, path: 'create/club-post'),
          _i1.RouteConfig(ScheduledWorkoutCreatorRoute.name,
              path: 'create/scheduled-workout'),
          _i1.RouteConfig(WorkoutCreatorRoute.name, path: 'create/workout'),
          _i1.RouteConfig(LoggedWorkoutCreatorRoute.name,
              path: 'create/workout-log'),
          _i1.RouteConfig(WorkoutPlanCreatorRoute.name,
              path: 'create/workout-plan'),
          _i1.RouteConfig(WorkoutPlanReviewCreatorRoute.name,
              path: 'create/workout-plan-review'),
          _i1.RouteConfig('*#redirect',
              path: '*', redirectTo: '/', fullMatch: true)
        ])
      ];
}

class UnauthedLandingRoute extends _i1.PageRouteInfo<void> {
  const UnauthedLandingRoute() : super(name, path: '/auth');

  static const String name = 'UnauthedLandingRoute';
}

class AuthedRouter extends _i1.PageRouteInfo<void> {
  const AuthedRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'AuthedRouter';
}

class MainTabsRoute extends _i1.PageRouteInfo<void> {
  const MainTabsRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '', initialChildren: children);

  static const String name = 'MainTabsRoute';
}

class ChatsOverviewRoute extends _i1.PageRouteInfo<void> {
  const ChatsOverviewRoute() : super(name, path: 'chats');

  static const String name = 'ChatsOverviewRoute';
}

class OneToOneChatRoute extends _i1.PageRouteInfo<OneToOneChatRouteArgs> {
  OneToOneChatRoute({_i63.Key? key, required String otherUserId})
      : super(name,
            path: 'chat',
            args: OneToOneChatRouteArgs(key: key, otherUserId: otherUserId));

  static const String name = 'OneToOneChatRoute';
}

class OneToOneChatRouteArgs {
  const OneToOneChatRouteArgs({this.key, required this.otherUserId});

  final _i63.Key? key;

  final String otherUserId;
}

class ClubMembersChatRoute extends _i1.PageRouteInfo<ClubMembersChatRouteArgs> {
  ClubMembersChatRoute({_i63.Key? key, required String clubId})
      : super(name,
            path: 'club-chat',
            args: ClubMembersChatRouteArgs(key: key, clubId: clubId));

  static const String name = 'ClubMembersChatRoute';
}

class ClubMembersChatRouteArgs {
  const ClubMembersChatRouteArgs({this.key, required this.clubId});

  final _i63.Key? key;

  final String clubId;
}

class ClubInviteLandingRoute
    extends _i1.PageRouteInfo<ClubInviteLandingRouteArgs> {
  ClubInviteLandingRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'club-invite/:id',
            args: ClubInviteLandingRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'ClubInviteLandingRoute';
}

class ClubInviteLandingRouteArgs {
  const ClubInviteLandingRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class CollectionDetailsRoute
    extends _i1.PageRouteInfo<CollectionDetailsRouteArgs> {
  CollectionDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'collection/:id',
            args: CollectionDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'CollectionDetailsRoute';
}

class CollectionDetailsRouteArgs {
  const CollectionDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class DoWorkoutWrapperRoute
    extends _i1.PageRouteInfo<DoWorkoutWrapperRouteArgs> {
  DoWorkoutWrapperRoute(
      {_i63.Key? key,
      required String id,
      _i64.ScheduledWorkout? scheduledWorkout,
      List<_i1.PageRouteInfo>? children})
      : super(name,
            path: 'do-workout/:id',
            args: DoWorkoutWrapperRouteArgs(
                key: key, id: id, scheduledWorkout: scheduledWorkout),
            rawPathParams: {'id': id},
            initialChildren: children);

  static const String name = 'DoWorkoutWrapperRoute';
}

class DoWorkoutWrapperRouteArgs {
  const DoWorkoutWrapperRouteArgs(
      {this.key, required this.id, this.scheduledWorkout});

  final _i63.Key? key;

  final String id;

  final _i64.ScheduledWorkout? scheduledWorkout;
}

class SettingsRoute extends _i1.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: 'settings');

  static const String name = 'SettingsRoute';
}

class WorkoutFinderRoute extends _i1.PageRouteInfo<WorkoutFinderRouteArgs> {
  WorkoutFinderRoute(
      {_i63.Key? key,
      void Function(_i64.Workout)? selectWorkout,
      bool? initialOpenPublicTab})
      : super(name,
            path: 'find-workout',
            args: WorkoutFinderRouteArgs(
                key: key,
                selectWorkout: selectWorkout,
                initialOpenPublicTab: initialOpenPublicTab));

  static const String name = 'WorkoutFinderRoute';
}

class WorkoutFinderRouteArgs {
  const WorkoutFinderRouteArgs(
      {this.key, this.selectWorkout, this.initialOpenPublicTab});

  final _i63.Key? key;

  final void Function(_i64.Workout)? selectWorkout;

  final bool? initialOpenPublicTab;
}

class WorkoutPlanFinderRoute
    extends _i1.PageRouteInfo<WorkoutPlanFinderRouteArgs> {
  WorkoutPlanFinderRoute(
      {_i63.Key? key,
      bool? initialOpenPublicTab = false,
      void Function(_i64.WorkoutPlan)? selectWorkoutPlan})
      : super(name,
            path: 'find-plan',
            args: WorkoutPlanFinderRouteArgs(
                key: key,
                initialOpenPublicTab: initialOpenPublicTab,
                selectWorkoutPlan: selectWorkoutPlan));

  static const String name = 'WorkoutPlanFinderRoute';
}

class WorkoutPlanFinderRouteArgs {
  const WorkoutPlanFinderRouteArgs(
      {this.key, this.initialOpenPublicTab = false, this.selectWorkoutPlan});

  final _i63.Key? key;

  final bool? initialOpenPublicTab;

  final void Function(_i64.WorkoutPlan)? selectWorkoutPlan;
}

class ClubDetailsRoute extends _i1.PageRouteInfo<ClubDetailsRouteArgs> {
  ClubDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'club/:id',
            args: ClubDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'ClubDetailsRoute';
}

class ClubDetailsRouteArgs {
  const ClubDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class LoggedWorkoutDetailsRoute
    extends _i1.PageRouteInfo<LoggedWorkoutDetailsRouteArgs> {
  LoggedWorkoutDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'logged-workout/:id',
            args: LoggedWorkoutDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'LoggedWorkoutDetailsRoute';
}

class LoggedWorkoutDetailsRouteArgs {
  const LoggedWorkoutDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class PersonalBestDetailsRoute
    extends _i1.PageRouteInfo<PersonalBestDetailsRouteArgs> {
  PersonalBestDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'personal-best/:id',
            args: PersonalBestDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'PersonalBestDetailsRoute';
}

class PersonalBestDetailsRouteArgs {
  const PersonalBestDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class UserPublicProfileDetailsRoute
    extends _i1.PageRouteInfo<UserPublicProfileDetailsRouteArgs> {
  UserPublicProfileDetailsRoute({_i63.Key? key, required String userId})
      : super(name,
            path: 'profile/:userId',
            args: UserPublicProfileDetailsRouteArgs(key: key, userId: userId),
            rawPathParams: {'userId': userId});

  static const String name = 'UserPublicProfileDetailsRoute';
}

class UserPublicProfileDetailsRouteArgs {
  const UserPublicProfileDetailsRouteArgs({this.key, required this.userId});

  final _i63.Key? key;

  final String userId;
}

class ProgressJournalDetailsRoute
    extends _i1.PageRouteInfo<ProgressJournalDetailsRouteArgs> {
  ProgressJournalDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'progress-journal/:id',
            args: ProgressJournalDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'ProgressJournalDetailsRoute';
}

class ProgressJournalDetailsRouteArgs {
  const ProgressJournalDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class WorkoutDetailsRoute extends _i1.PageRouteInfo<WorkoutDetailsRouteArgs> {
  WorkoutDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'workout/:id',
            args: WorkoutDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'WorkoutDetailsRoute';
}

class WorkoutDetailsRouteArgs {
  const WorkoutDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class WorkoutPlanDetailsRoute
    extends _i1.PageRouteInfo<WorkoutPlanDetailsRouteArgs> {
  WorkoutPlanDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'workout-plan/:id',
            args: WorkoutPlanDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'WorkoutPlanDetailsRoute';
}

class WorkoutPlanDetailsRouteArgs {
  const WorkoutPlanDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class WorkoutPlanEnrolmentDetailsRoute
    extends _i1.PageRouteInfo<WorkoutPlanEnrolmentDetailsRouteArgs> {
  WorkoutPlanEnrolmentDetailsRoute({_i63.Key? key, required String id})
      : super(name,
            path: 'workout-plan-progress/:id',
            args: WorkoutPlanEnrolmentDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'WorkoutPlanEnrolmentDetailsRoute';
}

class WorkoutPlanEnrolmentDetailsRouteArgs {
  const WorkoutPlanEnrolmentDetailsRouteArgs({this.key, required this.id});

  final _i63.Key? key;

  final String id;
}

class ClubCreatorRoute extends _i1.PageRouteInfo<ClubCreatorRouteArgs> {
  ClubCreatorRoute({_i63.Key? key, _i64.Club? club})
      : super(name,
            path: 'create/club',
            args: ClubCreatorRouteArgs(key: key, club: club));

  static const String name = 'ClubCreatorRoute';
}

class ClubCreatorRouteArgs {
  const ClubCreatorRouteArgs({this.key, this.club});

  final _i63.Key? key;

  final _i64.Club? club;
}

class CollectionCreatorRoute
    extends _i1.PageRouteInfo<CollectionCreatorRouteArgs> {
  CollectionCreatorRoute(
      {_i63.Key? key,
      _i64.Collection? collection,
      void Function(_i64.Collection)? onComplete})
      : super(name,
            path: 'create/collection',
            args: CollectionCreatorRouteArgs(
                key: key, collection: collection, onComplete: onComplete));

  static const String name = 'CollectionCreatorRoute';
}

class CollectionCreatorRouteArgs {
  const CollectionCreatorRouteArgs(
      {this.key, this.collection, this.onComplete});

  final _i63.Key? key;

  final _i64.Collection? collection;

  final void Function(_i64.Collection)? onComplete;
}

class CustomMoveCreatorRoute
    extends _i1.PageRouteInfo<CustomMoveCreatorRouteArgs> {
  CustomMoveCreatorRoute({_i63.Key? key, _i64.Move? move})
      : super(name,
            path: 'create/custom-move',
            args: CustomMoveCreatorRouteArgs(key: key, move: move));

  static const String name = 'CustomMoveCreatorRoute';
}

class CustomMoveCreatorRouteArgs {
  const CustomMoveCreatorRouteArgs({this.key, this.move});

  final _i63.Key? key;

  final _i64.Move? move;
}

class GymProfileCreatorRoute
    extends _i1.PageRouteInfo<GymProfileCreatorRouteArgs> {
  GymProfileCreatorRoute({_i63.Key? key, _i64.GymProfile? gymProfile})
      : super(name,
            path: 'create/gym-profile',
            args: GymProfileCreatorRouteArgs(key: key, gymProfile: gymProfile));

  static const String name = 'GymProfileCreatorRoute';
}

class GymProfileCreatorRouteArgs {
  const GymProfileCreatorRouteArgs({this.key, this.gymProfile});

  final _i63.Key? key;

  final _i64.GymProfile? gymProfile;
}

class ProgressJournalCreatorRoute
    extends _i1.PageRouteInfo<ProgressJournalCreatorRouteArgs> {
  ProgressJournalCreatorRoute(
      {_i63.Key? key, _i64.ProgressJournal? progressJournal})
      : super(name,
            path: 'create/journal',
            args: ProgressJournalCreatorRouteArgs(
                key: key, progressJournal: progressJournal));

  static const String name = 'ProgressJournalCreatorRoute';
}

class ProgressJournalCreatorRouteArgs {
  const ProgressJournalCreatorRouteArgs({this.key, this.progressJournal});

  final _i63.Key? key;

  final _i64.ProgressJournal? progressJournal;
}

class PersonalBestCreatorRoute
    extends _i1.PageRouteInfo<PersonalBestCreatorRouteArgs> {
  PersonalBestCreatorRoute({_i63.Key? key, _i64.UserBenchmark? userBenchmark})
      : super(name,
            path: 'create/personal-best',
            args: PersonalBestCreatorRouteArgs(
                key: key, userBenchmark: userBenchmark));

  static const String name = 'PersonalBestCreatorRoute';
}

class PersonalBestCreatorRouteArgs {
  const PersonalBestCreatorRouteArgs({this.key, this.userBenchmark});

  final _i63.Key? key;

  final _i64.UserBenchmark? userBenchmark;
}

class PostCreatorRoute extends _i1.PageRouteInfo<void> {
  const PostCreatorRoute() : super(name, path: 'create/post');

  static const String name = 'PostCreatorRoute';
}

class ClubPostCreatorRoute extends _i1.PageRouteInfo<ClubPostCreatorRouteArgs> {
  ClubPostCreatorRoute({_i63.Key? key, required String clubId})
      : super(name,
            path: 'create/club-post',
            args: ClubPostCreatorRouteArgs(key: key, clubId: clubId));

  static const String name = 'ClubPostCreatorRoute';
}

class ClubPostCreatorRouteArgs {
  const ClubPostCreatorRouteArgs({this.key, required this.clubId});

  final _i63.Key? key;

  final String clubId;
}

class ScheduledWorkoutCreatorRoute
    extends _i1.PageRouteInfo<ScheduledWorkoutCreatorRouteArgs> {
  ScheduledWorkoutCreatorRoute(
      {_i63.Key? key,
      _i64.ScheduledWorkout? scheduledWorkout,
      _i64.Workout? workout,
      DateTime? scheduleOn,
      String? workoutPlanEnrolmentId})
      : super(name,
            path: 'create/scheduled-workout',
            args: ScheduledWorkoutCreatorRouteArgs(
                key: key,
                scheduledWorkout: scheduledWorkout,
                workout: workout,
                scheduleOn: scheduleOn,
                workoutPlanEnrolmentId: workoutPlanEnrolmentId));

  static const String name = 'ScheduledWorkoutCreatorRoute';
}

class ScheduledWorkoutCreatorRouteArgs {
  const ScheduledWorkoutCreatorRouteArgs(
      {this.key,
      this.scheduledWorkout,
      this.workout,
      this.scheduleOn,
      this.workoutPlanEnrolmentId});

  final _i63.Key? key;

  final _i64.ScheduledWorkout? scheduledWorkout;

  final _i64.Workout? workout;

  final DateTime? scheduleOn;

  final String? workoutPlanEnrolmentId;
}

class WorkoutCreatorRoute extends _i1.PageRouteInfo<WorkoutCreatorRouteArgs> {
  WorkoutCreatorRoute({_i63.Key? key, _i64.Workout? workout})
      : super(name,
            path: 'create/workout',
            args: WorkoutCreatorRouteArgs(key: key, workout: workout));

  static const String name = 'WorkoutCreatorRoute';
}

class WorkoutCreatorRouteArgs {
  const WorkoutCreatorRouteArgs({this.key, this.workout});

  final _i63.Key? key;

  final _i64.Workout? workout;
}

class LoggedWorkoutCreatorRoute
    extends _i1.PageRouteInfo<LoggedWorkoutCreatorRouteArgs> {
  LoggedWorkoutCreatorRoute(
      {_i63.Key? key,
      required _i64.Workout workout,
      _i64.ScheduledWorkout? scheduledWorkout})
      : super(name,
            path: 'create/workout-log',
            args: LoggedWorkoutCreatorRouteArgs(
                key: key,
                workout: workout,
                scheduledWorkout: scheduledWorkout));

  static const String name = 'LoggedWorkoutCreatorRoute';
}

class LoggedWorkoutCreatorRouteArgs {
  const LoggedWorkoutCreatorRouteArgs(
      {this.key, required this.workout, this.scheduledWorkout});

  final _i63.Key? key;

  final _i64.Workout workout;

  final _i64.ScheduledWorkout? scheduledWorkout;
}

class WorkoutPlanCreatorRoute
    extends _i1.PageRouteInfo<WorkoutPlanCreatorRouteArgs> {
  WorkoutPlanCreatorRoute({_i63.Key? key, _i64.WorkoutPlan? workoutPlan})
      : super(name,
            path: 'create/workout-plan',
            args: WorkoutPlanCreatorRouteArgs(
                key: key, workoutPlan: workoutPlan));

  static const String name = 'WorkoutPlanCreatorRoute';
}

class WorkoutPlanCreatorRouteArgs {
  const WorkoutPlanCreatorRouteArgs({this.key, this.workoutPlan});

  final _i63.Key? key;

  final _i64.WorkoutPlan? workoutPlan;
}

class WorkoutPlanReviewCreatorRoute
    extends _i1.PageRouteInfo<WorkoutPlanReviewCreatorRouteArgs> {
  WorkoutPlanReviewCreatorRoute(
      {_i63.Key? key,
      _i64.WorkoutPlanReview? workoutPlanReview,
      required String parentWorkoutPlanId,
      required String parentWorkoutPlanEnrolmentId})
      : super(name,
            path: 'create/workout-plan-review',
            args: WorkoutPlanReviewCreatorRouteArgs(
                key: key,
                workoutPlanReview: workoutPlanReview,
                parentWorkoutPlanId: parentWorkoutPlanId,
                parentWorkoutPlanEnrolmentId: parentWorkoutPlanEnrolmentId));

  static const String name = 'WorkoutPlanReviewCreatorRoute';
}

class WorkoutPlanReviewCreatorRouteArgs {
  const WorkoutPlanReviewCreatorRouteArgs(
      {this.key,
      this.workoutPlanReview,
      required this.parentWorkoutPlanId,
      required this.parentWorkoutPlanEnrolmentId});

  final _i63.Key? key;

  final _i64.WorkoutPlanReview? workoutPlanReview;

  final String parentWorkoutPlanId;

  final String parentWorkoutPlanEnrolmentId;
}

class HomeStack extends _i1.PageRouteInfo<void> {
  const HomeStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: '', initialChildren: children);

  static const String name = 'HomeStack';
}

class DiscoverStack extends _i1.PageRouteInfo<void> {
  const DiscoverStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'discover', initialChildren: children);

  static const String name = 'DiscoverStack';
}

class SocialStack extends _i1.PageRouteInfo<void> {
  const SocialStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'social', initialChildren: children);

  static const String name = 'SocialStack';
}

class ProgressStack extends _i1.PageRouteInfo<void> {
  const ProgressStack({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'progress', initialChildren: children);

  static const String name = 'ProgressStack';
}

class ProfileRoute extends _i1.PageRouteInfo<void> {
  const ProfileRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileRoute';
}

class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '');

  static const String name = 'HomeRoute';
}

class YourCollectionsRoute extends _i1.PageRouteInfo<void> {
  const YourCollectionsRoute() : super(name, path: 'your-collections');

  static const String name = 'YourCollectionsRoute';
}

class YourChallengesRoute extends _i1.PageRouteInfo<void> {
  const YourChallengesRoute() : super(name, path: 'your-challenges');

  static const String name = 'YourChallengesRoute';
}

class YourClubsRoute extends _i1.PageRouteInfo<void> {
  const YourClubsRoute() : super(name, path: 'your-clubs');

  static const String name = 'YourClubsRoute';
}

class YourEventsRoute extends _i1.PageRouteInfo<void> {
  const YourEventsRoute() : super(name, path: 'your-events');

  static const String name = 'YourEventsRoute';
}

class YourPlansRoute extends _i1.PageRouteInfo<void> {
  const YourPlansRoute() : super(name, path: 'your-plans');

  static const String name = 'YourPlansRoute';
}

class YourScheduleRoute extends _i1.PageRouteInfo<YourScheduleRouteArgs> {
  YourScheduleRoute({_i63.Key? key, DateTime? openAtDate})
      : super(name,
            path: 'your-schedule',
            args: YourScheduleRouteArgs(key: key, openAtDate: openAtDate));

  static const String name = 'YourScheduleRoute';
}

class YourScheduleRouteArgs {
  const YourScheduleRouteArgs({this.key, this.openAtDate});

  final _i63.Key? key;

  final DateTime? openAtDate;
}

class YourWorkoutsRoute extends _i1.PageRouteInfo<void> {
  const YourWorkoutsRoute() : super(name, path: 'your-workouts');

  static const String name = 'YourWorkoutsRoute';
}

class DiscoverRoute extends _i1.PageRouteInfo<void> {
  const DiscoverRoute() : super(name, path: '');

  static const String name = 'DiscoverRoute';
}

class DiscoverWorkoutsRoute extends _i1.PageRouteInfo<void> {
  const DiscoverWorkoutsRoute() : super(name, path: 'discover-workouts');

  static const String name = 'DiscoverWorkoutsRoute';
}

class DiscoverPlansRoute extends _i1.PageRouteInfo<void> {
  const DiscoverPlansRoute() : super(name, path: 'discover-plans');

  static const String name = 'DiscoverPlansRoute';
}

class DiscoverChallengesRoute extends _i1.PageRouteInfo<void> {
  const DiscoverChallengesRoute() : super(name, path: 'discover-challenges');

  static const String name = 'DiscoverChallengesRoute';
}

class DiscoverClubsRoute extends _i1.PageRouteInfo<void> {
  const DiscoverClubsRoute() : super(name, path: 'discover-clubs');

  static const String name = 'DiscoverClubsRoute';
}

class SocialRoute extends _i1.PageRouteInfo<void> {
  const SocialRoute() : super(name, path: '');

  static const String name = 'SocialRoute';
}

class DiscoverPeopleRoute extends _i1.PageRouteInfo<void> {
  const DiscoverPeopleRoute() : super(name, path: 'discover-people');

  static const String name = 'DiscoverPeopleRoute';
}

class ProgressRoute extends _i1.PageRouteInfo<void> {
  const ProgressRoute() : super(name, path: '');

  static const String name = 'ProgressRoute';
}

class PersonalBestsRoute extends _i1.PageRouteInfo<void> {
  const PersonalBestsRoute() : super(name, path: 'personal-bests');

  static const String name = 'PersonalBestsRoute';
}

class JournalsRoute extends _i1.PageRouteInfo<void> {
  const JournalsRoute() : super(name, path: 'journals');

  static const String name = 'JournalsRoute';
}

class BodyTransformationRoute extends _i1.PageRouteInfo<void> {
  const BodyTransformationRoute() : super(name, path: 'transformation');

  static const String name = 'BodyTransformationRoute';
}

class LoggedWorkoutsRoute extends _i1.PageRouteInfo<void> {
  const LoggedWorkoutsRoute() : super(name, path: 'workout-logs');

  static const String name = 'LoggedWorkoutsRoute';
}

class ProfilePersonalRoute extends _i1.PageRouteInfo<void> {
  const ProfilePersonalRoute() : super(name, path: 'personal');

  static const String name = 'ProfilePersonalRoute';
}

class ProfileGymProfilesRoute extends _i1.PageRouteInfo<void> {
  const ProfileGymProfilesRoute() : super(name, path: 'gym-profiles');

  static const String name = 'ProfileGymProfilesRoute';
}

class ProfileCustomMovesRoute extends _i1.PageRouteInfo<void> {
  const ProfileCustomMovesRoute() : super(name, path: 'custom-moves');

  static const String name = 'ProfileCustomMovesRoute';
}

class DoWorkoutDoWorkoutRoute extends _i1.PageRouteInfo<void> {
  const DoWorkoutDoWorkoutRoute()
      : super(name, path: 'do-workout-do-workout-page');

  static const String name = 'DoWorkoutDoWorkoutRoute';
}

class DoWorkoutPostWorkoutRoute extends _i1.PageRouteInfo<void> {
  const DoWorkoutPostWorkoutRoute()
      : super(name, path: 'do-workout-post-workout-page');

  static const String name = 'DoWorkoutPostWorkoutRoute';
}
