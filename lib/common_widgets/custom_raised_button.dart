import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final double height;
  final Color color;
  final double borderradius;
  final VoidCallback onpressed;
  CustomRaisedButton(
      {this.child,
      this.borderradius: 2.0,
      this.color,
      this.onpressed,
      this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderradius),
          ),
        ),
        onPressed: onpressed,
      ),
    );
  }
}
