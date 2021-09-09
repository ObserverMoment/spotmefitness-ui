import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class NumberPickerInt extends StatelessWidget {
  final int? number;
  final void Function(int value) saveValue;
  final String modalTitle;
  NumberPickerInt(
      {required this.number,
      required this.saveValue,
      this.modalTitle = 'How many?'});

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
      child: ContentBox(
        child: MyText(
          number == null ? ' - ' : number.toString(),
          size: FONTSIZE.DISPLAY,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NumberPickerDouble extends StatelessWidget {
  final double? number;
  final void Function(double value) saveValue;
  final String modalTitle;
  NumberPickerDouble(
      {required this.number,
      required this.saveValue,
      this.modalTitle = 'How many?'});

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
          size: FONTSIZE.DISPLAY,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
