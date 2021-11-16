part of "../main.dart";

class ChatMessage {
  ChatMessage(this.messageContent, this.messageType);

  var messageContent = "";
  var messageType = "";
}

class Chat extends LanguagesChat with InputItems {
  Chat() {
    languagesSetup();
    //chatTextController.addListener(onTextChanged);
    //scrollController.addListener(onScrollChanged);
  }

  final chatTextController = TextEditingController();
  final scrollController = ScrollController();
  var focusNode = FocusNode();
  var listenerKey = GlobalKey();

  List<ChatMessage> messages = [
    ChatMessage("", "Sender"),
    ChatMessage("", "Sender"),
    ChatMessage("", "Sender"),
    ChatMessage("", "Sender"),
    ChatMessage("", "Sender")
  ];

  onTextChanged() {
    //var text = chatTextController.text;
    //print("onTextChanged");
  }

  onScrollChanged() {
    //print("onScrollChanged");
  }

  onSubmitted(String value) async {
    var text = chatTextController.text;
    print("onSubmitted");
    chatTextController.clear();

    messages.add(ChatMessage(text, "sender"));
    globalSetState();
    Map<String, dynamic> msg = {};
    msg["chatMessage"] = userName + ": " + text;
    msg["action"] = "chatMessage";
    msg["playerIds"] = application.playerIds;
    print(msg);
    net.sendToClients(msg);
    await Future.delayed(const Duration(milliseconds: 100), () {});
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);

    //focusNode.requestFocus();
  }
}
