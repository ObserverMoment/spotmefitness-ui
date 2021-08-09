import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/social/club_members_grid_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ClubDetailsPage extends StatelessWidget {
  final String id;
  ClubDetailsPage({@PathParam('id') required this.id});

  final _kthumbDisplaySize = Size(80, 80);

  @override
  Widget build(BuildContext context) {
    final query = ClubByIdQuery(variables: ClubByIdArguments(id: id));
    return QueryObserver<ClubById$Query, ClubByIdArguments>(
        key: Key('ClubDetailsPage - ${query.operationName}-${id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final club = data.clubById;

          /// 1 is the owner.
          final totalMembers = 1 + club.admins.length + club.members.length;

          return CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: _CustomSliverAppBarDelegate(
                      title: club.name,
                      expandedHeight: 200,
                      imageUri: club.coverImageUri),
                  pinned: true,
                  floating: true,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(height: 36),
                  MyHeaderText(
                    club.name,
                    size: FONTSIZE.HUGE,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (Utils.textNotNull(club.location))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.location,
                                  size: 20, color: Styles.infoBlue),
                              SizedBox(width: 2),
                              MyText(club.location!, color: Styles.infoBlue)
                            ],
                          ),
                        MyText('$totalMembers members')
                      ],
                    ),
                  ),
                  if (Utils.anyNotNull(
                      [club.introAudioUri, club.introVideoUri]))
                    Padding(
                      padding: const EdgeInsets.all(16),
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
                      padding: const EdgeInsets.all(16.0),
                      child: ViewMoreFullScreenTextBlock(
                        text: club.description!,
                        title: 'Description',
                        maxLines: 8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ClubMembersGridList(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    admins: club.admins,
                    avatarSize: 46,
                    members: club.members,
                    owner: club.owner,
                  ),
                  ClubMembersGridList(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    admins: club.admins,
                    avatarSize: 46,
                    members: club.members,
                    owner: club.owner,
                  ),
                  ClubMembersGridList(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    admins: club.admins,
                    avatarSize: 46,
                    members: club.members,
                    owner: club.owner,
                  ),
                  ClubMembersGridList(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    admins: club.admins,
                    avatarSize: 46,
                    members: club.members,
                    owner: club.owner,
                  ),
                ]))
              ],
            ),
          );
        });
  }
}

class _CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String title;
  final String? imageUri;

  const _CustomSliverAppBarDelegate(
      {required this.expandedHeight, this.imageUri, required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final buttonSize = 46;
    final top = expandedHeight - shrinkOffset - buttonSize / 2;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(context, shrinkOffset),
        buildAppBar(context, shrinkOffset),
        Positioned(
            left: 12, top: 50, child: buildBackButton(context, shrinkOffset)),
        Positioned(
            right: 12, top: 50, child: buildShareButton(context, shrinkOffset)),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildInviteButton(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(BuildContext context, double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: BorderlessNavBar(
          backgroundColor: context.theme.cardBackground,
          middle: NavBarTitle(title),
          trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.ellipsis_circle),
              onPressed: () => print('club menu options')),
        ),
      );

  Widget buildBackground(BuildContext context, double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Utils.textNotNull(imageUri)
                    ? SizedUploadcareImage(imageUri!)
                    : Image.asset(
                        'assets/social_images/group_placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
              ],
            )),
      );

  Widget buildInviteButton(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingIconButton(
                iconData: CupertinoIcons.mail,
                onPressed: () => print('request invite'),
                text: 'Request Invite'),
          ],
        ),
      );

  Widget buildBackButton(BuildContext context, double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: CircularBox(
            padding: const EdgeInsets.all(0),
            color: context.theme.background,
            child: NavBarBackButton(
              alignment: Alignment.center,
            )),
      );

  Widget buildShareButton(BuildContext context, double shrinkOffset) => Opacity(
      opacity: disappear(shrinkOffset),
      child: CircularBox(
          padding: const EdgeInsets.all(0),
          color: context.theme.background,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.share, size: 22),
              onPressed: () => print('share club flow'))));

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
