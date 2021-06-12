import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('DiscoverPage-CupertinoPageScaffold'),
      navigationBar: BasicNavBar(
        heroTag: 'DiscoverPage',
        key: Key('DiscoverPage-BasicNavBar'),
        customLeading: NavBarLargeTitle('Discover'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: MyText(
                'Discover great new workouts, plans, challenges and events!',
                maxLines: 6,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
