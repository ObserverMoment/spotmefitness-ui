import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/schedule/weekly_calendar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/router.gr.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('HomePage-CupertinoPageScaffold'),
      navigationBar: BasicNavBar(
        key: Key('HomePage-BasicNavBar'),
        leading: NavBarLargeTitle('Home'),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.calendar,
              size: 30,
            ),
            onPressed: () => context.pushRoute(YourScheduleRoute())),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 12),
              child: ListView(
                shrinkWrap: true,
                children: [
                  WeeklyCalendar(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: H2('News and articles - coming soon'),
                  ),
                  GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1.5,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () => context.pushRoute(YourCollectionsRoute()),
                        child: HomeScreenCard(
                          content: H2(
                            'Collections',
                            color: Styles.white,
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFF09819),
                                const Color(0xFFEDDE5D),
                              ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushRoute(YourWorkoutsRoute()),
                        child: HomeScreenCard(
                          content: H2(
                            'Workouts',
                            color: Styles.white,
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF232526),
                                const Color(0xFF414345),
                              ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushRoute(YourPlansRoute()),
                        child: HomeScreenCard(
                          content: H2(
                            'Plans',
                            color: Styles.white,
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF4CA1AF),
                                const Color(0xFF2C3E50),
                              ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushRoute(YourEventsRoute()),
                        child: HomeScreenCard(
                          content: H2(
                            'Events',
                            color: Styles.white,
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF004e92),
                                const Color(0xFF000428),
                              ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushRoute(YourClubsRoute()),
                        child: HomeScreenCard(
                          content: H2(
                            'Clubs',
                            color: Styles.white,
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFF09819),
                                const Color(0xFFEDDE5D),
                              ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushRoute(YourMovesRoute()),
                        child: HomeScreenCard(
                          content: H2(
                            'Moves',
                            color: Styles.white,
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF232526),
                                const Color(0xFF414345),
                              ]),
                        ),
                      ),
                      HomeScreenCard(
                        content: H2(
                          'Nutrition',
                          color: Styles.white,
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF4CA1AF),
                              const Color(0xFF2C3E50),
                            ]),
                      ),
                      HomeScreenCard(
                        content: H2(
                          'Mind',
                          color: Styles.white,
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF004e92),
                              const Color(0xFF000428),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
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
  HomeScreenCard({required this.content, required this.gradient});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: BorderRadius.circular(10)),
      child: Center(child: content),
    );
  }
}
