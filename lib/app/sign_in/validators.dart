import 'package:flutter/material.dart';

abstract class StringValidator {
  bool isvalid(String value);
}

class Nonemptystringvalidator implements StringValidator {
  bool isvalid(String value) {
    return value.isNotEmpty;
  }
}

class Emailandpasswordvalidators {
  final StringValidator emailvalidator = Nonemptystringvalidator();
  final StringValidator passwordvalidator = Nonemptystringvalidator();
  final String emailerrortext = 'Email can\'t be empty';
  final String passworderrortext = 'Password can\'t be empty';
}
