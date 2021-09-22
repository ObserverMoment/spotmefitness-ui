import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

class ClubChatsChannelList extends StatefulWidget {
  final chat.StreamChatClient streamChatClient;
  const ClubChatsChannelList({Key? key, required this.streamChatClient})
      : super(key: key);

  @override
  _ClubChatsChannelListState createState() => _ClubChatsChannelListState();
}

class _ClubChatsChannelListState extends State<ClubChatsChannelList> {
  late Stream<List<chat.Channel>> _channelStream;
  late StreamSubscription _channelSubscriber;

  /// Stream Channel plus user data from our API (name and avatar).
  List<ChannelWithClubSummaryData> _channelsWithClubSummaryData =
      <ChannelWithClubSummaryData>[];
  bool _loadingClubSummaryData = true;

  @override
  void initState() {
    super.initState();

    _channelStream = widget.streamChatClient.queryChannels(
        filter: chat.Filter.and([
          chat.Filter.equal('type', kClubMembersChannelName),
          chat.Filter.in_(
              'members', [widget.streamChatClient.state.currentUser!.id]),
        ]),
        sort: const [chat.SortOption('last_message_at')]);

    _channelSubscriber = _channelStream.listen(_updateChannelData);
  }

  Future<void> _updateChannelData(List<chat.Channel> channels) async {
    setState(() => _loadingClubSummaryData = true);

    final clubIds = channels.map((c) => c.id!).toList();

    /// Then call our API to get UserAvatarData[]
    final result = await context.graphQLStore
        .networkOnlyOperation<ClubSummaries$Query, ClubSummariesArguments>(
            operation: ClubSummariesQuery(
                variables: ClubSummariesArguments(ids: clubIds)));

    if (result.hasErrors || result.data == null) {
      result.errors?.forEach((e) {
        printLog(e.toString());
      });
      context.showToast(
          message: 'Sorry, there was a problem loading chat info');
    } else {
      final allSummaries = result.data!.clubSummaries;

      _channelsWithClubSummaryData = channels
          .map((channel) => ChannelWithClubSummaryData(
              channel: channel,
              clubData:
                  allSummaries.firstWhereOrNull((a) => a.id == channel.id)))
          .toList();
    }

    setState(() => _loadingClubSummaryData = false);
  }

  @override
  void dispose() {
    _channelSubscriber.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loadingClubSummaryData
        ? const ShimmerChatChannelPreviewList()
        : _channelsWithClubSummaryData.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    MyText('No club chats yet...'),
                  ],
                ))
            : ListView.builder(
                itemCount: _channelsWithClubSummaryData.length,
                itemBuilder: (c, i) => ClubChannelPreviewTile(
                      channelWithClubSummaryData:
                          _channelsWithClubSummaryData[i],
                    ));
  }
}

class ClubChannelPreviewTile extends StatelessWidget {
  final ChannelWithClubSummaryData channelWithClubSummaryData;
  const ClubChannelPreviewTile(
      {Key? key, required this.channelWithClubSummaryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chat.Channel channel = channelWithClubSummaryData.channel;
    final ClubPublicSummary? clubData = channelWithClubSummaryData.clubData;

    final lastMessage = channel.state?.lastMessage;
    final unreadCount = channel.state?.unreadCount ?? 0;

    return GestureDetector(
      onTap: clubData != null
          ? () => context.navigateTo(ClubMembersChatRoute(clubId: clubData.id))
          : null,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 6),
              child: Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Utils.textNotNull(clubData?.coverImageUri)
                    ? SizedUploadcareImage(clubData!.coverImageUri!)
                    : Image.asset(
                        'assets/social_images/group_placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
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
                            MyText(clubData?.name ?? 'Unnamed'),
                            MyText(
                              lastMessage?.text ?? '...',
                              subtext: true,
                              size: FONTSIZE.two,
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
                                        size: FONTSIZE.two,
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

class ChannelWithClubSummaryData {
  final chat.Channel channel;
  final ClubPublicSummary? clubData;
  const ChannelWithClubSummaryData({
    required this.channel,
    required this.clubData,
  });
}
