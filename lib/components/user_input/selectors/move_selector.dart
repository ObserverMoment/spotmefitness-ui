import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/creators/custom_move_creator/custom_move_creator.dart';
import 'package:spotmefitness_ui/components/user_input/filters/models/move_filters.dart';
import 'package:spotmefitness_ui/components/user_input/filters/screens/move_filters_screen.dart';
import 'package:spotmefitness_ui/components/workout/move_details.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
  String _textFilter = '';

  Future<void> _openCustomMoveCreator(Move? move) async {
    Utils.unfocusAny();
    final success =
        await context.push<bool?>(child: CustomMoveCreator(move: move));
    if (success != null && success) {
      if (move != null) {
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
      child: QueryResponseBuilder(
          options: QueryOptions(
              document: AllMovesQuery().document,
              fetchPolicy: FetchPolicy.cacheFirst),
          builder: (result, {refetch, fetchMore}) {
            final displayMoves = _activeTabIndex == 0
                ? AllMoves$Query.fromJson(result.data ?? {}).standardMoves
                : AllMoves$Query.fromJson(result.data ?? {}).userCustomMoves;

            /// Calc filters moves here. Text filter + moveFilters if present
            final textFilteredMoves = Utils.textNotNull(_textFilter)
                ? displayMoves.where((m) =>
                    m.name.toLowerCase().contains(_textFilter) ||
                    m.moveType.name.toLowerCase().contains(_textFilter))
                : displayMoves;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlidingSelect<int>(
                            value: _activeTabIndex,
                            children: {
                              0: MyText('Standard'),
                              1: MyText('Custom')
                            },
                            updateValue: (i) =>
                                setState(() => _activeTabIndex = i)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilterButton(
                              activeFilters: 5,
                              onPressed: () =>
                                  context.push(child: MoveFiltersScreen()),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: CupertinoSearchTextField(
                            onChanged: (value) => setState(
                                () => _textFilter = value.toLowerCase()),
                          ),
                        ),
                      ),
                      // If showing custom moves.
                      if (_activeTabIndex == 1)
                        FadeIn(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 6),
                            child: CreateTextIconButton(
                                onPressed: () => _openCustomMoveCreator(null)),
                          ),
                        )
                    ],
                  ),
                ),
                if (textFilteredMoves.isEmpty)
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
                        children: textFilteredMoves
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
          }),
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
                Flexible(
                  child: MyText(
                    move.name,
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                    child: MoveTypeTag(move.moveType, fontSize: FONTSIZE.TINY))
              ],
            ),
          ),
          if (optionalButton != null) optionalButton!
        ],
      ),
    );
  }
}
