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

  Future<void> _saveLogToDB(LoggedWorkoutCreatorBloc bloc) async {
    context.showLoadingAlert('Logging...',
        icon: Icon(
          CupertinoIcons.doc_plaintext,
          color: Styles.infoBlue,
        ));

    final log = bloc.loggedWorkout;
    final sectionsToIncludeInLog = bloc.sectionsToIncludeInLog;

    final input = CreateLoggedWorkoutInput(
        name: log.name,
        note: log.note,
        scheduledWorkout: null,
        gymProfile: log.gymProfile != null
            ? ConnectRelationInput(id: log.gymProfile!.id)
            : null,
        workoutProgramEnrolment: null,
        workoutProgramWorkout: null,
        completedOn: log.completedOn,
        loggedWorkoutSections: log.loggedWorkoutSections
            .where((section) => sectionsToIncludeInLog.contains(section))
            .map((section) => CreateLoggedWorkoutSectionInLoggedWorkoutInput(
                name: section.name,
                note: section.note,
                sectionIndex: section.sectionIndex,
                roundsCompleted: section.roundsCompleted,
                laptimesMs: [],
                repScore: section.repScore,
                timeTakenMs: section.timeTakenMs,
                timecap: section.timecap,
                workoutSectionType:
                    ConnectRelationInput(id: section.workoutSectionType.id),
                loggedWorkoutSets: section.loggedWorkoutSets
                    .map((logSet) => CreateLoggedWorkoutSetInLoggedSectionInput(
                        setIndex: logSet.setIndex,
                        note: logSet.note,
                        roundsCompleted: logSet.roundsCompleted,
                        laptimesMs: logSet.laptimesMs,
                        loggedWorkoutMoves: logSet.loggedWorkoutMoves
                            .map((logWorkoutMove) =>
                                CreateLoggedWorkoutMoveInLoggedSetInput(
                                    sortPosition: logWorkoutMove.sortPosition,
                                    timeTakenMs: logWorkoutMove.timeTakenMs,
                                    note: logWorkoutMove.note,
                                    repType: logWorkoutMove.repType,
                                    reps: logWorkoutMove.reps,
                                    distanceUnit: logWorkoutMove.distanceUnit,
                                    loadAmount: logWorkoutMove.loadAmount,
                                    loadUnit: logWorkoutMove.loadUnit,
                                    timeUnit: logWorkoutMove.timeUnit,
                                    equipment: logWorkoutMove.equipment != null
                                        ? ConnectRelationInput(
                                            id: logWorkoutMove.equipment!.id)
                                        : null,
                                    move: ConnectRelationInput(
                                        id: logWorkoutMove.moveSummary.id)))
                            .toList()))
                    .toList()))
            .toList());

    final variables = CreateLoggedWorkoutArguments(data: input);

    /// TODO: Once the query exists you need to add a ref to this new workout log to the
    /// [userLoggedWorkouts] query.
    final result = await context.graphQLStore
        .create(mutation: CreateLoggedWorkoutMutation(variables: variables));

    context.pop(); // Close loading alert.

    if (result.hasErrors) {
      context
          .showErrorAlert('Sorry, there was a problem logging this workout!');
    } else {
      await context.showSuccessAlert(
        'Workout Logged!',
        'You can go to Journals -> Logs to view it.',
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
      create: (context) => LoggedWorkoutCreatorBloc(workout: widget.workout),
      builder: (context, child) {
        final includedSections = context
            .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSection>>(
                (b) => b.sectionsToIncludeInLog)
            .sortedBy<num>((s) => s.sectionIndex);

        return CupertinoPageScaffold(
            navigationBar: BasicNavBar(
              leading: NavBarCancelButton(context.pop),
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
                          .map((section) =>
                              LoggedWorkoutCreatorSection(section.sectionIndex))
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
