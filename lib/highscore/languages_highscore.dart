part of "../main.dart";

class LanguagesHighscore extends Languages {
  final _highscores = {"English": "Highscores"};

  String get highscores_ => getText(_highscores);

  void languagesSetup() {
    _highscores["Swedish"] = "Topplista";
  }
}
