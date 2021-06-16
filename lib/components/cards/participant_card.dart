import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/country.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';

class ParticipantCard extends StatelessWidget {
  final UserSummary userSummary;
  const ParticipantCard({Key? key, required this.userSummary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            UserAvatar(
              size: 40,
              avatarUri: userSummary.avatarUri,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    H3(userSummary.displayName),
                    if (userSummary.countryCode != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: CountryFlag(userSummary.countryCode!, 28),
                      ),
                  ],
                ),
                if (Utils.textNotNull(userSummary.tagline))
                  MyText(
                    userSummary.tagline!,
                    size: FONTSIZE.SMALL,
                  )
              ],
            ),
          ],
        ),
        if (userSummary.userProfileScope == UserProfileScope.public)
          BorderButton(
              mini: true,
              text: 'Profile',
              prefix: Icon(
                CupertinoIcons.chevron_right_square_fill,
                size: 16,
                color: context.theme.primary,
              ),
              onPressed: () => context.navigateTo(
                  UserPublicProfileDetailsRoute(userId: userSummary.id)))
      ],
    ));
  }
}
