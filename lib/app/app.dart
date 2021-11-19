part of "../main.dart";

class App extends LanguagesApp with InputItems {
  App() {
    languagesSetup();
    setup();
    net.setCallbacks(callbackOnClientMsg, callbackOnServerMsg);
    net.connectToServer();
  }

  var animation = AnimationsApp();
  var tabController = TabController(length: 2, vsync: _PageDynamicState());

  postFrameCallback(BuildContext context) async {
    //startAnimations(context);
  }

  navigateToApp(BuildContext context, [bool replace = true]) {
    pages.navigateToMainPage(
        context,
        {
          "page": widgetScaffold,
          "postFrameCallback": postFrameCallback,
          "dispose": animationsScroll.animationController.stop
        },
        replace);
  }

  navigateToSettings(BuildContext context, [bool replace = true]) {
    pages.navigateToDynamicPage(
        context, {"page": widgetScaffoldSettings}, replace);
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

  chatCallbackOnSubmitted(String text) {
    pages._stateMain();
    Map<String, dynamic> msg = {};
    msg["chatMessage"] = userName + ": " + text;
    msg["action"] = "chatMessage";
    //msg["playerIds"] = playerIds;
    print(msg);
    net.sendToClients(msg);
  }

  setup() {}
}
