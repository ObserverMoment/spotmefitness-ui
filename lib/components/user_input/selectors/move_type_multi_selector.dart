import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class MoveTypeMultiSelector extends StatelessWidget {
  final String name;
  final void Function(List<MoveType> types) updateSelectedTypes;
  final List<MoveType> selectedTypes;
  const MoveTypeMultiSelector({
    required this.updateSelectedTypes,
    required this.selectedTypes,
    this.name = 'Move Types',
  });

  void _handleTap(MoveType type) {
    updateSelectedTypes(selectedTypes.toggleItem<MoveType>(type));
  }

  List<Widget> _buildChildren(List<MoveType> types) {
    return types
        .map((type) => GestureDetector(
              onTap: () => _handleTap(type),
              child: SelectableBox(
                onPressed: () => _handleTap(type),
                selectedColor: Styles.colorOne,
                isSelected: selectedTypes.contains(type),
                fontSize: FONTSIZE.BIG,
                text: type.name,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<MoveTypes$Query, json.JsonSerializable>(
        key: Key('MoveTypeSelector - ${MoveTypesQuery().operationName}'),
        query: MoveTypesQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    MyText(
                      selectedTypes.isEmpty
                          ? 'All'
                          : '(${selectedTypes.length})',
                      subtext: true,
                    )
                  ],
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _buildChildren(data.moveTypes),
              ),
            ],
          );
        });
  }
}
