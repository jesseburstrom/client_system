part of "../main.dart";

extension WidgetShopping on App {
  Widget widgetShopping(BuildContext context, double width, double height) {
    return Stack(children: [
      Column(children: [
        SizedBox(
            height: height * 0.20,
            width: width,
            child: Image.asset(
              "assets/images/bk/banner.jpg",
              fit: BoxFit.fill,
            )),
        SizedBox(
            height: height * 0.60,
            width: width,
            child: Row(children: [
              SizedBox(
                  width: width * 0.15,
                  child: Column(children: [
                    SizedBox(
                        height: height * 0.60 / 8,
                        width: width * 0.15,
                        child: Image.asset(
                          "assets/images/bk/meals.jpg",
                          fit: BoxFit.fill,
                        ))
                  ])),
              SizedBox(
                  width: width * 0.85,
                  child: Column(children: [
                    SizedBox(
                        height: height * 0.05,
                        width: width * 0.85,
                        child: Image.asset(
                          "assets/images/bk/desserts.jpg",
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                        height: height * 0.15,
                        width: width * 0.85,
                        child: Row(children: [
                          SizedBox(
                              width: width * 0.85 / 3,
                              height: height * 0.15,
                              child: Image.asset(
                                "assets/images/bk/campaign.jpg",
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                              width: width * 0.85 / 3,
                              height: height * 0.15,
                              child: Image.asset(
                                "assets/images/bk/kingjr.jpg",
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                              width: width * 0.85 / 3,
                              height: height * 0.15,
                              child: Image.asset(
                                "assets/images/bk/snacks.jpg",
                                fit: BoxFit.cover,
                              ))
                        ]))
                  ])),
            ])),
        SizedBox(height: height * 0.20),
      ])
    ]);
  }
}
