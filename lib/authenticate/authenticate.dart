part of '../main.dart';

class Authenticate extends LanguagesLogin with InputItems {
  Authenticate() {
    languagesSetup();
  }

  var fileAuthenticate = "authenticate.json";
  var tabController = TabController(length: 2, vsync: _PageDynamicState());

  final loginUser = TextEditingController();
  final loginPassword = TextEditingController();
  final signupUser = TextEditingController();
  final signupPassword = TextEditingController();

  var signupFormKey = GlobalKey<FormState>();
  var loginFormKey = GlobalKey<FormState>();

  var jwt = "";

  navigateToPage(BuildContext context, [bool replace = true]) {
    pages.navigateToDynamicPage(context, {"page": widgetScaffold}, replace);
  }

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
      applicationSettings.navigateToPage(context);
    }
  }

  Future attemptSignup(BuildContext context) async {
    dynamic response;
    try {
      response = await net.signup(signupUser.text, signupPassword.text);
    } catch (e) {
      print(e.toString());
      return;
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
        applicationSettings.navigateToPage(context);
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
}
