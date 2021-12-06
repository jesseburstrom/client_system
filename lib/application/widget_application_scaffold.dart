part of "../main.dart";

extension WidgetApplicationScaffold on Application {
  Widget widgetScaffold(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    if (screenHeight > screenWidth) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateToSettings(context, false);
            },
            tooltip: "Settings",
            child: const Icon(Icons.settings_applications),
            backgroundColor: Colors.blue,
          ),
          body: Stack(
            children: <Widget>[
                  Image.asset("assets/images/yatzy_portrait_dark.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  Stack(children: stackedWidgets),
                ] +
                layoutTopToBottom(screenWidth, screenHeight, [
                  highscore.widgetHighscore,
                  widgetSetupGameBoard,
                  gameDices.widgetDices,
                  chat.widgetChat,
                  animationsScroll.widgetEmptyContainer,
                  widgetDisplayGameStatus
                ]) +
                [gameDices.widgetWrapCCOverlay(context, pages._stateMain)],
          ));
    } else {
      // landscape
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateToSettings(context, false);
            },
            tooltip: "Settings",
            child: const Icon(Icons.settings_applications),
            backgroundColor: Colors.blue,
          ),
          body: Stack(
            children: <Widget>[
                  // ColorFiltered(
                  //   colorFilter: const ColorFilter.mode(
                  //     Color.fromRGBO(0, 0, 0, 0.5),
                  //     BlendMode.darken,
                  //   ),
                  //  child:
                  Image.asset("assets/images/yatzy_landscape2.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  // ),
                  Stack(children: stackedWidgets)
                ] +
                layoutLeftToRight(screenWidth, screenHeight, [
                  widgetSetupGameBoard,
                  gameDices.widgetDices,
                  highscore.widgetHighscore,
                  chat.widgetChat,
                  animationsScroll.widgetEmptyContainer,
                  widgetDisplayGameStatus
                ]),
          ));
    }
  }
}
