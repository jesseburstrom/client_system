part of "../main.dart";

class LanguagesApp extends LanguagesAppSettings {
  final _hello = {"English": "Hello"};

  String get hello_ => getText(_hello);

  @override
  languagesSetup() {
    super.languagesSetup();
    _hello["Swedish"] = "Hej";
  }
}
