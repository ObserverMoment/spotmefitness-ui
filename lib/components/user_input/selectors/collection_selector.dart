import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/collection_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/collection_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Returns a collection.
/// Also allows inline creation of a new collection (name input only) which gets immediately returned.
class CollectionSelector extends StatelessWidget {
  final void Function(Collection collection) selectCollection;
  const CollectionSelector({Key? key, required this.selectCollection})
      : super(key: key);

  void _handleSelectCollection(BuildContext context, Collection collection) {
    selectCollection(collection);
    context.pop();
  }

  void _openCreateCollection(BuildContext context) {
    context.showBottomSheet(
        expand: true,
        child: CollectionCreator(
          onComplete: (collection) {
            selectCollection(collection);
            context.pop();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: context.theme.modalBackground,
        navigationBar: BorderlessNavBar(
          backgroundColor: context.theme.modalBackground,
          customLeading: NavBarCancelButton(context.pop),
          middle: NavBarTitle('Your Collections'),
        ),
        child: QueryObserver<UserCollections$Query, json.JsonSerializable>(
            key: Key(
                'CollectionSelector - ${UserCollectionsQuery().operationName}'),
            query: UserCollectionsQuery(),
            fetchPolicy: QueryFetchPolicy.storeFirst,
            loadingIndicator: ShimmerCardList(itemCount: 20, cardHeight: 100),
            builder: (data) {
              final collections = data.userCollections
                  .sortedBy<DateTime>((c) => c.createdAt)
                  .reversed
                  .toList();

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: CreateTextIconButton(
                            text: 'Create new collection',
                            onPressed: () => _openCreateCollection(context)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 12, right: 12),
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: collections.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16),
                              itemBuilder: (c, i) => GestureDetector(
                                    onTap: () => _handleSelectCollection(
                                        context, collections[i]),
                                    child: CollectionCard(
                                        backgroundColor:
                                            context.theme.background,
                                        collection: collections[i]),
                                  )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
