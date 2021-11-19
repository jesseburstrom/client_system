part of '../main.dart';

class ApplicationSettings extends Application {
  //LanguagesApplicationSettings with InputItems {
  ApplicationSettings() {
    languagesSetup();
    net.setCallbacks(callbackOnClientMsg, callbackOnServerMsg);
    appInit(navigateToSettings);
    gameTypeS = [gameType];
    nrPlayersS = [nrPlayers];
  }

  var gameTypeS = <String>[];
  var nrPlayersS = <int>[];
  var games = [];
  var onSettingsPage = true;
  var tabController = TabController(length: 2, vsync: _PageDynamicState());

  navigateToSettings(BuildContext context, [bool replace = true]) {
    pages.navigateToDynamicPage(
        context, {"page": widgetScaffoldSettings}, replace);
  }

  callbackOnServerMsg(var data) {
    print("onServerMsg");
    print(data);
    switch (data["action"]) {
      case "onGetId":
        data = Map<String, dynamic>.from(data);
        net.socketConnectionId = data["id"];
        break;
      case "onGameStart":
        data = Map<String, dynamic>.from(data);
        myPlayerId = data["playerIds"].indexOf(net.socketConnectionId);
        print(net.socketConnectionId);
        print("myPlayerID: " + myPlayerId.toString());
        gameId = data["gameId"];
        playerIds = data["playerIds"];
        setup();
        userName = userNames[myPlayerId];
        applicationStarted = true;
        onSettingsPage = true;
        navigateToApp(pages._context);
        break;
      case "onRequestGames":
        print("onRequestGames");
        data = List<dynamic>.from(data["Games"]);
        games = data;
        pages._state();
        break;
      case "onGameAborted":
        print("onGameAborted");
        data = Map<String, dynamic>.from(data["game"]);
        applicationStarted = false;
        navigateToSettings(pages._contextMain);
        break;
    }
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
      case "sendSelection":
        gameDices.diceValue = data["diceValue"].cast<int>();
        updateDiceValues();
        calcNewSums(data["player"], data["cell"]);
        pages._stateMain();
        if (myPlayerId == playerToMove && gameDices.unityDices[0]) {
          gameDices.sendStartToUnity();
        }
        break;
      case "sendDices":
        data = Map<String, dynamic>.from(data);
        gameDices.diceValue = data["diceValue"].cast<int>();
        updateDiceValues();
        gameDices.nrRolls += 1;
        gameDices.updateDiceImages();
        pages._stateMain();
        break;
      case "chatMessage":
        updateChat(data["chatMessage"]);
        break;
    }
  }

  Widget widgetWaiting() {
    Widget widget = const Text("");

    for (var i = 0; i < games.length; i++) {
      print(games[i]["playerIds"]);
      print(net.socketConnectionId);
      if (games[i]["playerIds"].indexOf(net.socketConnectionId) != -1) {
        widget = Text(
            games[i]["gameType"] +
                " " +
                games[i]["connected"].toString() +
                "/" +
                games[i]["nrPlayers"].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue[800],
              shadows: const [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.red,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ));
        break;
      }
    }
    return widget;
  }

  void onGameListButton(BuildContext context) {
    Map<String, dynamic> msg = {};
    msg["action"] = "getId";
    msg["id"] = "";

    net.sendToServer(msg);

    msg = {};
    msg["playerIds"] = List.filled(nrPlayersS[0], "");
    msg["gameType"] = gameTypeS[0];
    msg["nrPlayers"] = nrPlayersS[0];
    msg["action"] = "requestGame";
    net.sendToServer(msg);
    onSettingsPage = false;
    pages._state();
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
                  Tab(text: game_),
                  Tab(text: general_),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: <Widget>[
                          widgetStringRadioButton(
                              state,
                              ["Mini", "Ordinary", "Maxi"],
                              gameTypeS,
                              [
                                gameTypeMini_,
                                gameTypeOrdinary_,
                                gameTypeMaxi_
                              ]),
                          widgetIntRadioButton(
                              state, ["1", "2", "3", "4"], nrPlayersS),
                          widgetCheckbox(state, () => {}, choseUnity_,
                              gameDices.unityDices),
                          widgetCheckbox(state, () => {}, colorChangeOverlay_,
                              gameDices.unityColorChangeOverlay)
                        ] +
                        gameDices.widgetColorChangeOverlay(context, state) +
                        [
                          widgetSizedBox(15),
                          if (onSettingsPage)
                            widgetButton(context, onGameListButton, gameList_)
                          else
                            widgetWaiting(),
                        ],
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(children: [
                          widgetSizedBox(15),
                          widgetParagraph(misc_),
                          widgetDropDownList(
                              state,
                              " " + choseLanguage_,
                              Languages.differentLanguages,
                              Languages.chosenLanguage),
                        ])))
              ],
            )));
  }
}
