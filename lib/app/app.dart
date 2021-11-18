part of "../main.dart";

class App extends LanguagesApp {
  App() {
    languagesSetup();
    setup();
    net.setCallbacks(callbackOnClientMsg, callbackOnServerMsg);
    net.connectToServer();
  }

  setup() {}

  postFrameCallback(BuildContext context) async {
    //startAnimations(context);
  }

  navigateToPage(BuildContext context, [bool replace = true]) {
    pages.navigateToMainPage(
        context,
        {
          "page": widgetScaffold,
          //"postFrameCallback": startAnimations,
          "dispose": animationsScroll.animationController.stop
        },
        replace);
  }

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
        print("chatMessage");
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
