part of "../main.dart";

class Languages {
  static var chosenLanguage = ["English"];
  static var standardLanguage = "English";

  static var differentLanguages = ["English", "Swedish"];

  List<String> getLanguages() {
    List<String> translatedLanguages = [];

    return translatedLanguages;
  }

  String getText(var textVariable) {
    var text = textVariable[chosenLanguage[0]];
    if (text != null) {
      return text;
    } else {
      return textVariable[standardLanguage]!;
    }
  }
}
