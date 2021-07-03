import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/common_widgets/alert_dialogs.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';

import 'email_sign_in_model.dart';

class Emailsigninformblocbased extends StatefulWidget {
  Emailsigninformblocbased({@required this.bloc});
  final Emailsigninbloc bloc;

  static Widget create(BuildContext context) {
    final Authbase auth = Provider.of<Authbase>(context, listen: false);
    return Provider<Emailsigninbloc>(
      create: (context) => Emailsigninbloc(auth: auth),
      child: Consumer<Emailsigninbloc>(
        builder: (context, bloc, _) => Emailsigninformblocbased(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailsigninformblocbasedState createState() =>
      _EmailsigninformblocbasedState();
}

class _EmailsigninformblocbasedState extends State<Emailsigninformblocbased> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FocusNode _emailfocusnode = FocusNode();
  final FocusNode _passwordfocusnode = FocusNode();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _emailfocusnode.dispose();
    _passwordfocusnode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } catch (e) {
      Platformalertdailog(
              title: 'Sign in failed',
              content: e.toString(),
              defaultactiontext: 'OK')
          .show(context);
    }
  }

  void _emaileditingcomplete(Emailsigninmodel model) {
    final newfocus = model.emailvalidator.isvalid(model.email)
        ? _passwordfocusnode
        : _emailfocusnode;
    FocusScope.of(context).requestFocus(newfocus);
  }

  void _toggleformtype(Emailsigninmodel model) {
    widget.bloc.toggleformtype();

    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  List<Widget> _buildchildren(Emailsigninmodel model) {
    return [
      _buildeemailtextfield(model),
      SizedBox(
        height: 10.0,
      ),
      _buildpasswordtextField(model),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: FormSubmitButton(
          onpressed: model.cansubmit ? _submit : null,
          text: model.primarytext,
        ),
      ),
      TextButton(
        onPressed: !model.isloading ? () => _toggleformtype(model) : null,
        child: Text(model.secondarytext),
      ),
    ];
  }

  TextField _buildpasswordtextField(Emailsigninmodel model) {
    bool showerrortext =
        model.submitted && !model.passwordvalidator.isvalid(model.password);

    return TextField(
      focusNode: _passwordfocusnode,
      textInputAction: TextInputAction.done,
      controller: _passwordcontroller,
      enabled: model.isloading == false,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password', errorText: model.passworderrortext),
      onEditingComplete: _submit,
      onChanged: widget.bloc.updatepassword,
    );
  }

  TextField _buildeemailtextfield(Emailsigninmodel model) {
    bool showerrortext =
        model.submitted && !model.emailvalidator.isvalid(model.email);
    return TextField(
      focusNode: _emailfocusnode,
      enabled: model.isloading == false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: _emailcontroller,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter email',
        errorText: model.emailerrortext,
      ),
      onEditingComplete: () => _emaileditingcomplete(model),
      onChanged: widget.bloc.updateemail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Emailsigninmodel>(
        stream: widget.bloc.modelstream,
        initialData: Emailsigninmodel(),
        builder: (context, snapshot) {
          final Emailsigninmodel model = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildchildren(model),
            ),
          );
        });
  }
}
