import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/logged_workout_creator_section.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_body.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_times.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class LoggedWorkoutSectionDetailsEditable extends StatefulWidget {
  final int sectionIndex;
  LoggedWorkoutSectionDetailsEditable(this.sectionIndex);

  @override
  _LoggedWorkoutSectionDetailsEditableState createState() =>
      _LoggedWorkoutSectionDetailsEditableState();
}

class _LoggedWorkoutSectionDetailsEditableState
    extends State<LoggedWorkoutSectionDetailsEditable> {
  int _activeTabIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  Future<void> _saveAndClose(BuildContext context) async {
    context.read<LoggedWorkoutCreatorBloc>().writeAllChangesToStore();
    context.pop();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final section =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[widget.sectionIndex]);

    final sectionHasUnsavedChanges =
        context.select<LoggedWorkoutCreatorBloc, bool>(
            (b) => b.sectionHasUnsavedChanges);

    return MyPageScaffold(
        navigationBar: CreateEditPageNavBar(
          formIsDirty: sectionHasUnsavedChanges,
          handleClose: context.pop,
          handleSave: () => _saveAndClose(context),
          inputValid: true,
          title: Utils.textNotNull(section.name)
              ? section.name!
              : 'Section ${widget.sectionIndex + 1} Log',
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4),
              child: MyTabBarNav(
                  titles: ['Summary', 'Edit Sets', 'Body', 'Times'],
                  handleTabChange: _changeTab,
                  activeTabIndex: _activeTabIndex),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _changeTab,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _LoggedWorkoutSectionWrapper(widget.sectionIndex),
                  LoggedWorkoutCreatorSection(widget.sectionIndex),
                  LoggedWorkoutSectionBody(widget.sectionIndex),
                  LoggedWorkoutSectionTimes(widget.sectionIndex),
                ],
              ),
            )
          ],
        ));
  }
}

/// Copied from [DoWorkoutLogWorkoutPage] logic.
/// Hooks into the bloc to pull out the correct logged workout section based on the section index and provides it to the pure UI widget [LoggedWorkoutSectionSummarycard].
class _LoggedWorkoutSectionWrapper extends StatelessWidget {
  final int sectionIndex;
  const _LoggedWorkoutSectionWrapper(this.sectionIndex);

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: LoggedWorkoutSectionSummaryCard(
          loggedWorkoutSection: loggedWorkoutSection,
          addNoteToLoggedSection: (note) => context
              .read<LoggedWorkoutCreatorBloc>()
              .editLoggedWorkoutSection(sectionIndex, {'note': note})),
    );
  }
}
