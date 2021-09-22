import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/social/users_group_summary.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/utils.dart';

class ClubCard extends StatelessWidget {
  final Club club;
  const ClubCard({Key? key, required this.club}) : super(key: key);

  double get cardHeight => 240.0;

  @override
  Widget build(BuildContext context) {
    final List<UserSummary> allMembers = [...club.admins, ...club.members];
    return Card(
      height: cardHeight,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: kStandardCardBorderRadius,
            child: SizedBox(
              width: 100,
              height: cardHeight,
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
              padding: const EdgeInsets.all(16.0),
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
                        size: FONTSIZE.four,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Wrap(spacing: 8, runSpacing: 8, children: [
                          MyText(
                            '${club.owner.displayName} (owner)',
                            size: FONTSIZE.two,
                            weight: FontWeight.bold,
                          ),
                          ...club.admins
                              .map(
                                (a) => MyText(
                                  '${a.displayName} (admin)',
                                  size: FONTSIZE.two,
                                  subtext: true,
                                ),
                              )
                              .toList(),
                        ]),
                      ),
                    ],
                  ),
                  if (Utils.textNotNull(club.description))
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: MyText(
                          club.description!,
                          maxLines: 4,
                          lineHeight: 1.3,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (Utils.textNotNull(club.location))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.location,
                                    size: 20, color: Styles.infoBlue),
                                const SizedBox(width: 2),
                                MyText(club.location!, color: Styles.infoBlue)
                              ],
                            ),
                          ),
                        UsersGroupSummary(
                          users: allMembers,
                          showMax: 3,
                          avatarSize: 28,
                          subtitle: '${allMembers.length} members',
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
    );
  }
}
