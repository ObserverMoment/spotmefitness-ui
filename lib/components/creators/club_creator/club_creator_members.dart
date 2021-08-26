import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_invite_token_creator.dart';
import 'package:spotmefitness_ui/components/social/club_members_grid_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/sharing_and_linking.dart';
import 'package:auto_route/auto_route.dart';

class ClubCreatorMembers extends StatelessWidget {
  final Club club;
  final void Function(ClubInviteToken token) onCreateInviteToken;
  final void Function(ClubInviteToken token) onUpdateInviteToken;
  final void Function(ClubInviteToken token) deleteClubInviteToken;
  final void Function(String userId, ClubMemberType memberType)
      removeUserFromClub;
  final void Function(String userId) giveMemberAdminStatus;
  final void Function(String userId) removeMemberAdminStatus;

  const ClubCreatorMembers(
      {Key? key,
      required this.club,
      required this.deleteClubInviteToken,
      required this.onCreateInviteToken,
      required this.onUpdateInviteToken,
      required this.removeUserFromClub,
      required this.giveMemberAdminStatus,
      required this.removeMemberAdminStatus})
      : super(key: key);

  void _confirmDeleteToken(BuildContext context, ClubInviteToken token) {
    context.showConfirmDeleteDialog(
        itemType: 'Invite Link',
        message: 'This cannot be un-done and the link will become inactive.',
        onConfirm: () => deleteClubInviteToken(token));
  }

  void _confirmRemoveUserFromClub(
      BuildContext context, String userId, ClubMemberType memberType) {
    context.showConfirmDialog(
        title: 'Remove from Club?',
        content: MyText(
          'Are you sure you want to remove this person from the club? They will no longer have access to club chat, feeds or content.',
          maxLines: 6,
          lineHeight: 1.3,
          textAlign: TextAlign.center,
        ),
        onConfirm: () => removeUserFromClub(userId, memberType));
  }

  void _onTapAvatar(
      BuildContext context,
      String userId,
      ClubMemberType memberType,
      ClubMemberType authedUserMemberType,
      String authedUserId) {
    showCupertinoModalPopup(
      useRootNavigator: false,
      context: context,
      builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: MyText('View Profile'),
              onPressed: () async {
                context.pop();
                context
                    .navigateTo(UserPublicProfileDetailsRoute(userId: userId));
              },
            ),
            // Don't try and message yourself...
            if (authedUserId != userId)
              CupertinoActionSheetAction(
                child: MyText('Send Message'),
                onPressed: () async {
                  context.pop();
                  context.navigateTo(OneToOneChatRoute(
                    otherUserId: userId,
                  ));
                },
              ),
            if (authedUserMemberType == ClubMemberType.owner &&
                memberType == ClubMemberType.member)
              CupertinoActionSheetAction(
                child: MyText('Give Admin Status'),
                onPressed: () async {
                  context.pop();
                  giveMemberAdminStatus(userId);
                },
              ),

            if (authedUserMemberType == ClubMemberType.owner &&
                memberType == ClubMemberType.admin)
              CupertinoActionSheetAction(
                child: MyText('Remove Admin Status'),
                onPressed: () async {
                  context.pop();
                  removeMemberAdminStatus(userId);
                },
              ),
            // Cannot remove owners from clubs - clubs needs to be deleted first.
            // Owners can remove anyone else from the club.
            // Admins can remove members, but not other admins.
            if (memberType != ClubMemberType.owner &&
                (authedUserMemberType == ClubMemberType.owner ||
                    memberType == ClubMemberType.member))
              CupertinoActionSheetAction(
                child: MyText(
                  'Remove from Club',
                  color: Styles.errorRed,
                ),
                isDestructiveAction: true,
                onPressed: () {
                  context.pop();
                  _confirmRemoveUserFromClub(context, userId, memberType);
                },
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: MyText(
              'Cancel',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
    );
  }

  Widget _buildTokenRowButton(IconData iconData, onPressed) => CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onPressed: onPressed,
      child: Icon(iconData, size: 20));

  @override
  Widget build(BuildContext context) {
    final authedUserId = GetIt.I<AuthBloc>().authedUser!.id;
    final authedUserMemberType = club.owner.id == authedUserId
        ? ClubMemberType.owner
        : club.admins.any((a) => a.id == authedUserId)
            ? ClubMemberType.admin
            : ClubMemberType.member;

    if (authedUserMemberType == ClubMemberType.member) {
      throw Exception('Members should not have access to Club management!');
    }

    final totalMembers = 1 + club.admins.length + club.members.length;
    final sortedInviteTokens = club.clubInviteTokens
        .sortedBy<DateTime>((t) => t.createdAt)
        .reversed
        .toList();

    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.mail,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  MyHeaderText(
                    'Invite Links (${sortedInviteTokens.length})',
                    size: FONTSIZE.BIG,
                  )
                ],
              ),
              BorderButton(
                  prefix: Icon(
                    CupertinoIcons.add,
                    size: 14,
                  ),
                  text: 'Invite Link',
                  onPressed: () => context.push(
                          child: ClubInviteTokenCreator(
                        club: club,
                        onUpdateComplete: (token) => onCreateInviteToken(token),
                      )))
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: sortedInviteTokens.isEmpty
                ? Center(child: MyText('No invite links'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: sortedInviteTokens.length,
                    itemBuilder: (c, i) {
                      final token = sortedInviteTokens[i];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: context.theme.primary.withOpacity(0.2))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    token.name,
                                    lineHeight: 1.3,
                                  ),
                                  MyText(
                                    token.inviteLimit == 0
                                        ? '${token.joinedUserIds.length} of unlimited used'
                                        : '${token.joinedUserIds.length} of ${token.inviteLimit} used',
                                    color: token.inviteLimit != 0 &&
                                            token.joinedUserIds.length >=
                                                token.inviteLimit
                                        ? Styles.errorRed
                                        : Styles.infoBlue,
                                    lineHeight: 1.3,
                                  ),
                                  MyText(
                                    'Created ${token.createdAt.minimalDateString}',
                                    size: FONTSIZE.TINY,
                                    subtext: true,
                                    lineHeight: 1.4,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                _buildTokenRowButton(
                                    CupertinoIcons.paperplane,
                                    () => SharingAndLinking.shareClubInviteLink(
                                        token.id)),
                                _buildTokenRowButton(
                                    CupertinoIcons.pencil,
                                    () => context.push(
                                            child: ClubInviteTokenCreator(
                                          token: token,
                                          onUpdateComplete: (token) =>
                                              onUpdateInviteToken(token),
                                        ))),
                                _buildTokenRowButton(CupertinoIcons.trash,
                                    () => _confirmDeleteToken(context, token)),
                              ],
                            ),
                          ],
                        ),
                      );
                    })),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(CupertinoIcons.person_2),
              SizedBox(width: 8),
              MyHeaderText(
                'Members ($totalMembers)',
                size: FONTSIZE.BIG,
              )
            ],
          ),
        ),
        ClubMembersGridList(
          admins: club.admins,
          members: club.members,
          owner: club.owner,
          scrollPhysics: NeverScrollableScrollPhysics(),
          onTapAvatar: (userId, memberType) => _onTapAvatar(
              context, userId, memberType, authedUserMemberType, authedUserId),
        ),
      ],
    );
  }
}
