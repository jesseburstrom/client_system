part of "./main.dart";

// Test Pull request
List<Widget> layoutPTopToBottom4(
    double w, double h, Function fA, Function fB, Function fC, Function fD) {
  double widthA, heightA, widthB, heightB, widthC, heightC, widthD, heightD;

  widthA = w * 0.60;
  heightA = h * 0.20;
  widthB = w;
  heightB = h * 0.45;
  widthC = w;
  heightC = h * 0.25;
  widthD = w * 0.8;
  heightD = h - heightA - heightB - heightC;

  return [
    Positioned(left: 0, top: heightA + heightB, child: fC(widthC, heightC)),
    Stack(children: [
      Positioned(left: w * 0.20, top: 0, child: fA(widthA, heightA)),
      Positioned(left: 0, top: heightA, child: fB(widthB, heightB)),
      Positioned(
          left: 0, top: heightA + heightB + heightC, child: fD(widthD, heightD))
    ])
  ];
}

List<Widget> layoutLLeftToRight4(
    double w, double h, Function fA, Function fB, Function fC, Function fD) {
  double widthA, heightA, widthB, heightB, widthC, heightC, widthD, heightD;

  widthA = w * 0.35;
  heightA = h;
  widthB = w * 0.45;
  heightB = h;
  widthC = w - widthA - widthB;
  heightC = h * 0.8;
  widthD = w * 0.8 - widthA;
  heightD = h - heightC;

  return [
    Positioned(left: widthA, top: 0, child: fB(widthB, heightB)),
    Stack(children: [
      Positioned(left: widthA, top: heightC, child: fD(widthD, heightD)),
      Positioned(left: 0, top: 0, child: fA(widthA, heightA)),
      Positioned(left: widthA + widthB, top: 0, child: fC(widthC, heightC)),
    ])
  ];
}
