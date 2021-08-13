import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/stream.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:auto_route/auto_route.dart';

/// Opens a chat overview page for the currently logged in User.
class ChatsOverviewPage extends StatefulWidget {
  const ChatsOverviewPage({Key? key}) : super(key: key);

  @override
  _ChatsOverviewPageState createState() => _ChatsOverviewPageState();
}

class _ChatsOverviewPageState extends State<ChatsOverviewPage> {
  late AuthedUser _authedUser;
  late chat.StreamChatClient _streamChatClient;
  chat.OwnUser? _streamUser;

  /// 0 = Clubs. 1 = Friends.
  int _tabIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamChatClient = context.streamChatClient;

    _initGetStreamChat();
  }

  Future<void> _initGetStreamChat() async {
    try {
      _streamUser = await _streamChatClient.connectUser(
        chat.User(id: _authedUser.id),
        _authedUser.streamChatToken,
      );
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  void _updateTabIndex(int index) {
    setState(() => _tabIndex = index);
    _pageController.toPage(index);
  }

  @override
  void dispose() async {
    super.dispose();
    _pageController.dispose();
    await _streamChatClient.disconnectUser();
  }

  @override
  Widget build(BuildContext context) {
    return m.Material(
      child: CupertinoPageScaffold(
        navigationBar: BorderlessNavBar(
          middle: NavBarTitle('Chats'),
        ),
        child: chat.StreamChat(
          streamChatThemeData: StreamService.theme(context),
          client: _streamChatClient,
          child: chat.ChannelsBloc(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, bottom: 6, right: 12),
                    child: SlidingSelect<int>(
                        value: _tabIndex,
                        updateValue: _updateTabIndex,
                        children: {0: MyText('Friends'), 1: MyText('Clubs')}),
                  ),
                ),
                Flexible(
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      FriendChatsChannelList(
                        streamChatClient: _streamChatClient,
                        streamUser: _streamUser,
                      ),
                      Center(
                        child: MyHeaderText(
                          'Coming soon!',
                          size: FONTSIZE.HUGE,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FriendChatsChannelList extends StatelessWidget {
  final chat.StreamChatClient streamChatClient;
  final chat.OwnUser? streamUser;
  const FriendChatsChannelList(
      {Key? key, required this.streamChatClient, this.streamUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chat.ChannelListView(
      listBuilder: (c, channels) => ListView.builder(
          itemCount: channels.length,
          itemBuilder: (c, i) =>
              FriendChannelPreviewTile(channel: channels[i])),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      filter: streamUser != null
          ? chat.Filter.and([
              chat.Filter.equal('type', 'messaging'),
              chat.Filter.equal('chatType', ChatType.friend.toString()),
              chat.Filter.in_('members', [streamUser!.id]),
            ])
          : null,
      sort: const [chat.SortOption('last_message_at')],
      pagination: const chat.PaginationParams(
        limit: 20,
      ),
    );
  }
}

class FriendChannelPreviewTile extends StatelessWidget {
  final chat.Channel channel;
  const FriendChannelPreviewTile({Key? key, required this.channel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Need to get the displayName and avatarUri (if it exists) from the other member of the two person group chat.
    final otherMember = channel.state?.members.firstWhereOrNull(
        (m) => m.userId != GetIt.I<AuthBloc>().authedUser!.id);

    final displayName = otherMember?.user?.extraData['displayName'] as String?;
    final avatarUri = otherMember?.user?.extraData['avatarUri'] as String?;

    final lastMessage = channel.state?.lastMessage;
    final unreadCount = channel.state?.unreadCount ?? 0;

    return GestureDetector(
      onTap: otherMember?.userId != null
          ? () => context
              .navigateTo(OneToOneChatRoute(otherUserId: otherMember!.userId!))
          : null,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 6),
              child: UserAvatar(
                size: 36,
                border: true,
                borderWidth: 1,
                avatarUri: avatarUri,
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
                            MyText(displayName ?? 'Unnamed'),
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
                      width: 30,
                      child: Center(
                        child: unreadCount > 0
                            ? SizedBox(
                                width: 22,
                                child: CircularBox(
                                    padding: const m.EdgeInsets.all(2),
                                    color: Styles.infoBlue,
                                    child: Center(
                                      child: MyText(
                                        unreadCount.toString(),
                                        color: Styles.white,
                                        size: FONTSIZE.SMALL,
                                        lineHeight: 1.3,
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
