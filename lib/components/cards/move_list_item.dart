import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class MoveListItem extends StatelessWidget {
  final Move move;

  /// Optional icon style button on far right of column. Eg. Info / Edit.
  final Widget? optionalButton;
  MoveListItem({required this.move, this.optionalButton});
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
                Expanded(
                  child: MyText(
                    move.name,
                  ),
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
