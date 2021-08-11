import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_invite_token_creator.dart';
import 'package:spotmefitness_ui/components/social/club_members_grid_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class ClubCreatorMembers extends StatelessWidget {
  final Club club;
  final void Function(ClubInviteToken token) deleteClubInviteToken;
  const ClubCreatorMembers(
      {Key? key, required this.club, required this.deleteClubInviteToken})
      : super(key: key);

  void _confirmDeleteToken(BuildContext context, ClubInviteToken token) {
    context.showConfirmDeleteDialog(
        itemType: 'Invite Link', onConfirm: () => deleteClubInviteToken(token));
  }

  Widget _buildTokenRowButton(IconData iconData, onPressed) => CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onPressed: onPressed,
      child: Icon(iconData, size: 20));

  @override
  Widget build(BuildContext context) {
    final totalMembers = 1 + club.admins.length + club.members.length;

    return Column(
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
                    'Invite Links (${club.clubInviteTokens.length})',
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
                  onPressed: () =>
                      context.push(child: ClubInviteTokenCreator()))
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.only(left: 8),
            child: club.clubInviteTokens.isEmpty
                ? Center(child: MyText('No invite links'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: club.clubInviteTokens.length,
                    itemBuilder: (c, i) {
                      final token = club.clubInviteTokens[i];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                    'Created on ${token.createdAt.minimalDateString}'),
                                MyText(
                                  token.inviteLimit == 0
                                      ? '${token.joinedUserIds.length} of unlimited used'
                                      : '${token.joinedUserIds.length} of ${token.inviteLimit} used',
                                  color: Styles.infoBlue,
                                  lineHeight: 1.4,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _buildTokenRowButton(CupertinoIcons.share,
                                  () => print('share token ${token.token}')),
                              _buildTokenRowButton(
                                  CupertinoIcons.pencil,
                                  () => context.push(
                                          child: ClubInviteTokenCreator(
                                        token: token,
                                      ))),
                              _buildTokenRowButton(CupertinoIcons.trash,
                                  () => _confirmDeleteToken(context, token)),
                            ],
                          ),
                        ],
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
        ),
      ],
    );
  }
}
