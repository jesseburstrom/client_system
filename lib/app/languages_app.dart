part of "../main.dart";

class LanguagesApp extends Languages {
  final _hello = {"English": "Hello"};
  final _choseLanguage = {"English": "Chose Language"};
  final _settings = {"English": "Settings"};
  final _general = {"English": "General"};
  final _application = {"English": "Application"};
  final _misc = {"English": "Misc"};

  String get hello_ => getText(_hello);

  String get choseLanguage_ => getText(_choseLanguage);

  String get settings_ => getText(_settings);

  String get general_ => getText(_general);

  String get application_ => getText(_application);

  String get misc_ => getText(_misc);

  languagesSetup() {
    _hello["Swedish"] = "Hej";
    _choseLanguage["Swedish"] = "Välj Språk";
    _settings["Swedish"] = "Inställningar";
    _general["Swedish"] = "Allmänt";
    _application["Swedish"] = "Applikation";
    _misc["Swedish"] = "Diverse";
  }
}
