import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DiscoverPeoplePage extends StatelessWidget {
  const DiscoverPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: BorderlessNavBar(middle: NavBarTitle('Discover People')),
        child: Container(
          child: Center(
              child: MyHeaderText(
            'Coming soon!',
            size: FONTSIZE.BIG,
          )),
        ));
  }
}
