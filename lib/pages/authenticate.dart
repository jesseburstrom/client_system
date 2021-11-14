part of "../main.dart";

class PageAuthenticate extends StatefulWidget {
  const PageAuthenticate({Key? key}) : super(key: key);

  @override
  _PageAuthenticate createState() => _PageAuthenticate();
}

class _PageAuthenticate extends State<PageAuthenticate>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return authenticate.widgetScaffoldLogin(context);
  }
}

class Authenticate extends LanguagesLogin with InputItems {
  Authenticate() {
    languagesSetup();
  }

  var fileAuthenticate = "authenticate.json";
  var tabController = TabController(length: 2, vsync: _PageAuthenticate());

  final loginUser = TextEditingController();
  final loginPassword = TextEditingController();
  final signupUser = TextEditingController();
  final signupPassword = TextEditingController();

  var signupFormKey = GlobalKey<FormState>();
  var loginFormKey = GlobalKey<FormState>();

  var jwt = "";

  Future<bool> tryLogin(user, password) async {
    var isLoggedIn = false;
    dynamic response, json;
    try {
      response = await net.login(user, password);
    } catch (e) {
      print("error logging in!");
      return false;
    }

    print(response.statusCode);
    print(response.body);

    // ASP.NET
    if (net.isWebSocketChannel) {
      try {
        json = jsonDecode(response.body);
      } catch (e) {
        print(e.toString());
        return false;
      }
      if (response.statusCode == 200) {
        jwt = json["token"];
        print(jwt);
        isLoggedIn = true;
      }
    } else if (response.statusCode == 200) {
      isLoggedIn = true;
    }

    if (isLoggedIn) {
      print("User is logged in!");
    } else {
      print("Wrong email or password, try again!");
    }

    return isLoggedIn;
  }

  Future checkUser(BuildContext context) async {
    if (await tryLogin(loginUser.text, loginPassword.text)) {
      fileHandler.saveFile(
          {"username": loginUser.text, "password": loginPassword.text},
          fileAuthenticate);
      pages.navigateToSelectPageR(context);
    }
  }

  Future attemptSignup(BuildContext context) async {
    dynamic response;
    try {
      response = await net.signup(signupUser.text, signupPassword.text);
    } catch (e) {
      print("error signing up!");
    }

    if (response.statusCode == 200) {
      print("User is created!");

      fileHandler.saveFile(
          {"username": signupUser.text, "password": signupPassword.text},
          fileAuthenticate);
      if (await tryLogin(signupUser.text, signupPassword.text)) {
        fileHandler.saveFile(
            {"username": loginUser.text, "password": loginPassword.text},
            fileAuthenticate);
        pages.navigateToSelectPageR(context);
      } else {
        print("error logging in user");
      }
    } else {
      print("User exists or other error, try again!");
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return required_;
    } else if (value.length < 6) {
      return passwordAtLeast_ + 6.toString() + characters_;
    } else if (value.length > 15) {
      return passwordNotGreater_ + 15.toString() + characters_;
    } else {
      return "";
    }
  }

  void forgotPasswordLinkPressed() {
    //TODO FORGOT PASSWORD SCREEN GOES HERE
  }

  void newUserLinkPressed() {
    tabController.animateTo(1);
  }

  void loginButtonPressed(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      print("Validated format");
      checkUser(context);
    } else {
      print("Not Validated format");
    }
  }

  void signupButtonPressed(BuildContext context) {
    if (signupFormKey.currentState!.validate()) {
      print("Validated format");
      attemptSignup(context);
    } else {
      print("Not Validated format");
    }
  }

  Widget widgetScaffoldLogin(BuildContext context) {
    return DefaultTabController(
        length: tabController.length,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              bottom: TabBar(
                controller: tabController,
                isScrollable: false,
                tabs: [
                  Tab(text: login_),
                  Tab(text: signup_),
                ],
              ),
            ),
            body: TabBarView(controller: tabController, children: [
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: loginFormKey,
                  child: Column(
                    children: <Widget>[
                      widgetImage(200, 150, "assets/images/flutter_logo.png"),
                      widgetTextFormField(email_, enterValidEmail_, loginUser),
                      widgetTextFormField(
                          password_, enterSecurePassword_, loginPassword),
                      widgetTextLink(
                          forgotPasswordLinkPressed, forgotPassword_),
                      widgetButton(context, loginButtonPressed, login_),
                      widgetSizedBox(100),
                      widgetTextLink(newUserLinkPressed, newUser_),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: signupFormKey,
                  child: Column(
                    children: <Widget>[
                      widgetImage(200, 150, "assets/images/flutter_logo.png"),
                      widgetTextFormField(email_, enterValidEmail_, signupUser),
                      widgetTextFormField(
                          password_, enterSecurePassword_, signupPassword),
                      widgetSizedBox(20),
                      widgetButton(context, signupButtonPressed, signup_),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
