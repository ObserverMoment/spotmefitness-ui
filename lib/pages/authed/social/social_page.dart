import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('SocialPage-CupertinoPageScaffold'),
      navigationBar: BasicNavBar(
        heroTag: 'SocialPage',
        key: Key('SocialPage-BasicNavBar'),
        customLeading: NavBarLargeTitle('Social'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: MyText(
                'Chat to friends and workout buddies, join clubs and find great coaches!',
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
