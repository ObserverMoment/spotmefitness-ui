import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutSectionTypeMultiSelector extends StatelessWidget {
  final void Function(List<WorkoutSectionType> types) updateSelectedTypes;
  final List<WorkoutSectionType> selectedTypes;
  const WorkoutSectionTypeMultiSelector(
      {required this.updateSelectedTypes, required this.selectedTypes});

  void _handleTap(WorkoutSectionType type) {
    updateSelectedTypes(selectedTypes.toggleItem<WorkoutSectionType>(type));
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<WorkoutSectionTypes$Query, json.JsonSerializable>(
        key: Key(
            'WorkoutSectionTypeSelector - ${WorkoutSectionTypesQuery().operationName}'),
        query: WorkoutSectionTypesQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H3(
                      'Workout Types',
                      textAlign: TextAlign.start,
                    ),
                    MyText(
                      selectedTypes.isEmpty
                          ? 'All'
                          : '${selectedTypes.length} selected',
                      color: Styles.infoBlue,
                    )
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 4,
                runSpacing: 4,
                children: data.workoutSectionTypes
                    .sortedBy<num>((type) => int.parse(type.id))
                    .map((type) => GestureDetector(
                          onTap: () => _handleTap(type),
                          child: SelectableTag(
                            onPressed: () => _handleTap(type),
                            selectedColor: Styles.colorTwo,
                            isSelected: selectedTypes.contains(type),
                            text: type.name,
                          ),
                        ))
                    .toList(),
              ),
            ],
          );
        });
  }
}
