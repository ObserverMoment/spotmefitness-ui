import 'package:flutter/cupertino.dart';
import 'package:supercharged/supercharged.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/components/text.dart';

class WaffleChart extends StatelessWidget {
  final List<WaffleChartInput> inputs;
  final double width;
  WaffleChart({Key? key, required this.inputs, required this.width})
      : assert(inputs.sumByDouble((i) => i.fraction) == 1.0),
        super(key: key);

  final kTotalBlocks = 100;

  List<Widget> _buildList() {
    final sortedInputs = inputs.sortedBy<num>((i) => i.fraction);
    List<Widget> children = [];

    /// The value already accounted for by the preceding inputs.
    double curRangeLow = 0.0;

    for (var i = 0; i < kTotalBlocks; i++) {
      if ((i / kTotalBlocks) >= sortedInputs[0].fraction + curRangeLow) {
        curRangeLow += sortedInputs[0].fraction;
        sortedInputs.removeAt(0);
      }
      children.add(Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: sortedInputs[0].color,
        ),
      ));
    }

    /// Reversed as we want the largest block at the top.
    return children.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width,
          child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              crossAxisCount: 10,
              shrinkWrap: true,
              children: _buildList()),
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: inputs
              .sortedBy<num>((i) => i.fraction)
              .reversed
              .map((i) => Container(
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6),
                        MyText(
                          i.name,
                          size: FONTSIZE.SMALL,
                        ),
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}

class WaffleChartInput {
  final double fraction;
  final Color color;
  final String name;
  WaffleChartInput(
      {required this.fraction, required this.color, required this.name});
}
