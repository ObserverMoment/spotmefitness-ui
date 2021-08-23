import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/collection_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';

class YourCollectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserCollections$Query, json.JsonSerializable>(
        key: Key(
            'YourCollectionsPage - ${UserCollectionsQuery().operationName}'),
        query: UserCollectionsQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: ShimmerListPage(
          cardHeight: 100,
        ),
        builder: (data) {
          final collections = data.userCollections
              .sortedBy<DateTime>((c) => c.createdAt)
              .reversed
              .toList();

          return MyPageScaffold(
              navigationBar: BorderlessNavBar(
                middle: NavBarTitle('Your Collections'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CreateIconButton(
                      onPressed: () =>
                          context.navigateTo(CollectionCreatorRoute()),
                    ),
                    InfoPopupButton(
                        infoWidget: MyText('Info about collections'))
                  ],
                ),
              ),
              child: collections.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: collections.length,
                        itemBuilder: (c, i) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => context.navigateTo(
                              CollectionDetailsRoute(id: collections[i].id)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CollectionCard(
                              collection: collections[i],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: MyText(
                        'No collections yet...',
                        textAlign: TextAlign.center,
                      ),
                    ));
        });
  }
}
