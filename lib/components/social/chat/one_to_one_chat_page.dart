import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/image_viewer.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/stream.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
  late chat.StreamChatClient _streamChatClient;
  late chat.Channel _channel;
  String? _displayName; // Of the other person to show at the top center.
  String? _avatarUri; // Of the other person to show at the top right.
  late bool _channelReady = false;

  @override
  void initState() {
    super.initState();
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamChatClient = context.streamChatClient;

    _initGetStreamChat();
  }

  Future<void> _initGetStreamChat() async {
    try {
      /// Create / watch a channel consisting of the authed user and the 'other user.
      /// This type of channel is always just these two users. More users cannot be added.
      _channel = _streamChatClient.channel(kMessagingChannelName, extraData: {
        'members': [_authedUser.id, widget.otherUserId],
        'chatType': ChatType.friend.toString(),
      });

      await _channel.watch();

      /// Call API and get UserAvatarData[]
      final result = await context.graphQLStore
          .networkOnlyOperation<UserAvatarById$Query, UserAvatarByIdArguments>(
              operation: UserAvatarByIdQuery(
                  variables: UserAvatarByIdArguments(id: widget.otherUserId)));

      _displayName = result.data?.userAvatarById.displayName;
      _avatarUri = result.data?.userAvatarById.avatarUri;

      setState(() => _channelReady = true);
    } catch (e) {
      print(e);
      context.showToast(message: 'There was a problem setting up chat!');
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kStandardAnimationDuration,
      child: _channelReady
          ? chat.StreamChannel(
              channel: _channel,
              child: CupertinoPageScaffold(
                navigationBar: BorderlessNavBar(
                  middle: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => openBottomSheetMenu(
                          context: context,
                          child: BottomSheetMenu(
                              header: BottomSheetMenuHeader(
                                name: _displayName ?? 'Unnamed',
                                subtitle: 'Chat',
                                imageUri: _avatarUri,
                              ),
                              items: [
                                BottomSheetMenuItem(
                                    text: 'Block',
                                    icon: Icon(CupertinoIcons.nosign),
                                    onPressed: () => print('block')),
                                BottomSheetMenuItem(
                                    text: 'Report',
                                    icon: Icon(
                                        CupertinoIcons.exclamationmark_circle),
                                    onPressed: () => print('report')),
                              ])),
                      child: MyHeaderText(_displayName ?? 'Unnamed')),
                  trailing: CupertinoButton(
                    onPressed: _avatarUri != null
                        ? () => openFullScreenImageViewer(context, _avatarUri!)
                        : null,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: UserAvatar(
                      size: 36,
                      avatarUri: _avatarUri,
                    ),
                  ),
                ),
                child: chat.StreamChat(
                  client: _streamChatClient,
                  streamChatThemeData: StreamService.theme(context),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: chat.MessageListView(
                          onMessageTap: (message) => print(message),
                          messageBuilder: (context, message, messages,
                              defaultMessageWidget) {
                            return defaultMessageWidget.copyWith(
                              onLinkTap: (link) => print(link),
                              onMessageActions: (context, message) =>
                                  print(message),
                              onAttachmentTap: (message, attachment) =>
                                  print('View, share, save options'),
                              showUserAvatar: chat.DisplayWidget.gone,
                              usernameBuilder: (context, message) => Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: MyText(
                                  _displayName ?? 'Unnamed',
                                  color: Styles.colorOne,
                                  size: FONTSIZE.SMALL,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      chat.MessageInput(),
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
