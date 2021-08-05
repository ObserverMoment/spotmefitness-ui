import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Opens a chat overview page for the currently logged in User.
class ChatsOverviewPage extends StatefulWidget {
  const ChatsOverviewPage({Key? key}) : super(key: key);

  @override
  _ChatsOverviewPageState createState() => _ChatsOverviewPageState();
}

class _ChatsOverviewPageState extends State<ChatsOverviewPage> {
  late AuthedUser? _authedUser;
  late StreamChatClient _streamChatClient;
  bool _tokenError = false;
  OwnUser? _streamUser;

  @override
  void initState() {
    super.initState();
    _authedUser = GetIt.I<AuthBloc>().authedUser;
    _streamChatClient = GetIt.I<StreamChatClient>();

    if (_authedUser?.streamChatToken == null) {
      _tokenError == true;
    } else {
      _initGetStreamChat();
    }
  }

  Future<void> _initGetStreamChat() async {
    try {
      _streamUser = await _streamChatClient.connectUser(
        User(id: _authedUser!.id),
        _authedUser!.streamChatToken,
      );
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _streamChatClient.disconnectUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return m.Material(
      child: CupertinoPageScaffold(
        navigationBar: BorderlessNavBar(
          middle: NavBarTitle('Chats'),
        ),
        child: StreamChat(
          streamChatThemeData:
              StreamChatThemeData(brightness: context.theme.brightness),
          client: _streamChatClient,
          child: ChannelsBloc(
            child: ChannelListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              filter: _streamUser != null
                  ? Filter.in_(
                      'members',
                      [_streamUser!.id],
                    )
                  : null,
              sort: const [SortOption('last_message_at')],
              pagination: const PaginationParams(
                limit: 20,
              ),
              channelWidget: ChannelPage(streamChatClient: _streamChatClient),
            ),
          ),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  final StreamChatClient streamChatClient;
  const ChannelPage({
    Key? key,
    required this.streamChatClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.theme.brightness == Brightness.dark;
    final primary = context.theme.primary;
    final background = context.theme.background;
    final cardBackground = context.theme.cardBackground;

    return CupertinoPageScaffold(
      child: StreamChat(
        client: streamChatClient,
        streamChatThemeData: StreamChatThemeData(
          brightness: context.theme.brightness,
          colorTheme: isDark
              ? ColorTheme.dark(
                  accentPrimary: primary,
                )
              : ColorTheme.light(accentPrimary: primary),
          messageInputTheme: MessageInputTheme(
              inputTextStyle: GoogleFonts.sourceSansPro(),
              inputBackground: cardBackground),
          messageListViewTheme:
              MessageListViewThemeData(backgroundColor: background),
          channelTheme: ChannelTheme(
            channelHeaderTheme: ChannelHeaderTheme(
              color: background,
              title: GoogleFonts.archivo(textStyle: TextStyle(color: primary)),
              subtitle: GoogleFonts.sourceSansPro(),
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const ChannelHeader(
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: NavBarBackButton(),
                ),
              ),
              Expanded(
                child: MessageListView(),
              ),
              MessageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
