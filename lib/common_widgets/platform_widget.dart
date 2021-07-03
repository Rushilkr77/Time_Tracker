import 'package:flutter/material.dart';
import 'dart:io';

abstract class Platformwidget extends StatelessWidget {
  Widget Buildcupertino(BuildContext context);
  Widget Buildmaterial(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Buildcupertino(context);
    }
    return Buildmaterial(context);
  }
}
