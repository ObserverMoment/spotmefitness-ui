import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

class YourEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: MyText('YourEventsPage'),
    );
  }
}
