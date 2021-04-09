import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(title),
            Row(
              children: [
                display ??
                    MyText(
                      'Select...',
                      color: Styles.grey,
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
