import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
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
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: includedSections.length,
                      itemBuilder: (c, i) {
                        if (i == 0) {
                          return CupertinoButton(
                              onPressed: () => _changeTab(i),
                              padding: EdgeInsets.zero,
                              child: MyText('Overview'));
                        } else {
                          final WorkoutSection s = includedSections[i];
                          return CupertinoButton(
                              onPressed: () => _changeTab(i),
                              padding: EdgeInsets.zero,
                              child: WorkoutSectionTypeTag(
                                  Utils.textNotNull(s.name)
                                      ? s.name!
                                      : s.workoutSectionType.name,
                                  timecap: s.timecap));
                        }
                      }),
                ),
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
                      ...widget.workout.workoutSections
                          .map((section) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LoggedWorkoutCreatorSection(
                                    workoutSectionsToCreateLoggedWorkoutSections(
                                        [section])),
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
