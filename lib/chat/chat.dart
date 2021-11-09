part of "../main.dart";

class ChatMessage {
  ChatMessage(this.messageContent, this.messageType);

  var messageContent = "";
  var messageType = "";
}

class Chat extends InputItems {
  Chat() {
    chatTextController.addListener(onTextChanged);
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
    print("onScrollChanged");
  }

  Widget widgetChat(double width, double height) {
    Widget widgetChatOutput() {
      Widget widget = ListView.builder(
          controller: scrollController,
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          //physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (messages[index].messageContent.length > 0) {
              return Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.centerLeft
                      : Alignment.centerRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Text(messages[index].messageContent,
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              );
            } else {
              return Container(
                child: Text("", style: TextStyle(fontSize: 20)),
              );
            }
          });

      return widget;
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

    Widget widget = Container(
        width: width,
        height: height,
        color: Colors.blue.shade100.withOpacity(0.2),
        child: Stack(children: [
          Container(height: height - 30, child: widgetChatOutput()),
          Positioned(
              top: height - 30,
              child: SizedBox(
                  width: width,
                  height: 30,
                  child: widgetInputText("Send message...", onSubmitted,
                      chatTextController, focusNode)))
        ]));
    return widget;
  }
}
