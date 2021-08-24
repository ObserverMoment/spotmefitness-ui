import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/social/club_members_grid_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ClubDetailsPage extends StatelessWidget {
  final String id;
  ClubDetailsPage({@PathParam('id') required this.id});

  final _kthumbDisplaySize = Size(80, 80);

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
                        variables: DeleteClubByIdArguments(id: id)),
                    objectId: id,
                    typename: kClubTypeName,
                    removeAllRefsToId: true,
                    clearQueryDataAtKeys: [
                  GQLVarParamKeys.clubByIdQuery(id),
                ],
                    removeRefFromQueries: [
                  GQLOpNames.userClubsQuery
                ]);
            context.pop();
          } catch (e) {
            print(e);
            context.showToast(
                message: 'Sorry, there was a problem deleting this club!',
                toastType: ToastType.destructive);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final query = ClubByIdQuery(variables: ClubByIdArguments(id: id));
    return QueryObserver<ClubById$Query, ClubByIdArguments>(
        key: Key('ClubDetailsPage - ${query.operationName}-${id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final club = data.clubById;

          /// 1 is the owner.
          final totalMembers = 1 + club.admins.length + club.members.length;

          final authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
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
                    club: club,
                    userIsMember: userIsMember,
                    userIsAdmin: userIsAdmin,
                    userIsOwner: userIsOwner,
                    expandedHeight: 210,
                    safeAreaSize: MediaQuery.of(context).padding.top,
                    appBarSize: CupertinoNavigationBar().preferredSize.height,
                  ),
                  pinned: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(height: 24),
                    MyHeaderText(
                      club.name,
                      size: FONTSIZE.HUGE,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (Utils.textNotNull(club.location))
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.location,
                                    size: 18, color: Styles.infoBlue),
                                SizedBox(width: 2),
                                MyText(club.location!, color: Styles.infoBlue)
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.person_2, size: 20),
                              SizedBox(width: 8),
                              MyText('$totalMembers')
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (Utils.anyNotNull(
                        [club.introAudioUri, club.introVideoUri]))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (club.introVideoUri != null)
                              VideoThumbnailPlayer(
                                videoUri: club.introVideoUri,
                                videoThumbUri: club.introVideoThumbUri,
                                displaySize: _kthumbDisplaySize,
                              ),
                            if (club.introAudioUri != null)
                              AudioThumbnailPlayer(
                                audioUri: club.introAudioUri!,
                                displaySize: _kthumbDisplaySize,
                                playerTitle: '${club.name} - Intro',
                              ),
                          ],
                        ),
                      ),
                    if (Utils.textNotNull(club.description))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ViewMoreFullScreenTextBlock(
                          text: club.description!,
                          title: 'Description',
                          maxLines: 8,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SizedBox(height: 10),
                    PageLink(
                        linkText: 'Workouts (x)',
                        bold: true,
                        onPress: () => {}),
                    PageLink(
                        linkText: 'Plans (x)', bold: true, onPress: () => {}),
                    PageLink(
                        linkText: 'Challenges (x)',
                        bold: true,
                        onPress: () => {}),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.person_2),
                          SizedBox(width: 8),
                          H3('Members ($totalMembers)')
                        ],
                      ),
                    ),
                    ClubMembersGridList(
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      admins: club.admins,
                      members: club.members,
                      owner: club.owner,
                    ),
                  ])),
                )
              ],
            ),
          );
        });
  }
}

class _ClubDetailsSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback deleteClub;
  final double expandedHeight;
  final double safeAreaSize;
  final double appBarSize;
  final Club club;
  final bool userIsOwner;
  final bool userIsAdmin;
  final bool userIsMember;

  const _ClubDetailsSliverAppBarDelegate(
      {required this.deleteClub,
      required this.safeAreaSize,
      required this.appBarSize,
      required this.expandedHeight,
      required this.club,
      required this.userIsMember,
      required this.userIsAdmin,
      required this.userIsOwner});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final minHeight = appBarSize + safeAreaSize;
    final showOnlyNavBar = shrinkOffset > (expandedHeight - minHeight);

    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        if (!showOnlyNavBar) buildBackground(context, shrinkOffset),
        buildAppBar(context, showOnlyNavBar ? expandedHeight : shrinkOffset),
        Positioned(left: 8, top: safeAreaSize, child: buildBackButton(context)),
        Positioned(
            right: 8,
            top: safeAreaSize,
            child: buildMenuButtons(context, userIsMember, showOnlyNavBar)),
        if (!userIsMember && !showOnlyNavBar)
          Positioned(
            top: safeAreaSize,
            child: buildInviteButton(),
          ),
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
        child: BorderlessNavBar(
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

  Widget buildInviteButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingIconButton(
              iconData: CupertinoIcons.mail,
              onPressed: () => print('request invite'),
              text: 'Request Invite'),
        ],
      );

  Widget buildBackButton(BuildContext context) => CircularBox(
      padding: const EdgeInsets.all(0),
      color: context.theme.cardBackground,
      child: NavBarBackButton(
        alignment: Alignment.center,
      ));

  Widget buildMenuButtons(
          BuildContext context, bool userIsMember, bool showOnlyNavBar) =>
      NavBarTrailingRow(
        children: [
          if (userIsMember)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CircularBox(
                  padding: const EdgeInsets.all(0),
                  color: context.theme.cardBackground,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.chat_bubble_2),
                    onPressed: () => print('open club chat'),
                  )),
            ),
          CircularBox(
              padding: const EdgeInsets.all(0),
              color: context.theme.cardBackground,
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: AnimatedSwitcher(
                      duration: kStandardAnimationDuration,
                      child: showOnlyNavBar
                          ? Icon(CupertinoIcons.ellipsis_circle)
                          : Icon(CupertinoIcons.ellipsis)),
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
                                  icon: Icon(CupertinoIcons.pencil),
                                  onPressed: () => context.navigateTo(
                                      ClubCreatorRoute(club: club))),
                            if (userIsMember && !userIsOwner)
                              BottomSheetMenuItem(
                                  text: 'Leave Club',
                                  isDestructive: true,
                                  icon: Icon(
                                    CupertinoIcons.square_arrow_right,
                                    color: Styles.errorRed,
                                  ),
                                  onPressed: () => print('leave club flow')),
                            if (userIsOwner)
                              BottomSheetMenuItem(
                                  text: 'Delete',
                                  icon: Icon(
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
