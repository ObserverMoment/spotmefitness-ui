import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Used for standard on screen text inputs where focusing the field brings up a keyboard.
class MyTextFormFieldRow extends StatefulWidget {
  final Widget? prefix;
  final String placeholder;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool autofocus;
  final String? validationMessage;
  final bool Function()? validator;

  /// Pass a controller OR an initial value with and onChange function.
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String text)? onChanged;

  MyTextFormFieldRow(
      {this.prefix,
      required this.placeholder,
      required this.keyboardType,
      this.controller,
      this.initialValue,
      this.onChanged,
      this.autofillHints,
      this.autofocus = false,
      this.obscureText = false,
      this.validationMessage,
      this.validator})
      : assert(
            controller != null || (initialValue != null && onChanged != null));

  @override
  _MyTextFormFieldRowState createState() => _MyTextFormFieldRowState();
}

class _MyTextFormFieldRowState extends State<MyTextFormFieldRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CupertinoTextFormFieldRow(
                controller: widget.controller,
                initialValue: widget.initialValue,
                onChanged: widget.onChanged,
                padding:
                    EdgeInsets.only(top: 12, bottom: 4, left: 12, right: 12),
                prefix: widget.prefix,
                autofocus: widget.autofocus,
                placeholder: widget.placeholder,
                keyboardType: widget.keyboardType,
                style: TextStyle(fontSize: 18),
                placeholderStyle: TextStyle(fontSize: 16),
                autofillHints: widget.autofillHints,
                obscureText: widget.obscureText),
            if (_controller.text.length > 0)
              Positioned(
                  left: widget.prefix != null ? 8 : 17,
                  top: 5,
                  child: FadeIn(
                    child: MyText(
                      widget.placeholder,
                      size: FONTSIZE.TINY,
                      weight: FontWeight.bold,
                    ),
                  )),
            if (widget.validator != null && widget.validator!())
              Positioned(
                  right: 6,
                  bottom: 16,
                  child: FadeIn(
                      child: Icon(
                    CupertinoIcons.checkmark_alt,
                    color: CupertinoColors.systemBlue,
                  ))),
          ],
        ),
        if (widget.validationMessage != null)
          MyText(
            '(${widget.validationMessage!})',
            size: FONTSIZE.SMALL,
          ),
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
            keyboardAppearance: context.theme.cupertinoThemeData.brightness,
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
              left: prefix != null ? 8 : 17,
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
