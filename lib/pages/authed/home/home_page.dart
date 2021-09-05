import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/schedule/coming_up_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_and_timer.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/stream.dart';

class HomePage extends StatelessWidget {
  Widget _buildNavBarButton(IconData iconData, onPressed) => CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      onPressed: onPressed,
      child: Icon(iconData));

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      key: Key('HomePage-MyPageScaffold'),
      navigationBar: MyNavBar(
        key: Key('HomePage-MyNavBar'),
        customLeading: NavBarLargeTitle('Home'),
        trailing: NavBarTrailingRow(children: [
          NotificationsIconButton(),
          ChatsIconButton(),
          _buildNavBarButton(
              CupertinoIcons.timer,
              () => context.push(
                  child: StopwatchAndTimer(), rootNavigator: true)),
          _buildNavBarButton(
            CupertinoIcons.calendar,
            () => context.navigateTo(YourScheduleRoute()),
          ),
        ]),
      ),
      child: ListView(
        padding:
            EdgeInsets.only(bottom: EnvironmentConfig.bottomNavBarHeight + 12),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ComingUpList(),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyHeaderText(
              'Created and Saved',
              size: FONTSIZE.LARGE,
            ),
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1.3,
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
              GestureDetector(
                onTap: () => () => context.navigateTo(YourChallengesRoute()),
                child: _HomeScreenCard(
                  label: 'Challenges',
                  assetImagePath: 'home_page_challenges.jpg',
                ),
              ),
              GestureDetector(
                onTap: () => context.navigateTo(YourCollectionsRoute()),
                child: _HomeScreenCard(
                  label: 'Collections',
                  assetImagePath: 'home_page_collections.jpg',
                ),
              ),
            ],
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
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/home_page_images/${assetImagePath}')),
          borderRadius: BorderRadius.circular(4)),
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ContentBox(
              child: MyText(
                label,
                lineHeight: 1,
              ),
              borderRadius: 4,
            ),
          )),
    );
  }
}
