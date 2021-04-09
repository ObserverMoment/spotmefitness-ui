import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_meta.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutCreator extends StatefulWidget {
  final WorkoutData? workoutData;
  WorkoutCreator({this.workoutData});

  @override
  _WorkoutCreatorState createState() => _WorkoutCreatorState();
}

class _WorkoutCreatorState extends State<WorkoutCreator> {
  bool _formIsDirty = false;

  // Active (user is updating) data and backup data (from start point).
  Map<String, dynamic>? _backupJson;
  late WorkoutData _activeWorkoutData;

  // Text field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int _activeTabIndex = 0;
  final PageController _pageController = PageController();

  WorkoutData _initWorkout() {
    final _initWorkout = _backupJson != null
        ? WorkoutData.fromJson(_backupJson!)
        : WorkoutData.fromJson({
            '__typename': 'Workout',
            'id': 'temp_id',
            'name': 'Workout ${DateTime.now().dateString}',
            'difficultyLevel': 'CHALLENGING',
            'contentAccessScope': 'PRIVATE',
            'WorkoutGoals': [],
            'WorkoutTags': [],
            'WorkoutSections': []
          });
    _formIsDirty = false;
    setState(() {});
    return _initWorkout;
  }

  @override
  void initState() {
    super.initState();
    _backupJson = widget.workoutData?.toJson();
    _activeWorkoutData = _initWorkout();

    _nameController.addListener(() {
      if (_activeWorkoutData.name != _nameController.text) {
        _checkDirtyAndSetState(() {
          _activeWorkoutData.name = _nameController.text;
        });
      }
    });
    _descriptionController.addListener(() {
      if (_activeWorkoutData.description != _descriptionController.text) {
        _checkDirtyAndSetState(() {
          _activeWorkoutData.description = _descriptionController.text;
        });
      }
    });
  }

  void _checkDirtyAndSetState(void Function() fn) {
    _formIsDirty = true;
    setState(fn);
  }

  void _handleTabChange(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  void _updateWorkoutMetaData(Map<String, dynamic> data) {
    final _updated = {..._activeWorkoutData.toJson(), ...data};
    _checkDirtyAndSetState(() {
      _activeWorkoutData = WorkoutData.fromJson(_updated);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CreateEditPageNavBar(
        formIsDirty: _formIsDirty,
        handleClose: () => context.pop(),
        handleSave: () => {},
        handleUndo: () => {},
        inputValid: false,
        title: widget.workoutData == null ? 'New Workout' : 'Edit Workout',
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
              controller: _pageController,
              onPageChanged: _handleTabChange,
              children: [
                WorkoutCreatorMeta(
                  workoutData: _activeWorkoutData,
                  updateWorkoutMetaData: _updateWorkoutMetaData,
                  nameController: _nameController,
                  descriptionController: _descriptionController,
                ),
                MyText('Structure'),
                MyText('Media'),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
