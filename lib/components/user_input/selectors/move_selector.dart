import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/workout/move_details.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// The user is required to select a move before moving on to the workoutMove creator.
/// Unlike some other selectors this runs callback immediately on press.
class MoveSelector extends StatefulWidget {
  final Move? move;
  final void Function(Move move) selectMove;
  MoveSelector({required this.selectMove, this.move});

  @override
  _MoveSelectorState createState() => _MoveSelectorState();
}

class _MoveSelectorState extends State<MoveSelector> {
  int _activeTabIndex = 0;
  String _textFilter = '';
  List<MoveType> _selectedMoveTypes = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QueryResponseBuilder(
          options: QueryOptions(document: MoveTypesQuery().document),
          builder: (result, {refetch, fetchMore}) {
            final moveTypes =
                MoveTypes$Query.fromJson(result.data ?? {}).moveTypes;
            return QueryResponseBuilder(
                options: QueryOptions(
                    document: AllMovesQuery().document,
                    fetchPolicy: FetchPolicy.cacheFirst),
                builder: (result, {refetch, fetchMore}) {
                  final displayMoves = _activeTabIndex == 0
                      ? AllMoves$Query.fromJson(result.data ?? {}).standardMoves
                      : AllMoves$Query.fromJson(result.data ?? {})
                          .userCustomMoves;

                  /// Calc filters moves here. Text filter + moveFilters if present
                  final textFilteredMoves = Utils.textNotNull(_textFilter)
                      ? displayMoves.where((m) =>
                          m.name.toLowerCase().contains(_textFilter) ||
                          m.moveType.name.toLowerCase().contains(_textFilter))
                      : displayMoves;

                  final typeFilterMoves = _selectedMoveTypes.isNotEmpty
                      ? textFilteredMoves
                          .where((m) => _selectedMoveTypes.contains(m.moveType))
                          .toList()
                      : textFilteredMoves;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SlidingSelect<int>(
                                value: _activeTabIndex,
                                children: {
                                  0: MyText('Standard'),
                                  1: MyText('Custom')
                                },
                                updateValue: (i) =>
                                    setState(() => _activeTabIndex = i)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CupertinoSearchTextField(
                          onChanged: (value) =>
                              setState(() => _textFilter = value.toLowerCase()),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 6, left: 10),
                        height: 52,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: moveTypes
                              .map((type) => Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SelectableMoveTypeTag(
                                      moveType: type,
                                      isSelected:
                                          _selectedMoveTypes.contains(type),
                                      onPressed: () => setState(() =>
                                          _selectedMoveTypes =
                                              _selectedMoveTypes
                                                  .toggleItem<MoveType>(type)),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      if (typeFilterMoves.isEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyText(
                                'No moves match these filters...',
                                subtext: true,
                              ),
                            ),
                          ],
                        )
                      else
                        Expanded(
                          child: FadeIn(
                            child: ListView(
                              shrinkWrap: true,
                              children: displayMoves
                                  .where((m) => m.name
                                      .toLowerCase()
                                      .contains(_textFilter))
                                  .sortedBy<String>((move) => move.name)
                                  .map((move) => GestureDetector(
                                        onTap: () => widget.selectMove(move),
                                        child: MoveSelectorItem(move),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                    ],
                  );
                });
          }),
    );
  }
}

class MoveSelectorItem extends StatelessWidget {
  final Move move;
  MoveSelectorItem(this.move);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Styles.grey))),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MyText(move.name),
              SizedBox(width: 8),
              MoveTypeTag(move.moveType)
            ],
          ),
          InfoPopupButton(withoutNavBar: true, infoWidget: MoveDetails(move))
        ],
      ),
    );
  }
}
