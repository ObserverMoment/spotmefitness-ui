import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/schedule/coming_up_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_and_timer.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('HomePage-CupertinoPageScaffold'),
      navigationBar: BorderlessNavBar(
        key: Key('HomePage-BasicNavBar'),
        customLeading: NavBarLargeTitle('Home'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.timer_fill,
                  size: 30,
                ),
                onPressed: () => context.push(
                    child: StopwatchAndTimer(), rootNavigator: true)),
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.calendar,
                  size: 30,
                ),
                onPressed: () => context.navigateTo(YourScheduleRoute())),
          ],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8, bottom: kBottomNavBarHeight + 12),
        children: [
          ComingUpList(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.news),
                SizedBox(width: 8),
                H2('News and articles - coming soon!'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1.5,
              physics: NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () => context.navigateTo(YourWorkoutsRoute()),
                  child: HomeScreenCard(
                    content: H2(
                      'Workouts',
                      color: Styles.white,
                    ),
                    assetImagePath: 'home_page_workouts.jpg',
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF0065a3),
                          const Color(0xFF6dd5ed),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourPlansRoute()),
                  child: HomeScreenCard(
                    content: H2(
                      'Plans',
                      color: Styles.white,
                    ),
                    assetImagePath: 'home_page_plans.jpg',
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFcc2b5e),
                          const Color(0xFF414345),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourClubsRoute()),
                  child: HomeScreenCard(
                    content: H2(
                      'Clubs',
                      color: Styles.white,
                    ),
                    assetImagePath: 'home_page_clubs.jpg',
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF2c3e50),
                          const Color(0xFF0F2027),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourEventsRoute()),
                  child: HomeScreenCard(
                    content: H2(
                      'Events',
                      color: Styles.white,
                    ),
                    assetImagePath: 'home_page_events.jpg',
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffe259),
                          const Color(0xFFffa751),
                        ]),
                  ),
                ),
                HomeScreenCard(
                  content: H2(
                    'Challenges',
                    color: Styles.white,
                  ),
                  assetImagePath: 'home_page_challenges.jpg',
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFD31027),
                        const Color(0xFF493240),
                      ]),
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourCollectionsRoute()),
                  child: HomeScreenCard(
                    content: H2(
                      'Collections',
                      color: Styles.white,
                    ),
                    assetImagePath: 'home_page_collections.jpg',
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF6dd5ed),
                          const Color(0xFF314755),
                        ]),
                  ),
                ),
                HomeScreenCard(
                  content: H2(
                    'Nutrition',
                    color: Styles.white,
                  ),
                  assetImagePath: 'home_page_nutrition.jpg',
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF11998e),
                        const Color(0xFF38ef7d),
                      ]),
                ),
                HomeScreenCard(
                  content: H2(
                    'Mind',
                    color: Styles.white,
                  ),
                  assetImagePath: 'home_page_mind.jpg',
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFd9a7c7),
                        const Color(0xFFd9a7c7),
                        const Color(0xFFE9E4F0),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenCard extends StatelessWidget {
  final Widget content;
  final LinearGradient gradient;
  final String? assetImagePath;
  HomeScreenCard(
      {required this.content, required this.gradient, this.assetImagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          image: assetImagePath != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      context.theme.cardBackground.withOpacity(0.15),
                      BlendMode.dstATop),
                  image:
                      AssetImage('assets/home_page_images/${assetImagePath!}'))
              : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(5)),
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: content,
          )),
    );
  }
}
