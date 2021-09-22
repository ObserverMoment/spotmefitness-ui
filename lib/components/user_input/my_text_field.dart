import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';

/// Used for [TextRowClickToEdit] components
class MyTextField extends StatefulWidget {
  @override
  final Key? key;
  final bool autofocus;
  final FocusNode? focusNode;
  final Widget? icon;
  final String? placeholder;
  final bool isPassword;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final void Function(String)? onUnfocus;
  final String? initialValue;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextField(
      {this.key,
      required this.controller,
      this.autofocus = false,
      this.focusNode,
      this.icon,
      this.placeholder,
      this.textInputType,
      this.isPassword = false,
      this.maxLines = 1,
      this.maxLength,
      this.onUnfocus,
      this.initialValue,
      this.textAlign = TextAlign.start,
      this.autofillHints,
      this.inputFormatters})
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.onUnfocus != null) {
      _focusNode.addListener(() {
        if (mounted && !_focusNode.hasFocus) {
          widget.onUnfocus!(widget.controller.text);
        }
      });
    }
  }

  void _onClear() {
    setState(() {
      widget.controller.clear();
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      // If the focusNode did not come from a parent, you can dispose of it.
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CupertinoTextField(
        keyboardAppearance: context.theme.cupertinoThemeData.brightness,
        key: widget.key,
        maxLines: widget.maxLines,
        controller: widget.controller,
        autofocus: widget.autofocus,
        focusNode: _focusNode,
        maxLength: widget.maxLength,
        obscureText: widget.isPassword,
        textAlign: widget.textAlign,
        autofillHints: widget.autofillHints,
        style: const TextStyle(fontWeight: FontWeight.w500),
        inputFormatters: widget.inputFormatters,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: widget.icon,
        ),
        suffix: widget.controller.text.length > 2 && _focusNode.hasFocus
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _onClear,
                child: Icon(CupertinoIcons.clear_thick_circled,
                    color: CupertinoTheme.of(context)
                        .primaryColor
                        .withOpacity(0.8),
                    size: 18),
              )
            : null,
        placeholderStyle: TextStyle(
            color: CupertinoTheme.of(context).primaryColor.withOpacity(0.5)),
        placeholder: widget.placeholder,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        keyboardType: widget.isPassword
            ? TextInputType.visiblePassword
            : widget.textInputType ?? TextInputType.text,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).primaryColor.withOpacity(0.1),
        ),
      ),
    );
  }
}
