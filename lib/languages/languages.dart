part of "../main.dart";

class Languages {
  static var chosenLanguage = "Swedish";
  static var standardLanguage = "English";

  static var differentLanguages = ["English", "Swedish"];

  List<String> getLanguages() {
    List<String> translatedLanguages = [];

    return translatedLanguages;
  }

  String getText(var textVariable) {
    var text = textVariable[chosenLanguage];
    if (text != null) {
      return text;
    } else {
      return textVariable[standardLanguage]!;
    }
  }
}
