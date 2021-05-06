import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/pages/authed/app.dart';
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
import 'package:spotmefitness_ui/pages/authed/profile/gym_profiles.dart';
import 'package:spotmefitness_ui/pages/authed/profile/personal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/profile_page.dart';
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
            AutoRoute(path: 'your-schedule', page: YourSchedulePage),
            AutoRoute(path: 'your-collections', page: YourCollectionsPage),
            AutoRoute(path: 'your-workouts', page: YourWorkoutsPage),
            AutoRoute(path: 'your-plans', page: YourPlansPage),
            AutoRoute(path: 'your-events', page: YourEventsPage),
            AutoRoute(path: 'your-clubs', page: YourClubsPage),
            AutoRoute(path: 'your-moves', page: YourMovesPage),
            RedirectRoute(path: '*', redirectTo: '')
          ]),
      AutoRoute(path: 'discover', page: DiscoverPage, children: [
        AutoRoute(path: 'you', page: DiscoverYouPage),
        AutoRoute(path: 'workouts', page: DiscoverWorkoutsPage),
        AutoRoute(path: 'plans', page: DiscoverPlansPage),
        RedirectRoute(path: '*', redirectTo: 'personal')
      ]),
      AutoRoute(path: 'social', page: SocialPage),
      AutoRoute(path: 'journal', page: JournalPage),
      AutoRoute(path: 'profile', page: ProfilePage, children: [
        AutoRoute(path: 'personal', page: ProfilePersonalPage),
        AutoRoute(path: 'gym-profiles', page: ProfileGymProfilesPage),
        RedirectRoute(path: '*', redirectTo: 'personal')
      ]),
    ]),
    AutoRoute(path: '/workout/:id', page: WorkoutDetailsPage),
    RedirectRoute(path: '*', redirectTo: '/')
  ],
)
class $AppRouter {}
