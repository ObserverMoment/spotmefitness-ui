import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/social/users_group_summary.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/utils.dart';

class ClubSummaryCard extends StatelessWidget {
  final Club club;
  const ClubSummaryCard({Key? key, required this.club}) : super(key: key);

  double get kCardHeight => 140.0;

  @override
  Widget build(BuildContext context) {
    final List<UserSummary> allMembers = [...club.admins, ...club.members];
    return Card(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 260,
        height: kCardHeight,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: kStandardCardBorderRadius,
              child: SizedBox(
                width: 90,
                height: kCardHeight,
                child: Utils.textNotNull(club.coverImageUri)
                    ? SizedUploadcareImage(club.coverImageUri!)
                    : Image.asset(
                        'assets/social_images/group_placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          club.name,
                          weight: FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 4),
                          child: MyText(
                            club.owner.displayName,
                            size: FONTSIZE.two,
                          ),
                        ),
                        if (Utils.textNotNull(club.location))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.location,
                                    size: 14, color: Styles.infoBlue),
                                MyText(club.location!,
                                    size: FONTSIZE.two, color: Styles.infoBlue)
                              ],
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          UsersGroupSummary(
                            users: allMembers,
                            showMax: 3,
                            avatarSize: 28,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
