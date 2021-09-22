import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/schedule/coming_up_list.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/timers/stopwatch_and_timer.dart';
import 'package:sofie_ui/env_config.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/stream.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildNavBarButton(IconData iconData, VoidCallback onPressed) =>
      CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          onPressed: onPressed,
          child: Icon(iconData));

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        withoutLeading: true,
        middle: const LeadingNavBarTitle(
          'My Studio',
          fontSize: FONTSIZE.five,
        ),
        trailing: NavBarTrailingRow(children: [
          const ChatsIconButton(),
          _buildNavBarButton(
              CupertinoIcons.timer,
              () => context.push(
                  child: const CupertinoPageScaffold(
                      navigationBar: MyNavBar(
                        middle: NavBarTitle('Timers'),
                      ),
                      child: StopwatchAndTimer()),
                  rootNavigator: true)),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ComingUpList(),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: MyHeaderText(
              'Created and Saved',
              size: FONTSIZE.five,
            ),
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1.3,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () => context.navigateTo(const YourWorkoutsRoute()),
                child: const _HomeScreenCard(
                  label: 'Workouts',
                  assetImagePath: 'home_page_workouts.jpg',
                ),
              ),
              GestureDetector(
                onTap: () => context.navigateTo(const YourPlansRoute()),
                child: const _HomeScreenCard(
                  label: 'Plans',
                  assetImagePath: 'home_page_plans.jpg',
                ),
              ),
              GestureDetector(
                onTap: () => context.navigateTo(const YourClubsRoute()),
                child: const _HomeScreenCard(
                  label: 'Clubs',
                  assetImagePath: 'home_page_clubs.jpg',
                ),
              ),
              GestureDetector(
                onTap: () => context.showAlertDialog(title: 'Coming Soon!'),
                child: const _HomeScreenCard(
                  label: 'Events',
                  assetImagePath: 'home_page_events.jpg',
                ),
              ),
              GestureDetector(
                onTap: () => context.showAlertDialog(title: 'Coming Soon!'),
                child: const _HomeScreenCard(
                  label: 'Challenges',
                  assetImagePath: 'home_page_challenges.jpg',
                ),
              ),
              GestureDetector(
                onTap: () => context.navigateTo(const YourCollectionsRoute()),
                child: const _HomeScreenCard(
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
  const _HomeScreenCard({required this.label, required this.assetImagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/home_page_images/$assetImagePath')),
          borderRadius: BorderRadius.circular(4)),
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ContentBox(
              borderRadius: 4,
              child: MyText(
                label,
                lineHeight: 1,
              ),
            ),
          )),
    );
  }
}
