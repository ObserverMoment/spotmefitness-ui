import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_media.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_meta.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_creator_structure.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutCreator extends StatefulWidget {
  /// For use when duplicating a workout.
  final WorkoutData? workoutData;
  WorkoutCreator({this.workoutData});

  @override
  _WorkoutCreatorState createState() => _WorkoutCreatorState();
}

class _WorkoutCreatorState extends State<WorkoutCreator> {
  int _activeTabIndex = 0;
  WorkoutData? _initWorkoutData;
  final PageController _pageController = PageController();

  Future<WorkoutData> _initWorkout() async {
    if (_initWorkoutData != null) {
      return _initWorkoutData!;
    } else {
      _initWorkoutData =
          await WorkoutCreatorBloc.initialize(context, widget.workoutData);
      return _initWorkoutData!;
    }
  }

  void _handleTabChange(int index) {
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
    return FutureBuilderHandler<WorkoutData>(
        loadingWidget: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            middle: NavBarTitle('Getting ready...'),
          ),
          child: Center(
            child: LoadingCircle(),
          ),
        ),
        future: _initWorkout(),
        builder: (initialWorkoutData) => ChangeNotifierProvider(
              create: (context) => WorkoutCreatorBloc(initialWorkoutData),
              builder: (context, child) {
                return CupertinoPageScaffold(
                  navigationBar: CreateEditPageNavBar(
                    handleClose: () => context.pop(),
                    handleSave: () => {},
                    // Only allow undo when editing a workout - not when creating.
                    handleUndo: widget.workoutData != null ? () => {} : null,
                    formIsDirty: context.select<WorkoutCreatorBloc, bool>(
                        (bloc) => bloc.formIsDirty),
                    inputValid: false,
                    title: widget.workoutData == null
                        ? 'New Workout'
                        : 'Edit Workout',
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        MyTabBarNav(
                            titles: ['Meta', 'Structure', 'Media'],
                            handleTabChange: _handleTabChange,
                            activeTabIndex: _activeTabIndex),
                        Expanded(
                            child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: _handleTabChange,
                          children: [
                            WorkoutCreatorMeta(),
                            WorkoutCreatorStructure(),
                            WorkoutCreatorMedia(),
                          ],
                        )),
                      ],
                    ),
                  ),
                );
              },
            ));
  }
}
