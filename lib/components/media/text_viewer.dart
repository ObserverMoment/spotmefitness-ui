import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class TextViewer extends StatelessWidget {
  final String text;
  final String title;
  TextViewer(this.text, this.title);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: NavBarTitle(title),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: MyText(
            text,
            maxLines: 999,
          ),
        ),
      ),
    );
  }
}
