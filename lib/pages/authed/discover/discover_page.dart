import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/router.gr.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        customLeading: NavBarLargeTitle('Discover'),
      ),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 12, bottom: 8),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BorderButton(
                      mini: true,
                      text: 'Workouts',
                      onPressed: () =>
                          context.navigateTo(DiscoverWorkoutsRoute())),
                  BorderButton(
                      mini: true,
                      text: 'Plans',
                      onPressed: () =>
                          context.navigateTo(DiscoverPlansRoute())),
                  BorderButton(
                      mini: true,
                      text: 'Challenges',
                      onPressed: () =>
                          context.navigateTo(DiscoverChallengesRoute())),
                  BorderButton(
                      mini: true,
                      text: 'Events',
                      onPressed: () =>
                          context.navigateTo(DiscoverEventsRoute())),
                ],
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: SizedBox(
                            height: 150,
                            child: H1('Curated Content ${index + 1}'))),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
