import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_manager.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/common_widgets/alert_dialogs.dart';
import '../../services/auth.dart';
import 'social_sign_in_button.dart';
import 'dart:async';

class SignInPage extends StatelessWidget {
  final Signinmanager manager;
  final bool isloading;

  SignInPage({Key key, @required this.manager, this.isloading})
      : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<Authbase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (context) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (context, isloading, __) => Provider<Signinmanager>(
          create: (_) => Signinmanager(auth: auth, isloading: isloading),
          child: Consumer<Signinmanager>(
            builder: (context, manager, _) => SignInPage(
              manager: manager,
              isloading: isloading.value,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } catch (e) {
      Platformalertdailog(
        title: 'Sign in failed',
        content: e.toString(),
        defaultactiontext: "OK",
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } catch (e) {
      Platformalertdailog(
        title: 'Sign in failed',
        content: e.toString(),
        defaultactiontext: "OK",
      );
    }
  }

  void _signinwithemail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) {
          return Emailsigninpage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildheader(),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: "Sign in with Google",
            assetname: "images/google-logo.png",
            textcolor: Colors.black87,
            color: Colors.white,
            onpressed: isloading ? null : () => _signInWithGoogle(context),
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
            onpressed: () {
              _signinwithemail(context);
            },
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
            onpressed: isloading ? null : () => _signInAnonymously(context),
          )
        ],
      ),
    );
  }

  Widget _buildheader() {
    if (isloading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
