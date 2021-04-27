import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/menus.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/note_editor.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/round_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/timecap_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/section_type_creators/circuit_creator.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/section_type_creators/free_session_creator.dart';
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

  void _updateSection(Map<String, dynamic> data) {
    _bloc.updateWorkoutSection(widget.sectionIndex, data);
  }

  // Creates an empty default set and then pushes to workoutMoveCreator to add a move.
  void _createEmptyWorkoutSet(
      {bool openWorkoutMoveSelector = false,
      bool workoutMoveIgnoreReps = false,
      Map<String, dynamic> defaults = const {}}) {
    // Create default set.
    _bloc.createWorkoutSet(widget.sectionIndex, defaults: defaults);

    if (openWorkoutMoveSelector) {
      // Open workout move creator to add first move.
      // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
      Navigator.push(
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
  }

  // Creates a new set and then adds a workout move (rest) to it.
  // TODO: Consider on boot of app, saving these static default object types into a global repo somewhere.
  void _createRestSet(Move move, {Map<String, dynamic>? defaults}) async {
    final workoutSet = await _bloc.createWorkoutSet(widget.sectionIndex,
        defaults: defaults ?? {});
    if (workoutSet != null) {
      _bloc.createWorkoutMove(
          widget.sectionIndex,
          workoutSet.sortPosition,
          DefaultObjectfactory.defaultWorkoutMove(
              move: move,
              sortPosition: 0,
              timeAmount: 1,
              timeUnit: TimeUnit.minutes));
    }
  }

  Widget _buildSectionTypeCreator(
    WorkoutSectionType workoutSectionType,
  ) {
    switch (workoutSectionType.name) {
      case kFreeSession:
        return FreeSessionCreator(
            sortedWorkoutSets: _sortedWorkoutSets,
            sectionIndex: widget.sectionIndex,
            createSet: () =>
                _createEmptyWorkoutSet(openWorkoutMoveSelector: true));
      case kHIITCircuit:
        return CircuitCreator(
            sortedWorkoutSets: _sortedWorkoutSets,
            sectionIndex: widget.sectionIndex,
            // IgnoreReps is used when creating a workout move for a timed workout set.
            // No need to set the reps and the length of time working is determined by workoutSet.duration.
            createWorkoutSet: (defaults) => _createEmptyWorkoutSet(
                openWorkoutMoveSelector: true,
                workoutMoveIgnoreReps: true,
                defaults: defaults),
            createRestSet: (restMoveObj, duration) => _createRestSet(
                restMoveObj,
                defaults: {'duration': duration.inSeconds}));
      default:
        return Container();
    }
  }

  String _buildTitle(WorkoutSection workoutSection) {
    final first = 'Section ${(workoutSection.sortPosition + 1).toString()}';
    final second =
        workoutSection.name != null ? ' - ${workoutSection.name}' : '';
    return '$first $second';
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: NavBarTitle(_buildTitle(_workoutSection)),
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
                      onSave: (text) => _updateSection({'name': text}),
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
                      _updateSection({'WorkoutSectionType': type.toJson()});
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
                        WorkoutSectionTypeTag(
                            _workoutSection.workoutSectionType.name),
                        RoundPicker(
                          rounds: _workoutSection.rounds,
                          saveValue: (value) =>
                              _updateSection({'rounds': value}),
                          modalTitle: 'How many rounds?',
                        ),
                        if (![kHIITCircuit]
                            .contains(_workoutSection.workoutSectionType.name))
                          TimecapPicker(
                            timecap: _workoutSection.timecap != null
                                ? Duration(seconds: _workoutSection.timecap!)
                                : null,
                            saveTimecap: (duration) => _updateSection(
                                {'timecap': duration?.inSeconds}),
                          ),
                        NoteEditor(
                          title: 'Section Note',
                          note: _workoutSection.note,
                          saveNote: (note) => _updateSection({'note': note}),
                        )
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
