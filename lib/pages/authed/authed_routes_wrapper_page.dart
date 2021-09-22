import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sofie_ui/blocs/auth_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/indicators.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/env_config.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:stream_feed/src/client/notification_feed.dart';
import 'package:stream_feed/stream_feed.dart' as feed;
import 'package:stream_feed/stream_feed.dart';

/// https://github.com/Milad-Akarie/auto_route_library/issues/418
/// Creates and provides all the global objects required on a user is logged in.
class AuthedRoutesWrapperPage extends StatefulWidget {
  const AuthedRoutesWrapperPage({Key? key}) : super(key: key);

  @override
  _AuthedRoutesWrapperPageState createState() =>
      _AuthedRoutesWrapperPageState();
}

class _AuthedRoutesWrapperPageState extends State<AuthedRoutesWrapperPage> {
  late AuthedUser _authedUser;
  late chat.StreamChatClient _streamChatClient;
  late chat.OwnUser _streamChatUser;
  bool _chatInitialized = false;
  late feed.StreamFeedClient _streamFeedClient;
  late NotificationFeed _notificationFeed;
  late Subscription _feedSubscription;
  bool _feedsInitialized = false;

  @override
  void initState() {
    super.initState();
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamChatClient = _createStreamChatClient;
    _streamFeedClient = _createStreamFeedClient;
    _connectUserToChat().then((_) => _initFeeds());
  }

  chat.StreamChatClient get _createStreamChatClient => chat.StreamChatClient(
        EnvironmentConfig.getStreamPublicKey,
      );

  Future<void> _connectUserToChat() async {
    try {
      _streamChatUser = await _streamChatClient.connectUser(
        chat.User(id: _authedUser.id),
        _authedUser.streamChatToken,
      );

      /// Add the users device to Stream backend.
      /// https://getstream.io/chat/docs/sdk/flutter/guides/adding_push_notifications/#registering-a-device-at-stream-backend
      // FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      //   _streamChatClient.addDevice(token, PushProvider.firebase);
      // });

      setState(() {
        _chatInitialized = true;
      });
    } catch (e) {
      printLog(e.toString());
      context.showToast(message: e.toString());
      context.showToast(message: "Oops, couldn't initialize chat! $e");
    }
  }

  feed.StreamFeedClient get _createStreamFeedClient =>
      feed.StreamFeedClient.connect(
        EnvironmentConfig.getStreamPublicKey,
        appId: EnvironmentConfig.getStreamAppId,
        logLevel: feed.Level.OFF,
        token: feed.Token(
          _authedUser.streamFeedToken,
        ),
      );

  Future<void> _initFeeds() async {
    try {
      /// Set the user on the feed client.
      await _streamFeedClient.setUser({});

      /// Set up the notification feed.
      _notificationFeed = _streamFeedClient.notificationFeed(
          kUserNotificationName, _authedUser.id);

      _feedSubscription =
          await _notificationFeed.subscribe(_handleNotification);

      setState(() {
        _feedsInitialized = true;
      });
    } catch (e) {
      printLog(e.toString());
      context.showToast(message: e.toString());
      context.showToast(message: "Oops, couldn't initialize notifications! $e");
    }
  }

  Future<void> _handleNotification(feed.RealtimeMessage? message) async {
    final _message =
        message?.newActivities[0].object?.data.toString() ?? 'No message';
    context.showNotification(
        title: 'Notification',
        onPressed: () => printLog('printLog a test'),
        message: _message);
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _feedSubscription.cancel();
    await _streamChatClient.disconnectUser();
    await _streamChatClient.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chatInitialized && _feedsInitialized
        ? MultiProvider(
            providers: [
              Provider<chat.StreamChatClient>.value(
                value: _streamChatClient,
              ),
              Provider<chat.OwnUser>.value(
                value: _streamChatUser,
              ),
              Provider<feed.StreamFeedClient>.value(
                value: _streamFeedClient,
              ),
              Provider<NotificationFeed>.value(
                value: _notificationFeed,
              ),
            ],
            child: HeroControllerScope(
              controller: HeroController(),
              child: const AutoRouter(),
            ),
          )
        : const _InitAppLanding();
  }
}

class _InitAppLanding extends StatelessWidget {
  const _InitAppLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenHeight = constraints.maxHeight;
      return CupertinoPageScaffold(
          child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SizedBox.expand(
              child: Image.asset(
            'assets/stock_images/stretch.jpg',
            fit: BoxFit.fitHeight,
          )),
          Positioned(
            top: screenHeight * 0.16,
            child: SvgPicture.asset(
              'assets/logos/sofie_logo.svg',
              width: 50,
              color: Styles.white,
            ),
          ),
          Positioned(
            top: screenHeight * 0.30,
            child: Column(
              children: const [
                MyText(
                  'Getting ready',
                  color: Styles.white,
                ),
                SizedBox(height: 24),
                LoadingDots(
                  color: Styles.white,
                )
              ],
            ),
          ),
        ],
      ));
    });
  }
}
