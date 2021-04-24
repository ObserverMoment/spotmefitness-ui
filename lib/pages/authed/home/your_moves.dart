import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class YourMovesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(),
      child: MyText('YourMovesPage'),
    );
  }
}
