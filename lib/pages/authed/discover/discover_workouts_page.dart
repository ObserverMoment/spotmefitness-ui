import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/router.gr.dart';

class DiscoverWorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle('Workouts'),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: PrimaryButton(
                  text: 'Find a Workout',
                  prefix: Icon(
                    CupertinoIcons.viewfinder_circle,
                    color: Styles.infoBlue,
                  ),
                  onPressed: () => context.navigateTo(
                      WorkoutFinderRoute(initialOpenPublicTab: true))),
            ),
          ),
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
                            child: H1('Curated Workout Content ${index + 1}'))),
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
