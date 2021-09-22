import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:sofie_ui/components/media/video/video_thumbnail_player.dart';
import 'package:sofie_ui/components/social/club_members_grid_list.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/data_type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/utils.dart';

class ClubDetailsInfo extends StatelessWidget {
  final Club club;
  const ClubDetailsInfo({Key? key, required this.club}) : super(key: key);

  Size get _kthumbDisplaySize => const Size(80, 80);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (Utils.textNotNull(club.location))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.location,
                      size: 18, color: Styles.infoBlue),
                  const SizedBox(width: 2),
                  MyText(club.location!, color: Styles.infoBlue)
                ],
              ),
            ),
          if (Utils.anyNotNull([club.introAudioUri, club.introVideoUri]))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (club.introVideoUri != null)
                    VideoThumbnailPlayer(
                      videoUri: club.introVideoUri,
                      videoThumbUri: club.introVideoThumbUri,
                      displaySize: _kthumbDisplaySize,
                    ),
                  if (club.introAudioUri != null)
                    AudioThumbnailPlayer(
                      audioUri: club.introAudioUri!,
                      displaySize: _kthumbDisplaySize,
                      playerTitle: '${club.name} - Intro',
                    ),
                ],
              ),
            ),
          if (Utils.textNotNull(club.description))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ViewMoreFullScreenTextBlock(
                text: club.description!,
                title: 'Description',
                maxLines: 8,
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(CupertinoIcons.person_2),
                const SizedBox(width: 8),
                H3('Members (${club.totalMembers})')
              ],
            ),
          ),
          ClubMembersGridList(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              admins: club.admins,
              members: club.members,
              owner: club.owner,
              onTapAvatar: (userId, _) => context
                  .navigateTo(UserPublicProfileDetailsRoute(userId: userId))),
        ],
      ),
    );
  }
}
