import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_body.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_times.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_section.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/logged_workout_details.page.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:provider/provider.dart';

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

    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
          middle: NavBarTitle(Utils.textNotNull(section.name)
              ? section.name!
              : 'Section ${widget.sectionIndex + 1} Log'),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4),
              child: MyTabBarNav(
                  titles: ['Moves', 'Body', 'Times'],
                  handleTabChange: _changeTab,
                  activeTabIndex: _activeTabIndex),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _changeTab,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverToBoxAdapter(
                              child: LoggedWorkoutSectionSummary(section,
                                  showBodyAreas: false))
                        ];
                      },
                      body: LoggedWorkoutCreatorSection(widget.sectionIndex),
                    ),
                  ),
                  LoggedWorkoutSectionBody(widget.sectionIndex),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: LoggedWorkoutSectionTimes(widget.sectionIndex),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
