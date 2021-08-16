import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/country.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:auto_route/auto_route.dart';

class ParticipantCard extends StatelessWidget {
  final UserSummary userSummary;
  const ParticipantCard({Key? key, required this.userSummary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  UserAvatar(
                    size: 40,
                    avatarUri: userSummary.avatarUri,
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MyText(
                              userSummary.displayName ?? 'Unnamed',
                              size: FONTSIZE.BIG,
                            ),
                            if (userSummary.countryCode != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child:
                                    CountryFlag(userSummary.countryCode!, 32),
                              ),
                          ],
                        ),
                        if (Utils.textNotNull(userSummary.tagline))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: MyText(
                              userSummary.tagline!,
                              size: FONTSIZE.SMALL,
                              maxLines: 2,
                              lineHeight: 1.4,
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (userSummary.userProfileScope == UserProfileScope.public)
              BorderButton(
                  mini: true,
                  text: 'Profile',
                  onPressed: () => context.navigateTo(
                      UserPublicProfileDetailsRoute(userId: userSummary.id)))
          ],
        ));
  }
}
