import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutSectionTypeMultiSelector extends StatelessWidget {
  final String name;
  final void Function(List<WorkoutSectionType> types) updateSelectedTypes;
  final List<WorkoutSectionType> selectedTypes;
  final bool allowMultiSelect;

  /// If Vertical, physics will be set to [NeverScrollablePhysics]
  final Axis direction;
  final bool hideTitle;
  const WorkoutSectionTypeMultiSelector(
      {required this.updateSelectedTypes,
      required this.selectedTypes,
      this.allowMultiSelect = true,
      this.name = 'Workout Types',
      this.direction = Axis.horizontal,
      this.hideTitle = false});

  void _handleTap(WorkoutSectionType type) {
    if (allowMultiSelect) {
      updateSelectedTypes(selectedTypes.toggleItem<WorkoutSectionType>(type));
    } else {
      updateSelectedTypes([type]);
    }
  }

  List<Widget> _buildChildren(List<WorkoutSectionType> types) {
    return types
        .sortedBy<num>((type) => int.parse(type.id))
        .map((type) => Padding(
              padding: direction == Axis.vertical
                  ? const EdgeInsets.only(bottom: 8.0)
                  : const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => _handleTap(type),
                child: SelectableBox(
                  onPressed: () => _handleTap(type),
                  selectedColor: Styles.colorOne,
                  isSelected: selectedTypes.contains(type),
                  fontSize: FONTSIZE.BIG,
                  text: type.name,
                ),
              ),
            ))
        .toList();
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
              if (!hideTitle)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyHeaderText(
                        name,
                        textAlign: TextAlign.start,
                      ),
                      if (allowMultiSelect)
                        MyText(
                          selectedTypes.isEmpty
                              ? 'All'
                              : '${selectedTypes.length} selected',
                          subtext: true,
                        )
                    ],
                  ),
                ),
              direction == Axis.vertical
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: _buildChildren(data.workoutSectionTypes),
                    )
                  : SizedBox(
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: _buildChildren(data.workoutSectionTypes),
                      ),
                    ),
            ],
          );
        });
  }
}
