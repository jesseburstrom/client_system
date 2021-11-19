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
