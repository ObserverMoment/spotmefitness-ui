import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class RoundPicker extends StatelessWidget {
  final int rounds;
  final void Function(int value) saveValue;
  final String modalTitle;
  RoundPicker(
      {required this.rounds,
      required this.saveValue,
      this.modalTitle = 'How many rounds?'});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(8),
      onPressed: () => context.showBottomSheet<int>(
          child: NumberInputModal<int>(
        value: rounds,
        // Need to cast to dynamic because of this.
        // https://github.com/dart-lang/sdk/issues/32042
        saveValue: <int>(dynamic v) => saveValue(v),
        title: 'How many rounds?',
      )),
      child: NumberRoundsIcon(
        rounds,
        alignment: Axis.vertical,
      ),
    );
  }
}
