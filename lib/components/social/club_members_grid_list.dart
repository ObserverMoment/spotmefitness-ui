import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

/// Displays a grid of all the users in the club.
/// Shows tags on the owner and the admins.
class ClubMembersGridList extends StatelessWidget {
  final UserSummary owner;
  final List<UserSummary> admins;
  final List<UserSummary> members;
  final ScrollPhysics? scrollPhysics;
  const ClubMembersGridList(
      {Key? key,
      required this.members,
      // required this.avatarSize,
      required this.owner,
      required this.admins,
      this.scrollPhysics})
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

  Widget _buildDisplayName(String name) => MyText(
        name,
        size: FONTSIZE.TINY,
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
        Stack(
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
        ...admins
            .map((a) => Stack(
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
                ))
            .toList(),
        ...members
            .map((m) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserAvatar(
                      avatarUri: m.avatarUri,
                    ),
                    _buildDisplayName(m.displayName),
                  ],
                ))
            .toList()
      ],
    );
  }
}
