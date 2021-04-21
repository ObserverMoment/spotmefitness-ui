import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

class TextViewer extends StatelessWidget {
  final String text;
  final String title;
  TextViewer(this.text, this.title);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            H2(title),
            SizedBox(height: 16),
            MyText(
              text,
              maxLines: 999,
            ),
          ],
        ),
      ),
    );
  }
}
