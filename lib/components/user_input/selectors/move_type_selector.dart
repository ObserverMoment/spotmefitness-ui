import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class MoveTypeSelector extends StatelessWidget {
  final MoveType? moveType;
  final void Function(MoveType updated) updateMoveType;
  MoveTypeSelector({required this.moveType, required this.updateMoveType});

  void _handleSelectMoveType(BuildContext context, MoveType moveType) {
    updateMoveType(moveType);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: MyText(
              'Done',
              weight: FontWeight.bold,
            ),
            onPressed: context.pop),
        middle: NavBarTitle('Move Types'),
      ),
      child: QueryResponseBuilder(
          options: QueryOptions(
              document: MoveTypesQuery().document,
              fetchPolicy: FetchPolicy.cacheFirst),
          builder: (result, {refetch, fetchMore}) {
            final moveTypes =
                MoveTypes$Query.fromJson(result.data ?? {}).moveTypes;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: moveTypes
                    .map((type) => GestureDetector(
                          onTap: () => _handleSelectMoveType(context, type),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Styles.grey))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    MyText(type.name),
                                    if (moveType == type)
                                      FadeIn(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 6.0),
                                        child: ConfirmCheckIcon(),
                                      )),
                                  ],
                                ),
                                InfoPopupButton(
                                    infoWidget:
                                        MyText('Info about ${type.name}'))
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          }),
    );
  }
}
