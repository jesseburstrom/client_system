part of "../main.dart";

class ChatMessage {
  ChatMessage(this.messageContent, this.messageType);

  var messageContent = "";
  var messageType = "";
}

class Chat extends LanguagesChat with InputItems {
  Chat(Function callback) {
    languagesSetup();
    callbackOnSubmitted = callback;
    //chatTextController.addListener(onTextChanged);
    //scrollController.addListener(onScrollChanged);
  }

  late Function callbackOnSubmitted;
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
    callbackOnSubmitted(text);

    await Future.delayed(const Duration(milliseconds: 100), () {});
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);

    //focusNode.requestFocus();
  }
}
