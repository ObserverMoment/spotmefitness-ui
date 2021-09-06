import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';

class WorkoutGoalsSelectorRow extends StatelessWidget {
  final List<WorkoutGoal> selectedWorkoutGoals;
  final void Function(List<WorkoutGoal>) updateSelectedWorkoutGoals;
  final int? max;
  const WorkoutGoalsSelectorRow(
      {Key? key,
      required this.selectedWorkoutGoals,
      required this.updateSelectedWorkoutGoals,
      this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserInputContainer(
        child: CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 8),
      onPressed: () => context.push(
          child: WorkoutGoalsSelector(
        selectedWorkoutGoals: selectedWorkoutGoals,
        updateSelectedWorkoutGoals: updateSelectedWorkoutGoals,
        max: max,
      )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MyText(
                    'Goals',
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    CupertinoIcons.scope,
                    size: 18,
                  ),
                ],
              ),
              Row(
                children: [
                  MyText(
                    selectedWorkoutGoals.isEmpty ? 'Add' : 'Edit',
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    selectedWorkoutGoals.isEmpty
                        ? CupertinoIcons.add
                        : CupertinoIcons.pencil,
                    size: 18,
                  )
                ],
              )
            ],
          ),
          GrowInOut(
              show: selectedWorkoutGoals.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 2),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 4,
                  runSpacing: 4,
                  children: selectedWorkoutGoals
                      .map((g) => Tag(
                            tag: g.name,
                            color: Styles.colorOne,
                            textColor: Styles.white,
                          ))
                      .toList(),
                ),
              ))
        ],
      ),
    ));
  }
}

class WorkoutGoalsSelector extends StatefulWidget {
  final List<WorkoutGoal> selectedWorkoutGoals;
  final void Function(List<WorkoutGoal> updated) updateSelectedWorkoutGoals;
  final int? max;
  WorkoutGoalsSelector(
      {required this.selectedWorkoutGoals,
      required this.updateSelectedWorkoutGoals,
      this.max});
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
    if (widget.max == null ||
        _activeSelectedWorkoutGoals.length < widget.max! ||
        _activeSelectedWorkoutGoals.contains(tapped)) {
      setState(() {
        _activeSelectedWorkoutGoals =
            _activeSelectedWorkoutGoals.toggleItem<WorkoutGoal>(tapped);
      });

      widget.updateSelectedWorkoutGoals(_activeSelectedWorkoutGoals);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        withoutLeading: true,
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: MyText(
              'Done',
              weight: FontWeight.bold,
            ),
            onPressed: () => Navigator.pop(context)),
        middle: LeadingNavBarTitle(
          'Workout Goals',
          fontSize: FONTSIZE.MAIN,
        ),
      ),
      child: QueryObserver<WorkoutGoals$Query, json.JsonSerializable>(
          key: Key(
              'WorkoutGoalsSelector - ${WorkoutGoalsQuery().operationName}'),
          query: WorkoutGoalsQuery(),
          fetchPolicy: QueryFetchPolicy.storeFirst,
          builder: (data) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  if (widget.max != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          'Select up to ${widget.max!} goals - ',
                        ),
                        MyText(
                          '${_activeSelectedWorkoutGoals.length} selected',
                          color: Styles.colorTwo,
                        ),
                      ],
                    ),
                  Expanded(
                    child: ListView(
                      children: data.workoutGoals
                          .map((goal) => GestureDetector(
                                onTap: () => _handleUpdateSelected(goal),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Styles.grey))),
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
                  ),
                ],
              ),
            );
          }),
    );
  }
}
