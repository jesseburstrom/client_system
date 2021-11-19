part of "../main.dart";

class App extends LanguagesApp with InputItems {
  appInit(Function callback) {
    callbackNavigateSettings = callback;
    languagesSetup();
    setup();

    net.connectToServer();
  }

  late Function callbackNavigateSettings;

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
