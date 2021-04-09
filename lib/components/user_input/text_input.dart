import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';

class MyTextFormFieldRow extends StatelessWidget {
  final Widget? prefix;
  final String placeholder;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool autofocus;
  final TextEditingController controller;
  final bool Function()? validator;

  MyTextFormFieldRow(
      {this.prefix,
      required this.placeholder,
      required this.keyboardType,
      required this.controller,
      this.autofillHints,
      this.autofocus = false,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoTextFormFieldRow(
            controller: controller,
            padding: EdgeInsets.only(top: 12, bottom: 4, left: 12, right: 12),
            prefix: prefix,
            autofocus: autofocus,
            placeholder: placeholder,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 18),
            autofillHints: autofillHints,
            obscureText: obscureText),
        if (controller.text.length > 0)
          Positioned(
              left: 18,
              top: 5,
              child: FadeIn(
                child: MyText(
                  placeholder,
                  size: FONTSIZE.TINY,
                  weight: FontWeight.bold,
                ),
              )),
        if (validator != null && validator!())
          Positioned(
              right: 5,
              bottom: 16,
              child: FadeIn(
                  child: Icon(
                CupertinoIcons.check_mark_circled,
                color: CupertinoColors.systemBlue,
              ))),
      ],
    );
  }
}

class MyPasswordFieldRow extends StatefulWidget {
  final Widget? prefix;
  final bool obscureText;
  final bool autofocus;
  final TextEditingController controller;
  final bool Function()? validator;
  final List<String>? autofillHints;

  MyPasswordFieldRow(
      {this.prefix,
      required this.controller,
      this.autofillHints,
      this.autofocus = false,
      this.obscureText = false,
      this.validator});

  @override
  _MyPasswordFieldRowState createState() => _MyPasswordFieldRowState();
}

class _MyPasswordFieldRowState extends State<MyPasswordFieldRow> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: MyTextFormFieldRow(
            prefix: Icon(CupertinoIcons.lock_shield_fill),
            placeholder: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_showPassword,
            controller: widget.controller,
            validator: widget.validator,
            autofillHints: widget.autofillHints,
          ),
        ),
        CupertinoButton(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _showPassword
                  ? Icon(CupertinoIcons.eye_slash_fill)
                  : Icon(CupertinoIcons.eye_fill),
            ),
            onPressed: () => setState(() => _showPassword = !_showPassword))
      ],
    );
  }
}

class MyTextAreaFormFieldRow extends StatelessWidget {
  final Widget? prefix;
  final String placeholder;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool autofocus;
  final TextEditingController controller;
  final bool Function()? validator;

  MyTextAreaFormFieldRow(
      {this.prefix,
      required this.placeholder,
      required this.keyboardType,
      required this.controller,
      this.autofillHints,
      this.autofocus = false,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoTextFormFieldRow(
            controller: controller,
            expands: true,
            maxLines: null,
            minLines: null,
            padding: EdgeInsets.only(top: 20, bottom: 4, left: 18, right: 12),
            prefix: prefix,
            autofocus: autofocus,
            placeholder: placeholder,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 18, height: 1.4),
            autofillHints: autofillHints,
            obscureText: obscureText),
        if (controller.text.length > 0)
          Positioned(
              left: 18,
              top: 5,
              child: FadeIn(
                child: MyText(
                  placeholder,
                  size: FONTSIZE.TINY,
                  weight: FontWeight.bold,
                ),
              )),
        if (validator != null && validator!())
          Positioned(
              right: 5,
              bottom: 16,
              child: FadeIn(
                  child: Icon(
                CupertinoIcons.check_mark_circled,
                color: CupertinoColors.systemBlue,
              ))),
      ],
    );
  }
}
