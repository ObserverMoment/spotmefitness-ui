import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/note_editor.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/round_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/timecap_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/section_type_creators/circuit_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/section_type_creators/emom_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/section_type_creators/free_session_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/section_type_creators/tabata_creator.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_section_type_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/constants.dart';

class WorkoutSectionCreator extends StatefulWidget {
  final Key key;
  final int sectionIndex;
  final bool isCreate;
  WorkoutSectionCreator(
      {required this.key, required this.sectionIndex, this.isCreate = false})
      : super(key: key);

  @override
  _WorkoutSectionCreatorState createState() => _WorkoutSectionCreatorState();
}

class _WorkoutSectionCreatorState extends State<WorkoutSectionCreator> {
  late WorkoutCreatorBloc _bloc;
  late PageController _pageController;
  late WorkoutSection _workoutSection;
  late List<WorkoutSet> _sortedWorkoutSets;

  /// Disable multiple fast clicks from generating multiple actions which will cause errors.
  bool _processing = false;

  void _checkForNewData() {
    if (_bloc.workout.workoutSections.length > widget.sectionIndex) {
      final updatedWorkoutSection =
          _bloc.workout.workoutSections[widget.sectionIndex];

      if (_workoutSection != updatedWorkoutSection) {
        setState(() {
          _workoutSection =
              WorkoutSection.fromJson(updatedWorkoutSection.toJson());
        });
      }

      final updatedWorkoutSets =
          _bloc.workout.workoutSections[widget.sectionIndex].workoutSets;

      if (!_sortedWorkoutSets.equals(updatedWorkoutSets)) {
        setState(() {
          _sortedWorkoutSets =
              updatedWorkoutSets.sortedBy<num>((ws) => ws.sortPosition);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutCreatorBloc>();
    _pageController = PageController(initialPage: widget.isCreate ? 0 : 1);

    _workoutSection = WorkoutSection.fromJson(
        _bloc.workout.workoutSections[widget.sectionIndex].toJson());

    _sortedWorkoutSets = _bloc
        .workout.workoutSections[widget.sectionIndex].workoutSets
        .sortedBy<num>((ws) => ws.sortPosition);

    _bloc.addListener(_checkForNewData);

    _pageController.addListener(() {
      setState(() {});
    });
    // Hack so that the pageView controller check in build method below (hasClients) works.
    // Detemines if the menu ellipsis displays.
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  void _updateWorkoutSectionType(WorkoutSectionType type) async {
    /// Request any required inputs before the workoutSection is updated.
    /// And adjust / reset anything that needs to be changed when section type is changed.
    if (type.name == kAMRAPName) {
      await context.openBlurModalPopup<Duration>(
          TimecapPopup(
            timecap: Duration(minutes: 10),
            allowNoTimecap: false,
            title: 'AMRAP in how long?',
            saveTimecap: (timecap) => _updateWorkoutSection({
              'timecap': (timecap ?? Duration(minutes: 10)).inSeconds,
              'WorkoutSectionType': type.toJson()
            }),
          ),
          height: 400,
          // An input is required - clicking outside the modal should not close it.
          barrierDismissible: false);
    } else {
      _updateWorkoutSection({'WorkoutSectionType': type.toJson()});
    }
  }

  void _updateWorkoutSection(Map<String, dynamic> data) {
    _bloc.updateWorkoutSection(widget.sectionIndex, data);
  }

  // Creates an empty default set and then pushes to workoutMoveCreator to add a move.
  void _createEmptyWorkoutSet(
      {bool openWorkoutMoveSelector = false,
      bool workoutMoveIgnoreReps = false,
      Map<String, dynamic> defaults = const {}}) async {
    if (_processing) {
      return;
    }

    setState(() => _processing = true);
    // Create default set.
    await _bloc.createWorkoutSet(widget.sectionIndex, defaults: defaults);

    if (openWorkoutMoveSelector) {
      // Open workout move creator to add first move.
      // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) =>
              ChangeNotifierProvider<WorkoutCreatorBloc>.value(
            value: _bloc,
            child: WorkoutMoveCreator(
              pageTitle: 'Add Set',
              sectionIndex: widget.sectionIndex,
              setIndex: _sortedWorkoutSets.length - 1,
              workoutMoveIndex: 0,
              ignoreReps: workoutMoveIgnoreReps,
            ),
          ),
        ),
      );
    }
    setState(() => _processing = false);
  }

  // Creates a new set and then adds a workout move (rest) to it.
  // TODO: Consider on boot of app:
  // saving these static default object types into a global repo somewhere.
  void _createRestSet(Move restMove, {Map<String, dynamic>? defaults}) async {
    if (_processing) {
      return;
    }

    setState(() => _processing = true);

    /// [shouldNotifyListeners: false]. This will happen once _bloc.createWorkoutMove is complete.
    final workoutSet = await _bloc.createWorkoutSet(widget.sectionIndex,
        defaults: defaults ?? {}, shouldNotifyListeners: false);
    if (workoutSet != null) {
      await _bloc.createWorkoutMove(
          widget.sectionIndex,
          workoutSet.sortPosition,
          DefaultObjectfactory.defaultRestWorkoutMove(
              move: restMove,
              sortPosition: 0,
              timeAmount: 1,
              timeUnit: TimeUnit.minutes));
    }
    setState(() => _processing = false);
  }

  void toggleShowFullSetInfo() => _bloc.toggleShowFullSetInfo();

  Widget _buildSectionTypeCreator(
    WorkoutSectionType workoutSectionType,
  ) {
    switch (workoutSectionType.name) {
      case kFreeSessionName:
      case kForTimeName:
      case kAMRAPName:
        return FreeSessionCreator(
            sortedWorkoutSets: _sortedWorkoutSets,
            sectionIndex: widget.sectionIndex,
            totalRounds: _workoutSection.rounds,
            timecap: _workoutSection.timecap,
            workoutSectionType: workoutSectionType,
            createSet: () =>
                _createEmptyWorkoutSet(openWorkoutMoveSelector: true));
      case kHIITCircuitName:
        return CircuitCreator(
            sortedWorkoutSets: _sortedWorkoutSets,
            sectionIndex: widget.sectionIndex,
            totalRounds: _workoutSection.rounds,
            // workoutMoveIgnoreReps is used when creating a workout move for a timed workout set.
            // No need to set the reps and the length of time working is determined by workoutSet.duration.
            createWorkoutSet: (defaults) => _createEmptyWorkoutSet(
                openWorkoutMoveSelector: true,
                workoutMoveIgnoreReps: true,
                defaults: defaults),
            createRestSet: (restMoveObj, duration) => _createRestSet(
                restMoveObj,
                defaults: {'duration': duration.inSeconds}));
      case kEMOMName:
      case kLastStandingName:
        return EMOMCreator(
            sortedWorkoutSets: _sortedWorkoutSets,
            sectionIndex: widget.sectionIndex,
            totalRounds: _workoutSection.rounds,
            timecap: _workoutSection.timecap,
            workoutSectionType: workoutSectionType,
            createSet: (defaults) => _createEmptyWorkoutSet(
                openWorkoutMoveSelector: true, defaults: defaults));
      case kTabataName:
        return TabataCreator(
            sortedWorkoutSets: _sortedWorkoutSets,
            sectionIndex: widget.sectionIndex,
            totalRounds: _workoutSection.rounds,
            // workoutMoveIgnoreReps is used when creating a workout move for a timed workout set.
            // No need to set the reps and the length of time working is determined by workoutSet.duration.
            createWorkoutSet: _createEmptyWorkoutSet,
            createRestSet: (restMoveObj, duration) => _createRestSet(
                restMoveObj,
                defaults: {'duration': duration.inSeconds}));

      default:
        return Container();
    }
  }

  Widget _buildTitle(WorkoutSection workoutSection) {
    return SizedBox(
      height: 28,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WorkoutSectionTypeTag(
              _workoutSection.workoutSectionType.name.toUpperCase()),
          if (workoutSection.name != null)
            NavBarTitle(' - ${workoutSection.name!}'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFullSetInfo =
        context.select<WorkoutCreatorBloc, bool>((b) => b.showFullSetInfo);

    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: _buildTitle(_workoutSection),
        trailing: _pageController.hasClients && _pageController.page != 0
            ? NavBarEllipsisMenu(
                items: [
                  ContextMenuItem(
                    text: Utils.textNotNull(_workoutSection.name)
                        ? 'Edit name'
                        : 'Add name',
                    iconData: CupertinoIcons.pencil,
                    onTap: () => context.push(
                        child: FullScreenTextEditing(
                      title: 'Name',
                      inputValidation: (text) => true,
                      initialValue: _workoutSection.name,
                      onSave: (text) => _updateWorkoutSection({'name': text}),
                    )),
                  ),
                  ContextMenuItem(
                    text: 'Change type',
                    iconData: CupertinoIcons.arrow_left_right,
                    onTap: () => _pageController.toPage(0),
                  ),
                ],
              )
            : null,
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    MyText('What do you want to create?'),
                    WorkoutSectionTypeSelector((WorkoutSectionType type) {
                      _updateWorkoutSectionType(type);
                      _pageController.toPage(1);
                    }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (![kLastStandingName, kAMRAPName]
                            .contains(_workoutSection.workoutSectionType.name))
                          RoundPicker(
                            rounds: _workoutSection.rounds,
                            saveValue: (value) =>
                                _updateWorkoutSection({'rounds': value}),
                            modalTitle: 'How many rounds?',
                          ),
                        if (![
                          kHIITCircuitName,
                          kEMOMName,
                          kTabataName,
                          kForTimeName,
                        ].contains(_workoutSection.workoutSectionType.name))
                          TimecapPicker(
                            allowNoTimecap:
                                _workoutSection.workoutSectionType.name !=
                                    kAMRAPName,
                            timecap: _workoutSection.timecap != null
                                ? Duration(seconds: _workoutSection.timecap!)
                                : null,
                            saveTimecap: (duration) => _updateWorkoutSection(
                                {'timecap': duration?.inSeconds}),
                          ),
                        NoteEditor(
                          title: 'Section Note',
                          note: _workoutSection.note,
                          saveNote: (note) =>
                              _updateWorkoutSection({'note': note}),
                        ),
                        CupertinoButton(
                            pressedOpacity: 0.8,
                            padding: EdgeInsets.zero,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              child: showFullSetInfo
                                  ? Icon(CupertinoIcons.eye_slash)
                                  : Icon(CupertinoIcons.eye),
                            ),
                            onPressed: toggleShowFullSetInfo),
                      ],
                    ),
                    _buildSectionTypeCreator(
                        _workoutSection.workoutSectionType),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
