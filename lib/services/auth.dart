import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

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
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseClient.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseClient.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseClient.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
