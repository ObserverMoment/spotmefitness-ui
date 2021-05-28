import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:provider/provider.dart';

class WorkoutFiltersScreen extends StatefulWidget {
  @override
  _WorkoutFiltersScreenState createState() => _WorkoutFiltersScreenState();
}

class _WorkoutFiltersScreenState extends State<WorkoutFiltersScreen> {
  int _activeTabIndex = 0;
  late WorkoutFilters _activeMoveFilters;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _activeMoveFilters = context.read<WorkoutFiltersBloc>().filters;
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
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
    return CupertinoPageScaffold(
      child: MyText('WorkoutFiltersScreen'),
    );
  }
}

class WorkoutFiltersInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Icon(
          CupertinoIcons.info_circle_fill,
          size: 30,
        ),
      ),
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText('WorkoutFiltersInfo'),
        ],
      ),
    );
  }
}

class WorkoutFiltersEquipment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: UnRaisedButtonContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText('WorkoutFiltersEquipment'),
          ],
        ),
      ),
    );
  }
}

class WorkoutFiltersBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: UnRaisedButtonContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText('WorkoutFiltersBody'),
          ],
        ),
      ),
    );
  }
}

class WorkoutFiltersMoves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Styles.black.withOpacity(0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText('WorkoutFiltersMoves'),
          ],
        ),
      ),
    );
  }
}
