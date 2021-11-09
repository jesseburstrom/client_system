part of "./main.dart";

// Test Pull request
List<Widget> layoutPTopToBottom(double w, double h, Function fA, Function fB,
    Function fC, Function fD, Function fE, Function fF) {
  double widthA,
      heightA,
      widthB,
      heightB,
      widthC,
      heightC,
      widthD,
      heightD,
      widthE,
      heightE,
      widthF,
      heightF;

  widthA = w * 0.45;
  heightA = h * 0.20;
  widthD = w * 0.45;
  heightD = h * 0.16;
  widthF = w * 0.35;
  heightF = h * 0.11;
  widthB = w;
  heightB = h * 0.45;
  widthC = w;
  heightC = h * 0.25;
  widthE = w * 0.6;
  heightE = h - heightA - heightB - heightC;

  return [
    Positioned(left: 0, top: heightA + heightB, child: fC(widthC, heightC)),
    Stack(children: [
      Positioned(left: w * 0.025, top: 0, child: fA(widthA, heightA)),
      Positioned(left: 0, top: heightA, child: fB(widthB, heightB)),
      Positioned(left: w * 0.525, top: h * 0.04, child: fD(widthD, heightD)),
      Positioned(left: w * 0.03, top: h * 0.885, child: fF(widthF, heightF)),
      Positioned(
          left: w * 0.4,
          top: heightA + heightB + heightC,
          child: fE(widthE, heightE))
    ])
  ];
}

List<Widget> layoutLLeftToRight(double w, double h, Function fA, Function fB,
    Function fC, Function fD, Function fE, Function fF) {
  double widthA,
      heightA,
      widthB,
      heightB,
      widthC,
      heightC,
      widthD,
      heightD,
      widthE,
      heightE,
      widthF,
      heightF;

  widthA = w * 0.35;
  heightA = h;
  widthB = w * 0.45;
  heightB = application.gameDices.unityDices[0] ? widthB * 9 / 16 : h;
  widthC = w * 0.18;
  heightC = h * 0.8;
  widthD = w * 0.19;
  heightD = h * 0.3;
  widthF = w * 0.15;
  heightF = h * 0.3;
  widthE = w * 0.37;
  heightE = h - heightC;

  return [
    Positioned(
        left: widthA,
        top: application.gameDices.unityDices[0] ? h - heightB : 0,
        child: fB(widthB, heightB)),
    Stack(children: [
      Positioned(
          left: widthA + w * 0.085, top: -h * 0.08, child: fE(widthE, heightE)),
      Positioned(left: 0, top: 0, child: fA(widthA, heightA)),
      Positioned(left: w * 0.81, top: 0, child: fC(widthC, heightC)),
      Positioned(left: w * 0.61, top: h * 0.05, child: fD(widthD, heightD)),
      Positioned(
          left: widthA + w * 0.1, top: h * 0.05, child: fF(widthF, heightF)),
    ])
  ];
}
