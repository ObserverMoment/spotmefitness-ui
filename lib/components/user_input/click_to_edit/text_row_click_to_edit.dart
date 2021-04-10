import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/my_text_field.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

//// Update Jan 2021 ////
/// TikTok style text editing flow.
/// Clicking opens up auto focused full screen for entering text
/// [EditableTextFieldRow variant] used for single line displays
/// [EditableTextFieldArea variant] used for displaying blocks of text
class EditableTextFieldRow extends StatelessWidget {
  final String title;
  final String text;
  final Function(String) onSave;
  final bool Function(String) inputValidation;
  final String? validationMessage;
  final int maxInputLines;
  final int? maxChars;
  final bool isRequired;

  EditableTextFieldRow(
      {required this.title,
      this.text = '',
      required this.onSave,
      required this.inputValidation,
      this.validationMessage,
      this.maxChars,
      this.maxInputLines = 1,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      onPressed: () => context.push(
          child: FullScreenTextEditing(
        title: title,
        inputValidation: inputValidation,
        validationMessage: validationMessage,
        initialValue: text,
        onSave: onSave,
        maxChars: maxChars,
        maxInputLines: maxInputLines,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Row(
              children: [
                MyText(
                  title,
                ),
                if (isRequired == true) RequiredSuperText()
              ],
            ),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: MyText(
                  text,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(CupertinoIcons.pencil, size: 18),
            ]),
          ),
        ],
      ),
    );
  }
}

class EditableTextAreaRow extends StatelessWidget {
  final String title;
  final String text;
  final String placeholder;
  final int? maxDisplayLines;
  final Function(String) onSave;
  final bool Function(String) inputValidation;
  final String? validationMessage;
  final int? maxInputLines;
  final int? maxChars;
  final bool isRequired;

  EditableTextAreaRow(
      {required this.title,
      this.text = '',
      this.placeholder = 'add...',
      required this.onSave,
      required this.inputValidation,
      this.validationMessage,
      this.maxChars,
      this.maxInputLines,
      this.maxDisplayLines,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      onPressed: () => context.push(
          child: FullScreenTextEditing(
        title: title,
        inputValidation: inputValidation,
        validationMessage: validationMessage,
        initialValue: text,
        onSave: onSave,
        maxChars: maxChars,
        maxInputLines: maxInputLines,
      )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MyText(
                    title,
                  ),
                  if (isRequired == true) RequiredSuperText()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!Utils.textNotNull(text))
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: MyText(
                        placeholder,
                        subtext: true,
                      ),
                    ),
                  Icon(CupertinoIcons.pencil, size: 18),
                ],
              ),
            ],
          ),
          if (text != '')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: MyText(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: maxDisplayLines,
              ),
            ),
        ],
      ),
    );
  }
}

class FullScreenTextEditing extends StatefulWidget {
  final String title;
  final String? initialValue;
  final Function(String) onSave;
  final Function(String) inputValidation;
  final String? validationMessage;
  final int? maxChars;
  final int? maxInputLines;

  FullScreenTextEditing(
      {required this.title,
      this.initialValue,
      required this.onSave,
      required this.inputValidation,
      this.validationMessage,
      this.maxChars,
      this.maxInputLines});

  @override
  _FullScreenTextEditingState createState() => _FullScreenTextEditingState();
}

class _FullScreenTextEditingState extends State<FullScreenTextEditing> {
  late TextEditingController _controller;
  bool _formIsDirty = false;
  bool _inputIsValid() => widget.inputValidation(_controller.text);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() {
      setState(() => _formIsDirty = widget.initialValue != _controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onSave(_controller.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => Navigator.pop(context),
                  child: MyText('Cancel')),
            ],
          ),
          middle: NavBarTitle(widget.title),
          trailing: _formIsDirty && _inputIsValid()
              ? FadeIn(
                  child: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: _handleSave,
                  child: MyText(
                    'Save',
                    color: Styles.infoBlue,
                    weight: FontWeight.bold,
                  ),
                ))
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField(
                    placeholder: widget.title,
                    autofocus: true,
                    maxLines: widget.maxInputLines,
                    controller: _controller),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      if (widget.maxChars != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 2, top: 6.0),
                          child: MyText(
                            '${_controller.text.length}/${widget.maxChars}',
                            size: FONTSIZE.SMALL,
                            color: _controller.text.length > widget.maxChars!
                                ? Styles.errorRed
                                : CupertinoTheme.of(context).primaryColor,
                          ),
                        ),
                      if (widget.validationMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 3, top: 5.0),
                          child: MyText(
                            '(${widget.validationMessage})',
                            size: FONTSIZE.SMALL,
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
