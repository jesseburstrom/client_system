part of "../main.dart";

extension WidgetApp on App {
  Widget widgetCRUD(BuildContext context, double width, double height) {
    var listings = <Widget>[];

    listings.add(SizedBox(
        width: width,
        height: height,
        child: Column(children: [
          Row(children: [
            SizedBox(
                width: width * 0.5,
                height: height * 0.5,
                child: widgetUpdateProduct(context)),
            SizedBox(
                width: width * 0.5,
                height: height * 0.5,
                child: widgetUpdateCategory(context)),
          ]),
          Row(children: [
            SizedBox(
                width: width * 0.5,
                height: height * 0.5,
                child: widgetUpdateCategoryCategory(context)),
            SizedBox(
                width: width * 0.5,
                height: height * 0.5,
                child: widgetUpdateCategoryProduct(context)),
          ])
        ])));

    return Stack(children: listings);
  }
}
