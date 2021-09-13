import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section_summary_tag.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class LoggedWorkoutSectionSummaryCard extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final void Function(String note)? addNoteToLoggedSection;
  final bool showSectionName;
  const LoggedWorkoutSectionSummaryCard(
      {Key? key,
      required this.loggedWorkoutSection,
      this.addNoteToLoggedSection,
      this.showSectionName = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showSectionName && Utils.textNotNull(loggedWorkoutSection.name))
          MyText(
            '"${loggedWorkoutSection.name!}"',
            weight: FontWeight.bold,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: LoggedWorkoutSectionSummaryTag(
                loggedWorkoutSection,
              ),
            ),
            if (addNoteToLoggedSection != null)
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: AnimatedSwitcher(
                    duration: kStandardAnimationDuration,
                    child: Utils.textNotNull(loggedWorkoutSection.note)
                        ? MyText(
                            'Edit note',
                            weight: FontWeight.bold,
                          )
                        : MyText(
                            'Add note',
                            weight: FontWeight.bold,
                          ),
                  ),
                  onPressed: () => context.push(
                      child: FullScreenTextEditing(
                          title: 'Workout Note',
                          initialValue: loggedWorkoutSection.note,
                          onSave: addNoteToLoggedSection!,
                          inputValidation: (t) => true)))
          ],
        ),
        if (Utils.textNotNull(loggedWorkoutSection.note))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ViewMoreFullScreenTextBlock(
              text: loggedWorkoutSection.note!,
              title: 'Note',
              maxLines: 3,
            ),
          ),
      ],
    );
  }
}
