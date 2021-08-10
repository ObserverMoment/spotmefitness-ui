import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// Displays a horizontal list of small user avatars, up to a maximum, then + more indicator.
/// Standard for showing members of a group / enrolments etc.
class UsersGroupSummary extends StatelessWidget {
  final List<UserSummary> users;
  final int showMax;
  final String? subtitle;
  final double avatarSize;
  const UsersGroupSummary(
      {Key? key,
      required this.users,
      this.showMax = 5,
      this.subtitle,
      this.avatarSize = 30.0})
      : super(key: key);

  /// Less than one means an overlap.
  final kAvatarWidthFactor = 0.7;

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? MyText(
            'No members yet',
            size: FONTSIZE.TINY,
            weight: FontWeight.bold,
            subtext: true,
          )
        : Column(
            children: [
              Container(
                height: 36,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      ...users
                          .take(showMax)
                          .map((u) => Align(
                                widthFactor: kAvatarWidthFactor,
                                child: UserAvatar(
                                  avatarUri: u.avatarUri,
                                  size: avatarSize,
                                  borderWidth: 1,
                                  border: true,
                                ),
                              ))
                          .toList(),
                      if (users.length > showMax)
                        Align(
                          widthFactor: kAvatarWidthFactor,
                          child: PlusOthersIcon(
                            overflow: users.length - showMax,
                            size: avatarSize,
                          ),
                        )
                    ]),
              ),
              if (Utils.textNotNull(subtitle))
                Padding(
                  padding: const EdgeInsets.only(top: 3.0, bottom: 1),
                  child: MyText(
                    subtitle!,
                    size: FONTSIZE.TINY,
                    weight: FontWeight.bold,
                    subtext: true,
                  ),
                ),
            ],
          );
  }
}
