part of "../main.dart";

class LanguagesApp extends Languages {
  final _hello = {"English": "Hello"};

  String get hello_ => getText(_hello);

  void languagesSetup() {
    _hello["Swedish"] = "Hej";
  }
}
