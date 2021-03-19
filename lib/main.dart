import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/pages/authed/app.dart';
import 'package:spotmefitness_ui/pages/unauthed/unauthed_landing.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    GetIt.I.registerSingleton<AuthBloc>(_authBloc);

    super.initState();
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
          return FadeIn(
            child: authState == AuthState.AUTHED && _authedUser != null
                ? App(_authedUser)
                : UnAuthedLanding(),
          );
        });
  }
}
