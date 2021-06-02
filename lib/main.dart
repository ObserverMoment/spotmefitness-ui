import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/move_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(kSettingsHiveBoxName);
  await Hive.openBox(GraphQLStore.boxName);

  /// TODO: Remove this before pushing anything to staging.
  Hive.box(GraphQLStore.boxName).clear();

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
  final AppRouter _appRouter = AppRouter();
  late Brightness _userDeviceBrightness;

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton<AuthBloc>(_authBloc);
    _userDeviceBrightness =
        SchedulerBinding.instance?.window.platformBrightness ?? Brightness.dark;
  }

  @override
  void dispose() {
    GetIt.I.unregister<AuthBloc>(
      instance: _authBloc,
      disposingFunction: (bloc) => bloc.dispose(),
    );
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthState>(
        valueListenable: GetIt.I<AuthBloc>().authState,
        builder: (context, authState, _) {
          final _authedUser = GetIt.I<AuthBloc>().authedUser;

          return MultiProvider(
            providers: [
              Provider(create: (_) => GraphQLStore()),
              ChangeNotifierProvider(create: (_) => MoveFiltersBloc()),
              ChangeNotifierProvider(create: (_) => WorkoutFiltersBloc()),
              ChangeNotifierProvider(
                  create: (_) =>
                      ThemeBloc(deviceBrightness: _userDeviceBrightness)),
            ],
            child: Builder(
                builder: (context) => _Unfocus(
                        child: CupertinoApp.router(
                      routeInformationParser: _appRouter.defaultRouteParser(
                          includePrefixMatches: true),
                      routerDelegate: AutoRouterDelegate.declarative(
                        _appRouter,
                        routes: (_) => [
                          // if the user is logged in, they may proceed to the main App
                          if (authState == AuthState.AUTHED &&
                              _authedUser != null)
                            AuthedRouter()
                          // if they are not logged in, bring them to the Login page
                          else
                            UnauthedLandingRoute(),
                        ],
                      ),
                      debugShowCheckedModeBanner: false,
                      theme: context.theme.cupertinoThemeData,
                      localizationsDelegates: [
                        DefaultMaterialLocalizations.delegate,
                        DefaultCupertinoLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: [
                        const Locale('en', 'US'),
                        const Locale('en', 'GB'),
                      ],
                    ))),
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
