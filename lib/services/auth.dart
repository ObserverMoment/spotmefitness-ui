import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:spotmefitness_ui/env_config.dart';

class AuthService {
  FirebaseAuth get firebaseClient => FirebaseAuth.instance;
  FirebaseAuth _firebaseClient = FirebaseAuth.instance;

  Future<String> getIdToken() async {
    if (_firebaseClient.currentUser != null) {
      String _token = await _firebaseClient.currentUser!.getIdToken(true);
      return _token;
    } else {
      // Force sign out to clear any stale user data or tokens. Necessary?
      await _firebaseClient.signOut();
      throw AssertionError(
          'There is no currently authed user, so a token was not able to be retrieved.');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseClient.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential _user = await _firebaseClient
          .createUserWithEmailAndPassword(email: email, password: password);

      if (_user.user?.uid != null) {
        final _token = await _user.user!.getIdToken();
        // TODO: If local - use http - else use https.
        final _res = await http.post(
          EnvironmentConfig.getRegisterEndpoint(),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            HttpHeaders.authorizationHeader: 'Bearer $_token'
          },
        );
        print(_res);
      } else {
        print(
            '_user?.uid was null - no user was returned by registerWithEmailAndPassword');
        throw new Exception('Sorry, there was an issue registering.');
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw new Exception(e.message);
    } catch (e) {
      print(e.toString());
      throw new Exception(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseClient.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseClient.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
