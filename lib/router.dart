import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/pages/authed/app.dart';
import 'package:spotmefitness_ui/pages/authed/discover/discover_page.dart';
import 'package:spotmefitness_ui/pages/authed/home/home_page.dart';
import 'package:spotmefitness_ui/pages/authed/journal/journal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/gym_profiles.dart';
import 'package:spotmefitness_ui/pages/authed/profile/personal_page.dart';
import 'package:spotmefitness_ui/pages/authed/profile/profile_page.dart';
import 'package:spotmefitness_ui/pages/authed/social/social_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: GlobalPage, usesTabsRouter: true, children: [
      AutoRoute(path: 'home', name: 'homeRouter', page: HomePage),
      AutoRoute(path: 'discover', name: 'discoverRouter', page: DiscoverPage),
      AutoRoute(path: 'social', name: 'socialRouter', page: SocialPage),
      AutoRoute(path: 'journal', name: 'journalRouter', page: JournalPage),
      AutoRoute(
          path: 'profile',
          name: 'profileRouter',
          page: ProfilePage,
          usesTabsRouter: true,
          children: [
            AutoRoute(
                path: 'personal',
                name: 'profilePersonalRouter',
                page: ProfilePersonalPage),
            AutoRoute(
                path: 'gym-profiles',
                name: 'profileGymProfilesRouter',
                page: ProfileGymProfilesPage),
            RedirectRoute(path: '*', redirectTo: 'personal')
          ]),
      RedirectRoute(path: '*', redirectTo: '/')
    ]),
  ],
)
class $AppRouter {}
