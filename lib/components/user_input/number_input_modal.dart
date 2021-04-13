import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
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
    final backgroundColor = context.theme.cardBackground.withOpacity(0.8);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: NavBarCancelButton(context.pop),
        backgroundColor: backgroundColor,
        middle: NavBarTitle(widget.title),
        trailing: Utils.textNotNull(_controller.text)
            ? FadeIn(child: NavBarSaveButton(_saveValue))
            : null,
      ),
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
            child: CupertinoTextField(
              controller: _controller,
              keyboardAppearance: context.theme.cupertinoThemeData.brightness,
              autofocus: true,
              keyboardType: TextInputType.number,
              // https://stackoverflow.com/questions/54454983/allow-only-two-decimal-number-in-flutter-input
              inputFormatters: [
                widget.value is int
                    ? FilteringTextInputFormatter.digitsOnly
                    : FilteringTextInputFormatter.allow(
                        (RegExp(r'^\d+\.?\d{0,2}')))
              ],
              decoration: BoxDecoration(
                  color: Styles.lightGrey.withOpacity(0.01),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              style: TextStyle(fontSize: 50, height: 1),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
