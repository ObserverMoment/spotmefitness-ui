import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/collections/collection_workout_plans_list.dart';
import 'package:spotmefitness_ui/components/collections/collection_workouts_list.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class CollectionDetailsPage extends StatefulWidget {
  final String id;
  const CollectionDetailsPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  _CollectionDetailsPageState createState() => _CollectionDetailsPageState();
}

class _CollectionDetailsPageState extends State<CollectionDetailsPage> {
  int _activeTabIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    setState(() => _activeTabIndex = index);
  }

  void _confirmDeleteCollection(BuildContext context, Collection collection) {
    context.showConfirmDeleteDialog(
        itemType: 'Collection',
        itemName: collection.name,
        message: 'Everything will be removed from this collection. OK?',
        onConfirm: () => _deleteCollectionById(context));
  }

  Future<void> _deleteCollectionById(BuildContext context) async {
    context.showLoadingAlert('Deleting', customContext: context);

    final variables = DeleteCollectionByIdArguments(id: widget.id);

    final result = await context.graphQLStore
        .delete<DeleteCollectionById$Mutation, DeleteCollectionByIdArguments>(
            mutation: DeleteCollectionByIdMutation(variables: variables),
            objectId: widget.id,
            typename: kCollectionTypename,
            removeAllRefsToId: true,
            removeRefFromQueries: [UserCollectionsQuery().operationName]);

    context.pop(); // Loading dialog.

    if (result.hasErrors ||
        result.data == null ||
        result.data!.deleteCollectionById != widget.id) {
      context.showErrorAlert(
          'Sorry there was a problem, the collection was not deleted.');
    } else {
      context.pop(); // The CollectionDetailsPage.
    }
  }

  /// Top right of tabs to indicate how many of each type are in the list.
  Widget _buildNumberDisplay(int number) {
    return Positioned(
      top: -4,
      right: 4,
      child: MyText(
        number.toString(),
        size: FONTSIZE.SMALL,
        weight: FontWeight.bold,
        lineHeight: 1,
        color: Styles.colorTwo,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = UserCollectionByIdQuery(
        variables: UserCollectionByIdArguments(id: widget.id));

    return QueryObserver<UserCollectionById$Query, UserCollectionByIdArguments>(
        key: Key('CollectionDetailsPage - ${query.operationName}-${widget.id}'),
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
                onPressed: () => openBottomSheetMenu(
                    context: context,
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
                                onPressed: () => context.pushRoute(
                                    CollectionCreatorRoute(
                                        collection: collection))),
                          if (isOwner)
                            BottomSheetMenuItem(
                                text: 'Delete',
                                icon: Icon(
                                  CupertinoIcons.delete_simple,
                                  color: Styles.errorRed,
                                ),
                                isDestructive: true,
                                onPressed: () => _confirmDeleteCollection(
                                    context, collection)),
                        ])),
              ),
            ),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8),
                      child: MyText(
                        Utils.textNotNull(collection.description)
                            ? collection.description!
                            : 'No description',
                        maxLines: 10,
                        subtext: !Utils.textNotNull(collection.description),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTabBarNav(
                        titles: [
                          'Workouts',
                          'Plans'
                        ],
                        superscriptIcons: [
                          collection.workouts.isEmpty
                              ? null
                              : _buildNumberDisplay(collection.workouts.length),
                          collection.workoutPlans.isEmpty
                              ? null
                              : _buildNumberDisplay(
                                  collection.workoutPlans.length),
                        ],
                        handleTabChange: _changeTab,
                        activeTabIndex: _activeTabIndex),
                    SizedBox(height: 8),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: _changeTab,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          FilterableCollectionWorkouts(
                            collection: collection,
                          ),
                          FilterableCollectionWorkoutPlans(
                            collection: collection,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
