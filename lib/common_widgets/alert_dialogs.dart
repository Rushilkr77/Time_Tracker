import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/platform_widget.dart';
import 'dart:io';

class Platformalertdailog extends Platformwidget {
  final String title;
  final String content;
  final String defaultactiontext;
  final String cancelactiontext;

  Platformalertdailog(
      {this.title,
      this.content,
      this.defaultactiontext,
      this.cancelactiontext});

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => this,
          );
  }

  @override
  Widget Buildcupertino(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildactions(context),
    );
  }

  @override
  Widget Buildmaterial(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildactions(context),
    );
  }

  List<Widget> _buildactions(BuildContext context) {
    final actions = <Widget>[];
    if (cancelactiontext != null) {
      actions.add(
        Platformalertdialogaction(
          child: Text(cancelactiontext),
          onpressed: () => Navigator.of(context).pop(false),
        ),
      );
    }

    actions.add(
      Platformalertdialogaction(
        child: Text(defaultactiontext),
        onpressed: () => Navigator.of(context).pop(true),
      ),
    );
    return actions;
  }
}

class Platformalertdialogaction extends Platformwidget {
  final Widget child;
  final VoidCallback onpressed;

  Platformalertdialogaction({this.child, this.onpressed});

  @override
  Widget Buildcupertino(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onpressed,
    );
  }

  @override
  Widget Buildmaterial(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      child: child,
    );
  }
}
