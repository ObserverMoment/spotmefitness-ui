import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_meta.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_section.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class LoggedWorkoutCreator extends StatefulWidget {
  final Workout workout;
  final ScheduledWorkout? scheduledWorkout;
  LoggedWorkoutCreator({required this.workout, this.scheduledWorkout});

  @override
  _LoggedWorkoutCreatorState createState() => _LoggedWorkoutCreatorState();
}

class _LoggedWorkoutCreatorState extends State<LoggedWorkoutCreator> {
  int _activeTabIndex = 0;
  final PageController _pageController = PageController();

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  Widget _buildTabTitle(int index, List<WorkoutSection> sections) {
    final isSelected = index == _activeTabIndex;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _changeTab(index),
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
                width: 2,
                color: isSelected ? Styles.colorOne : Colors.transparent),
          )),
          child: MyText(
            index == 0
                ? 'Overview'
                : Utils.textNotNull(sections[index - 1].name)
                    ? sections[index - 1].name!
                    : sections[index - 1].workoutSectionType.name,
            color: isSelected ? Styles.white : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
          leading: NavBarCancelButton(context.pop),
          middle: NavBarTitle('Log Workout'),
          trailing: NavBarSaveButton(
            () => print('Log it'),
            text: 'Log It',
          ),
        ),
        child: ChangeNotifierProvider(
          create: (context) =>
              LoggedWorkoutCreatorBloc(workout: widget.workout),
          builder: (context, child) {
            final includedSections = context
                .select<LoggedWorkoutCreatorBloc, List<WorkoutSection>>(
                    (b) => b.sectionsToIncludeInLog)
                .sortedBy<num>((s) => s.sortPosition);

            return Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                MyTabBarNav(
                    titles: [
                      'Overview',
                      ...includedSections
                          .map((s) => Utils.textNotNull(s.name)
                              ? s.name!
                              : s.workoutSectionType.name)
                          .toList()
                    ],
                    handleTabChange: _changeTab,
                    activeTabIndex: _activeTabIndex),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _changeTab,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoggedWorkoutCreatorMeta(),
                      ),
                      ...includedSections
                          .map((section) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LoggedWorkoutCreatorSection(section),
                              ))
                          .toList()
                    ],
                  ),
                )),
              ],
            );
          },
        ));
  }
}
