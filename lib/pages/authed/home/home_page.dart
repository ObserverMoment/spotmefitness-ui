import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/schedule/coming_up_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_and_timer.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('HomePage-CupertinoPageScaffold'),
      navigationBar: BorderlessNavBar(
        key: Key('HomePage-BorderlessNavBar'),
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
        padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
            bottom: EnvironmentConfig.bottomNavBarHeight + 12),
        children: [
          ComingUpList(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.news),
                SizedBox(width: 8),
                H3('News & articles - coming soon!'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1.2,
              physics: NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () => context.navigateTo(YourWorkoutsRoute()),
                  child: _HomeScreenCard(
                    label: 'Workouts',
                    assetImagePath: 'home_page_workouts.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourPlansRoute()),
                  child: _HomeScreenCard(
                    label: 'Plans',
                    assetImagePath: 'home_page_plans.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourClubsRoute()),
                  child: _HomeScreenCard(
                    label: 'Clubs',
                    assetImagePath: 'home_page_clubs.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourEventsRoute()),
                  child: _HomeScreenCard(
                    label: 'Events',
                    assetImagePath: 'home_page_events.jpg',
                  ),
                ),
                _HomeScreenCard(
                  label: 'Challenges',
                  assetImagePath: 'home_page_challenges.jpg',
                ),
                GestureDetector(
                  onTap: () => context.navigateTo(YourCollectionsRoute()),
                  child: _HomeScreenCard(
                    label: 'Collections',
                    assetImagePath: 'home_page_collections.jpg',
                  ),
                ),
                _HomeScreenCard(
                  label: 'Nutrition',
                  assetImagePath: 'home_page_nutrition.jpg',
                ),
                _HomeScreenCard(
                  label: 'Mind',
                  assetImagePath: 'home_page_mind.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeScreenCard extends StatelessWidget {
  final String label;

  final String assetImagePath;
  _HomeScreenCard({required this.label, required this.assetImagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/home_page_images/${assetImagePath}')),
          borderRadius: BorderRadius.circular(5)),
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ContentBox(
              child: MyText(
                label,
                weight: FontWeight.bold,
                maxLines: 2,
                lineHeight: 1.3,
              ),
              borderRadius: 4,
            ),
          )),
    );
  }
}
