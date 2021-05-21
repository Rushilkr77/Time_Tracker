import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;
  void _updateuser(User user) {
    print("User id=${user.uid}");
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onsignin: _updateuser,
      );
    }
    return Container();
  }
}
