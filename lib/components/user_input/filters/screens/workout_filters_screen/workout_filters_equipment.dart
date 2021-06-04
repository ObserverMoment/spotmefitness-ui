import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutFiltersEquipment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bodyweightOnly = context
        .select<WorkoutFiltersBloc, bool>((b) => b.filters.bodyweightOnly);
    final availableEquipments =
        context.select<WorkoutFiltersBloc, List<Equipment>>(
            (b) => b.filters.availableEquipments);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoSwitchRow(
            value: bodyweightOnly,
            title: 'Bodyweight only / No equipment',
            updateValue: (v) => context
                .read<WorkoutFiltersBloc>()
                .updateFilters({'bodyweightOnly': v})),
        if (!bodyweightOnly)
          Expanded(
            child: FadeIn(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QueryObserver<Equipments$Query, json.JsonSerializable>(
                    key: Key(
                        'WorkoutFiltersEquipment - ${EquipmentsQuery().operationName}'),
                    query: EquipmentsQuery(),
                    fetchPolicy: QueryFetchPolicy.storeFirst,
                    builder: (data) {
                      final allEquipments = data.equipments;

                      return EquipmentMultiSelector(
                          selectedEquipments: availableEquipments,
                          scrollDirection: Axis.vertical,
                          equipments: allEquipments,
                          crossAxisCount: 4,
                          fontSize: FONTSIZE.SMALL,
                          showIcon: true,
                          handleSelection: (e) {
                            context.read<WorkoutFiltersBloc>().updateFilters({
                              'availableEquipments': availableEquipments
                                  .toggleItem<Equipment>(e)
                                  .map((e) => e.toJson())
                                  .toList()
                            });
                          });
                    }),
              ),
            ),
          ),
      ],
    );
  }
}
