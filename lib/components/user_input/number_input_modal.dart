import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// [T] should be either [int] or [double]
class NumberInputModal<T> extends StatefulWidget {
  final String title;
  final T value;
  final void Function<T>(T value) saveValue;
  NumberInputModal(
      {required this.value, required this.saveValue, this.title = 'Enter...'})
      : assert(value is int || value is double,
            'This widget only accepts ints or doubles.');
  @override
  _NumberInputModalState<T> createState() => _NumberInputModalState<T>();
}

class _NumberInputModalState<T> extends State<NumberInputModal> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _saveValue() {
    if (Utils.textNotNull(_controller.text) &&
        _controller.text != widget.value.toString()) {
      widget.value is int
          ? widget.saveValue(int.parse(_controller.text))
          : widget.saveValue(double.parse(_controller.text));
    }
    context.pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalCupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      cancel: context.pop,
      save: _saveValue,
      validToSave: Utils.textNotNull(_controller.text),
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: MyNumberInput(
              _controller,
              allowDouble: widget.value is double,
              autoFocus: true,
            ),
          ),
        ],
      ),
    );
  }
}
