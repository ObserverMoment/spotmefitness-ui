import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/workout/move_details.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

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
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:
                          FilterButton(onPressed: () => print('open filters')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SlidingSelect<int>(
                          value: _activeTabIndex,
                          children: {
                            0: MyText('Standard'),
                            1: MyText('Custom')
                          },
                          updateValue: (i) =>
                              setState(() => _activeTabIndex = i)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CupertinoSearchTextField(),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: displayMoves
                        .sortedBy<String>((move) => move.name)
                        .map((move) => GestureDetector(
                              onTap: () => widget.selectMove(move),
                              child: MoveSelectorItem(move),
                            ))
                        .toList(),
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
