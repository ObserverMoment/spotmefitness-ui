import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/schedule/weekly_calendar.dart';
import 'package:spotmefitness_ui/components/text.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      H2('Today'),
                      MyText('Workouts + Events in list'),
                    ],
                  ),
                  WeeklyCalendar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: H2('News and articles - coming soon'),
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      HomeScreenCard(
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
                      HomeScreenCard(
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
                      HomeScreenCard(
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
                      HomeScreenCard(
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
                    ],
                  )
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
          gradient: gradient, borderRadius: BorderRadius.circular(16)),
      child: Center(child: content),
    );
  }
}
