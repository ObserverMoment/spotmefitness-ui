import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('SocialPage-CupertinoPageScaffold'),
      navigationBar: BasicNavBar(
        key: Key('SocialPage-BasicNavBar'),
        leading: NavBarLargeTitle('Social'),
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
                    MyText('Social Page'),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
