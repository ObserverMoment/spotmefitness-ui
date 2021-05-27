import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/load_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/rep_picker.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/move_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class BenchmarkMoveCreator extends StatelessWidget {
  final BenchmarkType benchmarkType;
  final double? reps;
  final void Function(double reps) updateReps;
  final WorkoutMoveRepType? repType;
  final void Function(WorkoutMoveRepType repType) updateRepType;
  final double? load;
  final void Function(double load) updateLoad;
  final LoadUnit? loadUnit;
  final void Function(LoadUnit loadUnit) updateLoadUnit;
  final DistanceUnit? distanceUnit;
  final void Function(DistanceUnit distanceUnit) updateDistanceUnit;
  final Equipment? equipment;
  final void Function(Equipment equipment) updateEquipment;
  final Move? move;
  final void Function(Move move) updateMove;

  BenchmarkMoveCreator({
    this.reps,
    required this.updateReps,
    this.repType,
    required this.updateRepType,
    this.load,
    required this.updateLoad,
    this.loadUnit,
    required this.updateLoadUnit,
    this.distanceUnit,
    required this.updateDistanceUnit,
    this.equipment,
    required this.updateEquipment,
    this.move,
    required this.updateMove,
    required this.benchmarkType,
  });

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: H3(move?.name ?? '')),
            SizedBox(
              width: 16,
            ),
            BorderButton(
                mini: true,
                prefix: Icon(
                  CupertinoIcons.arrow_left_right,
                  size: 20,
                ),
                text: move != null ? 'Change' : 'Select Move',
                onPressed: () => context.push(
                    child: CupertinoPageScaffold(
                        navigationBar: BasicNavBar(
                          heroTag: 'BenchmarkMoveCreator - MoveSelector',
                          customLeading: NavBarCancelButton(context.pop),
                          middle: NavBarTitle('Select Move'),
                        ),
                        child: MoveSelector(
                            move: move,
                            selectMove: (m) {
                              updateMove(m);
                              context.pop();
                            }))))
          ],
        ),
        if (move != null && move!.requiredEquipments.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText('Required'),
              SizedBox(height: 4),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: move!.requiredEquipments
                    .map((e) => ContentBox(
                          child: MyText(
                            e.name,
                            weight: FontWeight.bold,
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        if (move != null && move!.selectableEquipments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 6),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: MyText('Select from...'),
                ),
                EquipmentMultiSelector(
                    showIcon: true,
                    fontSize: FONTSIZE.SMALL,
                    equipments: _equipmentsWithBodyWeightFirst(
                        move!.selectableEquipments),
                    handleSelection: updateEquipment,
                    selectedEquipments: [if (equipment != null) equipment!]),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            spacing: 30,
            runSpacing: 10,
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.spaceEvenly,
            children: [
              if ([BenchmarkType.maxload, BenchmarkType.fastesttime]
                  .contains(benchmarkType))
                RepPickerDisplay(
                    distanceUnit: distanceUnit ?? DistanceUnit.metres,
                    reps: reps ?? 0,
                    repType: repType ?? WorkoutMoveRepType.reps,
                    timeUnit: TimeUnit.seconds,
                    updateDistanceUnit: updateDistanceUnit,
                    updateReps: updateReps,
                    updateRepType: updateRepType,
                    updateTimeUnit: (_) {},
                    validRepTypes: [
                      WorkoutMoveRepType.reps,
                      WorkoutMoveRepType.calories,
                      WorkoutMoveRepType.distance
                    ]),
              if (benchmarkType != BenchmarkType.maxload &&
                  equipment != null &&
                  equipment!.loadAdjustable)
                LoadPickerDisplay(
                  loadAmount: load ?? 0,
                  loadUnit: loadUnit ?? LoadUnit.kg,
                  updateLoad: (load, loadUnit) {
                    updateLoad(load);
                    updateLoadUnit(loadUnit);
                  },
                )
            ],
          ),
        ),
      ],
    );
  }
}
