import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/social/club_members_grid_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

class ClubDetailsInfo extends StatelessWidget {
  final Club club;
  ClubDetailsInfo({Key? key, required this.club}) : super(key: key);

  final _kthumbDisplaySize = Size(80, 80);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Utils.textNotNull(club.location))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.location, size: 18, color: Styles.infoBlue),
                SizedBox(width: 2),
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
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(CupertinoIcons.person_2),
              SizedBox(width: 8),
              H3('Members (${club.totalMembers})')
            ],
          ),
        ),
        ClubMembersGridList(
          scrollPhysics: NeverScrollableScrollPhysics(),
          admins: club.admins,
          members: club.members,
          owner: club.owner,
        ),
      ],
    );
  }
}
