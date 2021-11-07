part of "../main.dart";

class LanguagesGameRequest extends Languages {
  final _gameRequest = {"English": "Game Request"};

  String get gameRequest_ => getText(_gameRequest);

  languagesSetup() {
    _gameRequest["Swedish"] = "Spel Inbjudan";
  }
}
