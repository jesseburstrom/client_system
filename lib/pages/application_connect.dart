part of "../main.dart";

class PageApplicationConnect extends StatefulWidget {
  const PageApplicationConnect({Key? key}) : super(key: key);

  @override
  _PageApplicationConnectState createState() => _PageApplicationConnectState();
}

class _PageApplicationConnectState extends State<PageApplicationConnect>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  saveContext(BuildContext context) {
    applicationConnect.context = context;
  }

  @override
  void initState() {
    super.initState();
    applicationConnect.state = state;
    net.connectToServer();
    Map<String, dynamic> msg = {};
    msg["action"] = "getId";
    msg["id"] = "";

    print(jsonEncode(msg));
    net.sendToServer(msg);

    msg = {};
    var nrPlayers = int.parse(applicationSettings.nrPlayers[0]);
    msg["playerIds"] = List.filled(nrPlayers, "");
    msg["gameType"] = applicationSettings.gameType[0];
    msg["nrPlayers"] = nrPlayers;
    msg["action"] = "requestGame";
    print(msg);
    net.sendToServer(msg);

    WidgetsBinding.instance!.addPostFrameCallback((_) => saveContext(context));
  }

  @override
  Widget build(BuildContext context) {
    return applicationConnect.widgetScaffoldGameRequest(context, state);
  }
}

class ApplicationConnect extends LanguagesApplicationConnect with InputItems {
  ApplicationConnect() {
    languagesSetup();
  }

  var tabController =
      TabController(length: 1, vsync: _PageApplicationConnectState());

  late BuildContext context;
  late Function state;
  var games = [];

  startGame(String gameType, int nrPlayers) {
    application.gameType = gameType;
    application.nrPlayers = nrPlayers;
    application.setup();
    userName = userNames[application.myPlayerId];
    gameStarted = true;
    pages.navigateToMainAppHandlerPageR(context);
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

  Widget widgetScaffoldGameRequest(BuildContext context, Function state) {
    return DefaultTabController(
        length: tabController.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(gameRequest_),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: tabController,
                isScrollable: false,
                tabs: [
                  Tab(text: gameRequest_),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                Scrollbar(
                  child: ListView(children: <Widget>[
                    widgetWaiting(),
                  ]),
                ),
              ],
            )));
  }
}
