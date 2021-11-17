part of "../main.dart";

extension WidgetScaffoldApplication on Application {
  Widget widgetScaffold(BuildContext context) {
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
              applicationSettings.navigateToPage(context, false);
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
                    widgetSetupGameBoard,
                    gameDices.widgetDices,
                    chat.widgetChat,
                    animationsScroll.widgetEmptyContainer,
                    widgetDisplayGameStatus) +
                [gameDices.widgetWrapCCOverlay(context, pages._stateMain)],
          ));
    } else {
      // landscape
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              applicationSettings.navigateToPage(context, false);
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
                    widgetSetupGameBoard,
                    gameDices.widgetDices,
                    highscore.widgetHighscore,
                    chat.widgetChat,
                    animationsScroll.widgetEmptyContainer,
                    widgetDisplayGameStatus),
          ));
    }
  }
}
