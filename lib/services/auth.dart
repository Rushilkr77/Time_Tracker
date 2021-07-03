import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Newuser {
  final String uid;
  Newuser({this.uid});
}

abstract class Authbase {
  Future<Newuser> currentUser();
  Future<Newuser> signInAnonymously();
  Future<void> signOut();
  Stream<Newuser> get onAuthStateChanged;
  Future<Newuser> signInWithGoogle();
  Future<Newuser> signinwithemailandpass(String email, String password);
  Future<Newuser> createuserwithemailandpass(String email, String password);
}

class Auth implements Authbase {
  final _firebaseAuth = FirebaseAuth.instance;
  Newuser _userfromfirebase(User user) {
    if (user == null) return null;
    return Newuser(uid: user.uid);
  }

  @override
  Stream<Newuser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((_userfromfirebase));
  }

  @override
  Future<Newuser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userfromfirebase(user);
  }

  @override
  Future<Newuser> signInAnonymously() async {
    final authresult = await _firebaseAuth.signInAnonymously();
    return _userfromfirebase(authresult.user);
  }

  @override
  Future<Newuser> signinwithemailandpass(String email, String password) async {
    final authresult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userfromfirebase(authresult.user);
  }

  @override
  Future<Newuser> createuserwithemailandpass(
      String email, String password) async {
    final authresult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userfromfirebase(authresult.user);
  }

  @override
  Future<Newuser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleaccount = await googleSignIn.signIn();
    if (googleaccount != null) {
      final googleauth = await googleaccount.authentication;
      if (googleauth.accessToken != null && googleauth.idToken != null) {
        final authresult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleauth.idToken,
            accessToken: googleauth.accessToken,
          ),
        );
        return _userfromfirebase(authresult.user);
      } else {
        throw PlatformException(
          code: "Error Aborted By User",
          message: 'Missing token',
        );
      }
    } else {
      throw PlatformException(
        code: "Error Aborted By User",
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googlesignin = GoogleSignIn();
    await googlesignin.signOut();
    await _firebaseAuth.signOut();
  }
}
