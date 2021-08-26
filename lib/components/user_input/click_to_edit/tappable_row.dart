import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Spans the width with title on left + currently selected value on right.
class TappableRow extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Widget? display;
  final bool showPenIcon;
  const TappableRow(
      {required this.onTap,
      required this.title,
      this.display,
      this.showPenIcon = true});
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
                if (showPenIcon)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(CupertinoIcons.pencil, size: 18),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
