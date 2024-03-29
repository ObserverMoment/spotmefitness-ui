import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sofie_ui/blocs/auth_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/club/club_details_content.dart';
import 'package:sofie_ui/components/club/club_details_info.dart';
import 'package:sofie_ui/components/club/club_details_timeline.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/navigation.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/model/enum.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/graphql_operation_names.dart';
import 'package:sofie_ui/services/store/query_observer.dart';
import 'package:sofie_ui/services/utils.dart';

class ClubDetailsPage extends StatefulWidget {
  final String id;
  const ClubDetailsPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  _ClubDetailsPageState createState() => _ClubDetailsPageState();
}

class _ClubDetailsPageState extends State<ClubDetailsPage> {
  int _activeTabIndex = 0;

  void _confirmDeleteClub(BuildContext context, String clubName) {
    context.showConfirmDeleteDialog(
        message:
            'Warning: This cannot be undone and will result in the deletion of all data, chat and timeline history from this club!',
        itemName: clubName,
        itemType: 'Club',
        onConfirm: () async {
          try {
            await context.graphQLStore
                .delete<DeleteClubById$Mutation, DeleteClubByIdArguments>(
                    mutation: DeleteClubByIdMutation(
                        variables: DeleteClubByIdArguments(id: widget.id)),
                    objectId: widget.id,
                    typename: kClubTypeName,
                    removeAllRefsToId: true,
                    clearQueryDataAtKeys: [
                  GQLVarParamKeys.clubByIdQuery(widget.id),
                ],
                    removeRefFromQueries: [
                  GQLOpNames.userClubsQuery
                ]);
            context.pop();
          } catch (e) {
            printLog(e.toString());
            context.showToast(
                message: 'Sorry, there was a problem deleting this club!',
                toastType: ToastType.destructive);
          }
        });
  }

  void _confirmLeaveClub(
      BuildContext context, String authedUserId, String clubId) {
    context.showConfirmDialog(
        title: 'Leave this Club?',
        content: const MyText(
          'Are you sure you want to leave this club? You will no longer have access to club chat, feeds or content.',
          maxLines: 6,
          lineHeight: 1.3,
          textAlign: TextAlign.center,
        ),
        onConfirm: () async {
          try {
            await context.graphQLStore.mutate<RemoveUserFromClub$Mutation,
                RemoveUserFromClubArguments>(
              mutation: RemoveUserFromClubMutation(
                  variables: RemoveUserFromClubArguments(
                      userToRemoveId: authedUserId, clubId: clubId)),
              clearQueryDataAtKeys: [GQLVarParamKeys.clubByIdQuery(clubId)],
              removeRefFromQueries: [GQLOpNames.userClubsQuery],
            );
            context.pop();
          } catch (e) {
            printLog(e.toString());
            context.showToast(
                message: 'Sorry, there was a problem deleting this club!',
                toastType: ToastType.destructive);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final query = ClubByIdQuery(variables: ClubByIdArguments(id: widget.id));
    return QueryObserver<ClubById$Query, ClubByIdArguments>(
        key: Key('ClubDetailsPage - ${query.operationName}-${widget.id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: const ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final club = data.clubById;

          final authedUserId = GetIt.I<AuthBloc>().authedUser!.id;
          final userIsOwner = authedUserId == club.owner.id;
          final userIsAdmin = club.admins.any((a) => a.id == authedUserId);

          final userIsMember = userIsOwner ||
              userIsAdmin ||
              club.members.any((m) => m.id == authedUserId);

          return CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: _ClubDetailsSliverAppBarDelegate(
                    deleteClub: () => _confirmDeleteClub(context, club.name),
                    confirmLeaveClub: () =>
                        _confirmLeaveClub(context, authedUserId, club.id),
                    club: club,
                    userIsMember: userIsMember,
                    userIsAdmin: userIsAdmin,
                    userIsOwner: userIsOwner,
                    expandedHeight: 210,
                    safeAreaSize: MediaQuery.of(context).padding.top,
                    appBarSize:
                        const CupertinoNavigationBar().preferredSize.height,
                  ),
                  pinned: true,
                ),
                SliverPersistentHeader(
                  delegate: _ClubDetailsTabBarDelegate(
                      activeTabIndex: _activeTabIndex,
                      selectTabIndex: (i) =>
                          setState(() => _activeTabIndex = i)),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IndexedStack(
                      sizing: StackFit.passthrough,
                      index: _activeTabIndex,
                      children: [
                        ClubDetailsInfo(
                          club: club,
                        ),
                        ClubDetailsContent(club: club),
                        ClubDetailsTimeline(
                          club: club,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class _ClubDetailsTabBarDelegate extends SliverPersistentHeaderDelegate {
  final void Function(int index) selectTabIndex;
  final int activeTabIndex;
  const _ClubDetailsTabBarDelegate(
      {required this.selectTabIndex, required this.activeTabIndex});

  double get kHeight => 60.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.theme.background,
      alignment: Alignment.center,
      height: kHeight,
      padding: const EdgeInsets.only(left: 8),
      child: MyTabBarNav(
          titles: const ['About', 'Content', 'Timeline'],
          handleTabChange: selectTabIndex,
          activeTabIndex: activeTabIndex),
    );
  }

  @override
  double get maxExtent => kHeight;

  @override
  double get minExtent => kHeight;

  @override
  bool shouldRebuild(covariant _ClubDetailsTabBarDelegate oldDelegate) =>
      oldDelegate.activeTabIndex != activeTabIndex;
}

class _ClubDetailsSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback deleteClub;
  final VoidCallback confirmLeaveClub;
  final double expandedHeight;
  final double safeAreaSize;
  final double appBarSize;
  final Club club;
  final bool userIsOwner;
  final bool userIsAdmin;
  final bool userIsMember;

  const _ClubDetailsSliverAppBarDelegate(
      {required this.confirmLeaveClub,
      required this.deleteClub,
      required this.safeAreaSize,
      required this.appBarSize,
      required this.expandedHeight,
      required this.club,
      required this.userIsMember,
      required this.userIsAdmin,
      required this.userIsOwner});

  void _openClubChat(BuildContext context) =>
      context.navigateTo(ClubMembersChatRoute(clubId: club.id));

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final minHeight = appBarSize + safeAreaSize;
    final showOnlyNavBar = shrinkOffset > (expandedHeight - minHeight);

    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.passthrough,
      children: [
        if (!showOnlyNavBar) buildBackground(context, shrinkOffset),
        if (!showOnlyNavBar)
          Positioned(
            left: 8,
            bottom: 8,
            child: buildClubNameTag(context, shrinkOffset),
          ),
        buildAppBar(context, showOnlyNavBar ? expandedHeight : shrinkOffset),
        Positioned(left: 8, top: safeAreaSize, child: buildBackButton(context)),
        Positioned(
            right: 8,
            top: safeAreaSize,
            child: buildMenuButtons(
                context: context,
                userIsMember: userIsMember,
                showOnlyNavBar: showOnlyNavBar,
                openClubChat: () => _openClubChat(context))),
      ],
    );
  }

  // https://easings.net/#easeInExpo
  double easeInExpo(double x) {
    return (x == 0 ? 0 : pow(2, 10 * x - 10)).toDouble();
  }

  double appear(double shrinkOffset) =>
      easeInExpo(shrinkOffset / expandedHeight);

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(BuildContext context, double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: MyNavBar(
          withoutLeading: true,
          backgroundColor: context.theme.cardBackground,
          middle: NavBarTitle(club.name),
        ),
      );

  Widget buildBackground(BuildContext context, double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: SizedBox(
            height: expandedHeight,
            child: Utils.textNotNull(club.coverImageUri)
                ? SizedUploadcareImage(club.coverImageUri!)
                : Image.asset(
                    'assets/social_images/group_placeholder.jpg',
                    fit: BoxFit.cover,
                  )),
      );

  Widget buildClubNameTag(BuildContext context, double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
              color: context.theme.background,
              borderRadius: BorderRadius.circular(50)),
          child: MyHeaderText(
            club.name,
            size: FONTSIZE.five,
          ),
        ),
      );

  Widget buildBackButton(BuildContext context) => CircularBox(
      padding: EdgeInsets.zero,
      color: context.theme.cardBackground,
      child: const NavBarBackButton(
        alignment: Alignment.center,
      ));

  Widget buildMenuButtons(
          {required BuildContext context,
          required bool userIsMember,
          required bool showOnlyNavBar,
          required VoidCallback openClubChat}) =>
      NavBarTrailingRow(
        children: [
          if (userIsMember)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CircularBox(
                  padding: EdgeInsets.zero,
                  color: context.theme.cardBackground,
                  child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: openClubChat,
                      child: const Icon(CupertinoIcons.chat_bubble_2))),
            ),
          CircularBox(
              padding: EdgeInsets.zero,
              color: context.theme.cardBackground,
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: AnimatedSwitcher(
                      duration: kStandardAnimationDuration,
                      child: showOnlyNavBar
                          ? const Icon(CupertinoIcons.ellipsis)
                          : const Icon(CupertinoIcons.ellipsis)),
                  onPressed: () => openBottomSheetMenu(
                      context: context,
                      child: BottomSheetMenu(
                          header: BottomSheetMenuHeader(
                            name: club.name,
                            subtitle: 'Club',
                            imageUri: club.coverImageUri,
                          ),
                          items: [
                            if (userIsOwner || userIsAdmin)
                              BottomSheetMenuItem(
                                  text: 'Manage',
                                  icon: const Icon(CupertinoIcons.pencil),
                                  onPressed: () => context.navigateTo(
                                      ClubCreatorRoute(club: club))),
                            if (userIsOwner || userIsAdmin)
                              BottomSheetMenuItem(
                                  text: 'New Post',
                                  icon: const Icon(CupertinoIcons.add),
                                  onPressed: () => context.navigateTo(
                                      ClubPostCreatorRoute(clubId: club.id))),
                            if (userIsMember && !userIsOwner)
                              BottomSheetMenuItem(
                                  text: 'Leave Club',
                                  isDestructive: true,
                                  icon: const Icon(
                                    CupertinoIcons.square_arrow_right,
                                    color: Styles.errorRed,
                                  ),
                                  onPressed: confirmLeaveClub),
                            if (userIsOwner)
                              BottomSheetMenuItem(
                                  text: 'Delete',
                                  icon: const Icon(
                                    CupertinoIcons.delete_simple,
                                    color: Styles.errorRed,
                                  ),
                                  isDestructive: true,
                                  onPressed: deleteClub),
                          ])))),
        ],
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => appBarSize + safeAreaSize;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
