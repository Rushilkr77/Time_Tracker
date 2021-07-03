import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_change_model..dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/common_widgets/alert_dialogs.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';

class Emailsigninformchangenotifier extends StatefulWidget {
  Emailsigninformchangenotifier({@required this.model});
  final Emailsigninchangemodel model;

  static Widget create(BuildContext context) {
    final Authbase auth = Provider.of<Authbase>(context, listen: false);
    return ChangeNotifierProvider<Emailsigninchangemodel>(
      create: (context) => Emailsigninchangemodel(auth: auth),
      child: Consumer<Emailsigninchangemodel>(
        builder: (context, model, _) => Emailsigninformchangenotifier(
          model: model,
        ),
      ),
    );
  }

  @override
  _EmailsigninformchangenotifierState createState() =>
      _EmailsigninformchangenotifierState();
}

class _EmailsigninformchangenotifierState
    extends State<Emailsigninformchangenotifier> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FocusNode _emailfocusnode = FocusNode();
  final FocusNode _passwordfocusnode = FocusNode();
  Emailsigninchangemodel get model => widget.model;

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
      await model.submit();
      Navigator.of(context).pop();
    } catch (e) {
      Platformalertdailog(
              title: 'Sign in failed',
              content: e.toString(),
              defaultactiontext: 'OK')
          .show(context);
    }
  }

  void _emaileditingcomplete() {
    final newfocus = model.emailvalidator.isvalid(model.email)
        ? _passwordfocusnode
        : _emailfocusnode;
    FocusScope.of(context).requestFocus(newfocus);
  }

  void _toggleformtype() {
    model.toggleformtype();

    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  List<Widget> _buildchildren() {
    return [
      _buildeemailtextfield(),
      SizedBox(
        height: 10.0,
      ),
      _buildpasswordtextField(),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: FormSubmitButton(
          onpressed: model.cansubmit ? _submit : null,
          text: model.primarytext,
        ),
      ),
      TextButton(
        onPressed: !model.isloading ? () => _toggleformtype() : null,
        child: Text(model.secondarytext),
      ),
    ];
  }

  TextField _buildpasswordtextField() {
    bool showerrortext =
        model.submitted && !model.passwordvalidator.isvalid(model.password);

    return TextField(
      focusNode: _passwordfocusnode,
      textInputAction: TextInputAction.done,
      controller: _passwordcontroller,
      enabled: model.isloading == false,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password', errorText: widget.model.passworderrortext),
      onEditingComplete: _submit,
      onChanged: model.updatepassword,
    );
  }

  TextField _buildeemailtextfield() {
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
      onEditingComplete: () => _emaileditingcomplete(),
      onChanged: model.updateemail,
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
}
