import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/creators/benchmark_creator/benchmark_creator.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/logged_workout_creator.dart';
import 'package:spotmefitness_ui/components/creators/progress_journal/progress_journal_creator.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator.dart';
import 'package:spotmefitness_ui/components/creators/workout_plan_creator/workout_plan_creator.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_do_workout_page.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_log_workout_page.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_wrapper_page.dart';
import 'package:spotmefitness_ui/components/workout/workout_finder/workout_finder.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_finder/workout_plan_finder.dart';
import 'package:spotmefitness_ui/pages/authed/app.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/benchmark_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/collection_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/logged_workout_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/progress_journal_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/user_public_profile_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/workout_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/workout_plan_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/workout_plan_enrolment_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_challenges_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_events_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_plans_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_workouts_page.dart';
import 'package:spotmefitness_ui/pages/authed/home/home_page.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_clubs.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_collections.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_events.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_schedule.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts/your_workouts.dart';
import 'package:spotmefitness_ui/pages/authed/journal/journal_page.dart';
import 'package:spotmefitness_ui/pages/authed/journal/your_benchmarks.dart';
import 'package:spotmefitness_ui/pages/authed/journal/your_logged_workouts.dart';
import 'package:spotmefitness_ui/pages/authed/journal/your_progress_journals.dart';
import 'package:spotmefitness_ui/pages/authed/profile/custom_moves_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/gym_profiles.dart';
import 'package:spotmefitness_ui/pages/authed/profile/personal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/profile_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/settings.dart';
import 'package:spotmefitness_ui/pages/authed/social/social_page.dart';
import 'package:spotmefitness_ui/pages/unauthed/unauthed_landing.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/auth', page: UnauthedLandingPage),
    AutoRoute(
        path: '/',
        name: 'authedRouter',
        page: HeroEmptyRouterPage,
        children: [
          // The main tabs screen has five tabs where each is a stack. Generally these are pages that are user specific and are not likely to be shared across users or groups. Each stack maintains its own state.
          AutoRoute(path: '', page: MainTabsPage, children: [
            AutoRoute(
                path: '',
                name: 'homeStack',
                page: HeroEmptyRouterPage,
                children: [
                  AutoRoute(path: '', page: HomePage),
                  AutoRoute(
                      path: 'your-collections', page: YourCollectionsPage),
                  AutoRoute(path: 'your-workouts', page: YourWorkoutsPage),
                  AutoRoute(path: 'your-plans', page: YourPlansPage),
                  AutoRoute(path: 'your-events', page: YourEventsPage),
                  AutoRoute(path: 'your-clubs', page: YourClubsPage),
                  AutoRoute(
                      path: 'your-collections', page: YourCollectionsPage),
                  AutoRoute(path: 'your-schedule', page: YourSchedulePage),
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
                  AutoRoute(path: 'discover-events', page: DiscoverEventsPage),
                  RedirectRoute(path: '*', redirectTo: '')
                ]),
            AutoRoute(path: 'social', page: SocialPage),
            AutoRoute(
                path: 'journal',
                name: 'journalStack',
                page: HeroEmptyRouterPage,
                children: [
                  AutoRoute(path: '', page: JournalPage),
                  AutoRoute(path: 'your-benchmarks', page: YourBenchmarksPage),
                  AutoRoute(
                      path: 'your-logged-workouts',
                      page: YourLoggedWorkoutsPage),
                  AutoRoute(
                      path: 'your-progress-journals',
                      page: YourProgressJournalsPage),
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
          // Usually the flow from these pages always ends up back on this page - where the user can hit [back] to go back to the main tabs view. E.g. MainTabsView -> WorkoutDetails -> Do Workout -> LogWorkout -> WorkoutDetails -> MainTabsView
          AutoRoute(path: 'benchmark/:id', page: BenchmarkDetailsPage),
          AutoRoute(path: 'collection/:id', page: CollectionDetailsPage),
          AutoRoute(path: 'create-benchmark', page: BenchmarkCreatorPage),
          AutoRoute(path: 'create-journal', page: ProgressJournalCreatorPage),
          AutoRoute(path: 'create-workout', page: WorkoutCreatorPage),
          AutoRoute(path: 'create-workout-plan', page: WorkoutPlanCreatorPage),
          AutoRoute(
              path: "do-workout/:id",
              page: DoWorkoutWrapperPage,
              children: [
                AutoRoute(page: DoWorkoutDoWorkoutPage),
                AutoRoute(page: DoWorkoutLogWorkoutPage),
              ]),
          AutoRoute(path: 'find-workout', page: WorkoutFinderPage),
          AutoRoute(path: 'find-plan', page: WorkoutPlanFinderPage),
          AutoRoute(path: 'log-workout', page: LoggedWorkoutCreatorPage),
          AutoRoute(path: 'logged-workout/:id', page: LoggedWorkoutDetailsPage),
          AutoRoute(
              path: 'profile/:userId', page: UserPublicProfileDetailsPage),
          AutoRoute(
              path: 'progress-journal/:id', page: ProgressJournalDetailsPage),

          AutoRoute(path: 'settings', page: SettingsPage),
          AutoRoute(path: 'workout/:id', page: WorkoutDetailsPage),
          AutoRoute(path: 'workout-plan/:id', page: WorkoutPlanDetailsPage),
          AutoRoute(
              path: 'workout-plan-progress/:id',
              page: WorkoutPlanEnrolmentDetailsPage),
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
