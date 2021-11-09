part of "../main.dart";

class PageGameRequest extends StatefulWidget {
  const PageGameRequest({Key? key}) : super(key: key);

  @override
  _PageGameRequestState createState() => _PageGameRequestState();
}

class _PageGameRequestState extends State<PageGameRequest>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  saveContext(BuildContext context) {
    gameRequest.context = context;
  }

  @override
  void initState() {
    super.initState();
    gameRequest.state = state;
    Map<String, dynamic> msg = {};
    msg["playerIds"] = [net.socketConnection.id];
    msg["gameType"] = gameSelect.gameType[0];
    msg["nrPlayers"] = int.parse(gameSelect.nrPlayers[0]);
    msg["action"] = "sendRequestGame";
    print(msg);
    net.sendToServer(msg);

    WidgetsBinding.instance!.addPostFrameCallback((_) => saveContext(context));
  }

  @override
  Widget build(BuildContext context) {
    return gameRequest.widgetScaffoldGameRequest(context, state);
  }
}

class GameRequest extends LanguagesGameRequest with InputItems {
  GameRequest() {
    languagesSetup();
  }

  var tabController = TabController(length: 1, vsync: _PageGameRequestState());

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
      if (games[i]["playerIds"].indexOf(net.socketConnection.id) != -1) {
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
                  child: ListView(children: <Widget>[widgetWaiting()]),
                ),
              ],
            )));
  }
}
