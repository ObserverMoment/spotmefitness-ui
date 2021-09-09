import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class RoundPicker extends StatelessWidget {
  final int rounds;
  final void Function(int value) saveValue;
  final String modalTitle;
  final EdgeInsetsGeometry? padding;
  RoundPicker(
      {required this.rounds,
      required this.saveValue,
      this.modalTitle = 'How many rounds?',
      this.padding});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding ?? const EdgeInsets.all(8),
      onPressed: () => context.showBottomSheet<int>(
          child: NumberInputModalInt(
        value: rounds,
        saveValue: (v) => saveValue(v),
        title: modalTitle,
      )),
      child: NumberRoundsIcon(
        rounds,
      ),
    );
  }
}
