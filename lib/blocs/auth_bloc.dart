import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:http/http.dart' as http;
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

enum AuthState { UNAUTHED, AUTHED, REGISTERING, VALIDATING, ERROR }

class AuthedUser {
  String id;
  String? avatarUri;
  bool hasOnboarded;
  ThemeName themeName;

  AuthedUser(
      {required this.id,
      this.avatarUri,
      required this.hasOnboarded,
      required this.themeName});

  factory AuthedUser.fromJson(Map<String, dynamic> json) {
    return AuthedUser(
        id: json['id'],
        avatarUri: json['avatarUri'],
        hasOnboarded: json['hasOnboarded'],
        themeName:
            json['themeName'] == 'DARK' ? ThemeName.dark : ThemeName.light);
  }
}

/// Only ever register this as a global singleton via Get.It. Do not instantiate multiple times.
class AuthBloc {
  FirebaseAuth _firebaseClient = FirebaseAuth.instance;
  bool _firebaseAuthed = false;
  AuthedUser? _authedUser;
  int _validationAttempts = 0;
  int _maxFailedAttempts = 10;

  AuthBloc() {
    _firebaseClient.authStateChanges().listen((User? user) async {
      if (user?.uid != null) {
        _firebaseAuthed = true;
        if (_authedUser?.id == null) {
          if (![AuthState.REGISTERING, AuthState.VALIDATING]
              .contains(authState.value)) {
            await validateUserAgainstFirebaseUid();
          }
        }
      } else {
        _firebaseAuthed = false;
        _authedUser = null;
        authState.value = AuthState.UNAUTHED;
      }
    });
  }

  AuthedUser? get authedUser => _authedUser;
  ValueNotifier<AuthState> authState = ValueNotifier(AuthState.UNAUTHED);

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      authState.value = AuthState.REGISTERING;
      UserCredential _user = await _firebaseClient
          .createUserWithEmailAndPassword(email: email, password: password);

      if (_user.user?.uid != null) {
        final _token = await getIdToken();
        final _endpoint = EnvironmentConfig.getRestApiEndpoint('user/register');

        final _res = await http.post(
          _endpoint,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $_token'},
        );

        String _body = _res.body;
        Map<String, dynamic> _json = jsonDecode(_body);

        if (_json['id'] != null) {
          _authedUser = AuthedUser.fromJson(_json);
        } else {
          print(
              'No valid user ID was returned when trying to register a new user.');
          _authedUser = null;
          throw new Exception('Sorry, there was an issue registering.');
        }
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
    } finally {
      await _checkAuthStatus();
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseClient.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw new Exception(e.message);
    } catch (e) {
      print(e.toString());
      throw new Exception(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw new Exception(e.message);
    } catch (e) {
      print(e.toString());
      throw new Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseClient.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw new Exception(e.message);
    } catch (e) {
      print(e.toString());
      throw new Exception(e);
    }
  }

  Future<String> getIdToken() async {
    if (_firebaseClient.currentUser != null) {
      try {
        String _token = await _firebaseClient.currentUser!.getIdToken(true);
        return _token;
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        throw new Exception(e.message);
      } catch (e) {
        print(e.toString());
        throw new Exception(e);
      }
    } else {
      // Force sign out to clear any stale user data or tokens. Necessary?
      await _firebaseClient.signOut();
      throw AssertionError(
          'There is no currently authed user, so a token was not able to be retrieved.');
    }
  }

  Future<void> validateUserAgainstFirebaseUid() async {
    authState.value = AuthState.VALIDATING;
    final _token = await getIdToken();
    final _endpoint = EnvironmentConfig.getRestApiEndpoint('user/current');

    final _res = await http.post(
      _endpoint,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $_token'},
    );

    String _body = _res.body;
    Map<String, dynamic> _json = jsonDecode(_body);

    if (_json['id'] != null) {
      _authedUser = AuthedUser.fromJson(_json);
    } else {
      print(
          'No valid user ID was returned when trying to register a new user.');
      _authedUser = null;
    }
    await _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    if (_validationAttempts > _maxFailedAttempts) {
      print('Too many failed attempts to validate the user. Signing out.');
      await signOut();
      _validationAttempts = 0;
    } else if (_firebaseAuthed && _authedUser?.id != null) {
      authState.value = AuthState.AUTHED;
      _validationAttempts = 0;
    } else if (!_firebaseAuthed && _authedUser?.id == null) {
      authState.value = AuthState.UNAUTHED;
      _validationAttempts = 0;
    } else if (_firebaseAuthed && _authedUser?.id == null) {
      // Try and validate the user based on the firebase auth, if not already.
      if (![AuthState.REGISTERING, AuthState.VALIDATING]
          .contains(authState.value)) {
        authState.value = AuthState.VALIDATING;
        _validationAttempts++;
        await validateUserAgainstFirebaseUid();
      }
    } else if (!_firebaseAuthed && _authedUser?.id != null) {
      print(
          'Should not be possible for an AuthUser to be present when firebase is not authed. Signing out.');
      await signOut();
      _validationAttempts = 0;
    }
  }

  void dispose() {
    authState.dispose();
  }
}
