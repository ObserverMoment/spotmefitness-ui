import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_body.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_times.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_section.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class LoggedWorkoutSectionDetailsEditable extends StatefulWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final List<BodyArea> uniqueBodyAreas;
  LoggedWorkoutSectionDetailsEditable(
      {required this.loggedWorkoutSection, required this.uniqueBodyAreas});

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
          middle: NavBarTitle(Utils.textNotNull(
                  widget.loggedWorkoutSection.name)
              ? widget.loggedWorkoutSection.name!
              : 'Section ${widget.loggedWorkoutSection.sectionIndex + 1} Log'),
        ),
        child: Column(
          children: [
            MyTabBarNav(
                titles: ['Summary', 'Moves', 'Body', 'Times'],
                handleTabChange: _changeTab,
                activeTabIndex: _activeTabIndex),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _changeTab,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MyText('Summary'),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: LoggedWorkoutCreatorSection(
                        widget.loggedWorkoutSection.sectionIndex),
                  ),
                  LoggedWorkoutSectionBody(
                    uniqueBodyAreas: widget.uniqueBodyAreas,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: LoggedWorkoutSectionTimes(
                        widget.loggedWorkoutSection.sectionIndex),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
