import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';

class DiscoverClubsPage extends StatelessWidget {
  const DiscoverClubsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyPageScaffold(
      navigationBar: MyNavBar(
        middle: NavBarTitle('Clubs'),
      ),
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: MyHeaderText(
              'Coming Soon!',
              size: FONTSIZE.six,
            ),
          )),
    );
  }
}
