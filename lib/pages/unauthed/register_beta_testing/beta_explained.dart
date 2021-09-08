import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class BetaExplained extends StatelessWidget {
  const BetaExplained({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        middle: NavBarTitle('What is "BETA"?'),
      ),
      child: MyText('Beta explained'),
    );
  }
}
