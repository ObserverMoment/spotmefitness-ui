import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/pages/authed/app.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_page.dart';
import 'package:spotmefitness_ui/pages/authed/discover/plans.dart';
import 'package:spotmefitness_ui/pages/authed/discover/workouts.dart';
import 'package:spotmefitness_ui/pages/authed/discover/you.dart';
import 'package:spotmefitness_ui/pages/authed/home/home_page.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_collections.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_events.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts.dart';
import 'package:spotmefitness_ui/pages/authed/journal/journal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/gym_profiles.dart';
import 'package:spotmefitness_ui/pages/authed/profile/personal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/profile_page.dart';
import 'package:spotmefitness_ui/pages/authed/social/social_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: GlobalPage, usesTabsRouter: true, children: [
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
            RedirectRoute(path: '*', redirectTo: '')
          ]),
      AutoRoute(
          path: 'discover',
          page: DiscoverPage,
          usesTabsRouter: true,
          children: [
            AutoRoute(path: 'you', page: DiscoverYouPage),
            AutoRoute(path: 'workouts', page: DiscoverWorkoutsPage),
            AutoRoute(path: 'plans', page: DiscoverPlansPage),
            RedirectRoute(path: '*', redirectTo: 'personal')
          ]),
      AutoRoute(path: 'social', page: SocialPage),
      AutoRoute(path: 'journal', page: JournalPage),
      AutoRoute(
          path: 'profile',
          page: ProfilePage,
          usesTabsRouter: true,
          children: [
            AutoRoute(path: 'personal', page: ProfilePersonalPage),
            AutoRoute(path: 'gym-profiles', page: ProfileGymProfilesPage),
            RedirectRoute(path: '*', redirectTo: 'personal')
          ]),
    ]),
    RedirectRoute(path: '*', redirectTo: '/')
  ],
)
class $AppRouter {}
