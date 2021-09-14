import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';

class SaveAndClosePicker extends StatelessWidget {
  final void Function() saveAndClose;
  final bool disabled;
  SaveAndClosePicker({required this.saveAndClose, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
        onPressed: saveAndClose, disabled: disabled, text: 'Save');
  }
}
