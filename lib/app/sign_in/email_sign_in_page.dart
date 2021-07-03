import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_In_change_notifier.dart';

class Emailsigninpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: Emailsigninformchangenotifier.create(context),
          ),
        ),
      ),
    );
  }
}
