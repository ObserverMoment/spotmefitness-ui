import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_invite_token_creator.dart';
import 'package:spotmefitness_ui/components/social/club_members_grid_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/sharing_and_linking.dart';

class ClubCreatorMembers extends StatelessWidget {
  final Club club;
  final void Function(ClubInviteToken token) onCreateInviteToken;
  final void Function(ClubInviteToken token) onUpdateInviteToken;
  final void Function(ClubInviteToken token) deleteClubInviteToken;
  const ClubCreatorMembers(
      {Key? key,
      required this.club,
      required this.deleteClubInviteToken,
      required this.onCreateInviteToken,
      required this.onUpdateInviteToken})
      : super(key: key);

  void _confirmDeleteToken(BuildContext context, ClubInviteToken token) {
    context.showConfirmDeleteDialog(
        itemType: 'Invite Link',
        message: 'This cannot be un-done and the link will become inactive.',
        onConfirm: () => deleteClubInviteToken(token));
  }

  Widget _buildTokenRowButton(IconData iconData, onPressed) => CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onPressed: onPressed,
      child: Icon(iconData, size: 20));

  @override
  Widget build(BuildContext context) {
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
        ),
      ],
    );
  }
}
