import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_meta.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_section.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class LoggedWorkoutCreatorPage extends StatefulWidget {
  final Workout workout;
  final ScheduledWorkout? scheduledWorkout;
  LoggedWorkoutCreatorPage({required this.workout, this.scheduledWorkout});

  @override
  _LoggedWorkoutCreatorPageState createState() =>
      _LoggedWorkoutCreatorPageState();
}

class _LoggedWorkoutCreatorPageState extends State<LoggedWorkoutCreatorPage> {
  int _activeTabIndex = 0;
  final PageController _pageController = PageController();

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  Future<void> _saveLogToDB(LoggedWorkoutCreatorBloc bloc) async {
    context.showLoadingAlert('Logging...',
        icon: Icon(
          CupertinoIcons.doc_plaintext,
          color: Styles.infoBlue,
        ));

    final result = await bloc.createAndSave(context);

    context.pop(); // Close loading alert.

    if (result.hasErrors) {
      context
          .showErrorAlert('Sorry, there was a problem logging this workout!');
    } else {
      await context.showSuccessAlert(
        'Workout Logged!',
        'You can go to Journals > Logs to view it.',
      );
      context.pop(); // Close the logged workout creator.
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          LoggedWorkoutCreatorBloc(context: context, workout: widget.workout),
      builder: (context, child) {
        final includedSections = context
            .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSection>>(
                (b) => b.sectionsToIncludeInLog)
            .sortedBy<num>((s) => s.sortPosition);

        return CupertinoPageScaffold(
            navigationBar: BasicNavBar(
              heroTag: 'LoggedWorkoutCreatorPage',
              customLeading: NavBarCancelButton(context.pop),
              middle: NavBarTitle('Log Workout'),
              trailing: includedSections.isNotEmpty
                  ? NavBarSaveButton(
                      () => _saveLogToDB(
                          context.read<LoggedWorkoutCreatorBloc>()),
                      text: 'Log It',
                    )
                  : null,
            ),
            child: Column(
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
                          .map((section) => LoggedWorkoutCreatorSection(
                                section.sortPosition,
                                showLapTimesButton: true,
                              ))
                          .toList()
                    ],
                  ),
                )),
              ],
            ));
      },
    );
  }
}
