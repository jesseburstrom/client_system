part of "../main.dart";

// Test Pull request
List<Widget> layoutTopToBottom(double w, double h, List<Function> widgets) {
  double widthA = w * 0.45;
  double heightA = h * 0.20;
  double widthB = w;
  double heightB = h * 0.45;

  return [
    Positioned(left: w * 0.025, top: 0, child: widgets[0](widthA, heightA)),
    Positioned(left: 0, top: heightA, child: widgets[1](widthB, heightB)),
  ];
}

List<Widget> layoutLeftToRight(double w, double h, List<Function> widgets) {
  double widthA = w * 0.45;
  double heightA = h * 0.20;
  double widthB = w;
  double heightB = h * 0.45;

  return [
    Positioned(left: w * 0.025, top: 0, child: widgets[0](widthA, heightA)),
    Positioned(left: 0, top: heightA, child: widgets[1](widthB, heightB)),
  ];
}
