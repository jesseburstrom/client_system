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
    animationsScroll.animationController.repeat(reverse: true);
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

  chatCallbackOnSubmitted(String text) {
    pages._stateMain();
    Map<String, dynamic> msg = {};
    msg["chatMessage"] = userName + ": " + text;
    msg["action"] = "chatMessage";
    msg["playerIds"] = [net.socketConnectionId];
    print(msg);
    net.sendToClients(msg);
  }

  setup() {}
}
