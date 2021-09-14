import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Has diverged (visually) from [NumberPickerDouble] below.
class NumberPickerInt extends StatelessWidget {
  final int? number;
  final void Function(int value) saveValue;
  final String modalTitle;
  final Color? contentBoxColor;
  final FONTSIZE fontSize;
  final Widget? prefix;
  final Widget? suffix;
  NumberPickerInt(
      {required this.number,
      required this.saveValue,
      this.modalTitle = 'How many?',
      this.contentBoxColor,
      this.fontSize = FONTSIZE.DISPLAY,
      this.prefix,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(8),
      onPressed: () => context.showBottomSheet(
          child: NumberInputModalInt(
        value: number,
        saveValue: (v) => saveValue(v),
        title: modalTitle,
      )),
      child: Row(
        children: [
          if (prefix != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: prefix!,
            ),
          MyText(
            number == null ? ' - ' : number.toString(),
            size: fontSize,
          ),
          if (suffix != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: suffix!,
            ),
        ],
      ),
    );
  }
}

class NumberPickerDouble extends StatelessWidget {
  final double? number;
  final void Function(double value) saveValue;
  final String modalTitle;
  final FONTSIZE fontSize;
  NumberPickerDouble(
      {required this.number,
      required this.saveValue,
      this.modalTitle = 'How many?',
      this.fontSize = FONTSIZE.DISPLAY});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(8),
      onPressed: () => context.showBottomSheet(
          child: NumberInputModalDouble(
        value: number,
        saveValue: (v) => saveValue(v),
        title: modalTitle,
      )),
      child: ContentBox(
        child: MyText(
          number == null ? ' - ' : number.toString(),
          size: fontSize,
        ),
      ),
    );
  }
}
