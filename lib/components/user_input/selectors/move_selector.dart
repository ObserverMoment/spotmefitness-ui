import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/creators/custom_move_creator/custom_move_creator.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/move_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/screens/move_filters_screen.dart';
import 'package:spotmefitness_ui/components/workout/move_details.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:json_annotation/json_annotation.dart' as json;

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
  /// 0 is standard moves, 1 is custom moves.
  int _activeTabIndex = 0;

  Future<void> _openCustomMoveCreator(Move? moveToUpdate) async {
    Utils.unfocusAny();
    final success =
        await context.push<bool?>(child: CustomMoveCreator(move: moveToUpdate));
    if (success != null && success) {
      if (moveToUpdate == null) {
        // Created
        context.showToast(message: 'New move created!');
      } else {
        // Updated
        context.showToast(message: 'Move updates saved!');
      }
    }
  }

  Widget _buildButton(Move move) {
    return move.scope == MoveScope.custom
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.pencil_circle),
            onPressed: () => _openCustomMoveCreator(move))
        : InfoPopupButton(withoutNavBar: true, infoWidget: MoveDetails(move));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QueryObserver<StandardMoves$Query, json.JsonSerializable>(
          key: Key('MoveSelector - ${StandardMovesQuery().operationName}'),
          query: StandardMovesQuery(),
          fetchPolicy: QueryFetchPolicy.storeFirst,
          builder: (standardMovesData) {
            return QueryObserver<UserCustomMoves$Query, json.JsonSerializable>(
                key: Key(
                    'MoveSelector - ${UserCustomMovesQuery().operationName}'),
                query: UserCustomMovesQuery(),
                builder: (customMovesData) {
                  final standardMoves = standardMovesData.standardMoves;

                  final customMoves = customMovesData.userCustomMoves;

                  final displayMoves =
                      _activeTabIndex == 0 ? standardMoves : customMoves;

                  final moveFiltersBloc = context.watch<MoveFiltersBloc>();
                  final filteredMoves = moveFiltersBloc.filter(displayMoves);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              SlidingSelect<int>(
                                  value: _activeTabIndex,
                                  children: {
                                    0: MyText('Standard'),
                                    1: MyText('Custom')
                                  },
                                  updateValue: (i) =>
                                      setState(() => _activeTabIndex = i)),
                              SizedBox(width: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilterButton(
                                    hasActiveFilters:
                                        moveFiltersBloc.hasActiveFilters,
                                    onPressed: () => context.push(
                                        child: MoveFiltersScreen()),
                                  ),
                                  SizedBox(width: 4),
                                  OpenTextSearchButton(
                                    onPressed: () => context.push(
                                        fullscreenDialog: true,
                                        child: MoveSelectorTextSearch(
                                          allMoves: [
                                            ...standardMoves,
                                            ...customMoves
                                          ],
                                          selectMove: widget.selectMove,
                                        )),
                                  ),
                                ],
                              ),
                              // If showing custom moves.
                              if (_activeTabIndex == 1)
                                FadeIn(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CreateTextIconButton(
                                        onPressed: () =>
                                            _openCustomMoveCreator(null)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      GrowInOut(
                          show: moveFiltersBloc.hasActiveFilters,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 2),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(
                                      'Filters',
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(width: 10),
                                    TextButton(
                                      text: 'Clear all',
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      destructive: true,
                                      underline: false,
                                      onPressed: () => context
                                          .read<MoveFiltersBloc>()
                                          .clearAllFilters(),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: [
                                      ...moveFiltersBloc.moveTypeFilters
                                          .map((e) => Tag(
                                                tag: e.name,
                                              ))
                                          .toList(),
                                      if (moveFiltersBloc.bodyweightOnlyFilter)
                                        Tag(
                                          tag: 'Bodyweight Only',
                                          color: Styles.colorOne,
                                          textColor: Styles.white,
                                        )
                                      else
                                        ...moveFiltersBloc.equipmentFilters
                                            .map((e) => Tag(
                                                tag: e.name,
                                                color: Styles.colorOne,
                                                textColor: Styles.white))
                                            .toList(),
                                      ...moveFiltersBloc.bodyAreaFilters
                                          .map((e) => Tag(
                                              tag: e.name,
                                              color: Styles.colorThree,
                                              textColor: Styles.white))
                                          .toList(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      if (filteredMoves.isEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: MyText(
                                _activeTabIndex == 0
                                    ? 'No moves found. Create a custom move?'
                                    : 'No moves found',
                                maxLines: 3,
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
                              children: filteredMoves
                                  .sortedBy<String>((move) => move.name)
                                  .map((move) => GestureDetector(
                                      onTap: () => widget.selectMove(move),
                                      child: MoveSelectorItem(
                                          move: move,
                                          optionalButton: _buildButton(move))))
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

class MoveSelectorTextSearch extends StatefulWidget {
  final List<Move> allMoves;
  final void Function(Move move) selectMove;

  MoveSelectorTextSearch({required this.allMoves, required this.selectMove});

  @override
  _MoveSelectorTextSearchState createState() => _MoveSelectorTextSearchState();
}

class _MoveSelectorTextSearchState extends State<MoveSelectorTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  bool _filter(Move move) {
    return [move.name, move.searchTerms, move.moveType.name]
        .where((t) => Utils.textNotNull(t))
        .map((t) => t!.toLowerCase())
        .any((t) => t.contains(_searchString));
  }

  List<Move> _filterBySearchString() {
    return Utils.textNotNull(_searchString)
        ? widget.allMoves.where((m) => _filter(m)).toList()
        : widget.allMoves;
  }

  void _handleSelectMove(Move move) {
    widget.selectMove(move);
    context.pop();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMoves = _filterBySearchString();
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: NavBarTitle('Search Moves'),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: CupertinoSearchTextField(
                      focusNode: _focusNode,
                      onChanged: (value) =>
                          setState(() => _searchString = value.toLowerCase()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FadeIn(
              child: ListView(
                shrinkWrap: true,
                children: filteredMoves
                    .sortedBy<String>((move) => move.name)
                    .map((move) => GestureDetector(
                        onTap: () => _handleSelectMove(move),
                        child: MoveSelectorItem(
                          move: move,
                          optionalButton: move.scope == MoveScope.custom
                              ? Tag(tag: 'Custom')
                              : null,
                        )))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoveSelectorItem extends StatelessWidget {
  final Move move;

  /// Optional icon style button on far right of column. Eg. Info / Edit.
  final Widget? optionalButton;
  MoveSelectorItem({required this.move, this.optionalButton});
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
          Expanded(
            child: Row(
              children: [
                MyText(
                  move.name,
                ),
                SizedBox(width: 8),
                MoveTypeTag(move.moveType, fontSize: FONTSIZE.TINY)
              ],
            ),
          ),
          if (optionalButton != null) optionalButton!
        ],
      ),
    );
  }
}
