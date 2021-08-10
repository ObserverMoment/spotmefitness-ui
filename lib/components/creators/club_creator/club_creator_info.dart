import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ClubCreatorInfo extends StatelessWidget {
  /// Before there is a created club in the DB user can enter basic initial fields (inline text input fields) before creating. Once the club is created (and the user is now 'editing) then we show the standard [TextFieldRow] style inputs which open in a new page to edit.
  final bool showPreCreateUI;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController locationController;

  const ClubCreatorInfo({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    required this.locationController,
    required this.showPreCreateUI,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedSwitcher(
        duration: kStandardAnimationDuration,
        child: showPreCreateUI
            ? ListView(
                shrinkWrap: true,
                children: [
                  MyTextFormFieldRow(
                    autofocus: true,
                    backgroundColor: context.theme.cardBackground,
                    controller: nameController,
                    placeholder: 'Name',
                    keyboardType: TextInputType.text,
                    validator: () =>
                        nameController.text.length > 2 &&
                        nameController.text.length < 21,
                    validationMessage: 'Min 3, max 20 characters',
                  ),
                  MyTextAreaFormFieldRow(
                      placeholder: 'Description (optional)',
                      backgroundColor: context.theme.cardBackground,
                      keyboardType: TextInputType.text,
                      controller: descriptionController),
                  MyTextAreaFormFieldRow(
                      placeholder: 'Location (optional)',
                      backgroundColor: context.theme.cardBackground,
                      keyboardType: TextInputType.text,
                      controller: locationController),
                ],
              )
            : ListView(
                children: [
                  EditableTextFieldRow(
                    title: 'Name',
                    isRequired: true,
                    text: nameController.text,
                    onSave: (newText) => nameController.text = newText,
                    inputValidation: (String text) =>
                        text.length > 3 && text.length <= 30,
                    validationMessage: 'Min 3, max 20 characters',
                    maxChars: 20,
                  ),
                  EditableTextAreaRow(
                    title: 'Description',
                    text: descriptionController.text,
                    onSave: (newText) => descriptionController.text = newText,
                    inputValidation: (t) => true,
                    maxDisplayLines: 4,
                  ),
                  EditableTextFieldRow(
                    title: 'Location',
                    text: locationController.text,
                    onSave: (newText) => locationController.text = newText,
                    inputValidation: (t) => true,
                  ),
                ],
              ),
      ),
    );
  }
}
