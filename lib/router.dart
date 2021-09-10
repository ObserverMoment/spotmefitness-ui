import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_creator.dart';
import 'package:spotmefitness_ui/components/creators/collection_creator.dart';
import 'package:spotmefitness_ui/components/creators/custom_move_creator/custom_move_creator.dart';
import 'package:spotmefitness_ui/components/creators/gym_profile_creator.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/logged_workout_creator.dart';
import 'package:spotmefitness_ui/components/creators/personal_best_creator/personal_best_creator.dart';
import 'package:spotmefitness_ui/components/creators/post_creator/club_post_creator.dart';
import 'package:spotmefitness_ui/components/creators/post_creator/post_creator.dart';
import 'package:spotmefitness_ui/components/creators/progress_journal_creator/progress_journal_creator.dart';
import 'package:spotmefitness_ui/components/creators/scheduled_workout_creator.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator.dart';
import 'package:spotmefitness_ui/components/creators/workout_plan_creator/workout_plan_creator.dart';
import 'package:spotmefitness_ui/components/creators/workout_plan_review_creator.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_do_workout_page.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_log_workout_page.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_wrapper_page.dart';
import 'package:spotmefitness_ui/components/social/chat/club_members_chat_page.dart';
import 'package:spotmefitness_ui/components/workout/workout_finder/workout_finder.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_finder/workout_plan_finder.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_clubs_page.dart';
import 'package:spotmefitness_ui/pages/authed/main_tabs_page.dart';
import 'package:spotmefitness_ui/pages/authed/authed_routes_wrapper_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/club_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/personal_best_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/collection_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/logged_workout_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/progress_journal_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/user_public_profile_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/workout_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/workout_plan_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/workout_plan_enrolment_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_challenges_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_plans_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_workouts_page.dart';
import 'package:spotmefitness_ui/pages/authed/home/home_page.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_challenges.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_clubs.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_collections.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_events.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_schedule.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts/your_workouts.dart';
import 'package:spotmefitness_ui/pages/authed/landing_pages/club_invite_landing_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/custom_moves_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/gym_profiles.dart';
import 'package:spotmefitness_ui/pages/authed/profile/personal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/profile_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/settings.dart';
import 'package:spotmefitness_ui/pages/authed/progress/personal_bests_page.dart';
import 'package:spotmefitness_ui/pages/authed/progress/body_transformation_page.dart';
import 'package:spotmefitness_ui/pages/authed/progress/logged_workouts_page.dart';
import 'package:spotmefitness_ui/pages/authed/progress/journals_page.dart';
import 'package:spotmefitness_ui/pages/authed/progress/progress_page.dart';
import 'package:spotmefitness_ui/components/social/chat/chats_overview_page.dart';
import 'package:spotmefitness_ui/pages/authed/social/discover_people_page.dart';
import 'package:spotmefitness_ui/components/social/chat/one_to_one_chat_page.dart';
import 'package:spotmefitness_ui/pages/authed/social/social_page.dart';
import 'package:spotmefitness_ui/pages/unauthed/unauthed_landing.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/auth', page: UnauthedLandingPage),
    AutoRoute(
        path: '/',
        name: 'authedRouter',
        page: AuthedRoutesWrapperPage,
        children: [
          // The main tabs screen has five tabs where each is a stack. Generally these are pages that are user specific and are not likely to be shared across users or groups. Each stack maintains its own state and navigation in iOS style.
          AutoRoute(path: '', page: MainTabsPage, children: [
            AutoRoute(
                path: '',
                name: 'homeStack',
                page: HeroEmptyRouterPage,
                children: [
                  AutoRoute(path: '', page: HomePage),
                  AutoRoute(
                      path: 'your-collections', page: YourCollectionsPage),
                  AutoRoute(path: 'your-challenges', page: YourChallengesPage),
                  AutoRoute(path: 'your-clubs', page: YourClubsPage),
                  AutoRoute(path: 'your-events', page: YourEventsPage),
                  AutoRoute(path: 'your-plans', page: YourPlansPage),
                  AutoRoute(path: 'your-schedule', page: YourSchedulePage),
                  AutoRoute(path: 'your-workouts', page: YourWorkoutsPage),
                  RedirectRoute(path: '*', redirectTo: '')
                ]),
            AutoRoute(
                path: 'discover',
                name: 'discoverStack',
                page: HeroEmptyRouterPage,
                children: [
                  AutoRoute(path: '', page: DiscoverPage),
                  AutoRoute(
                      path: 'discover-workouts', page: DiscoverWorkoutsPage),
                  AutoRoute(path: 'discover-plans', page: DiscoverPlansPage),
                  AutoRoute(
                      path: 'discover-challenges',
                      page: DiscoverChallengesPage),
                  AutoRoute(path: 'discover-clubs', page: DiscoverClubsPage),
                  RedirectRoute(path: '*', redirectTo: '')
                ]),
            AutoRoute(
                path: 'social',
                name: 'socialStack',
                page: HeroEmptyRouterPage,
                children: [
                  AutoRoute(path: '', page: SocialPage),
                  AutoRoute(path: 'discover-people', page: DiscoverPeoplePage),
                  RedirectRoute(path: '*', redirectTo: '')
                ]),
            AutoRoute(
                path: 'progress',
                name: 'progressStack',
                page: HeroEmptyRouterPage,
                children: [
                  AutoRoute(path: '', page: ProgressPage),
                  AutoRoute(path: 'personal-bests', page: PersonalBestsPage),
                  AutoRoute(path: 'journals', page: JournalsPage),
                  AutoRoute(
                      path: 'transformation', page: BodyTransformationPage),
                  AutoRoute(path: 'workout-logs', page: LoggedWorkoutsPage),
                  RedirectRoute(path: '*', redirectTo: '')
                ]),
            AutoRoute(path: 'profile', page: ProfilePage, children: [
              AutoRoute(path: 'personal', page: ProfilePersonalPage),
              AutoRoute(path: 'gym-profiles', page: ProfileGymProfilesPage),
              AutoRoute(path: 'custom-moves', page: ProfileCustomMovesPage),
              RedirectRoute(path: '*', redirectTo: 'personal')
            ]),
          ]),
          // These pages are 'stand-alone'. They push on top of the underlying main tabs UI / stacks and so go into full screen.
          // They can be pushed to from anywhere and are also pages that would want to be linkable. E.g. when sharing a workout details page with a group or another user.
          // Usually the flow from these pages ends up back on this page - where the user can hit [back] to go back to the main tabs view. E.g. MainTabsView -> WorkoutDetails -> Do Workout -> LogWorkout -> WorkoutDetails -> MainTabsView
          AutoRoute(path: 'chats', page: ChatsOverviewPage),
          AutoRoute(path: 'chat', page: OneToOneChatPage),
          AutoRoute(path: 'club-chat', page: ClubMembersChatPage),
          AutoRoute(path: 'club-invite/:id', page: ClubInviteLandingPage),
          AutoRoute(path: 'collection/:id', page: CollectionDetailsPage),
          AutoRoute(
              path: "do-workout/:id",
              page: DoWorkoutWrapperPage,
              children: [
                AutoRoute(page: DoWorkoutDoWorkoutPage),
                AutoRoute(page: DoWorkoutLogWorkoutPage),
              ]),
          AutoRoute(path: 'settings', page: SettingsPage),

          /// Finders.
          AutoRoute(path: 'find-workout', page: WorkoutFinderPage),
          AutoRoute(path: 'find-plan', page: WorkoutPlanFinderPage),

          /// Details pages - for certain object types.
          AutoRoute(path: 'club/:id', page: ClubDetailsPage),
          AutoRoute(path: 'logged-workout/:id', page: LoggedWorkoutDetailsPage),
          AutoRoute(path: 'personal-best/:id', page: PersonalBestDetailsPage),
          AutoRoute(
              path: 'profile/:userId', page: UserPublicProfileDetailsPage),
          AutoRoute(
              path: 'progress-journal/:id', page: ProgressJournalDetailsPage),
          AutoRoute(path: 'workout/:id', page: WorkoutDetailsPage),
          AutoRoute(path: 'workout-plan/:id', page: WorkoutPlanDetailsPage),
          AutoRoute(
              path: 'workout-plan-progress/:id',
              page: WorkoutPlanEnrolmentDetailsPage),

          /// Creator pages. CRUD pages for database models.
          AutoRoute(path: 'create/club', page: ClubCreatorPage),
          AutoRoute(path: 'create/collection', page: CollectionCreatorPage),
          AutoRoute(path: 'create/custom-move', page: CustomMoveCreatorPage),
          AutoRoute(path: 'create/gym-profile', page: GymProfileCreatorPage),
          AutoRoute(path: 'create/journal', page: ProgressJournalCreatorPage),
          AutoRoute(
              path: 'create/personal-best', page: PersonalBestCreatorPage),
          AutoRoute(path: 'create/post', page: PostCreatorPage),
          AutoRoute(path: 'create/club-post', page: ClubPostCreatorPage),
          AutoRoute(
              path: 'create/scheduled-workout',
              page: ScheduledWorkoutCreatorPage),
          AutoRoute(path: 'create/workout', page: WorkoutCreatorPage),
          AutoRoute(path: 'create/workout-log', page: LoggedWorkoutCreatorPage),
          AutoRoute(path: 'create/workout-plan', page: WorkoutPlanCreatorPage),
          AutoRoute(
              path: 'create/workout-plan-review',
              page: WorkoutPlanReviewCreatorPage),
          RedirectRoute(path: '*', redirectTo: '/')
        ]),
  ],
)
class $AppRouter {}

/// https://github.com/Milad-Akarie/auto_route_library/issues/418
class HeroEmptyRouterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: HeroController(),
      child: AutoRouter(),
    );
  }
}
