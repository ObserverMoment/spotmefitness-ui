import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/progress_journal/progress_journal_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator.dart';
import 'package:spotmefitness_ui/pages/authed/app.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/benchmark_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/logged_workout_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/progress_journal_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/workout_details_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/plans.dart';
import 'package:spotmefitness_ui/pages/authed/discover/workouts.dart';
import 'package:spotmefitness_ui/pages/authed/discover/you.dart';
import 'package:spotmefitness_ui/pages/authed/home/home_page.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_clubs.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_collections.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_events.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_moves.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_schedule.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts.dart';
import 'package:spotmefitness_ui/pages/authed/journal/journal_page.dart';
import 'package:spotmefitness_ui/pages/authed/journal/your_benchmarks.dart';
import 'package:spotmefitness_ui/pages/authed/journal/your_logged_workouts.dart';
import 'package:spotmefitness_ui/pages/authed/journal/your_progress_journals.dart';
import 'package:spotmefitness_ui/pages/authed/profile/gym_profiles.dart';
import 'package:spotmefitness_ui/pages/authed/profile/personal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/profile_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/settings_and_info.dart';
import 'package:spotmefitness_ui/pages/authed/social/social_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: GlobalPage, children: [
      AutoRoute(
          path: 'home',
          name: 'homeStack',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: HomePage),
            AutoRoute(path: 'your-collections', page: YourCollectionsPage),
            AutoRoute(path: 'your-workouts', page: YourWorkoutsPage),
            AutoRoute(path: 'your-plans', page: YourPlansPage),
            AutoRoute(path: 'your-events', page: YourEventsPage),
            AutoRoute(path: 'your-clubs', page: YourClubsPage),
            AutoRoute(path: 'your-moves', page: YourMovesPage),
            AutoRoute(path: 'your-schedule', page: YourSchedulePage),
            RedirectRoute(path: '*', redirectTo: 'home')
          ]),
      AutoRoute(path: 'discover', page: DiscoverPage, children: [
        AutoRoute(path: 'you', page: DiscoverYouPage),
        AutoRoute(path: 'workouts', page: DiscoverWorkoutsPage),
        AutoRoute(path: 'plans', page: DiscoverPlansPage),
        RedirectRoute(path: '*', redirectTo: 'you')
      ]),
      AutoRoute(path: 'social', page: SocialPage),
      AutoRoute(
          path: 'journal',
          name: 'journalStack',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: JournalPage),
            AutoRoute(path: 'your-benchmarks', page: YourBenchmarksPage),
            AutoRoute(
                path: 'your-logged-workouts', page: YourLoggedWorkoutsPage),
            AutoRoute(
                path: 'your-progress-journals', page: YourProgressJournalsPage),
            RedirectRoute(path: '*', redirectTo: 'journal')
          ]),
      AutoRoute(path: 'profile', page: ProfilePage, children: [
        AutoRoute(path: 'personal', page: ProfilePersonalPage),
        AutoRoute(path: 'gym-profiles', page: ProfileGymProfilesPage),
        RedirectRoute(path: '*', redirectTo: 'personal')
      ]),
    ]),
    AutoRoute(path: 'workout/:id', page: WorkoutDetailsPage),
    AutoRoute(path: 'logged-workout/:id', page: LoggedWorkoutDetailsPage),
    AutoRoute(path: 'progress-journal/:id', page: ProgressJournalDetailsPage),
    AutoRoute(path: 'benchmark/:id', page: BenchmarkDetailsPage),
    AutoRoute(path: 'settings', page: SettingsAndInfoPage),
    AutoRoute(path: 'create-workout', page: WorkoutCreatorPage),
    AutoRoute(path: 'create-journal', page: ProgressJournalCreatorPage),
    AutoRoute(path: 'log-workout', page: LoggedWorkoutCreatorPage),
    RedirectRoute(path: '*', redirectTo: '/')
  ],
)
class $AppRouter {}
