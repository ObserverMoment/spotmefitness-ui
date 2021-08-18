import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stream_feed/stream_feed.dart';

class TimelinePostCard extends StatelessWidget {
  final ActivityWithObjectData activityWithObjectData;
  const TimelinePostCard({Key? key, required this.activityWithObjectData})
      : super(key: key);

  Widget _buildReactionButton(IconData iconData, onPressed) => CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      onPressed: onPressed,
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
                  MyText(objectData != null ? objectData.userDisplayName : ''),
                  MyText(
                      objectData != null ? objectData.objectType.display : '',
                      color: Styles.colorTwo)
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

  Widget _buildTitleAndCaption(
          Activity activity, TimelinePostData? objectData) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyHeaderText(
                  objectData?.title ?? 'No title',
                  size: FONTSIZE.LARGE,
                  lineHeight: 1.2,
                ),
                SizedBox(height: 4),
                MyText(
                  activity.extraData?['caption'] as String? ?? 'No caption',
                  lineHeight: 1.4,
                  maxLines: 3,
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final activity = activityWithObjectData.activity;
    final objectData = activityWithObjectData.objectData;

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: _buildAvatarAndDisplayName(objectData),
      ),
      SizedBox(height: 8),
      if (objectData?.imageUri != null)
        SizedBox(
            height: 200, child: SizedUploadcareImage(objectData!.imageUri!)),
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
          MyText(
            (activity.time as DateTime).compactDateString,
            size: FONTSIZE.SMALL,
          )
        ],
      ),
      _buildTitleAndCaption(activity, objectData),
      SizedBox(height: 10),
      HorizontalLine(
          verticalPadding: 0, color: context.theme.primary.withOpacity(0.1))
    ]);
  }
}
