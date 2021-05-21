import 'package:flutter/cupertino.dart';
import 'package:time_tracker/common_widgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton(
      {String text, Color color, Color textcolor, VoidCallback onpressed})
      : super(
            child: Text(
              text,
              style: TextStyle(
                color: textcolor,
                fontSize: 15.0,
              ),
            ),
            color: color,
            onpressed: onpressed,
            height: 50.0);
}
