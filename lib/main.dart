import 'package:artemis/client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/app.dart';
import 'package:spotmefitness_ui/pages/unauthed/unauthed_landing.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('graphql_cache');
  await Hive.openBox(kSettingsHiveBoxName);

  // final cache = Hive.box(HiveStore.defaultBoxName);

  // for (String key in cache.keys) {
  //   // print(key);
  //   if (key == 'Query') {
  //     print(cache.get(key));
  //   }
  //   if (key.contains('Workout:')) {
  //     print(key);
  //     print(cache.get(key));
  //   }
  // }

  await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // Default to light initially - this needs to be updated to dark if the user selects light theme.
    statusBarIconBrightness: Brightness.light,
  ));

  // Global services that have no deps.
  GetIt.I.registerSingleton<UploadcareService>(UploadcareService());

  runApp(AuthRouter());
}

class AuthRouter extends StatefulWidget {
  @override
  _AuthRouterState createState() => _AuthRouterState();
}

class _AuthRouterState extends State<AuthRouter> {
  final AuthBloc _authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton<AuthBloc>(_authBloc);
    test();
  }

  void test() async {
    final HttpLink _httpLink = HttpLink(
      EnvironmentConfig.graphqlEndpoint,
    );

    final AuthLink _authLink = AuthLink(
        getToken: () async =>
            'Bearer ${await GetIt.I<AuthBloc>().getIdToken()}');

    final Link _link = _authLink.concat(_httpLink);

    final artemisClient = ArtemisClient.fromLink(_link);

    final result = await artemisClient.execute(UserWorkoutsQuery());
    print(result.data?.userWorkouts);
    final authedUser = await artemisClient.execute(AuthedUserQuery());
    print(authedUser.data?.authedUser);

    /// Nice!
    final result2 = await artemisClient.execute(UpdateWorkoutMoveMutation(
        variables: UpdateWorkoutMoveArguments(
            data: UpdateWorkoutMoveInput(id: '72728'))));
    print(result2.data?.updateWorkoutMove);

    /// Keep in mind this will not close clients whose Artemis client
    /// was instantiated from [ArtemisClient.fromLink]. If you're using
    /// this constructor, you need to close your own links.
    /// ...like so.
    _httpLink.dispose();

    artemisClient.dispose();
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthState>(
        valueListenable: GetIt.I<AuthBloc>().authState,
        builder: (context, authState, _) {
          final _authedUser = GetIt.I<AuthBloc>().authedUser;
          return _Unfocus(
            child: FadeIn(
              child: authState == AuthState.AUTHED && _authedUser != null
                  ? App(_authedUser)
                  : ChangeNotifierProvider(
                      create: (_) => ThemeBloc(isLanding: true),
                      builder: (context, child) => CupertinoApp(
                          theme: context.theme.cupertinoThemeData,
                          home: UnAuthedLanding()),
                    ),
            ),
          );
        });
  }
}

/// A widget that unfocus everything when tapped.
///
/// This implements the "Unfocus when tapping in empty space" behavior for the
/// entire application.
class _Unfocus extends StatelessWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
