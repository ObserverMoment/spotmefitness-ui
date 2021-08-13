import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/move_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_plan_filters_bloc.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'package:stream_feed/stream_feed.dart' as feed;

/// https://github.com/Milad-Akarie/auto_route_library/issues/418
/// Creates and provides all the global objects required on a user is logged in.
class AuthedRoutesWrapperPage extends StatefulWidget {
  @override
  _AuthedRoutesWrapperPageState createState() =>
      _AuthedRoutesWrapperPageState();
}

class _AuthedRoutesWrapperPageState extends State<AuthedRoutesWrapperPage> {
  chat.StreamChatClient get _createStreamChatClient => chat.StreamChatClient(
        EnvironmentConfig.getStreamPublicKey,
        // https://getstream.io/chat/docs/react/multi_region/?language=dart
        location: chat.Location.euWest,
      );

  feed.StreamFeedClient get _createStreamFeedClient =>
      feed.StreamFeedClient.connect(EnvironmentConfig.getStreamPublicKey,
          token: feed.Token(GetIt.I<AuthBloc>().authedUser!.streamFeedToken));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GraphQLStore>(
          create: (_) => GraphQLStore(),
          dispose: (context, store) => store.dispose(),
        ),
        Provider<chat.StreamChatClient>(
          create: (_) => _createStreamChatClient,
          dispose: (context, client) => client.dispose(),
        ),
        Provider<feed.StreamFeedClient>(
          create: (_) => _createStreamFeedClient,
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
    );
  }
}
