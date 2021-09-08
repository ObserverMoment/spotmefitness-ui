import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

class CommaSeparatedList extends StatelessWidget {
  final List<String> names;
  final FONTSIZE fontSize;
  CommaSeparatedList(this.names, {this.fontSize = FONTSIZE.SMALL});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1,
      runSpacing: 5,
      children: names
          .asMap()
          .map((index, name) => MapEntry(
              index,
              MyText(
                index == names.length - 1 ? '$name.' : '$name, ',
                size: fontSize,
              )))
          .values
          .toList(),
    );
  }
}

class ListAvoidFAB extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  const ListAvoidFAB({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount + 1,
        itemBuilder: (c, i) {
          if (i == itemCount) {
            /// The height (hard coded!) needed to allow the list to scroll clear of the FAB.
            return SizedBox(height: 60);
          } else {
            return itemBuilder(context, i);
          }
        });
  }
}
