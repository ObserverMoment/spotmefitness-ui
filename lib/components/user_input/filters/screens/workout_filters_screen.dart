import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_section_type_multi_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutFiltersScreen extends StatefulWidget {
  @override
  _WorkoutFiltersScreenState createState() => _WorkoutFiltersScreenState();
}

class _WorkoutFiltersScreenState extends State<WorkoutFiltersScreen> {
  final kIconSize = 24.0;
  final kTabPagePadding =
      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8);

  int _activeTabIndex = 0;

  final PageController _pageController = PageController();

  void _updateTabIndex(int index) {
    _pageController.jumpToPage(index);
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
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
          onPageChanged: _updateTabIndex,
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
  @override
  Widget build(BuildContext context) {
    final workoutSectionTypes =
        context.select<WorkoutFiltersBloc, List<WorkoutSectionType>>(
            (b) => b.filters.workoutSectionTypes);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WorkoutSectionTypeMultiSelector(
          selectedTypes: workoutSectionTypes,
          updateSelectedTypes: (types) => context
              .read<WorkoutFiltersBloc>()
              .updateWorkoutSectionTypes(types),
        ),
        MyText('Class Videos'),
        MyText('Difficulty Level'),
        MyText('Workout Goals'),
        MyText('Workout Length'),
      ],
    );
  }
}

class WorkoutFiltersEquipment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText('WorkoutFiltersEquipment'),
      ],
    );
  }
}

class WorkoutFiltersBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText('WorkoutFiltersBody'),
      ],
    );
  }
}

class WorkoutFiltersMoves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText('WorkoutFiltersMoves'),
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
                      color:
                          isSelected ? Styles.colorOne : Colors.transparent))),
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
