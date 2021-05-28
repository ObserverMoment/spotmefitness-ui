import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

/// Widget that uses filters to find and select a workout.
class WorkoutFinderPage extends StatefulWidget {
  final void Function(Workout workout) selectWorkout;
  WorkoutFinderPage(this.selectWorkout);

  @override
  _WorkoutFinderPageState createState() => _WorkoutFinderPageState();
}

class _WorkoutFinderPageState extends State<WorkoutFinderPage> {
  final kIconSize = 28.0;
  final PanelController _panelController = PanelController();
  bool _panelIsOpen = false;

  void _togglePanel() {
    if (_panelIsOpen) {
      _panelIsOpen = false;
      _panelController.close();
    } else {
      _panelIsOpen = true;
      _panelController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        heroTag: 'WorkoutFinderPage',
        middle: NavBarTitle('Find a Workout'),
      ),
      child: SlidingUpPanel(
        controller: _panelController,
        minHeight: 70,
        maxHeight: size.height - 30,
        borderRadius: BorderRadius.circular(20),
        margin: const EdgeInsets.all(6),
        panel: Column(
          children: [
            GestureDetector(
              onTap: _togglePanel,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                          ),
                          SizedBox(width: 8),
                          MyText('Search', weight: FontWeight.bold),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyText('Filters', weight: FontWeight.bold),
                          SizedBox(width: 8),
                          Transform.rotate(
                            angle: -pi / 2,
                            child: Icon(
                              CupertinoIcons.slider_horizontal_3,
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
            ),
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
                      onTap: () => print(0)),
                  FilterTabIcon(
                      icon: SvgPicture.asset(
                          'assets/workout_filters_icons/filter_equipment_icon.svg',
                          height: kIconSize,
                          width: kIconSize),
                      label: 'Equipment',
                      onTap: () => print(1)),
                  FilterTabIcon(
                      icon: SvgPicture.asset(
                          'assets/workout_filters_icons/filter_body_icon.svg',
                          height: kIconSize,
                          width: kIconSize),
                      label: 'Body',
                      onTap: () => print(2)),
                  FilterTabIcon(
                      icon: SvgPicture.asset(
                          'assets/workout_filters_icons/filter_moves_icon.svg',
                          height: kIconSize,
                          width: kIconSize),
                      label: 'Moves',
                      onTap: () => print(3)),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: MyText('Workout Finder'),
            ),
            Center(
              child: MyText('Workout Finder'),
            ),
            Center(
              child: MyText('Workout Finder'),
            ),
            Center(
              child: MyText('Workout Finder'),
            ),
            Center(
              child: MyText('Workout Finder'),
            ),
            Center(
              child: MyText('Workout Finder'),
            ),
            Center(
              child: MyText('Workout Finder'),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterTabIcon extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function() onTap;
  FilterTabIcon({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [icon, MyText(label, size: FONTSIZE.TINY)],
        ),
      ),
    );
  }
}
