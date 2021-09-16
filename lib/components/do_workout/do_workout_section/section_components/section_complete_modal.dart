import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc_archived.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/section_components/section_modal_container.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class SectionCompleteModal extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  const SectionCompleteModal({Key? key, required this.loggedWorkoutSection})
      : super(key: key);

  void _handleResetSection(BuildContext context) {
    context.showConfirmDialog(
      title: 'Reset this section?',
      content: MyText(
        'The work you have just done will not be saved. OK?',
        textAlign: TextAlign.center,
        maxLines: 3,
      ),
      onConfirm: () => context
          .read<DoWorkoutBloc>()
          .resetSection(loggedWorkoutSection.sortPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionModalContainer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: H1('Nice Work!'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: LoggedWorkoutSectionSummaryCard(
                loggedWorkoutSection: loggedWorkoutSection),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 4),
          child: SecondaryButton(
            onPressed: () => _handleResetSection(context),
            prefixIconData: CupertinoIcons.refresh_bold,
            text: 'Redo Section',
          ),
        ),
      ],
    ));
  }
}
