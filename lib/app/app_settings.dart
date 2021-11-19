part of "../main.dart";

class AppSettings extends App {
  AppSettings() {
    languagesSetup();
    net.setCallbacks(callbackOnClientMsg, callbackOnServerMsg);
    appInit(navigateToSettings);
  }

  var tabController = TabController(length: 2, vsync: _PageDynamicState());

  navigateToSettings(BuildContext context, [bool replace = true]) {
    pages.navigateToDynamicPage(
        context, {"page": widgetScaffoldSettings}, replace);
  }

  // List of widgets for the application specific settings
  List<Widget> settings() {
    return <Widget>[];
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

  Widget widgetScaffoldSettings(BuildContext context) {
    Function state = pages._state;
    return DefaultTabController(
        length: tabController.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(settings_),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: tabController,
                isScrollable: false,
                tabs: [
                  Tab(text: application_),
                  Tab(text: general_),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: settings(),
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(children: [
                          widgetSizedBox(15),
                          widgetParagraph(misc_),
                          widgetDropDownList(
                              pages._state,
                              " " + choseLanguage_,
                              Languages.differentLanguages,
                              Languages.chosenLanguage),
                        ])))
              ],
            )));
  }
}
