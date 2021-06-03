import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/body_areas/body_area_selectors.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/difficulty_level_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_goals_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_section_type_multi_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class WorkoutFiltersScreen extends StatefulWidget {
  @override
  _WorkoutFiltersScreenState createState() => _WorkoutFiltersScreenState();
}

class _WorkoutFiltersScreenState extends State<WorkoutFiltersScreen> {
  final kIconSize = 24.0;
  final kTabPagePadding =
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8);

  int _activeTabIndex = 0;

  final PageController _pageController = PageController();

  /// Page change from [_pageController]
  void _onPageChanged(int index) {
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  /// Page change from tabs icons.
  void _updateTabIndex(int index) {
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
    _pageController.toPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterTabIcon(
                  icon: Icon(
                    CupertinoIcons.info_circle_fill,
                    size: kIconSize,
                  ),
                  label: 'Meta',
                  isSelected: _activeTabIndex == 0,
                  onTap: () => _updateTabIndex(0)),
              FilterTabIcon(
                  icon: SvgPicture.asset(
                    'assets/workout_filters_icons/filter_equipment_icon.svg',
                    height: kIconSize,
                    width: kIconSize,
                    color: context.theme.primary,
                  ),
                  label: 'Equipment',
                  isSelected: _activeTabIndex == 1,
                  onTap: () => _updateTabIndex(1)),
              FilterTabIcon(
                  icon: SvgPicture.asset(
                      'assets/workout_filters_icons/filter_body_icon.svg',
                      height: kIconSize,
                      width: kIconSize,
                      color: context.theme.primary),
                  label: 'Body',
                  isSelected: _activeTabIndex == 2,
                  onTap: () => _updateTabIndex(2)),
              FilterTabIcon(
                  icon: SvgPicture.asset(
                      'assets/workout_filters_icons/filter_moves_icon.svg',
                      height: kIconSize,
                      width: kIconSize,
                      color: context.theme.primary),
                  label: 'Moves',
                  isSelected: _activeTabIndex == 3,
                  onTap: () => _updateTabIndex(3)),
            ],
          ),
        ),
        Expanded(
            child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            Padding(
              padding: kTabPagePadding,
              child: WorkoutFiltersInfo(),
            ),
            Padding(
              padding: kTabPagePadding,
              child: WorkoutFiltersEquipment(),
            ),
            Padding(
              padding: kTabPagePadding,
              child: WorkoutFiltersBody(),
            ),
            Padding(
              padding: kTabPagePadding,
              child: WorkoutFiltersMoves(),
            ),
          ],
        ))
      ],
    );
  }
}

class WorkoutFiltersInfo extends StatelessWidget {
  /// 0 = true / yes
  /// 1 = false / no
  /// 2 = null / don't care
  int _hasClassVideoToInt(bool? b) {
    return b == null
        ? 2
        : b
            ? 0
            : 1;
  }

  bool? _intToClassVideo(int i) {
    return i == 0
        ? true
        : i == 1
            ? false
            : null;
  }

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
    final difficultyLevel =
        context.select<WorkoutFiltersBloc, DifficultyLevel?>(
            (b) => b.filters.difficultyLevel);
    final workoutGoals = context.select<WorkoutFiltersBloc, List<WorkoutGoal>>(
        (b) => b.filters.workoutGoals);

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
                    updateValue: (v) => context
                        .read<WorkoutFiltersBloc>()
                        .updateFilters(_intToMinLengthMaxLength(v)),
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
          SizedBox(height: 28),
          WorkoutSectionTypeMultiSelector(
            selectedTypes: workoutSectionTypes,
            updateSelectedTypes: (types) => context
                .read<WorkoutFiltersBloc>()
                .updateFilters({
              'workoutSectionTypes': types.map((t) => t.toJson()).toList()
            }),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  'Class Video',
                  textAlign: TextAlign.start,
                  size: FONTSIZE.BIG,
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: SlidingSelect<int>(
                      value: _hasClassVideoToInt(hasClassVideo),
                      updateValue: (v) => context
                          .read<WorkoutFiltersBloc>()
                          .updateFilters(
                              {'hasClassVideo': _intToClassVideo(v)}),
                      children: {
                        0: MyText('Yes'),
                        1: MyText('No'),
                        2: MyText("Don't mind")
                      }),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          DifficultyLevelSelectorRow(
            difficultyLevel: difficultyLevel,
            updateDifficultyLevel: (difficultyLevel) => context
                .read<WorkoutFiltersBloc>()
                .updateFilters({'difficultyLevel': difficultyLevel?.apiValue}),
          ),
          SizedBox(height: 16),
          WorkoutGoalsSelectorRow(
              selectedWorkoutGoals: workoutGoals,
              updateSelectedWorkoutGoals: (goals) => context
                  .read<WorkoutFiltersBloc>()
                  .updateFilters(
                      {'workoutGoals': goals.map((t) => t.toJson()).toList()})),
        ],
      ),
    );
  }
}

class WorkoutFiltersEquipment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bodyweightOnly = context
        .select<WorkoutFiltersBloc, bool>((b) => b.filters.bodyweightOnly);
    final availableEquipments =
        context.select<WorkoutFiltersBloc, List<Equipment>>(
            (b) => b.filters.availableEquipments);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoSwitchRow(
            value: bodyweightOnly,
            title: 'Bodyweight only / No equipment',
            updateValue: (v) => context
                .read<WorkoutFiltersBloc>()
                .updateFilters({'bodyweightOnly': v})),
        if (!bodyweightOnly)
          Expanded(
            child: FadeIn(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QueryObserver<Equipments$Query, json.JsonSerializable>(
                    key: Key(
                        'WorkoutFiltersEquipment - ${EquipmentsQuery().operationName}'),
                    query: EquipmentsQuery(),
                    fetchPolicy: QueryFetchPolicy.storeFirst,
                    builder: (data) {
                      final allEquipments = data.equipments;

                      return EquipmentMultiSelector(
                          selectedEquipments: availableEquipments,
                          scrollDirection: Axis.vertical,
                          equipments: allEquipments,
                          crossAxisCount: 4,
                          fontSize: FONTSIZE.SMALL,
                          showIcon: true,
                          handleSelection: (e) {
                            context.read<WorkoutFiltersBloc>().updateFilters({
                              'availableEquipments': availableEquipments
                                  .toggleItem<Equipment>(e)
                                  .map((e) => e.toJson())
                                  .toList()
                            });
                          });
                    }),
              ),
            ),
          ),
      ],
    );
  }
}

class WorkoutFiltersBody extends StatefulWidget {
  @override
  _WorkoutFiltersBodyState createState() => _WorkoutFiltersBodyState();
}

class _WorkoutFiltersBodyState extends State<WorkoutFiltersBody> {
  final kBodyGraphicHeight = 420.0;
  late int _activePageIndex;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _activePageIndex = 0;
  }

  void _animateToPage(int page) {
    setState(() => _activePageIndex = page);
    _pageController.toPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final targetedBodyAreas =
        context.select<WorkoutFiltersBloc, List<BodyArea>>(
            (b) => b.filters.targetedBodyAreas);

    return QueryObserver<BodyAreas$Query, json.JsonSerializable>(
        key: Key('MoveFiltersBody - ${BodyAreasQuery().operationName}'),
        query: BodyAreasQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          final allBodyAreas = data.bodyAreas;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 46,
                      child: SlidingSelect<int>(
                        updateValue: _animateToPage,
                        value: _activePageIndex,
                        children: {
                          0: MyText('Front'),
                          1: MyText('Back'),
                        },
                      ),
                    ),
                    if (targetedBodyAreas.isNotEmpty)
                      TextButton(
                        text: 'Clear body',
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        destructive: true,
                        underline: false,
                        onPressed: () => context
                            .read<WorkoutFiltersBloc>()
                            .updateFilters({'targetedBodyAreas': []}),
                      ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: kBodyGraphicHeight,
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BodyAreaSelectorIndicator(
                                  selectedBodyAreas: targetedBodyAreas,
                                  frontBack: BodyAreaFrontBack.front,
                                  allBodyAreas: allBodyAreas,
                                  handleTapBodyArea: (b) => context
                                          .read<WorkoutFiltersBloc>()
                                          .updateFilters({
                                        'targetedBodyAreas': targetedBodyAreas
                                            .toggleItem(b)
                                            .map((b) => b.toJson())
                                            .toList()
                                      }),
                                  height: kBodyGraphicHeight),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BodyAreaSelectorIndicator(
                                  selectedBodyAreas: targetedBodyAreas,
                                  frontBack: BodyAreaFrontBack.back,
                                  allBodyAreas: allBodyAreas,
                                  handleTapBodyArea: (b) => context
                                          .read<WorkoutFiltersBloc>()
                                          .updateFilters({
                                        'targetedBodyAreas': targetedBodyAreas
                                            .toggleItem(b)
                                            .map((b) => b.toJson())
                                            .toList()
                                      }),
                                  height: kBodyGraphicHeight),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BodyAreaNamesList(targetedBodyAreas),
              ),
            ],
          );
        });
  }
}

class WorkoutFiltersMoves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText('Required Moves'),
        MyText('Excluded Moves'),
      ],
    );
  }
}

class FilterTabIcon extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function() onTap;
  final bool isSelected;
  FilterTabIcon(
      {required this.icon,
      required this.label,
      required this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: kStandardAnimationDuration,
      opacity: isSelected ? 1 : 0.55,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: AnimatedContainer(
          duration: kStandardAnimationDuration,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: isSelected
                          ? Styles.colorOne
                          : material.Colors.transparent))),
          padding: const EdgeInsets.only(bottom: 4),
          child: Column(
            children: [
              icon,
              SizedBox(height: 2),
              MyText(label, size: FONTSIZE.TINY)
            ],
          ),
        ),
      ),
    );
  }
}
