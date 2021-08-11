import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class MyNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final bool allowDouble;
  final double textSize;
  final bool autoFocus;
  final Color? backgroundColor;
  MyNumberInput(
    this.controller, {
    this.allowDouble = false,
    this.textSize = 50,
    this.autoFocus = false,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      keyboardAppearance: context.theme.cupertinoThemeData.brightness,
      autofocus: autoFocus,
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: autoFocus),
      // https://stackoverflow.com/questions/54454983/allow-only-two-decimal-number-in-flutter-input
      inputFormatters: [
        allowDouble
            ? FilteringTextInputFormatter.allow((RegExp(r'^\d+\.?\d{0,2}')))
            : FilteringTextInputFormatter.digitsOnly
      ],
      decoration: BoxDecoration(
          color: backgroundColor ?? context.theme.cardBackground,
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      style: TextStyle(fontSize: textSize, height: 1),
      textAlign: TextAlign.center,
    );
  }
}
