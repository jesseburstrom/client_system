part of "../main.dart";

class LanguagesDices extends Languages {
  final _hold = {"English": "HOLD"};
  final _rollsLeft = {"English": "Rolls left"};

  String get hold_ => getText(_hold);

  String get rollsLeft_ => getText(_rollsLeft);

  void languagesSetup() {
    _hold["Swedish"] = "HÅLL";
    _rollsLeft["Swedish"] = "Kast kvar";
  }
}
