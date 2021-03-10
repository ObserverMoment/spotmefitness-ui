import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/screens/authed/app.dart';
import 'package:spotmefitness_ui/screens/unauthed/unauthed_landing.dart';
import 'package:spotmefitness_ui/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.I.registerSingleton<AuthService>(AuthService());
  runApp(AuthRouter());
}

class AuthRouter extends StatefulWidget {
  @override
  _AuthRouterState createState() => _AuthRouterState();
}

class _AuthRouterState extends State<AuthRouter> {
  String? _authedFirebaseUid;
  @override
  void initState() {
    _authedFirebaseUid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _authedFirebaseUid = user?.uid;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _authedFirebaseUid != null
        ? App(_authedFirebaseUid)
        : UnAuthedLanding();
  }
}
