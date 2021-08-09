import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class YourChallengesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle('Challenges'),
      ),
      child: Center(
        child: MyHeaderText(
          'Coming soon!',
          size: FONTSIZE.HUGE,
        ),
      ),
    );
  }
}
