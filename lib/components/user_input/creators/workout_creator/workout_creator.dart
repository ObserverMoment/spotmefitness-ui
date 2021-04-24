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
  /// For use when editing or duplicating a workout.
  final Workout? workout;
  WorkoutCreator({this.workout});

  @override
  _WorkoutCreatorState createState() => _WorkoutCreatorState();
}

class _WorkoutCreatorState extends State<WorkoutCreator> {
  int _activeTabIndex = 0;
  Workout? _workout;
  final PageController _pageController = PageController();

  Future<Workout> _initWorkout() async {
    if (_workout != null) {
      return _workout!;
    } else {
      _workout = await WorkoutCreatorBloc.initialize(context, widget.workout);
      return _workout!;
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilderHandler<Workout>(
        loadingWidget: CupertinoPageScaffold(
          navigationBar: BasicNavBar(
            automaticallyImplyLeading: false,
            middle: NavBarTitle('Getting ready...'),
          ),
          child: Center(
            child: LoadingCircle(),
          ),
        ),
        future: _initWorkout(),
        builder: (initialWorkout) => ChangeNotifierProvider(
              create: (context) => WorkoutCreatorBloc(initialWorkout, context),
              builder: (context, child) {
                final bool formIsDirty =
                    context.select<WorkoutCreatorBloc, bool>(
                        (bloc) => bloc.formIsDirty);
                final String name = context.select<WorkoutCreatorBloc, String>(
                    (bloc) => bloc.workout.name);
                return CupertinoPageScaffold(
                  navigationBar: CreateEditPageNavBar(
                    handleClose: context.pop,
                    handleSave: () => _saveAndClose(context),
                    saveText: 'Done',

                    /// You always need to run the bloc.saveAllUpdates fn when creating.
                    /// i.e when [widget.workout == null]
                    formIsDirty: widget.workout == null || formIsDirty,
                    inputValid: name.length >= 3,
                    title:
                        widget.workout == null ? 'New Workout' : 'Edit Workout',
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
