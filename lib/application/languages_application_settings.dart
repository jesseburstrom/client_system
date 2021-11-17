part of '../main.dart';

class LanguagesGameSelect extends Languages {
  final _gameTypeOrdinary = {"English": "Ordinary"};
  final _gameTypeMini = {"English": "Mini"};
  final _gameTypeMaxi = {"English": "Maxi"};
  final _choseUnity = {"English": "3D Dices"};
  final _settings = {"English": "Settings"};
  final _game = {"English": "Game"};
  final _general = {"English": "General"};
  final _colorChangeOverlay = {"English": "Color Change Overlay"};
  final _choseLanguage = {"English": "Chose Language"};
  final _startGame = {"English": "Start Game"};
  final _gameList = {"English": "Games List"};
  final _transparency = {"English": "Transparency"};
  final _lightMotion = {"English": "Light Motion"};
  final _red = {"English": "Red"};
  final _green = {"English": "Green"};
  final _blue = {"English": "Blue"};
  final _appearance = {"English": "Appearance"};
  final _misc = {"English": "Misc"};
  final _gameRequest = {"English": "Game Request"};

  String get gameTypeOrdinary_ => getText(_gameTypeOrdinary);

  String get gameTypeMini_ => getText(_gameTypeMini);

  String get gameTypeMaxi_ => getText(_gameTypeMaxi);

  String get choseUnity_ => getText(_choseUnity);

  String get settings_ => getText(_settings);

  String get game_ => getText(_game);

  String get general_ => getText(_general);

  String get colorChangeOverlay_ => getText(_colorChangeOverlay);

  String get choseLanguage_ => getText(_choseLanguage);

  String get startGame_ => getText(_startGame);

  String get gameList_ => getText(_gameList);

  String get transparency_ => getText(_transparency);

  String get lightMotion_ => getText(_lightMotion);

  String get red_ => getText(_red);

  String get green_ => getText(_green);

  String get blue_ => getText(_blue);

  String get appearance_ => getText(_appearance);

  String get misc_ => getText(_misc);
  String get gameRequest_ => getText(_gameRequest);

  languagesSetup() {
    _gameTypeOrdinary["Swedish"] = "Standard";
    _choseUnity["Swedish"] = "3D Tärningar";
    _settings["Swedish"] = "Inställningar";
    _game["Swedish"] = "Spel";
    _general["Swedish"] = "Allmänt";
    _colorChangeOverlay["Swedish"] = "Färginställningar Live";
    _choseLanguage["Swedish"] = "Välj Språk";
    _startGame["Swedish"] = "Starta Spelet";
    _gameList["Swedish"] = "Spel Lista";
    _transparency["Swedish"] = "Transparens";
    _lightMotion["Swedish"] = "Cirkulärt Ljus";
    _red["Swedish"] = "Röd";
    _green["Swedish"] = "Grön";
    _blue["Swedish"] = "Blå";
    _appearance["Swedish"] = "Utseende";
    _misc["Swedish"] = "Diverse";
    _gameRequest["Swedish"] = "Spel Inbjudan";
  }
}
