import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/services/auth.dart';

import 'email_sign_in_model.dart';

class Emailsigninchangemodel with Emailandpasswordvalidators, ChangeNotifier {
  String email;
  String password;
  Emailsigninformtype formtype;
  bool isloading;
  bool submitted;
  final Authbase auth;

  Emailsigninchangemodel(
      {this.email = '',
      this.auth,
      this.password = '',
      this.formtype = Emailsigninformtype.signin,
      this.isloading = false,
      this.submitted = false});
  Future<void> submit() async {
    updatewith(isloading: true, submitted: true);
    try {
      if (formtype == Emailsigninformtype.signin) {
        await auth.signinwithemailandpass(email, password);
      } else {
        await auth.createuserwithemailandpass(email, password);
      }
    } catch (e) {
      updatewith(isloading: false);
      rethrow;
    }
  }

  void updateemail(String email) => updatewith(email: email);
  void updatepassword(String password) => updatewith(password: password);

  String get primarytext {
    return formtype == Emailsigninformtype.signin
        ? "Sign in"
        : "Create an account";
  }

  String get secondarytext {
    return formtype == Emailsigninformtype.signin
        ? "Need an account? Register"
        : "Have an account? sign in";
  }

  bool get cansubmit {
    return emailvalidator.isvalid(email) &&
        passwordvalidator.isvalid(password) &&
        !isloading;
  }

  String get invalidpassworderrortext {
    bool showerrortext = submitted && !passwordvalidator.isvalid(password);
    return showerrortext ? invalidpassworderrortext : null;
  }

  String get invalidemailerrortext {
    bool showerrortext = submitted && !emailvalidator.isvalid(email);
    return showerrortext ? invalidemailerrortext : null;
  }

  void toggleformtype() {
    final formtype = this.formtype == Emailsigninformtype.signin
        ? Emailsigninformtype.register
        : Emailsigninformtype.signin;
    updatewith(
      email: '',
      password: '',
      formtype: formtype,
      isloading: false,
      submitted: false,
    );
  }

  void updatewith({
    String email,
    String password,
    Emailsigninformtype formtype,
    bool isloading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formtype = formtype ?? this.formtype;
    this.isloading = isloading ?? this.isloading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
