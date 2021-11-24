part of '../main.dart';

//extends Application {
extension WidgetApplicationSettings on Application {
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

  onGameListButton(BuildContext context) {
    Map<String, dynamic> msg = {};
    msg["action"] = "getId";
    msg["id"] = "";

    net.sendToServer(msg);

    msg = {};
    msg["playerIds"] = List.filled(nrPlayersS, "");
    msg["gameType"] = gameTypeS;
    msg["nrPlayers"] = nrPlayersS;
    msg["action"] = "requestGame";
    net.sendToServer(msg);
    onSettingsPage = false;
    pages._state();
  }

  onUpdateUserName(value) {
    userName = textEditingController.text;
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
                              [gameTypeMini_, gameTypeOrdinary_, gameTypeMaxi_],
                              (x) => {gameTypeS = x},
                              gameTypeS),
                          widgetIntRadioButton(state, ["1", "2", "3", "4"],
                              (x) => {nrPlayersS = x}, nrPlayersS),
                          widgetCheckbox(
                              state,
                              (x) => {gameDices.unityDices = x},
                              choseUnity_,
                              gameDices.unityDices),
                          widgetCheckbox(
                              state,
                              (x) => {gameDices.unityColorChangeOverlay = x},
                              colorChangeOverlay_,
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
                          Text("Current UserName: " + userName.toString()),
                          Row(children: [
                            SizedBox(
                                width: 150,
                                height: 30,
                                child: widgetInputText(
                                    "Enter username",
                                    onUpdateUserName,
                                    textEditingController,
                                    focusNode))
                          ]),
                          widgetDropDownList(
                              state,
                              " " + choseLanguage_,
                              Languages.differentLanguages,
                              (x) => {Languages.chosenLanguage = x},
                              Languages.chosenLanguage),
                        ])))
              ],
            )));
  }
}
