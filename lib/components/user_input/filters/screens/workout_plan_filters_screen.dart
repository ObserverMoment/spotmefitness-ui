import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_plan_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/number_picker_modal.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/difficulty_level_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_goals_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class WorkoutPlanFiltersScreen extends StatelessWidget {
  const WorkoutPlanFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lengthWeeks = context
        .select<WorkoutPlanFiltersBloc, int?>((b) => b.filters.lengthWeeks);

    final daysPerWeek = context
        .select<WorkoutPlanFiltersBloc, int?>((b) => b.filters.daysPerWeek);

    final bodyweightOnly = context
        .select<WorkoutPlanFiltersBloc, bool?>((b) => b.filters.bodyweightOnly);

    final difficultyLevel =
        context.select<WorkoutPlanFiltersBloc, DifficultyLevel?>(
            (b) => b.filters.difficultyLevel);

    final workoutGoals =
        context.select<WorkoutPlanFiltersBloc, List<WorkoutGoal>>(
            (b) => b.filters.workoutGoals);

    final _updateFilters = context.read<WorkoutPlanFiltersBloc>().updateFilters;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            TappableRow(
                onTap: () => context.showBottomSheet<int>(
                        child: NumberPickerModal(
                      initialValue: lengthWeeks,
                      min: 1,
                      max: 52,
                      saveValue: (lengthWeeks) =>
                          _updateFilters({'lengthWeeks': lengthWeeks}),
                      title: 'Weeks',
                    )),
                display: Row(
                  children: [
                    ContentBox(
                      child: MyText(
                        lengthWeeks != null ? lengthWeeks.toString() : ' - ',
                        size: FONTSIZE.DISPLAY,
                        weight: FontWeight.bold,
                        lineHeight: 1.2,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyText('weeks'),
                    if (lengthWeeks != null)
                      _ClearInputButton(
                        onPressed: () => _updateFilters({'lengthWeeks': null}),
                      )
                  ],
                ),
                title: 'Plan Length'),
            TappableRow(
                onTap: () => context.showBottomSheet<int>(
                        child: NumberPickerModal(
                      initialValue: daysPerWeek,
                      min: 1,
                      max: 52,
                      saveValue: (daysPerWeek) =>
                          _updateFilters({'daysPerWeek': daysPerWeek}),
                      title: 'Days',
                    )),
                display: Row(
                  children: [
                    ContentBox(
                      child: MyText(
                        daysPerWeek != null ? daysPerWeek.toString() : ' - ',
                        size: FONTSIZE.DISPLAY,
                        weight: FontWeight.bold,
                        lineHeight: 1.2,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyText('days / week'),
                    if (daysPerWeek != null)
                      _ClearInputButton(
                        onPressed: () => _updateFilters({'daysPerWeek': null}),
                      )
                  ],
                ),
                title: 'Days / Week'),
            SizedBox(height: 12),
            H3('Use Equipment?'),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: SlidingSelect<int>(
                          value: DataUtils.nullableBoolToInt(bodyweightOnly),
                          updateValue: (v) => _updateFilters({
                                'bodyweightOnly': DataUtils.intToNullableBool(v)
                              }),
                          children: {
                            1: MyText('Yes'),
                            0: MyText('No'),
                            2: MyText("Don't mind")
                          }),
                    ),
                  ),
                ),
                InfoPopupButton(
                    infoWidget: MyText(
                  'No = bodyweight only, yes = not bodyweight only (i.e. has equipment',
                  maxLines: 5,
                ))
              ],
            ),
            SizedBox(height: 24),
            DifficultyLevelSelectorRow(
              difficultyLevel: difficultyLevel,
              updateDifficultyLevel: (difficultyLevel) => _updateFilters(
                  {'difficultyLevel': difficultyLevel?.apiValue}),
            ),
            SizedBox(height: 24),
            WorkoutGoalsSelectorRow(
                selectedWorkoutGoals: workoutGoals,
                updateSelectedWorkoutGoals: (goals) => _updateFilters(
                    {'workoutGoals': goals.map((t) => t.toJson()).toList()})),
          ],
        ),
      ),
    );
  }
}

class _ClearInputButton extends StatelessWidget {
  final void Function() onPressed;
  const _ClearInputButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: CupertinoButton(
          child: Icon(
            CupertinoIcons.clear_thick,
            color: Styles.errorRed,
            size: 22,
          ),
          onPressed: onPressed),
    );
  }
}
