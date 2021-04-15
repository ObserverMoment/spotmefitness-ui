import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/load_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/rep_picker.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/move_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:collection/collection.dart';

/// Handles state internally the user is ready to save it and add it to the section.
class WorkoutMoveCreator extends StatefulWidget {
  final String? pageTitle;
  final int sectionIndex;
  final int setIndex;
  final int workoutMoveIndex;
  final WorkoutMove? workoutMove;
  WorkoutMoveCreator(
      {required this.sectionIndex,
      required this.setIndex,
      required this.workoutMoveIndex,
      this.pageTitle,
      this.workoutMove});

  @override
  _WorkoutMoveCreatorState createState() => _WorkoutMoveCreatorState();
}

class _WorkoutMoveCreatorState extends State<WorkoutMoveCreator> {
  late WorkoutCreatorBloc _bloc;
  late PageController _pageController;
  WorkoutMove? _activeWorkoutMove;

  @override
  void initState() {
    super.initState();
    _activeWorkoutMove = widget.workoutMove != null
        ? WorkoutMove.fromJson(widget.workoutMove!.toJson())
        : null;
    _bloc = context.read<WorkoutCreatorBloc>();
    _pageController =
        PageController(initialPage: widget.workoutMove == null ? 0 : 1);
    _pageController.addListener(() {
      setState(() {});
    });
    // Hack so that the pageView controller check in build method below (hasClients) works.
    // Detemines if the menu ellipsis displays.
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  void _selectMove(Move move) {
    // Selected equipment will need to be reselected.
    _activeWorkoutMove = WorkoutMove()
      ..id = _activeWorkoutMove?.id ?? 'tempId'
      ..sortPosition = widget.workoutMoveIndex
      ..reps = _activeWorkoutMove?.reps ?? 10
      ..repType = _activeWorkoutMove?.repType ?? WorkoutMoveRepType.reps
      ..distanceUnit = _activeWorkoutMove?.distanceUnit ?? DistanceUnit.metres
      ..loadUnit = _activeWorkoutMove?.loadUnit ?? LoadUnit.kg
      ..timeUnit = _activeWorkoutMove?.timeUnit ?? TimeUnit.minutes
      ..loadAmount = 0
      ..move = move;
    _pageController.toPage(1);
    setState(() {});
  }

  /// [_activeWorkoutMove] must be non null before calling this.
  void _updateWorkoutMove(Map<String, dynamic> data) {
    setState(() {
      _activeWorkoutMove =
          WorkoutMove.fromJson({..._activeWorkoutMove!.toJson(), ...data});
    });
  }

  bool _validToSave() {
    if (_activeWorkoutMove == null) {
      return false;
    }
    return _activeWorkoutMove!.move.selectableEquipments.isEmpty ||
        _activeWorkoutMove!.equipment != null;
  }

  void _saveWorkoutMove() {
    if (_activeWorkoutMove != null && _validToSave()) {
      // Check if this is a create or an edit op.
      if (widget.workoutMove != null) {
        _bloc.editWorkoutMove(
            widget.sectionIndex, widget.setIndex, _activeWorkoutMove!);
      } else {
        _bloc.createWorkoutMove(
            widget.sectionIndex, widget.setIndex, _activeWorkoutMove!);
      }
    }
    context.pop();
  }

  Widget? _buildTopRightIcon() {
    if (!_pageController.hasClients) {
      return null;
    } else if (_pageController.page == 0 && _activeWorkoutMove?.move != null) {
      return NavBarTextButton(
        text: 'Edit >',
        onPressed: () => _pageController.toPage(1),
      );
    } else if (_validToSave()) {
      // Check if this is a create or an edit op.

      return FadeIn(
        child: NavBarSaveButton(
          _saveWorkoutMove,
        ),
      );
    }
  }

  List<Equipment> _equipmentsWithBodyWeightFirst(List<Equipment> equipments) {
    final bodyweight =
        equipments.firstWhereOrNull((e) => e.id == kBodyweightEquipmentId);
    return bodyweight == null
        ? equipments
        : [
            bodyweight,
            ...equipments.where((e) => e.id != kBodyweightEquipmentId),
          ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: NavBarCancelButton(context.pop),
        middle: NavBarTitle(widget.pageTitle ?? 'Set'),
        trailing: _buildTopRightIcon(),
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
                      MoveSelector(
                        move: _activeWorkoutMove?.move,
                        selectMove: _selectMove,
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: _activeWorkoutMove == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MiniButton(
                                    prefix: Icon(
                                      CupertinoIcons.arrow_left_right_square,
                                      color: context.theme.background,
                                      size: 20,
                                    ),
                                    text: 'Select a move',
                                    onPressed: () => _pageController.toPage(0))
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    H2(_activeWorkoutMove!.move.name),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    MiniButton(
                                        prefix: Icon(
                                          CupertinoIcons
                                              .arrow_left_right_square,
                                          color: context.theme.background,
                                          size: 20,
                                        ),
                                        text: 'Change',
                                        onPressed: () =>
                                            _pageController.toPage(0))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Wrap(
                                    spacing: 30,
                                    runSpacing: 10,
                                    alignment: WrapAlignment.spaceEvenly,
                                    runAlignment: WrapAlignment.spaceEvenly,
                                    children: [
                                      RepPickerDisplay(
                                        reps: _activeWorkoutMove!.reps,
                                        repType: _activeWorkoutMove!.repType,
                                        updateReps: (reps) =>
                                            _updateWorkoutMove({'reps': reps}),
                                        updateRepType: (repType) =>
                                            _updateWorkoutMove(
                                                {'repType': repType.apiValue}),
                                        distanceUnit:
                                            _activeWorkoutMove!.distanceUnit,
                                        updateDistanceUnit: (distanceUnit) =>
                                            _updateWorkoutMove({
                                          'distanceUnit': distanceUnit.apiValue
                                        }),
                                        timeUnit: _activeWorkoutMove!.timeUnit,
                                        updateTimeUnit: (timeUnit) =>
                                            _updateWorkoutMove({
                                          'timeUnit': timeUnit.apiValue
                                        }),
                                      ),
                                      LoadPickerDisplay(
                                        loadAmount:
                                            _activeWorkoutMove!.loadAmount,
                                        loadUnit: _activeWorkoutMove!.loadUnit,
                                        updateLoadAmount: (loadAmount) =>
                                            _updateWorkoutMove(
                                                {'loadAmount': loadAmount}),
                                        updateLoadUnit: (loadUnit) =>
                                            _updateWorkoutMove({
                                          'loadUnit': loadUnit.apiValue
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_activeWorkoutMove!
                                    .move.requiredEquipments.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyText('Required'),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        height: 40,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          children: _activeWorkoutMove!
                                              .move.requiredEquipments
                                              .map((e) => ContentBox(
                                                    child: MyText(
                                                      e.name,
                                                      weight: FontWeight.bold,
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                if (_activeWorkoutMove!
                                    .move.selectableEquipments.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 6),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: MyText('Select from...'),
                                        ),
                                        EquipmentMultiSelector(
                                            showIcon: true,
                                            fontSize: FONTSIZE.SMALL,
                                            equipments:
                                                _equipmentsWithBodyWeightFirst(
                                                    _activeWorkoutMove!.move
                                                        .selectableEquipments),
                                            handleSelection: (equipment) =>
                                                _updateWorkoutMove({
                                                  'Equipment':
                                                      equipment.toJson()
                                                }),
                                            selectedEquipments: [
                                              if (_activeWorkoutMove!
                                                      .equipment !=
                                                  null)
                                                _activeWorkoutMove!.equipment!
                                            ]),
                                      ],
                                    ),
                                  ),
                                if (_activeWorkoutMove!.equipment != null)
                                  GrowIn(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            MyText('Selected'),
                                            ContentBox(
                                              child: MyText(
                                                _activeWorkoutMove!
                                                    .equipment!.name,
                                                weight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              ],
                            ),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
