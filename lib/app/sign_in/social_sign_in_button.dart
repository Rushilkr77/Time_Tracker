import 'package:flutter/cupertino.dart';
import 'package:time_tracker/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton(
      {String text,
      Color color,
      Color textcolor,
      VoidCallback onpressed,
      String assetname})
      : super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(assetname),
                Text(
                  text,
                  style: TextStyle(color: textcolor, fontSize: 15.0),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(assetname),
                ),
              ],
            ),
            color: color,
            onpressed: onpressed,
            height: 50.0);
}
