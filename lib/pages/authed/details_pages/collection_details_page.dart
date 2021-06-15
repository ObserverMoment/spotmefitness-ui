import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/collection_creator.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class CollectionDetailsPage extends StatelessWidget {
  final String id;
  const CollectionDetailsPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  void _confirmDeleteCollection(BuildContext context, Collection collection) {
    context.showConfirmDeleteDialog(
        itemType: 'Collection',
        itemName: collection.name,
        message: 'Everything will be removed from this collection. OK?',
        onConfirm: () => _deleteCollectionById(context));
  }

  Future<void> _deleteCollectionById(BuildContext context) async {
    context.showLoadingAlert('Deleting', customContext: context);

    final variables = DeleteCollectionByIdArguments(id: id);

    final result = await context.graphQLStore
        .delete<DeleteCollectionById$Mutation, DeleteCollectionByIdArguments>(
            mutation: DeleteCollectionByIdMutation(variables: variables),
            objectId: id,
            typename: kCollectionTypename,
            removeAllRefsToId: true,
            removeRefFromQueries: [UserCollectionsQuery().operationName]);

    context.pop(); // Loading dialog.

    if (result.hasErrors ||
        result.data == null ||
        result.data!.deleteCollectionById != id) {
      context.showErrorAlert(
          'Sorry there was a problem, the collection was not deleted.');
    } else {
      context.pop(); // The CollectionDetailsPage.
    }
  }

  @override
  Widget build(BuildContext context) {
    final query =
        UserCollectionByIdQuery(variables: UserCollectionByIdArguments(id: id));

    return QueryObserver<UserCollectionById$Query, UserCollectionByIdArguments>(
        key: Key('CollectionDetailsPage - ${query.operationName}-$id'),
        query: query,
        fetchPolicy: QueryFetchPolicy.storeAndNetwork,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final collection = data.userCollectionById;

          final String? authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
          final bool isOwner = collection.user.id == authedUserId;

          return CupertinoPageScaffold(
            navigationBar: BorderlessNavBar(
              middle: NavBarTitle(collection.name),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.ellipsis_circle),
                onPressed: () => context.showBottomSheet(
                    child: BottomSheetMenu(
                        header: BottomSheetMenuHeader(
                          name: collection.name,
                          subtitle: 'Collection',
                        ),
                        items: [
                      if (isOwner)
                        BottomSheetMenuItem(
                            text: 'Edit',
                            icon: Icon(CupertinoIcons.pencil),
                            onPressed: () => context.showBottomSheet(
                                useRootNavigator: true,
                                expand: true,
                                child:
                                    CollectionCreator(collection: collection))),
                      BottomSheetMenuItem(
                          text: 'Share',
                          icon: Icon(CupertinoIcons.share),
                          onPressed: () => print('share')),
                      if (isOwner)
                        BottomSheetMenuItem(
                            text: 'Delete',
                            icon: Icon(
                              CupertinoIcons.delete_simple,
                              color: Styles.errorRed,
                            ),
                            isDestructive: true,
                            onPressed: () =>
                                _confirmDeleteCollection(context, collection)),
                    ])),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(collection.name),
                if (Utils.textNotNull(collection.description))
                  MyText(collection.description!),
                MyText('${collection.workouts.length} workouts'),
                MyText('${collection.workoutPlans.length} workout plans'),
              ],
            ),
          );
        });
  }
}
