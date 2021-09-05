import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/stream.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:collection/collection.dart';

class ClubMembersChatPage extends StatefulWidget {
  final String clubId;
  const ClubMembersChatPage({Key? key, required this.clubId}) : super(key: key);

  @override
  _ClubMembersChatPageState createState() => _ClubMembersChatPageState();
}

class _ClubMembersChatPageState extends State<ClubMembersChatPage> {
  late chat.StreamChatClient _streamChatClient;
  late chat.Channel _channel;
  late bool _channelReady = false;
  late Club _club;

  @override
  void initState() {
    super.initState();
    _streamChatClient = context.streamChatClient;

    _initGetStreamChat();
  }

  Future<void> _initGetStreamChat() async {
    try {
      /// Get club and club member data.
      final result = await context.graphQLStore
          .networkOnlyOperation<ClubById$Query, ClubByIdArguments>(
              operation: ClubByIdQuery(
                  variables: ClubByIdArguments(id: widget.clubId)));

      if (result.hasErrors || result.data == null) {
        throw Exception('Could not retrieve Club data for this chat.');
      } else {
        _club = result.data!.clubById;
      }

      /// Create / watch a channel consisting of the authed user and the 'other user.
      /// This type of channel is always just these two users. More users cannot be added.
      _channel =
          _streamChatClient.channel(kClubMembersChannelName, id: widget.clubId);

      await _channel.watch();

      setState(() => _channelReady = true);
    } catch (e) {
      print(e);
      context.showToast(message: 'There was a problem setting up chat!');
    }
  }

  String _getUserNameFromStreamId(String? id) {
    if (id == null) {
      return 'Unknown';
    }
    if (_club.owner.id == id) {
      return '${_club.owner.displayName} (Owner)';
    }
    final admin = _club.admins.firstWhereOrNull((a) => a.id == id);
    if (admin != null) {
      return '${admin.displayName} (Admin)';
    }
    final member = _club.members.firstWhereOrNull((m) => m.id == id);
    if (member != null) {
      return member.displayName;
    }
    return 'Non-member';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kStandardAnimationDuration,
      child: _channelReady
          ? chat.StreamChannel(
              channel: _channel,
              child: CupertinoPageScaffold(
                navigationBar: MyNavBar(
                  middle: Column(
                    children: [
                      NavBarTitle('Club Chat'),
                      MyText(
                        '${_club.totalMembers} members',
                        size: FONTSIZE.SMALL,
                        subtext: true,
                        lineHeight: 1.4,
                      )
                    ],
                  ),
                  trailing: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Utils.textNotNull(_club.coverImageUri)
                            ? UserAvatar(
                                size: 40,
                                avatarUri: _club.coverImageUri!,
                              )
                            : Container(
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.asset(
                                  'assets/social_images/group_placeholder.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ],
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              onLinkTap: (link) => print(link),
                              onMessageActions: (context, message) =>
                                  print(message),
                              onAttachmentTap: (message, attachment) =>
                                  print('View, share, save options'),
                              showUserAvatar: chat.DisplayWidget.gone,
                              usernameBuilder: (context, message) => Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: MyText(
                                  _getUserNameFromStreamId(message.user?.id),
                                  color: Styles.colorOne,
                                  size: FONTSIZE.SMALL,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      chat.MessageInput(
                        showCommandsButton: false,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : MyPageScaffold(
              navigationBar: MyNavBar(
                middle: NavBarTitle('Loading Chat...'),
              ),
              child: LoadingCircle()),
    );
  }
}
