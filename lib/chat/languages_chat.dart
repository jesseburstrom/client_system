part of "../main.dart";

class LanguagesChat extends Languages {
  final _sendMessage = {"English": "Send message..."};

  String get sendMessage_ => getText(_sendMessage);

  void languagesSetup() {
    _sendMessage["Swedish"] = "Skicka meddelande...";
  }
}
