import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutFiltersEquipment extends StatelessWidget {
  void _handleImportFromGymProfile(BuildContext context) {
    context.showBottomSheet(child: SafeArea(
      child: GymProfileSelector(selectGymProfile: (gymProfile) {
        if (gymProfile != null) {
          context.read<WorkoutFiltersBloc>().updateFilters({
            'availableEquipments':
                gymProfile.equipments.map((e) => e.toJson()).toList()
          });
        }
      }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bodyweightOnly = context
        .select<WorkoutFiltersBloc, bool>((b) => b.filters.bodyweightOnly);
    final availableEquipments =
        context.select<WorkoutFiltersBloc, List<Equipment>>(
            (b) => b.filters.availableEquipments);

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 6.0, bottom: 8, left: 4, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoSwitchRow(
                  value: bodyweightOnly,
                  title: 'No equipment ',
                  updateValue: (v) => context
                      .read<WorkoutFiltersBloc>()
                      .updateFilters({'bodyweightOnly': v})),
              BorderButton(
                  mini: true,
                  text: 'From gym profile',
                  onPressed: () => _handleImportFromGymProfile(context))
            ],
          ),
        ),
        if (!bodyweightOnly)
          Expanded(
            child: FadeIn(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          // Bodyweight has no impact on workout filters. It is / should be ignored by both the client side and api side filter logic.
                          equipments: allEquipments
                              .where((e) => e.id != kBodyweightEquipmentId)
                              .toList(),
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
