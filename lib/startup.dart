part of "./main.dart";

var localhost = "http://192.168.0.168:3000";
var localhostIO = "http://192.168.0.168:3001";
var localhostNET = "https://localhost:44357/api/Values";
var localhostNETIO = "wss://localhost:44357/ws";
var applicationStarted = false;
var userName = "Yatzy";
var userNames = ["Bo", "Paula", "Jessica", "Henrik"];
var stackedWidgets = <Widget>[];
late double screenWidth;
late double screenHeight;
// scrcpy -s R3CR4037M1R --shortcut-mod=lctrl --always-on-top --stay-awake --window-title "Samsung Galaxy S21"
// android:theme="@style/UnityThemeSelector.Translucent"
// android/app/Src/main/AndroidManifest.xml

var languagesGlobal = LanguagesGlobal();
var pages = Pages();
var fileHandler = FileHandler();
var net = Net();

var animationsScroll = AnimationsScroll();
var highscore = Highscore();

var app = App();
//var app = Application();
var authenticate = Authenticate(app.navigateToSettings);
var chat = Chat(app.chatCallbackOnSubmitted);

Future attemptLogin(BuildContext context) async {
  var isLoggedIn = false;
  try {
    var userData = await fileHandler.readFile(authenticate.fileAuthenticate);
    print(userData);
    isLoggedIn =
        await authenticate.tryLogin(userData["username"], userData["password"]);
  } catch (e) {
    print(e.toString());
  }

  Timer.run(() {
    if (!isLoggedIn) {
      authenticate.navigateToPage(context);
    } else if (!applicationStarted) {
      app.navigateToSettings(context);
    } else {
      app.navigateToApp(context);
    }
  });
}
