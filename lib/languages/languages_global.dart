part of '../main.dart';

class LanguagesGlobal extends Languages {
  LanguagesGlobal() {
    languagesSetup();
  }

  final _isRequired = {"English": " is required"};

  String get isRequired_ => getText(_isRequired);

  languagesSetup() {
    _isRequired["Swedish"] = " är nödvändigt";
  }
}
