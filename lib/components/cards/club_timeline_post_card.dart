import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/sharing_and_linking.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ClubTimelinePostCard extends StatelessWidget {
  final TimelinePostFullData postData;
  // Removes interactivity when [true].
  final bool isPreview;
  final void Function(String activityId)? deleteActivityById;

  const ClubTimelinePostCard({
    Key? key,
    required this.postData,
    this.isPreview = false,
    this.deleteActivityById,
  }) : super(key: key);

  void _openDetailsPageByType(BuildContext context) {
    final object = postData.object;
    switch (object.type) {
      case TimelinePostType.workout:
        context.navigateTo(WorkoutDetailsRoute(id: object.id));
        break;
      case TimelinePostType.workoutplan:
        context.navigateTo(WorkoutPlanDetailsRoute(id: object.id));
        break;
      default:
        throw Exception(
            'ClubTimelinePostCard._ClubTimelinePostEllipsisMenu: No method defined for ${postData.object.type}.');
    }
  }

  Widget _buildTitleCaptionAndTags() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyHeaderText(
                    postData.object.name,
                    size: FONTSIZE.LARGE,
                    lineHeight: 1.2,
                  ),
                  SizedBox(height: 4),
                  if (Utils.textNotNull(postData.caption))
                    MyText(
                      postData.caption!,
                      lineHeight: 1.4,
                      maxLines: 3,
                    ),
                  if (postData.tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 4),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: postData.tags
                            .map((tag) => MyText(
                                  '#$tag',
                                  color: Styles.colorOne,
                                  weight: FontWeight.bold,
                                ))
                            .toList(),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
    final userIsPoster = authedUserId == postData.poster.id;
    final userIsCreator = authedUserId == postData.creator.id;

    return GestureDetector(
      onTap: () => _openDetailsPageByType(context),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserAvatar(
                    size: 40,
                    avatarUri: postData.creator.avatarUri,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyHeaderText(
                        postData.object.type.display,
                        size: FONTSIZE.SMALL,
                        lineHeight: 1.3,
                      ),
                      MyText(
                        'By ${postData.creator.displayName}',
                        lineHeight: 1.4,
                        size: FONTSIZE.SMALL,
                      ),
                    ],
                  ),
                ],
              ),
              _ClubTimelinePostEllipsisMenu(
                userIsCreator: userIsCreator,
                userIsPoster: userIsPoster,
                object: postData.object,
                poster: postData.poster,
                creator: postData.creator,
                openDetailsPage: () => _openDetailsPageByType(context),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        if (postData.object.coverImageUri != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
                height: 200,
                child: SizedUploadcareImage(postData.object.coverImageUri!)),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CupertinoButton(
                      onPressed: () => print('like'),
                      child: Icon(CupertinoIcons.hand_thumbsup)),
                  CupertinoButton(
                      onPressed: () => print('comments / chat'),
                      child: Icon(CupertinoIcons.chat_bubble)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userIsPoster
                      ? Tag(
                          tag: 'Posted by you',
                          withBorder: true,
                          textColor: context.theme.primary,
                          color: context.theme.background,
                          fontSize: FONTSIZE.SMALL,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                        )
                      : Tag(
                          tag: 'Posted by ${postData.poster.displayName}',
                          textColor: context.theme.primary,
                          color: context.theme.cardBackground,
                          fontSize: FONTSIZE.SMALL,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                        ),
                  SizedBox(height: 4),
                  Tag(
                    tag: postData.postedAt.daysAgo,
                    textColor: context.theme.primary,
                    color: context.theme.cardBackground,
                    fontSize: FONTSIZE.SMALL,
                    fontWeight: FontWeight.normal,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  )
                ],
              )
            ],
          ),
        ),
        Flexible(child: _buildTitleCaptionAndTags()),
        SizedBox(height: 10),
        HorizontalLine(
            verticalPadding: 0, color: context.theme.primary.withOpacity(0.2))
      ]),
    );
  }
}

class _ClubTimelinePostEllipsisMenu extends StatelessWidget {
  final bool userIsPoster;
  final bool userIsCreator;
  final TimelinePostObjectDataUser poster;
  final TimelinePostObjectDataUser creator;
  final TimelinePostObjectDataObject object;
  final VoidCallback? handleDeletePost;
  final VoidCallback? openEditPost;
  final VoidCallback openDetailsPage;
  const _ClubTimelinePostEllipsisMenu({
    Key? key,
    required this.object,
    required this.openDetailsPage,
    required this.poster,
    required this.creator,
    this.openEditPost,
    this.handleDeletePost,
    required this.userIsPoster,
    required this.userIsCreator,
  }) : super(key: key);

  void _openUserProfile(BuildContext context, String userId) {
    context.navigateTo(UserPublicProfileDetailsRoute(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Icon(CupertinoIcons.ellipsis),
      onPressed: () => openBottomSheetMenu(
          context: context,
          child: BottomSheetMenu(
              header: BottomSheetMenuHeader(
                  name: '${object.name} by ${creator.displayName}',
                  subtitle: 'Posted by ${poster.displayName}',
                  imageUri: object.coverImageUri),
              items: [
                BottomSheetMenuItem(
                    text: 'View ${object.type.display}',
                    icon: Icon(CupertinoIcons.eye),
                    onPressed: openDetailsPage),
                if (!userIsCreator)
                  BottomSheetMenuItem(
                      text: 'View Creator',
                      icon: Icon(CupertinoIcons.person_crop_rectangle),
                      onPressed: () => _openUserProfile(context, creator.id)),
                if (!userIsPoster)
                  BottomSheetMenuItem(
                      text: 'View Poster',
                      icon: Icon(CupertinoIcons.person_crop_rectangle),
                      onPressed: () => _openUserProfile(context, poster.id)),
                if (userIsPoster && handleDeletePost != null)
                  BottomSheetMenuItem(
                      text: 'Delete Post',
                      icon: Icon(
                        CupertinoIcons.delete_simple,
                        color: Styles.errorRed,
                      ),
                      onPressed: handleDeletePost!,
                      isDestructive: true),
                if (!userIsPoster)
                  BottomSheetMenuItem(
                      text: 'Report',
                      icon: Icon(
                        CupertinoIcons.exclamationmark_circle,
                        color: Styles.errorRed,
                      ),
                      isDestructive: true,
                      onPressed: () => print('report this post')),
              ])),
    );
  }
}
