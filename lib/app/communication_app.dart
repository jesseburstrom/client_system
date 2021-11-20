part of "../main.dart";

extension CommunicationApp on App {
  updateChat(String text) async {
    chat.messages.add(ChatMessage(text, "receiver"));
    pages._stateMain();
    await Future.delayed(const Duration(milliseconds: 100), () {});
    chat.scrollController.animateTo(
        chat.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
  }

  callbackOnClientMsg(var data) {
    print("onClientMsg");
    print(data);
    switch (data["action"]) {
      case "chatMessage":
        updateChat(data["chatMessage"]);
        break;
    }
  }

  callbackOnServerMsg(var data) {
    print("onServerMsg");
    print(data);
    switch (data["action"]) {
      case "onGetId":
        data = Map<String, dynamic>.from(data);
        net.socketConnectionId = data["id"];
        break;
    }
  }
}
