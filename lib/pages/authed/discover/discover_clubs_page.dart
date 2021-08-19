import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DiscoverClubsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle('Clubs'),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: MyHeaderText(
              'Coming Soon!',
              size: FONTSIZE.HUGE,
            ),
          )),
    );
  }
}
