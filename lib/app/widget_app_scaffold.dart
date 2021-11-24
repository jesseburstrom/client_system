part of "../main.dart";

extension WidgetAppScaffold on App {
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
                  Image.asset("assets/images/img3.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  Stack(children: stackedWidgets),
                ] +
                layoutTopToBottom(
                  context,
                  screenWidth,
                  screenHeight,
                  [
                    chat.widgetChat,
                    animationsScroll.widgetEmptyContainer,
                    widgetCRUD,
                    widgetShopping
                  ],
                ),
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
                  Image.asset("assets/images/neutral.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  Stack(children: stackedWidgets)
                ] +
                layoutLeftToRight(
                  context,
                  screenWidth,
                  screenHeight,
                  [
                    chat.widgetChat,
                    animationsScroll.widgetEmptyContainer,
                    widgetCRUD,
                    widgetShopping
                  ],
                ),
          ));
    }
  }
}
