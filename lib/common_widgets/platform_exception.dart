// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:time_tracker/common_widgets/alert_dialogs.dart';

// class Platformexceptiondialog extends Platformalertdailog {
//   final String title;
//   final PlatformException exception;

//   Platformexceptiondialog({this.title, this.exception})
//       : super(
//           title: title,
//           content: _message(exception),
//           defaultactiontext: "OK",
//         );
//   static String _message(PlatformException exception) {
//     return _errors[exception.code]?? exception.message;
//   }
//   static Map<String,String> _errors={
//     /// - **email-already-in-use**:
//   ///  - Thrown if there already exists an account with the given email address.
//   /// - **invalid-email**:
//   ///  - Thrown if the email address is not valid.
//   /// - **operation-not-allowed**:
//   ///  - Thrown if email/password accounts are not enabled. Enable
//   ///    email/password accounts in the Firebase Console, under the Auth tab.
//   /// - **weak-password**:
//   ///  - Thrown if the password is not strong enough.
//   ///  - **invalid-email**:
//   ///  - Thrown if the email address is not valid.
//   /// - **user-disabled**:
//   ///  - Thrown if the user corresponding to the given email has been disabled.
//   /// - **user-not-found**:
//   ///  - Thrown if there is no user corresponding to the given email.
//       'ERROR_WRONG_PASSWORD':'wrong-password',

//   };

// }
