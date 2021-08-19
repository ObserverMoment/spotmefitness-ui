import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
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
  final Color? backgroundColor;
  final TextAlign textAlign;

  /// Pass a controller OR an initial value with and onChange function.
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String text)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

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
      this.backgroundColor,
      this.inputFormatters,
      this.validationMessage,
      this.validator,
      this.textAlign = TextAlign.left})
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              padding:
                  const EdgeInsets.only(left: 8, top: 10, bottom: 6, right: 8),
              decoration: widget.backgroundColor != null
                  ? BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(8))
                  : null,
              child: CupertinoTextFormFieldRow(
                  controller: widget.controller,
                  initialValue: widget.initialValue,
                  onChanged: widget.onChanged,
                  textAlign: widget.textAlign,
                  prefix: widget.prefix,
                  autofocus: widget.autofocus,
                  inputFormatters: widget.inputFormatters,
                  padding: EdgeInsets.only(
                      top: 16,
                      bottom: 4,
                      left: widget.prefix != null ? 18 : 6,
                      right: 12),
                  placeholder: widget.placeholder,
                  keyboardType: widget.keyboardType,
                  style: TextStyle(fontSize: 18),
                  autofillHints: widget.autofillHints,
                  obscureText: widget.obscureText),
            ),
            if (_controller.text.length > 0)
              Positioned(
                  left: widget.prefix != null ? 8 : 17,
                  top: 14,
                  child: FadeIn(
                    child: MyText(
                      widget.placeholder,
                      size: FONTSIZE.TINY,
                      weight: FontWeight.bold,
                    ),
                  )),
            if (widget.validator != null && widget.validator!())
              Positioned(
                  right: 10,
                  top: 28,
                  child: FadeIn(
                      child: Icon(
                    CupertinoIcons.checkmark_alt,
                    color: Styles.infoBlue,
                  ))),
          ],
        ),
        if (widget.validationMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 6),
            child: MyText(
              '(${widget.validationMessage!})',
              size: FONTSIZE.SMALL,
              textAlign: TextAlign.start,
            ),
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
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;

  MyTextAreaFormFieldRow(
      {this.prefix,
      required this.placeholder,
      required this.keyboardType,
      required this.controller,
      this.autofillHints,
      this.autofocus = false,
      this.obscureText = false,
      this.validator,
      this.backgroundColor,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          padding: const EdgeInsets.only(left: 8, top: 10, bottom: 6, right: 8),
          decoration: backgroundColor != null
              ? BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8))
              : null,
          child: CupertinoTextFormFieldRow(
              keyboardAppearance: context.theme.cupertinoThemeData.brightness,
              controller: controller,
              expands: true,
              maxLines: null,
              minLines: null,
              padding: EdgeInsets.only(
                  top: 14, bottom: 4, left: prefix != null ? 18 : 6, right: 12),
              prefix: prefix,
              autofocus: autofocus,
              placeholder: placeholder,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              style: TextStyle(fontSize: 18, height: 1.4),
              autofillHints: autofillHints,
              obscureText: obscureText),
        ),
        if (controller.text.length > 0)
          Positioned(
              left: prefix != null ? 8 : 17,
              top: 14,
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
