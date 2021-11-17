part of '../main.dart';

class ApplicationSettings extends LanguagesGameSelect with InputItems {
  ApplicationSettings() {
    languagesSetup();
  }

  var gameType = [application.gameType];
  var nrPlayers = [application.nrPlayers.toString()];
  var tabController = TabController(length: 2, vsync: _PageDynamicState());

  var games = [];
  var onSettingsPage = true;

  navigateToPage(BuildContext context, [bool replace = true]) {
    pages.navigateToDynamicPage(context, {"page": widgetScaffold}, replace);
  }

  startGame(String gameType, int nrPlayers) {
    application.gameType = gameType;
    application.nrPlayers = nrPlayers;
    application.setup();
    userName = userNames[application.myPlayerId];
    applicationStarted = true;
    onSettingsPage = true;
    application.navigateToPage(pages._context);
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
    print("List games");
    net.connectToServer();
    Map<String, dynamic> msg = {};
    msg["action"] = "getId";
    msg["id"] = "";

    net.sendToServer(msg);

    msg = {};
    var nrPlayers = int.parse(applicationSettings.nrPlayers[0]);
    msg["playerIds"] = List.filled(nrPlayers, "");
    msg["gameType"] = applicationSettings.gameType[0];
    msg["nrPlayers"] = nrPlayers;
    msg["action"] = "requestGame";
    net.sendToServer(msg);
    onSettingsPage = false;
    pages._state();
  }

  Widget widgetScaffold(BuildContext context) {
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
                          gameType,
                          [gameTypeMini_, gameTypeOrdinary_, gameTypeMaxi_]),
                      widgetStringRadioButton(state, ["1", "2", "3", "4"],
                          nrPlayers, ["1", "2", "3", "4"]),
                      widgetCheckbox(state, () => {}, choseUnity_,
                          application.gameDices.unityDices),
                      widgetCheckbox(state, () => {}, colorChangeOverlay_,
                          application.gameDices.unityColorChangeOverlay),
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
                        child: ListView(
                            children: [widgetParagraph(appearance_)] +
                                application.gameDices
                                    .widgetColorChangeOverlay(context, state) +
                                [
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
