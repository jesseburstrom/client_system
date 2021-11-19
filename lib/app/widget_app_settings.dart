part of "../main.dart";

extension WidgetAppSettings on App {


  // List of widgets for the application specific settings
  List<Widget> settings() {
    return <Widget>[];
  }


  Widget widgetScaffoldSettings(BuildContext context) {
    Function state = pages._state;
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
                  Tab(text: application_),
                  Tab(text: general_),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: settings(),
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(children: [
                          widgetSizedBox(15),
                          widgetParagraph(misc_),
                          widgetDropDownList(
                              pages._state,
                              " " + choseLanguage_,
                              Languages.differentLanguages,
                              Languages.chosenLanguage),
                        ])))
              ],
            )));
  }
}
