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

/// https://github.com/Milad-Akarie/auto_route_library/issues/418
/// Creates and provides all the global objects required on a user is logged in.
class AuthedRoutesWrapperPage extends StatefulWidget {
  @override
  _AuthedRoutesWrapperPageState createState() =>
      _AuthedRoutesWrapperPageState();
}

class _AuthedRoutesWrapperPageState extends State<AuthedRoutesWrapperPage> {
  late chat.StreamChatClient _streamChatClient;
  late chat.OwnUser _streamChatUser;
  bool _chatInitialized = false;

  @override
  void initState() {
    super.initState();
    _streamChatClient = _createStreamChatClient;
    _connectUserToChat();
  }

  chat.StreamChatClient get _createStreamChatClient => chat.StreamChatClient(
        EnvironmentConfig.getStreamPublicKey,
      );

  Future<void> _connectUserToChat() async {
    try {
      _streamChatUser = await _streamChatClient.connectUser(
        chat.User(id: GetIt.I<AuthBloc>().authedUser!.id),
        GetIt.I<AuthBloc>().authedUser!.streamChatToken,
      );
      setState(() {
        _chatInitialized = true;
      });
    } catch (e) {
      print(e);
      context.showToast(message: "Oops, couldn't initialize chat!");
      GetIt.I<AuthBloc>().signOut();
    }
  }

  feed.StreamFeedClient get _createStreamFeedClient =>
      feed.StreamFeedClient.connect(
        EnvironmentConfig.getStreamPublicKey,
        appId: EnvironmentConfig.getStreamAppId,
        token: feed.Token(
          GetIt.I<AuthBloc>().authedUser!.streamFeedToken,
        ),
      );

  @override
  void dispose() async {
    super.dispose();
    await _streamChatClient.disconnectUser();
    await _streamChatClient.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chatInitialized
        ? MultiProvider(
            providers: [
              Provider<GraphQLStore>(
                create: (_) => GraphQLStore(),
                dispose: (context, store) => store.dispose(),
              ),
              Provider<feed.StreamFeedClient>(
                create: (_) => _createStreamFeedClient,
              ),
              Provider<chat.StreamChatClient>.value(
                value: _streamChatClient,
              ),
              Provider<chat.OwnUser>.value(
                value: _streamChatUser,
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
