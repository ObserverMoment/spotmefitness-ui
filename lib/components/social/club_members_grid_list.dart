import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// Displays a grid of all the users in the club.
/// Shows tags on the owner and the admins.
class ClubMembersGridList extends StatelessWidget {
  final UserSummary owner;
  final List<UserSummary> admins;
  final List<UserSummary> members;
  final ScrollPhysics? scrollPhysics;
  final void Function(String userId, ClubMemberType memberType) onTapAvatar;
  const ClubMembersGridList(
      {Key? key,
      required this.members,
      required this.owner,
      required this.admins,
      this.scrollPhysics,
      required this.onTapAvatar})
      : super(key: key);

  Widget _buildPositionedOwnerTag(String text) => Positioned(
      top: 8,
      child: Tag(
        tag: text,
        color: Styles.infoBlue,
        textColor: Styles.white,
      ));

  Widget _buildPositionedAdminTag(String text) =>
      Positioned(top: 8, child: Tag(tag: text));

  Widget _buildDisplayName(String? name) => Utils.textNotNull(name)
      ? MyText(
          name!,
          size: FONTSIZE.TINY,
        )
      : Container();

  Widget _gestureDetectorWrap(
          {required BuildContext context,
          required String userId,
          required Widget child,
          required ClubMemberType memberType}) =>
      GestureDetector(
        onTap: () => onTapAvatar(userId, memberType),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: scrollPhysics,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 0.6,
      shrinkWrap: true,
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: [
        _gestureDetectorWrap(
          context: context,
          userId: owner.id,
          memberType: ClubMemberType.owner,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserAvatar(
                    avatarUri: owner.avatarUri,
                  ),
                  _buildDisplayName(owner.displayName),
                ],
              ),
              _buildPositionedOwnerTag('Owner'),
            ],
          ),
        ),
        ...admins
            .map((a) => _gestureDetectorWrap(
                  context: context,
                  userId: a.id,
                  memberType: ClubMemberType.admin,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UserAvatar(
                            avatarUri: a.avatarUri,
                          ),
                          _buildDisplayName(a.displayName),
                        ],
                      ),
                      _buildPositionedAdminTag('Admin'),
                    ],
                  ),
                ))
            .toList(),
        ...members
            .map((m) => _gestureDetectorWrap(
                  context: context,
                  userId: m.id,
                  memberType: ClubMemberType.member,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserAvatar(
                        avatarUri: m.avatarUri,
                      ),
                      _buildDisplayName(m.displayName),
                    ],
                  ),
                ))
            .toList()
      ],
    );
  }
}
