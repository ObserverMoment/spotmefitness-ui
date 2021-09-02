import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/move_list_item.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';

class ProfileCustomMovesPage extends StatelessWidget {
  Future<void> _openCustomMoveCreator(
      {required BuildContext context, Move? moveToUpdate}) async {
    final success =
        await context.pushRoute(CustomMoveCreatorRoute(move: moveToUpdate));
    if (success == true) {
      if (moveToUpdate == null) {
        // Created
        context.showToast(message: 'New move created!');
      } else {
        // Updated
        context.showToast(message: 'Move updates saved!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserCustomMoves$Query, json.JsonSerializable>(
        key: Key(
            'ProfileCustomMovesPage - ${UserCustomMovesQuery().operationName}'),
        query: UserCustomMovesQuery(),
        builder: (customMovesData) {
          final customMoves = customMovesData.userCustomMoves
              .sortedBy<String>((move) => move.name);

          return StackAndFloatingButton(
            buttonText: 'Add Move',
            pageHasBottomNavBar: true,
            onPressed: () => _openCustomMoveCreator(context: context),
            child: customMoves.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,

                        // Hack...+ 1 to allow for building a sized box spacer to lift up above the floating button.
                        itemCount: customMoves.length + 1,
                        itemBuilder: (c, i) {
                          if (i == customMoves.length) {
                            return SizedBox(
                                height: kAssumedFloatingButtonHeight +
                                    EnvironmentConfig.bottomNavBarHeight);
                          } else {
                            return GestureDetector(
                                onTap: () => _openCustomMoveCreator(
                                    context: context,
                                    moveToUpdate: customMoves[i]),
                                child: MoveListItem(
                                  move: customMoves[i],
                                ));
                          }
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: MyText(
                      'No custom moves yet...',
                      textAlign: TextAlign.center,
                    ),
                  ),
          );
        });
  }
}
