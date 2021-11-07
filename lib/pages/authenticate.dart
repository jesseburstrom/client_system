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

  final loginTxtUserName = TextEditingController();
  final loginTxtPassword = TextEditingController();
  final signupTxtUserName = TextEditingController();
  final signupTxtPassword = TextEditingController();
  final signupTxtPassword2 = TextEditingController();

  var signupFormKey = GlobalKey<FormState>();
  var loginFormKey = GlobalKey<FormState>();

  Future checkUser(BuildContext context) async {
    try {
      var serverResponse =
          await net.mainLogin(loginTxtUserName.text, loginTxtPassword.text);
      if (serverResponse.statusCode == 200) {
        print(serverResponse.body);
        userName = loginTxtUserName.text;
        print("User is logged in!");
        var _json = {
          "username": loginTxtUserName.text,
          "password": loginTxtPassword.text
        };
        fileHandler.saveFile(_json, fileAuthenticate);
        pages.navigateToSelectPageR(context);
      } else {
        // TODO: handle not logged in case
        print("user not logged in");
      }
    } catch (e) {
      print("error logging in!");
    }
  }

  Future attemptSignup(BuildContext context) async {
    try {
      var serverResponse =
          await net.mainSignup(signupTxtUserName.text, signupTxtPassword.text);

      if (serverResponse.statusCode == 200) {
        userName = signupTxtUserName.text;

        print("User is created!");
        var _json = {"username": userName, "password": signupTxtPassword.text};
        fileHandler.saveFile(_json, fileAuthenticate);
        try {
          var serverResponse =
              await net.mainLogin(userName, signupTxtPassword.text);
          if (serverResponse.statusCode == 200) {
            print("User is logged in!");
          } else {
            // TODO: handle not logged in case
            print("user not logged in");
          }
        } catch (e) {
          print("error logging in!");
        }
        pages.navigateToSelectPageR(context);
      } else {
        print("User not created");
      }
    } catch (e) {
      print("error signing up!");
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
                      widgetTextFormField(
                          email_, enterValidEmail_, loginTxtUserName),
                      widgetTextFormField(
                          password_, enterSecurePassword_, loginTxtPassword),
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
                      widgetTextFormField(
                          email_, enterValidEmail_, signupTxtUserName),
                      widgetTextFormField(
                          password_, enterSecurePassword_, signupTxtPassword),
                      widgetSizedBox(20),
                      widgetButton(context, signupButtonPressed, signup_),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
