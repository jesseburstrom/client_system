part of "../main.dart";

extension WidgetScaffoldApp on App {
  Widget widgetScaffold(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

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
                layoutTopToBottom(
                  screenWidth,
                  screenHeight,
                  [chat.widgetChat, animationsScroll.widgetEmptyContainer],
                ),
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
                layoutLeftToRight(
                  screenWidth,
                  screenHeight,
                  [chat.widgetChat, animationsScroll.widgetEmptyContainer],
                ),
          ));
    }
  }
}
