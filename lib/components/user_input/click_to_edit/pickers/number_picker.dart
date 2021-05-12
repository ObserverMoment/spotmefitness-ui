import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class NumberPickerInt extends StatelessWidget {
  final int number;
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
      onPressed: () => context.showBottomSheet<int>(
          child: NumberInputModalInt(
        value: number,
        // Need to cast to dynamic because of this.
        // https://github.com/dart-lang/sdk/issues/32042
        saveValue: (v) => saveValue(v),
        title: modalTitle,
      )),
      child: ContentBox(
        child: MyText(
          number.toString(),
          size: FONTSIZE.DISPLAY,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
