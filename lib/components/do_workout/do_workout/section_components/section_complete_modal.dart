import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/section_components/section_modal_container.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class SectionCompleteModal extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  const SectionCompleteModal({Key? key, required this.loggedWorkoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionModalContainer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: H1('Nice Work!'),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: LoggedWorkoutSectionSummaryCard(
                  loggedWorkoutSection: loggedWorkoutSection),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 4),
          child: SecondaryButton(
            onPressed: () => print('reset section'),
            prefix: Icon(CupertinoIcons.refresh_bold),
            text: 'Redo Section',
          ),
        ),
      ],
    ));
  }
}
