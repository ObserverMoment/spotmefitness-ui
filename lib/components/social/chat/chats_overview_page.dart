import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/social/chat/club_chats_channel_list.dart';
import 'package:spotmefitness_ui/components/social/chat/friend_chats_channel_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/sliding_select.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Opens a chat overview page for the currently logged in User.
class ChatsOverviewPage extends StatefulWidget {
  const ChatsOverviewPage({Key? key}) : super(key: key);

  @override
  _ChatsOverviewPageState createState() => _ChatsOverviewPageState();
}

class _ChatsOverviewPageState extends State<ChatsOverviewPage> {
  late chat.StreamChatClient _streamChatClient;

  /// 0 = Clubs. 1 = Friends.
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _streamChatClient = context.streamChatClient;
  }

  void _updateTabIndex(int index) {
    setState(() => _activeTabIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        middle: NavBarTitle('Chats'),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 6, right: 4),
              child: SlidingSelect<int>(
                  value: _activeTabIndex,
                  updateValue: _updateTabIndex,
                  children: {0: MyText('Friends'), 1: MyText('Clubs')}),
            ),
          ),
          Expanded(
            child: _streamChatClient.state.currentUser == null
                ? ShimmerChatChannelPreviewList()
                : IndexedStack(
                    index: _activeTabIndex,
                    children: [
                      FriendChatsChannelList(
                        streamChatClient: _streamChatClient,
                      ),
                      ClubChatsChannelList(
                        streamChatClient: _streamChatClient,
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
    );
  }
}
