import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/common_widgets/custom_raised_button.dart';
import 'social_sign_in_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({this.onsignin});
  final Function(User) onsignin;
  Future<void> _signInAnonymously() async {
    try {
      final authresult = await FirebaseAuth.instance.signInAnonymously();
      onsignin(authresult.user);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: "Sign in with Google",
            assetname: "images/google-logo.png",
            textcolor: Colors.black87,
            color: Colors.white,
            onpressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign in with Facebook",
            assetname: "images/facebook-logo.png",
            textcolor: Colors.white,
            color: Color(0xFF334D92),
            onpressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Sign in with email",
            textcolor: Colors.black87,
            color: Colors.teal[700],
            onpressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "or",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Go Anonymous",
            textcolor: Colors.black87,
            color: Colors.lime[300],
            onpressed: _signInAnonymously,
          )
        ],
      ),
    );
  }
}
