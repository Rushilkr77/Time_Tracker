import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/common_widgets/platform_exception.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/common_widgets/alert_dialogs.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';

import 'email_sign_in_model.dart';

class Emailsigninformstateful extends StatefulWidget
    with Emailandpasswordvalidators {
  @override
  _EmailsigninformstatefulState createState() =>
      _EmailsigninformstatefulState();
}

class _EmailsigninformstatefulState extends State<Emailsigninformstateful> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FocusNode _emailfocusnode = FocusNode();
  final FocusNode _passwordfocusnode = FocusNode();
  String get _email => _emailcontroller.text;
  String get _password => _passwordcontroller.text;
  Emailsigninformtype _formtype = Emailsigninformtype.signin;
  bool _submitted = false;
  bool _isloading = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _emailfocusnode.dispose();
    _passwordfocusnode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
      _isloading = true;
    });
    try {
      final auth = Provider.of<Authbase>(context, listen: false);

      if (_formtype == Emailsigninformtype.signin) {
        await auth.signinwithemailandpass(_email, _password);
      } else {
        await auth.createuserwithemailandpass(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      Platformalertdailog(
              title: 'Sign in failed',
              content: e.toString(),
              defaultactiontext: 'OK')
          .show(context);
    } finally {
      _isloading = false;
    }
  }

  void _emaileditingcomplete() {
    final newfocus = widget.emailvalidator.isvalid(_email)
        ? _passwordfocusnode
        : _emailfocusnode;
    FocusScope.of(context).requestFocus(newfocus);
  }

  void _toggleformtype() {
    setState(() {
      _submitted = false;
      _formtype = _formtype == Emailsigninformtype.signin
          ? Emailsigninformtype.register
          : Emailsigninformtype.signin;
    });
    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  List<Widget> _buildchildren() {
    final primarytext = _formtype == Emailsigninformtype.signin
        ? "Sign in"
        : "Create an account";
    final secondarytext = _formtype == Emailsigninformtype.signin
        ? "Need an account? Register"
        : "Have an account? sign in";
    bool _submitenabled = widget.emailvalidator.isvalid(_email) &&
        widget.passwordvalidator.isvalid(_password) &&
        !_isloading;
    return [
      _buildeemailtextfield(),
      SizedBox(
        height: 10.0,
      ),
      _buildpasswordtextField(),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: FormSubmitButton(
          onpressed: _submitenabled ? _submit : null,
          text: primarytext,
        ),
      ),
      TextButton(
        onPressed: !_isloading ? _toggleformtype : null,
        child: Text(secondarytext),
      ),
    ];
  }

  TextField _buildpasswordtextField() {
    bool showerrortext =
        _submitted && !widget.passwordvalidator.isvalid(_password);

    return TextField(
      focusNode: _passwordfocusnode,
      textInputAction: TextInputAction.done,
      controller: _passwordcontroller,
      enabled: _isloading == false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showerrortext ? widget.passworderrortext : null,
      ),
      onEditingComplete: _submit,
      onChanged: (password) => _updatestate(),
    );
  }

  TextField _buildeemailtextfield() {
    bool showerrortext = _submitted && !widget.emailvalidator.isvalid(_email);
    return TextField(
      focusNode: _emailfocusnode,
      enabled: _isloading == false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: _emailcontroller,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter email',
        errorText: showerrortext ? widget.emailerrortext : null,
      ),
      onEditingComplete: _emaileditingcomplete,
      onChanged: (email) => _updatestate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildchildren(),
      ),
    );
  }

  void _updatestate() {
    setState(() {});
  }
}
