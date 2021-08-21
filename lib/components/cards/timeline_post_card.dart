import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/creators/post_creator/post_editor.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:auto_route/auto_route.dart';

class TimelinePostCard extends StatelessWidget {
  final ActivityWithObjectData activityWithObjectData;
  // Removes interactivity.
  final bool isPreview;
  final void Function(String activityId)? deleteActivityById;
  const TimelinePostCard(
      {Key? key,
      required this.activityWithObjectData,
      this.isPreview = false,
      this.deleteActivityById})
      : super(key: key);

  void _openDetailsPageByType(BuildContext context) {
    final object = activityWithObjectData.objectData!.object;
    switch (object.type) {
      case TimelinePostType.workout:
        context.navigateTo(WorkoutDetailsRoute(id: object.id));
        break;
      case TimelinePostType.workoutplan:
        context.navigateTo(WorkoutPlanDetailsRoute(id: object.id));
        break;
      default:
        throw Exception(
            'TimelinePostCard._TimelinePostEllipsisMenu: No method defined for ${object.type}.');
    }
  }

  Widget _buildReactionButton(IconData iconData, VoidCallback onPressed) =>
      CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          onPressed: isPreview ? null : onPressed,
          child: Icon(iconData));

  Widget _buildAvatarAndDisplayName(BuildContext context,
          TimelinePostData? objectData, Activity activity) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserAvatar(
                size: 40,
                avatarUri: objectData?.creator.avatarUri,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(objectData != null
                      ? 'By ${objectData.creator.displayName}'
                      : ''),
                  MyHeaderText(
                    objectData != null ? objectData.object.type.display : '',
                    size: FONTSIZE.SMALL,
                    lineHeight: 1.3,
                  )
                ],
              ),
            ],
          ),
          _TimelinePostEllipsisMenu(
            object: objectData!.object,
            poster: objectData.poster,
            creator: objectData.creator,
            handleDeletePost: deleteActivityById != null
                ? () => deleteActivityById!(activity.id!)
                : null,
            openEditPost: () => context.navigateTo(PostEditorRoute(
                activityWithObjectData: activityWithObjectData)),
            openDetailsPage: () => _openDetailsPageByType(context),
          )
        ],
      );

  Widget _buildTitleCaptionAndTags(
          Activity activity, TimelinePostData? objectData) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyHeaderText(
                    objectData?.object.name ?? 'No title',
                    size: FONTSIZE.LARGE,
                    lineHeight: 1.2,
                  ),
                  SizedBox(height: 4),
                  if (activity.extraData?['caption'] is String)
                    MyText(
                      activity.extraData?['caption'] as String,
                      lineHeight: 1.4,
                      maxLines: 3,
                    ),
                  // There are no type checks on the getStream side so we need to defend against anything weird being in this field.
                  if (activity.extraData?['tags'] is List)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 4),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: (activity.extraData?['tags'] as List)
                            // Ensure we only render strings.
                            .whereType<String>()
                            .map((tag) => MyText(
                                  '#$tag',
                                  color: Styles.colorOne,
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
    final activity = activityWithObjectData.activity;
    final objectData = activityWithObjectData.objectData;

    return GestureDetector(
      onTap: () => _openDetailsPageByType(context),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: _buildAvatarAndDisplayName(context, objectData, activity),
        ),
        SizedBox(height: 4),
        if (objectData?.object.coverImageUri != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
                height: 200,
                child: SizedUploadcareImage(objectData!.object.coverImageUri!)),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildReactionButton(CupertinoIcons.hand_thumbsup,
                    () => print('like this post')),
                _buildReactionButton(
                    CupertinoIcons.paperplane, () => print('share')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyText(
                    'Posted by ${objectData?.poster.displayName ?? "Unknown"}',
                    size: FONTSIZE.SMALL,
                    subtext: true,
                    lineHeight: 1.3,
                  ),
                  MyText(
                    (activity.time as DateTime).daysAgo,
                    size: FONTSIZE.SMALL,
                    subtext: true,
                    lineHeight: 1.3,
                  ),
                ],
              ),
            )
          ],
        ),
        Flexible(child: _buildTitleCaptionAndTags(activity, objectData)),
        SizedBox(height: 10),
        HorizontalLine(
            verticalPadding: 0, color: context.theme.primary.withOpacity(0.2))
      ]),
    );
  }
}

class _TimelinePostEllipsisMenu extends StatelessWidget {
  final TimelinePostDataUser poster;
  final TimelinePostDataUser creator;
  final TimelinePostDataObject object;
  final VoidCallback? handleDeletePost;
  final VoidCallback openEditPost;
  final VoidCallback openDetailsPage;
  const _TimelinePostEllipsisMenu(
      {Key? key,
      required this.object,
      required this.openDetailsPage,
      required this.poster,
      required this.creator,
      required this.openEditPost,
      this.handleDeletePost})
      : super(key: key);

  void _openUserProfile(BuildContext context, String userId) {
    context.navigateTo(UserPublicProfileDetailsRoute(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    final authedUserId = GetIt.I<AuthBloc>().authedUser!.id;
    final userIsPoster = authedUserId == poster.id;
    final userIsCreator = authedUserId == creator.id;

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
                if (userIsPoster)
                  BottomSheetMenuItem(
                    text: 'Edit Post',
                    icon: Icon(CupertinoIcons.pencil),
                    onPressed: openEditPost,
                  ),
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
                      text: 'Report post',
                      icon: Icon(
                        CupertinoIcons.exclamationmark_circle,
                        color: Styles.errorRed,
                      ),
                      isDestructive: true,
                      onPressed: () => print('report')),
              ])),
    );
  }
}
