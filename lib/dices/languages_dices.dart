part of "../main.dart";

class LanguagesDices extends Languages {
  final _hold = {"English": "HOLD"};

  String get hold_ => getText(_hold);

  void languagesSetup() {
    _hold["Swedish"] = "HÅLL";
  }
}
