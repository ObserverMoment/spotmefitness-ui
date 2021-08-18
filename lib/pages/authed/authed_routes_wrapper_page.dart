import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/move_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_plan_filters_bloc.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:stream_feed/stream_feed.dart' as feed;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:stream_feed/src/client/notification_feed.dart';
import 'package:faye_dart/src/subscription.dart';

/// https://github.com/Milad-Akarie/auto_route_library/issues/418
/// Creates and provides all the global objects required on a user is logged in.
class AuthedRoutesWrapperPage extends StatefulWidget {
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
    _connectUserToChat().then((_) => _initNotificationFeed());
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
      setState(() {
        _chatInitialized = true;
      });
    } catch (e) {
      print(e);
      context.showToast(message: "Oops, couldn't initialize chat!");
      throw Exception(e);
    }
  }

  feed.StreamFeedClient get _createStreamFeedClient =>
      feed.StreamFeedClient.connect(
        EnvironmentConfig.getStreamPublicKey,
        appId: EnvironmentConfig.getStreamAppId,
        token: feed.Token(
          _authedUser.streamFeedToken,
        ),
      );

  Future<void> _initNotificationFeed() async {
    try {
      _notificationFeed = _streamFeedClient.notificationFeed(
          'user_notification', _authedUser.id);

      _feedSubscription =
          await _notificationFeed.subscribe(_handleNotification);

      setState(() {
        _feedsInitialized = true;
      });
    } catch (e) {
      print(e);
      context.showToast(message: "Oops, couldn't initialize notifications!");
      throw Exception(e);
    }
  }

  Future<void> _handleNotification(feed.RealtimeMessage? message) async {
    print('notification received');
    print('TODO: Handle further processing');
    print(message);
    context.showNotification(
        title: 'Notification',
        onPressed: () => print('print a test'),
        message: message!.newActivities[0].object!.data.toString());
  }

  @override
  void dispose() async {
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
              Provider<GraphQLStore>(
                create: (_) => GraphQLStore(),
                dispose: (context, store) => store.dispose(),
              ),
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
              ChangeNotifierProvider<MoveFiltersBloc>(
                  create: (_) => MoveFiltersBloc()),
              ChangeNotifierProvider<WorkoutFiltersBloc>(
                  create: (_) => WorkoutFiltersBloc()),
              ChangeNotifierProvider<WorkoutPlanFiltersBloc>(
                  create: (_) => WorkoutPlanFiltersBloc()),
            ],
            child: HeroControllerScope(
              controller: HeroController(),
              child: AutoRouter(),
            ),
          )
        : _InitAppLanding();
  }
}

class _InitAppLanding extends StatelessWidget {
  const _InitAppLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
              child: Image.asset(
            'assets/stock_images/stretch.jpg',
            fit: BoxFit.fitHeight,
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logos/spotme_logo.svg',
                width: 60.0,
                color: Styles.white,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: MyText(
                  'Getting ready',
                  color: Styles.white,
                ),
              ),
              LoadingDots(
                color: Styles.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
