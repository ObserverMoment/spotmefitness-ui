import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/difficulty_level_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_goals_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_section_type_multi_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';

class WorkoutFiltersInfo extends StatelessWidget {
  /// 0 = any
  // 1 = < 15, 2 = 15 - 30, 3 = 30 - 45, 4 = 45 - 60, 5 = 60 >
  int _minLengthToInt(Duration? d) {
    switch (d?.inMinutes) {
      case null:
        return 0;
      case 0:
        return 1;
      case 15:
        return 2;
      case 30:
        return 3;
      case 45:
        return 4;
      case 60:
        return 5;
      default:
        return 0;
    }
  }

  Map<String, int?> _intToMinLengthMaxLength(int i) {
    switch (i) {
      case 0:
        return {
          'minLength': null,
          'maxLength': null,
        };
      case 1:
        return {
          'minLength': 0,
          'maxLength': 15,
        };
      case 2:
        return {
          'minLength': 15,
          'maxLength': 30,
        };
      case 3:
        return {
          'minLength': 30,
          'maxLength': 45,
        };
      case 4:
        return {
          'minLength': 45,
          'maxLength': 60,
        };
      case 5:
        return {
          'minLength': 60,
          'maxLength': null,
        };
      default:
        return {
          'minLength': null,
          'maxLength': null,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final minLength = context
        .select<WorkoutFiltersBloc, Duration?>((b) => b.filters.minLength);

    final workoutSectionTypes =
        context.select<WorkoutFiltersBloc, List<WorkoutSectionType>>(
            (b) => b.filters.workoutSectionTypes);

    final hasClassVideo = context
        .select<WorkoutFiltersBloc, bool?>((b) => b.filters.hasClassVideo);

    final hasClassAudio = context
        .select<WorkoutFiltersBloc, bool?>((b) => b.filters.hasClassAudio);

    final difficultyLevel =
        context.select<WorkoutFiltersBloc, DifficultyLevel?>(
            (b) => b.filters.difficultyLevel);

    final workoutGoals = context.select<WorkoutFiltersBloc, List<WorkoutGoal>>(
        (b) => b.filters.workoutGoals);

    final _updateFilters = context.read<WorkoutFiltersBloc>().updateFilters;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  'Length (minutes)',
                  textAlign: TextAlign.start,
                  size: FONTSIZE.BIG,
                ),
                SizedBox(height: 8),
                SlidingSelect<int>(
                    value: _minLengthToInt(minLength),
                    updateValue: (v) =>
                        _updateFilters(_intToMinLengthMaxLength(v)),
                    children: {
                      0: MyText('Any'),
                      1: MyText('< 15'),
                      2: MyText("15-30"),
                      3: MyText("30-45"),
                      4: MyText("45-60"),
                      5: MyText("60 >"),
                    })
              ],
            ),
          ),
          SizedBox(height: 25),
          DifficultyLevelSelectorRow(
            difficultyLevel: difficultyLevel,
            updateDifficultyLevel: (difficultyLevel) =>
                _updateFilters({'difficultyLevel': difficultyLevel.apiValue}),
          ),
          SizedBox(height: 16),
          WorkoutGoalsSelectorRow(
              selectedWorkoutGoals: workoutGoals,
              updateSelectedWorkoutGoals: (goals) => _updateFilters(
                  {'workoutGoals': goals.map((t) => t.toJson()).toList()})),
          SizedBox(height: 28),
          WorkoutSectionTypeMultiSelector(
            selectedTypes: workoutSectionTypes,
            updateSelectedTypes: (types) => _updateFilters(
                {'workoutSectionTypes': types.map((t) => t.toJson()).toList()}),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  'Class Video',
                  textAlign: TextAlign.start,
                  size: FONTSIZE.BIG,
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: SlidingSelect<int>(
                      value: DataUtils.nullableBoolToInt(hasClassVideo),
                      updateValue: (v) => _updateFilters(
                          {'hasClassVideo': DataUtils.intToNullableBool(v)}),
                      children: {
                        0: MyText('Yes'),
                        1: MyText('No'),
                        2: MyText("Don't mind")
                      }),
                ),
                SizedBox(height: 12),
                MyText(
                  'Class Audio',
                  textAlign: TextAlign.start,
                  size: FONTSIZE.BIG,
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: SlidingSelect<int>(
                      value: DataUtils.nullableBoolToInt(hasClassAudio),
                      updateValue: (v) => _updateFilters(
                          {'hasClassAudio': DataUtils.intToNullableBool(v)}),
                      children: {
                        0: MyText('Yes'),
                        1: MyText('No'),
                        2: MyText("Don't mind")
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
