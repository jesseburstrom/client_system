part of '../main.dart';

extension WidgetAuthenticate on Authenticate {
  Widget widgetScaffold(BuildContext context) {
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
                      widgetInputEmail(email_, enterValidEmail_, loginUser),
                      widgetInputPassword(
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
                      widgetInputEmail(email_, enterValidEmail_, signupUser),
                      widgetInputEmail(
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
