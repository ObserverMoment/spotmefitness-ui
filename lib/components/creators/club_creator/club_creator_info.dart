import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class ClubCreatorInfo extends StatelessWidget {
  final Club club;
  final void Function(Map<String, dynamic> data) updateClub;

  const ClubCreatorInfo(
      {Key? key, required this.club, required this.updateClub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedSwitcher(
        duration: kStandardAnimationDuration,
        child: ListView(
          children: [
            EditableTextFieldRow(
              title: 'Name',
              isRequired: true,
              text: club.name,
              onSave: (t) => updateClub({'name': t}),
              inputValidation: (t) => t.length > 3 && t.length <= 30,
              validationMessage: 'Min 3, max 20 characters',
              maxChars: 20,
            ),
            EditableTextAreaRow(
              title: 'Description',
              text: club.description ?? '',
              onSave: (t) => updateClub({'description': t}),
              inputValidation: (t) => true,
              maxDisplayLines: 4,
            ),
            EditableTextFieldRow(
              title: 'Location',
              text: club.location ?? '',
              onSave: (t) => updateClub({'location': t}),
              inputValidation: (t) => true,
            ),
          ],
        ),
      ),
    );
  }
}
