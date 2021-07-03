import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker/services/auth.dart';

class Emailsigninbloc {
  BuildContext context;
  final Authbase auth;
  final StreamController<Emailsigninmodel> _modelcontroller =
      StreamController<Emailsigninmodel>();
  Emailsigninmodel _model = Emailsigninmodel();

  Emailsigninbloc({this.auth});
  Stream<Emailsigninmodel> get modelstream => _modelcontroller.stream;
  void dispose() {
    _modelcontroller.close();
  }

  Future<void> submit() async {
    updatewith(isloading: true, issubmitted: true);
    try {
      if (_model.formtype == Emailsigninformtype.signin) {
        await auth.signinwithemailandpass(_model.email, _model.password);
      } else {
        await auth.createuserwithemailandpass(_model.email, _model.password);
      }
    } catch (e) {
      updatewith(isloading: false);
      rethrow;
    }
  }

  void updateemail(String email) => updatewith(email: email);
  void updatepassword(String password) => updatewith(password: password);
  void toggleformtype() {
    final formtype = _model.formtype == Emailsigninformtype.signin
        ? Emailsigninformtype.register
        : Emailsigninformtype.signin;
    updatewith(
      email: '',
      password: '',
      formtype: formtype,
      isloading: false,
      issubmitted: false,
    );
  }

  void updatewith({
    String email,
    String password,
    Emailsigninformtype formtype,
    bool isloading,
    bool issubmitted,
  }) {
    _model = _model.copywith(
      email: email,
      password: password,
      formtype: formtype,
      isloading: isloading,
      submitted: issubmitted,
    );
    _modelcontroller.add(_model);
  }
}
