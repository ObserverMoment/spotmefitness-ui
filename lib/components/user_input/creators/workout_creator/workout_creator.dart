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
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  Future<void> _saveAndClose(BuildContext context) async {
    await context.read<WorkoutCreatorBloc>().saveAllChanges(context);
    context.pop();
  }

  void _undoAllChanges(BuildContext context) {
    context.showConfirmDialog(
        title: 'Undo all changes?',
        content: MyText(
          'All changes from this session will be reset.',
          maxLines: 3,
        ),
        onConfirm: () =>
            context.read<WorkoutCreatorBloc>().undoAllChanges(context));
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
                final bool formIsDirty =
                    context.select<WorkoutCreatorBloc, bool>(
                        (bloc) => bloc.formIsDirty);
                final String name = context.select<WorkoutCreatorBloc, String>(
                    (bloc) => bloc.workoutData.name);
                return CupertinoPageScaffold(
                  navigationBar: CreateEditPageNavBar(
                    handleClose: context.pop,
                    handleSave: () => _saveAndClose(context),
                    handleUndo: () => _undoAllChanges(context),

                    /// You always need to run the bloc.saveAllUpdates fn when creating.
                    /// i.e when [widget.workoutData == null]
                    formIsDirty: widget.workoutData == null || formIsDirty,
                    inputValid: name.length >= 3,
                    title: widget.workoutData == null
                        ? 'New Workout'
                        : 'Edit Workout',
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        MyTabBarNav(
                            titles: ['Meta', 'Structure', 'Media'],
                            handleTabChange: _changeTab,
                            activeTabIndex: _activeTabIndex),
                        Expanded(
                            child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: _changeTab,
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
