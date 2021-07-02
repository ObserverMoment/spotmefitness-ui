import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class CustomMoveCreatorEquipment extends StatelessWidget {
  final Move move;
  final void Function(Map<String, dynamic> data) updateMove;
  CustomMoveCreatorEquipment({required this.move, required this.updateMove});
  @override
  Widget build(BuildContext context) {
    return QueryObserver<Equipments$Query, json.JsonSerializable>(
        key: Key(
            'CustomMoveCreatorEquipment - ${EquipmentsQuery().operationName}'),
        query: EquipmentsQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          final allEquipments = data.equipments;

          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
              child: Column(
                children: [
                  SelectedEquipmentsDisplay(
                    selectedEquipments: move.requiredEquipments,
                    title: 'Required',
                    allEquipments: allEquipments,
                    updateSelectedEquipments: (List<Equipment> equipments) {
                      updateMove({
                        'RequiredEquipments':
                            equipments.map((e) => e.toJson()).toList()
                      });
                    },
                  ),
                  SelectedEquipmentsDisplay(
                    selectedEquipments: move.selectableEquipments,
                    title: 'Selectable',
                    allEquipments: allEquipments,
                    updateSelectedEquipments: (List<Equipment> equipments) {
                      updateMove({
                        'SelectableEquipments':
                            equipments.map((e) => e.toJson()).toList()
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class SelectedEquipmentsDisplay extends StatelessWidget {
  final String title;
  final List<Equipment> allEquipments;
  final List<Equipment> selectedEquipments;
  final void Function(List<Equipment> equipments) updateSelectedEquipments;

  SelectedEquipmentsDisplay(
      {required this.title,
      required this.allEquipments,
      required this.selectedEquipments,
      required this.updateSelectedEquipments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                title,
                weight: FontWeight.bold,
              ),
              InfoPopupButton(
                  infoWidget:
                      MyText('What are selectable and required equipments')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: selectedEquipments.isEmpty
                ? [
                    MyText(
                      'None',
                      subtext: true,
                    )
                  ]
                : selectedEquipments.map((e) => Tag(tag: e.name)).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SecondaryButton(
              text: selectedEquipments.isEmpty ? 'Add' : 'Edit',
              onPressed: () => context.push(
                  fullscreenDialog: true,
                  child: FullScreenEquipmentSelector(
                      selectedEquipments: selectedEquipments,
                      allEquipments: allEquipments,
                      handleSelection: updateSelectedEquipments))),
        )
      ],
    );
  }
}
