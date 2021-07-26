import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Spans the width with title on left + currently selected value on right.
class TappableRow extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Widget? display;
  TappableRow({required this.onTap, required this.title, this.display});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(title),
            Row(
              children: [
                display ??
                    MyText(
                      'Select...',
                      color: context.theme.primary.withOpacity(0.5),
                    ),
                SizedBox(
                  width: 8,
                ),
                Icon(CupertinoIcons.pencil, size: 18)
              ],
            )
          ],
        ),
      ),
    );
  }
}
