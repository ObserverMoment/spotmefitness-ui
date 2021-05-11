import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

class CommaSeparatedList extends StatelessWidget {
  final List<String> names;
  CommaSeparatedList(this.names);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1,
      runSpacing: 1,
      children: names
          .asMap()
          .map((index, name) => MapEntry(
              index,
              MyText(
                index == names.length - 1 ? '$name.' : '$name, ',
                size: FONTSIZE.SMALL,
              )))
          .values
          .toList(),
    );
  }
}
