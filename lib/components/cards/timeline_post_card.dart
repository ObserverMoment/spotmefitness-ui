import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_and_follows.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
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
                size: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText('TODO: displayName from API'),
                  MyText(objectData?.type.toString() ?? '',
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

  Widget _buildTitleAndCaption(Activity activity) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyHeaderText(
                  activity.extraData?['title'] as String? ?? 'No title',
                  size: FONTSIZE.LARGE,
                ),
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
      _buildAvatarAndDisplayName(objectData),
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
          MyText((activity.time as DateTime).compactDateString)
        ],
      ),
      _buildTitleAndCaption(activity),
    ]);
  }
}
