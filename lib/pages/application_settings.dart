part of "../main.dart";

class PageApplicationSettings extends StatefulWidget {
  const PageApplicationSettings({Key? key}) : super(key: key);

  @override
  _PageApplicationSettingsState createState() =>
      _PageApplicationSettingsState();
}

class _PageApplicationSettingsState extends State<PageApplicationSettings>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return applicationSettings.widgetScaffoldGameSelect(context, state);
  }
}

class ApplicationSettings extends LanguagesGameSelect with InputItems {
  ApplicationSettings() {
    languagesSetup();
  }

  var gameType = [application.gameType];
  var nrPlayers = [application.nrPlayers.toString()];
  var tabController =
      TabController(length: 2, vsync: _PageApplicationSettingsState());

  List<Widget> widgetColorChangeOverlay(BuildContext context, Function state) {
    return <Widget>[
      widgetCheckbox(
          state,
          application.gameDices.sendTransparencyChangedToUnity,
          transparency_,
          application.gameDices.unityTransparent),
      widgetCheckbox(state, application.gameDices.sendLightMotionChangedToUnity,
          lightMotion_, application.gameDices.unityLightMotion),
      widgetSlider(context, state, application.gameDices.sendColorsToUnity,
          red_, application.gameDices.unityColors, 0),
      widgetSlider(context, state, application.gameDices.sendColorsToUnity,
          green_, application.gameDices.unityColors, 1),
      widgetSlider(context, state, application.gameDices.sendColorsToUnity,
          blue_, application.gameDices.unityColors, 2),
      widgetSlider(context, state, application.gameDices.sendColorsToUnity,
          transparency_, application.gameDices.unityColors, 3)
    ];
  }

  void onGameListButton(BuildContext context) {
    print("List games");
    //pages.navigateToMainAppHandlerPageR(context);
    pages.navigateToRequestPageR(context);

    // if (GameStarted) {
    //   Navigator.pop(context);
    // } else {
    //   GameStarted = true;
    //   pages.NavigateToMainAppHandlerPageR(context);
    // }
  }

  Widget widgetScaffoldGameSelect(BuildContext context, Function state) {
    return DefaultTabController(
        length: tabController.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(settings_),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: tabController,
                isScrollable: false,
                tabs: [
                  Tab(text: game_),
                  Tab(text: general_),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: <Widget>[
                      widgetStringRadioButton(
                          state,
                          ["Mini", "Ordinary", "Maxi"],
                          gameType,
                          [gameTypeMini_, gameTypeOrdinary_, gameTypeMaxi_]),
                      widgetStringRadioButton(state, ["1", "2", "3", "4"],
                          nrPlayers, ["1", "2", "3", "4"]),
                      widgetCheckbox(state, () => {}, choseUnity_,
                          application.gameDices.unityDices),
                      widgetCheckbox(state, () => {}, colorChangeOverlay_,
                          application.gameDices.unityColorChangeOverlay),
                      widgetSizedBox(15),
                      widgetButton(context, onGameListButton, gameList_),
                    ],
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                            children: [widgetParagraph(appearance_)] +
                                widgetColorChangeOverlay(context, state) +
                                [
                                  widgetSizedBox(15),
                                  widgetParagraph(misc_),
                                  widgetDropDownList(
                                      state,
                                      " " + choseLanguage_,
                                      Languages.differentLanguages,
                                      Languages.chosenLanguage),
                                ])))
              ],
            )));
  }
}
