import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stream_feed/stream_feed.dart';

class TimelinePostCard extends StatelessWidget {
  final ActivityWithObjectData activityWithObjectData;

  /// Removes interactivity.
  final bool isPreview;
  const TimelinePostCard(
      {Key? key, required this.activityWithObjectData, this.isPreview = false})
      : super(key: key);

  Widget _buildReactionButton(IconData iconData, VoidCallback onPressed) =>
      CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          onPressed: isPreview ? null : onPressed,
          child: Icon(iconData));

  Widget _buildAvatarAndDisplayName(TimelinePostData? objectData) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserAvatar(
                size: 40,
                avatarUri: objectData?.userAvatarUri,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(objectData != null
                      ? 'By ${objectData.userDisplayName}'
                      : ''),
                  MyText(
                    objectData != null
                        ? objectData.objectType.display.toUpperCase()
                        : '',
                    color: Styles.colorOne,
                    size: FONTSIZE.SMALL,
                    lineHeight: 1.3,
                  )
                ],
              ),
            ],
          ),
          _buildReactionButton(
            CupertinoIcons.ellipsis,
            () => print('open post interaction options'),
          ),
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
                    objectData?.title ?? 'No title',
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

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: _buildAvatarAndDisplayName(objectData),
      ),
      SizedBox(height: 4),
      if (objectData?.imageUri != null)
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
              height: 200, child: SizedUploadcareImage(objectData!.imageUri!)),
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildReactionButton(
                  CupertinoIcons.chat_bubble, () => print('leave a comment')),
              _buildReactionButton(
                  CupertinoIcons.paperplane, () => print('share')),
              _buildReactionButton(
                  CupertinoIcons.bookmark, () => print('save to collection')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyText(
                  'Posted by postername',
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
    ]);
  }
}
