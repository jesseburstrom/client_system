part of "../main.dart";

class LanguagesDices extends Languages {
  final _hold = {"English": "HOLD"};
  final _rollsLeft = {"English": "Rolls left"};
  final _transparency = {"English": "Transparency"};
  final _lightMotion = {"English": "Light Motion"};
  final _red = {"English": "Red"};
  final _green = {"English": "Green"};
  final _blue = {"English": "Blue"};

  String get hold_ => getText(_hold);

  String get transparency_ => getText(_transparency);

  String get lightMotion_ => getText(_lightMotion);

  String get red_ => getText(_red);

  String get green_ => getText(_green);

  String get blue_ => getText(_blue);

  String get rollsLeft_ => getText(_rollsLeft);

  void languagesSetup() {
    _hold["Swedish"] = "HÅLL";
    _rollsLeft["Swedish"] = "Kast kvar";
    _transparency["Swedish"] = "Transparens";
    _lightMotion["Swedish"] = "Cirkulärt Ljus";
    _red["Swedish"] = "Röd";
    _green["Swedish"] = "Grön";
    _blue["Swedish"] = "Blå";
  }
}
