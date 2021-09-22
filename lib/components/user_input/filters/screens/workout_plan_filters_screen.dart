import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:sofie_ui/components/user_input/filters/blocs/workout_plan_filters_bloc.dart';
import 'package:sofie_ui/components/user_input/number_picker_modal.dart';
import 'package:sofie_ui/components/user_input/pickers/sliding_select.dart';
import 'package:sofie_ui/components/user_input/selectors/difficulty_level_selector.dart';
import 'package:sofie_ui/components/user_input/selectors/workout_goals_selector.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/data_utils.dart';

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
            UserInputContainer(
              child: TappableRow(
                  onTap: () => context.showActionSheetPopup(
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
                          size: FONTSIZE.six,
                          weight: FontWeight.bold,
                          lineHeight: 1.2,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const MyText('weeks'),
                    ],
                  ),
                  title: 'Plan Length'),
            ),
            UserInputContainer(
              child: TappableRow(
                  onTap: () => context.showActionSheetPopup(
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
                          size: FONTSIZE.six,
                          weight: FontWeight.bold,
                          lineHeight: 1.2,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const MyText('days / week'),
                    ],
                  ),
                  title: 'Days / Week'),
            ),
            const SizedBox(height: 12),
            UserInputContainer(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: const [
                      MyHeaderText('Use Equipment?'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SlidingSelect<int>(
                          value: DataUtils.nullableBoolToInt(
                              value: bodyweightOnly),
                          updateValue: (v) => _updateFilters({
                                'bodyweightOnly': DataUtils.intToNullableBool(v)
                              }),
                          children: const {
                            1: MyText('Yes'),
                            0: MyText('No'),
                            2: MyText("Don't mind")
                          }),
                    ),
                    const InfoPopupButton(
                        infoWidget: MyText(
                      'No = bodyweight only, yes = not bodyweight only (i.e. has equipment',
                      maxLines: 5,
                    ))
                  ],
                ),
              ],
            )),
            DifficultyLevelSelectorRow(
              difficultyLevel: difficultyLevel,
              updateDifficultyLevel: (difficultyLevel) =>
                  _updateFilters({'difficultyLevel': difficultyLevel.apiValue}),
            ),
            const SizedBox(height: 24),
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
