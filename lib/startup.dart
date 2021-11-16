part of "./main.dart";

var localhost = "http://192.168.0.168:3000";
var localhostIO = "http://192.168.0.168:3001";
var localhostNET = "https://localhost:44357/api/Values";
var localhostNETIO = "wss://localhost:44357/ws";
var gameStarted = false;
var reloadHighscore = true; // only used ones at startup
var userName = "Yatzy";
var userNames = ["Bo", "Paula", "Jessica", "Henrik"];
var stackedWidgets = <Widget>[];
late Function globalSetState;
late BuildContext globalContext;
late double screenWidth;
late double screenHeight;
// scrcpy -s R3CR4037M1R --shortcut-mod=lctrl --always-on-top --stay-awake --window-title "Samsung Galaxy S21"
// android:theme="@style/UnityThemeSelector.Translucent"
// android/app/Src/main/AndroidManifest.xml

startAnimations(BuildContext context) async {
  animationsScroll.animationController.repeat(reverse: true);
  globalContext = context;
}

var pages = Pages();
var fileHandler = FileHandler();
var net = Net();
var authenticate = Authenticate();

var animationsScroll = AnimationsScroll();
var chat = Chat();
var highscore = Highscore();

var applicationSettings = ApplicationSettings();
var applicationConnect = ApplicationConnect();
var application = Application();

class MainAppHandler extends StatefulWidget {
  const MainAppHandler({Key? key}) : super(key: key);

  @override
  _MainAppHandlerState createState() => _MainAppHandlerState();
}

class _MainAppHandlerState extends State<MainAppHandler>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    globalSetState = state;

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => startAnimations(context));
  }

  @override
  void dispose() {
    animationsScroll.animationController.stop();
    super.dispose();
  }

  Widget widgetWrapCCOverlay(BuildContext context, Function state) {
    if (application.gameDices.unityColorChangeOverlay[0]) {
      return Positioned(
          left: 0,
          top: 380,
          child: Container(
              color: Colors.white,
              width: 250,
              height: 150,
              child: ListView(
                  children: applicationSettings.widgetColorChangeOverlay(
                      context, state))));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (reloadHighscore) {
      highscore.loadHighscoreFromServer();
      reloadHighscore = false;
    }

    if (screenHeight > screenWidth) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              pages.navigateToSelectPage(context);
            },
            tooltip: "Settings",
            child: const Icon(Icons.settings_applications),
            backgroundColor: Colors.blue,
          ),
          body: Stack(
            children: <Widget>[
                  Image.asset("assets/images/yatzy_portrait.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  Stack(children: stackedWidgets),
                ] +
                layoutPTopToBottom(
                    screenWidth,
                    screenHeight,
                    highscore.widgetHighscore,
                    application.widgetSetupGameBoard,
                    application.gameDices.widgetDices,
                    chat.widgetChat,
                    animationsScroll.widgetEmptyContainer,
                    application.widgetDisplayGameStatus) +
                [widgetWrapCCOverlay(context, state)],
          ));
    } else {
      // landscape
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              pages.navigateToSelectPage(context);
            },
            tooltip: "Settings",
            child: const Icon(Icons.settings_applications),
            backgroundColor: Colors.blue,
          ),
          body: Stack(
            children: <Widget>[
                  Image.asset("assets/images/yatzy_landscape2.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  Stack(children: stackedWidgets)
                ] +
                layoutLLeftToRight(
                    screenWidth,
                    screenHeight,
                    application.widgetSetupGameBoard,
                    application.gameDices.widgetDices,
                    highscore.widgetHighscore,
                    chat.widgetChat,
                    animationsScroll.widgetEmptyContainer,
                    application.widgetDisplayGameStatus),
          ));
    }
  }
}
