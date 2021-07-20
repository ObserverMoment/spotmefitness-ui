import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/data_vis/waffle_chart.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/components/text.dart';

class PercentageBarChartSingle extends StatelessWidget {
  final List<WaffleChartInput> inputs;
  final double barHeight;
  const PercentageBarChartSingle(
      {Key? key, required this.inputs, this.barHeight = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedInputs =
        inputs.sortedBy<num>((i) => i.fraction).reversed.toList();
    final borderRadius = BorderRadius.circular(30);

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
                width: double.infinity,
                height: barHeight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: sortedInputs.length > 1
                          ? LinearGradient(
                              colors: sortedInputs.map((i) => i.color).toList())
                          : null),
                )),
            Opacity(
              opacity: 0.7,
              child: SizedBox(
                width: double.infinity,
                height: barHeight,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: CustomPaint(
                    painter: GoalsBreakdownGraphicPainter(inputs: sortedInputs),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: sortedInputs
              .map((i) => Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: i.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
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

class GoalsBreakdownGraphicPainter extends CustomPainter {
  final List<WaffleChartInput> inputs;
  GoalsBreakdownGraphicPainter({required this.inputs});

  @override
  void paint(Canvas canvas, Size size) {
    /// The offset will move across the screen when we move to start drawing bar for a new goal.
    /// This will be a fraction of [size] and will end at 1.0.
    double offset = 0.0;

    inputs.forEachIndexed((i, e) {
      final paint = Paint()
        ..color = inputs[i].color
        ..style = PaintingStyle.fill;

      final itemFraction = inputs[i].fraction;
      final itemWidth = itemFraction * size.width;
      final startAt = offset * size.width;

      if (i == inputs.length - 1) {
        /// Paint from sortedInputs[i].fraction * size to 1.0 * size.
        canvas.drawRect(
            Offset(startAt, 0) & Size(itemWidth, size.height), paint);
      } else {
        /// Paint from sortedInputs[i].fraction * size to sortedInputs[i + 1].fraction
        canvas.drawRect(
            Offset(startAt, 0) & Size(itemWidth, size.height), paint);
      }
      offset += itemFraction;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
