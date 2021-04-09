import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutGoalsSelector extends StatefulWidget {
  final List<WorkoutGoal> selectedWorkoutGoals;
  final void Function(List<WorkoutGoal> updated) updateSelectedWorkoutGoals;
  WorkoutGoalsSelector(
      {required this.selectedWorkoutGoals,
      required this.updateSelectedWorkoutGoals});
  @override
  _WorkoutGoalsSelectorState createState() => _WorkoutGoalsSelectorState();
}

class _WorkoutGoalsSelectorState extends State<WorkoutGoalsSelector> {
  List<WorkoutGoal> _activeSelectedWorkoutGoals = [];

  @override
  void initState() {
    super.initState();
    _activeSelectedWorkoutGoals = [...widget.selectedWorkoutGoals];
  }

  void _handleUpdateSelected(WorkoutGoal tapped) {
    setState(() {
      _activeSelectedWorkoutGoals =
          _activeSelectedWorkoutGoals.toggleItem<WorkoutGoal>(tapped);
    });
    widget.updateSelectedWorkoutGoals(_activeSelectedWorkoutGoals);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: NavBarTitle('Workout Goals'),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: MyText(
              'Done',
              weight: FontWeight.bold,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      child: Query(
          options: QueryOptions(
              document: WorkoutGoalsQuery().document,
              fetchPolicy: FetchPolicy.cacheFirst),
          builder: (result, {refetch, fetchMore}) => QueryResponseBuilder(
              result: result,
              builder: () {
                final _workoutGoals =
                    WorkoutGoals$Query.fromJson(result.data ?? {}).workoutGoals;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: _workoutGoals
                        .map((goal) => GestureDetector(
                              onTap: () => _handleUpdateSelected(goal),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Styles.lightGrey))),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        MyText(goal.name),
                                        if (_activeSelectedWorkoutGoals
                                            .contains(goal))
                                          FadeIn(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: ConfirmCheckIcon(),
                                          )),
                                      ],
                                    ),
                                    InfoPopupButton(
                                        infoWidget:
                                            MyText('Info about ${goal.name}'))
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              })),
    );
  }
}
