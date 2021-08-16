import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class UserProfileCard extends StatelessWidget {
  final UserPublicProfileSummary profileSummary;
  const UserProfileCard({Key? key, required this.profileSummary})
      : super(key: key);

  final kAvatarSize = 70.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: kAvatarSize / 2),
            child: Card(
                padding: EdgeInsets.only(
                    top: kAvatarSize / 2, left: 8, right: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MyText(
                        profileSummary.displayName ?? 'Unnamed',
                        weight: FontWeight.bold,
                      ),
                    ),
                    if (Utils.textNotNull(profileSummary.tagline))
                      MyText(
                        profileSummary.tagline!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        lineHeight: 1.3,
                        size: FONTSIZE.SMALL,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            MyText(
                              'Workouts',
                              lineHeight: 1,
                            ),
                            MyText(
                              profileSummary.numberPublicWorkouts.toString(),
                              weight: FontWeight.bold,
                              size: FONTSIZE.BIG,
                              lineHeight: 1.2,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            MyText(
                              'Plans',
                              lineHeight: 1,
                            ),
                            MyText(
                              profileSummary.numberPublicPlans.toString(),
                              weight: FontWeight.bold,
                              size: FONTSIZE.BIG,
                              lineHeight: 1.2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          UserAvatar(
            avatarUri: profileSummary.avatarUri,
            size: kAvatarSize,
            border: true,
            borderWidth: 1,
          ),
        ],
      ),
    );
  }
}
