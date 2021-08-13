import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';

/// Chat and Feeds service from getStream.io
abstract class StreamService {
  static theme(BuildContext context) {
    final bool isDark = context.theme.brightness == Brightness.dark;
    final primary = context.theme.primary;
    final background = context.theme.background;
    final cardBackground = context.theme.cardBackground;

    return StreamChatThemeData(
      brightness: context.theme.brightness,
      primaryIconTheme: IconThemeData(color: primary),
      colorTheme: isDark
          ? ColorTheme.dark(
              accentPrimary: primary,
            )
          : ColorTheme.light(accentPrimary: primary),
      messageInputTheme: MessageInputTheme(
          inputTextStyle: GoogleFonts.sourceSansPro(),
          inputBackground: cardBackground),
      channelListViewTheme:
          ChannelListViewThemeData(backgroundColor: background),
      messageListViewTheme:
          MessageListViewThemeData(backgroundColor: background),
      channelTheme: ChannelTheme(
        channelHeaderTheme: ChannelHeaderTheme(
          color: background,
          title: GoogleFonts.archivo(textStyle: TextStyle(color: primary)),
          subtitle: GoogleFonts.sourceSansPro(),
        ),
      ),
    );
  }
}

/// Displays a button which updates depending on whether or not the authed users [user_timeline] feed is following the user with [otherUserId]s [user_feed].
/// Onpress it handles follow / unfollow functionality.
class UserFeedConnectionButton extends StatefulWidget {
  final String otherUserId;
  const UserFeedConnectionButton({Key? key, required this.otherUserId})
      : super(key: key);

  @override
  _UserFeedConnectionButtonState createState() =>
      _UserFeedConnectionButtonState();
}

class _UserFeedConnectionButtonState extends State<UserFeedConnectionButton> {
  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;

  late FlatFeed _authedUserTimeline;
  late FlatFeed _otherUserFeed;

  bool _isConnected = false;

  @override
  void initState() {
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;

    _authedUserTimeline =
        _streamFeedClient.flatFeed('user_timeline', _authedUser.id);
    _otherUserFeed =
        _streamFeedClient.flatFeed('user_feed', widget.otherUserId);

    _checkUserConnection();

    super.initState();
  }

  /// Does [_authedUserTimeline] follow [_otherUserFeed]?
  Future<void> _checkUserConnection() async {
    // Check if authed user follows [user_feed] of otherUser.
    final feed = await _authedUserTimeline.following(
        offset: 0,
        limit: 1,
        filter: [FeedId.id('user_feed:${widget.otherUserId}')]);

    setState(() {
      _isConnected = feed.isNotEmpty;
    });
  }

  Future<void> _followOtherUser() async {
    /// Optimistic: Assume succes and revert later if not.
    setState(() => _isConnected = true);
    try {
      // Follow feed without copying the activities:
      await _authedUserTimeline.follow(_otherUserFeed, activityCopyLimit: 0);
    } catch (e) {
      setState(() => _isConnected = false);
      context.showToast(
          toastType: ToastType.destructive,
          message: 'Sorry, there was a problem, please try again');
      print(e.toString());
    }
  }

  Future<void> _unfollowOtherUser() async {
    /// Optimistic: Assume succes and revert later if not.
    setState(() => _isConnected = false);

    try {
      // Unfollow feed but do not purge already received activities.
      await _authedUserTimeline.unfollow(_otherUserFeed, keepHistory: true);
    } catch (e) {
      setState(() => _isConnected = true);
      context.showToast(
          toastType: ToastType.destructive,
          message: 'Sorry, there was a problem, please try again');
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: kStandardAnimationDuration,
        child: _isConnected
            ? BorderButton(
                text: 'Following',
                onPressed: _unfollowOtherUser,
                backgroundColor: Styles.infoBlue,
                textColor: Styles.white)
            : BorderButton(
                prefix: Icon(
                  CupertinoIcons.person_add,
                  size: 15,
                ),
                text: 'Follow',
                onPressed: _followOtherUser));
  }
}
