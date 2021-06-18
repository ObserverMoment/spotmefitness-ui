import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DiscoverEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle('Events'),
      ),
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
                      child: H1('Curated Event Content ${index + 1}'))),
            ),
          ),
        ),
      ),
    );
  }
}
