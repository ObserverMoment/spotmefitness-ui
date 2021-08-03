import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/collection_card.dart';
import 'package:spotmefitness_ui/components/creators/collection_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

class YourCollectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BorderlessNavBar(
          middle: NavBarTitle('Your Collections'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CreateIconButton(
                onPressed: () => context.showBottomSheet(
                    useRootNavigator: true,
                    expand: true,
                    child: CollectionCreator()),
              ),
              InfoPopupButton(infoWidget: MyText('Info about collections'))
            ],
          ),
        ),
        child: QueryObserver<UserCollections$Query, json.JsonSerializable>(
            key: Key(
                'YourCollectionsPage - ${UserCollectionsQuery().operationName}'),
            query: UserCollectionsQuery(),
            fetchPolicy: QueryFetchPolicy.storeFirst,
            loadingIndicator: ShimmerCardList(itemCount: 20),
            builder: (data) {
              final collections = data.userCollections
                  .sortedBy<DateTime>((c) => c.createdAt)
                  .reversed
                  .toList();

              return collections.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: collections.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                        itemBuilder: (c, i) => GestureDetector(
                          onTap: () => context.navigateTo(
                              CollectionDetailsRoute(id: collections[i].id)),
                          child: CollectionCard(
                            collection: collections[i],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: MyText(
                        'No collections yet...',
                        textAlign: TextAlign.center,
                      ),
                    );
            }));
  }
}
