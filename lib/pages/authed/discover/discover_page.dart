import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('DiscoverPage-CupertinoPageScaffold'),
      navigationBar: BasicNavBar(
        key: Key('DiscoverPage-BasicNavBar'),
        customLeading: NavBarLargeTitle('Discover'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText('Discover Page'),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
