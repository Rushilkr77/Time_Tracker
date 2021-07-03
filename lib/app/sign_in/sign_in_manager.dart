import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_tracker/services/auth.dart';

class Signinmanager {
  final Authbase auth;
  final ValueNotifier<bool> isloading;

  Signinmanager({this.auth, this.isloading});

  Future<Newuser> _signin(Future<Newuser> Function() signinmethod) async {
    try {
      isloading.value = true;
      await signinmethod();
    } catch (e) {
      isloading.value = false;
    }
  }

  Future<Newuser> signInAnonymously() async =>
      await _signin(auth.signInAnonymously);

  Future<Newuser> signInWithGoogle() async =>
      await _signin(auth.signInWithGoogle);
}
