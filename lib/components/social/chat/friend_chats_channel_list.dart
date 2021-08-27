import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';

class FriendChatsChannelList extends StatefulWidget {
  final chat.StreamChatClient streamChatClient;
  const FriendChatsChannelList({Key? key, required this.streamChatClient})
      : super(key: key);

  @override
  _FriendChatsChannelListState createState() => _FriendChatsChannelListState();
}

class _FriendChatsChannelListState extends State<FriendChatsChannelList> {
  late Stream<List<chat.Channel>> _channelStream;
  late StreamSubscription _channelSubscriber;

  /// Stream Channel plus user data from our API (name and avatar).
  List<ChannelWithUserData> _channelsWithUserData = <ChannelWithUserData>[];
  bool _loadingUserData = true;

  @override
  void initState() {
    super.initState();

    _channelStream = widget.streamChatClient.queryChannels(
        filter: chat.Filter.and([
          chat.Filter.equal('type', kMessagingChannelName),
          chat.Filter.in_(
              'members', [widget.streamChatClient.state.currentUser!.id]),
        ]),
        sort: const [chat.SortOption('last_message_at')]);

    _channelSubscriber = _channelStream.listen(_updateChannelData);
  }

  Future<void> _updateChannelData(List<chat.Channel> channels) async {
    setState(() => _loadingUserData = true);
    final authedUserId = GetIt.I<AuthBloc>().authedUser!.id;

    /// For each channel get the userId of the other member of this one on one chat.
    final List<String> otherUserIds = channels
        .map((c) => c.state!.members
            .firstWhereOrNull((m) => m.userId != authedUserId)
            ?.userId)
        .whereType<String>()
        .toList();

    /// Then call our API to get UserAvatarData[]
    final result = await context.graphQLStore
        .networkOnlyOperation<UserAvatars$Query, UserAvatarsArguments>(
            operation: UserAvatarsQuery(
                variables: UserAvatarsArguments(ids: otherUserIds)));

    _channelsWithUserData = channels
        .mapIndexed((i, channel) => ChannelWithUserData(
            channel,
            result.data?.userAvatars
                .firstWhereOrNull((u) => u.id == otherUserIds[i])))
        .toList();

    setState(() => _loadingUserData = false);
  }

  @override
  void dispose() {
    _channelSubscriber.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loadingUserData
        ? ShimmerChatChannelPreviewList()
        : ListView.builder(
            itemCount: _channelsWithUserData.length,
            itemBuilder: (c, i) => FriendChannelPreviewTile(
                  channelWithUserData: _channelsWithUserData[i],
                ));
  }
}

class FriendChannelPreviewTile extends StatelessWidget {
  final ChannelWithUserData channelWithUserData;
  const FriendChannelPreviewTile({Key? key, required this.channelWithUserData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chat.Channel channel = channelWithUserData.channel;
    final UserAvatarData? userAvatarData = channelWithUserData.userAvatarData;

    final lastMessage = channel.state?.lastMessage;
    final unreadCount = channel.state?.unreadCount ?? 0;

    return GestureDetector(
      onTap: userAvatarData != null
          ? () => context
              .navigateTo(OneToOneChatRoute(otherUserId: userAvatarData.id))
          : null,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 6),
              child: UserAvatar(
                size: 50,
                border: true,
                borderWidth: 1,
                avatarUri: userAvatarData?.avatarUri,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: context.theme.primary.withOpacity(0.1)))),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyText(userAvatarData?.displayName ?? 'Unnamed'),
                            MyText(
                              lastMessage?.text ?? '...',
                              subtext: true,
                              size: FONTSIZE.SMALL,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 28,
                      child: Center(
                        child: unreadCount > 0
                            ? SizedBox(
                                width: 20,
                                child: CircularBox(
                                    color: Styles.heartRed,
                                    child: Center(
                                      child: MyText(
                                        unreadCount.toString(),
                                        color: Styles.white,
                                        size: FONTSIZE.SMALL,
                                      ),
                                    )),
                              )
                            : Icon(
                                CupertinoIcons.checkmark_alt_circle,
                                color: context.theme.primary.withOpacity(0.6),
                                size: 20,
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChannelWithUserData {
  final chat.Channel channel;
  final UserAvatarData? userAvatarData;
  const ChannelWithUserData(this.channel, this.userAvatarData);
}
