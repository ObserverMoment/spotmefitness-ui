import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/filters/screens/workout_filters_screen/workout_filters_body.dart';
import 'package:spotmefitness_ui/components/user_input/filters/screens/workout_filters_screen/workout_filters_equipment.dart';
import 'package:spotmefitness_ui/components/user_input/filters/screens/workout_filters_screen/workout_filters_info.dart';
import 'package:spotmefitness_ui/components/user_input/filters/screens/workout_filters_screen/workout_filters_moves.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutFiltersScreen extends StatefulWidget {
  @override
  _WorkoutFiltersScreenState createState() => _WorkoutFiltersScreenState();
}

class _WorkoutFiltersScreenState extends State<WorkoutFiltersScreen> {
  final kIconSize = 24.0;
  final kTabPagePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

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
