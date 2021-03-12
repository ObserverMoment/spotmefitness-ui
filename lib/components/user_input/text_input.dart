import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';

class MyTextFormFieldRow extends StatelessWidget {
  final Widget? prefix;
  final String placeholder;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final bool Function()? validator;

  MyTextFormFieldRow(
      {this.prefix,
      required this.placeholder,
      required this.keyboardType,
      required this.controller,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoTextFormFieldRow(
            controller: controller,
            padding: EdgeInsets.only(top: 18, bottom: 8, left: 18, right: 12),
            prefix: prefix,
            placeholder: placeholder,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 18),
            obscureText: obscureText),
        if (controller.text.length > 0)
          Positioned(
              left: 18,
              top: 5,
              child: FadeIn(
                child: MyText(
                  placeholder,
                  size: FONTSIZE.TINY,
                  weight: FONTWEIGHT.BOLD,
                ),
              )),
        if (validator != null && validator!())
          Positioned(
              right: 5,
              top: 5,
              child: FadeIn(
                  child: Icon(
                CupertinoIcons.check_mark_circled,
                color: CupertinoColors.activeGreen,
              ))),
      ],
    );
  }
}
