import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/stream.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as s;
import 'package:collection/collection.dart';

/// A standalone page that can open up a one to one chat conversation.
/// [otherUserSummary] - The UserSummary of the other user. The first user is the authed user.
class OneToOneChatPage extends StatefulWidget {
  final String otherUserId;
  const OneToOneChatPage({
    Key? key,
    required this.otherUserId,
  }) : super(key: key);

  @override
  OneToOneChatPageState createState() => OneToOneChatPageState();
}

class OneToOneChatPageState extends State<OneToOneChatPage> {
  late AuthedUser _authedUser;
  late s.StreamChatClient _streamChatClient;
  late s.Channel _channel;
  s.Member? _otherMember;
  String? _displayName; // Of the other person to show at the top center.
  String? _avatarUri; // Of the other person to show at the top right.
  late bool _channelReady = false;

  final kChannelType = 'messaging';

  @override
  void initState() {
    super.initState();
    _streamChatClient = GetIt.I<s.StreamChatClient>();
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _initGetStreamChat();
  }

  Future<void> _initGetStreamChat() async {
    try {
      if (_streamChatClient.state.currentUser == null) {
        await _streamChatClient.connectUser(
          s.User(id: _authedUser.id),
          _authedUser.streamChatToken,
        );
      }

      /// Create / watch a channel consisting of the authed user and the 'other user.
      /// This type of channel is always just these two users. More users cannot be added.
      _channel = _streamChatClient.channel(kChannelType, extraData: {
        'members': [_authedUser.id, widget.otherUserId],
        'chatType': ChatType.friend.toString(),
      });

      await _channel.watch();

      /// Need to get the displayName and avatarUri (if it exists) from the other member of the two person group chat.
      _otherMember = _channel.state?.members.firstWhereOrNull(
          (m) => m.userId != GetIt.I<AuthBloc>().authedUser!.id);

      _displayName = _otherMember?.user?.extraData['displayName'] as String?;
      _avatarUri = _otherMember?.user?.extraData['avatarUri'] as String?;

      setState(() => _channelReady = true);
    } catch (e) {
      print(e);
    }
  }

  // https://github.com/flutter/flutter/issues/64935
  @override
  void dispose() async {
    super.dispose();
    _channel.dispose();
    await _streamChatClient.disconnectUser();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kStandardAnimationDuration,
      child: _channelReady
          ? s.StreamChannel(
              channel: _channel,
              child: CupertinoPageScaffold(
                navigationBar: BorderlessNavBar(
                  middle: MyHeaderText(_displayName ?? 'Unnamed'),
                  trailing: CupertinoButton(
                    onPressed: () => print('open user actions'),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: UserAvatar(
                      size: 38,
                      avatarUri: _avatarUri,
                    ),
                  ),
                ),
                child: s.StreamChat(
                  client: _streamChatClient,
                  streamChatThemeData: StreamService.theme(context),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: s.MessageListView(),
                      ),
                      s.MessageInput(),
                    ],
                  ),
                ),
              ),
            )
          : MyPageScaffold(
              navigationBar: BorderlessNavBar(
                middle: NavBarTitle('Loading Chat...'),
              ),
              child: LoadingCircle()),
    );
  }
}