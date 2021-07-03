import 'package:time_tracker/app/sign_in/validators.dart';

enum Emailsigninformtype { signin, register }

class Emailsigninmodel with Emailandpasswordvalidators {
  final String email;
  final String password;
  final Emailsigninformtype formtype;
  final bool isloading;
  final bool submitted;

  Emailsigninmodel(
      {this.email = '',
      this.password = '',
      this.formtype = Emailsigninformtype.signin,
      this.isloading = false,
      this.submitted = false});

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

  Emailsigninmodel copywith({
    String email,
    String password,
    Emailsigninformtype formtype,
    bool isloading,
    bool submitted,
  }) {
    return Emailsigninmodel(
      email: email ?? this.email,
      password: password ?? this.password,
      formtype: formtype ?? this.formtype,
      isloading: isloading ?? this.isloading,
      submitted: submitted ?? this.submitted,
    );
  }
}
