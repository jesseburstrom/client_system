part of "../main.dart";

class AnimationsScroll extends LanguagesAnimationsScroll {
  AnimationsScroll() {
    setup();
  }

  var sizeAnimation = 350.0;
  var scrollHeight = 200.0;
  var keyXPos = 0.0, keyYPos = 0.0;
  var counterR = 0, counterG = 0, counterB = 0;
  var scrollTextStyle = const TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0),
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
    letterSpacing: 3,
    wordSpacing: 3,
  );
  var emptyContainerKey = GlobalKey();

  var animationController = AnimationController(
      vsync: _MainAppHandlerState(), duration: const Duration(seconds: 1));

  late Animation<double> positionAnimation;

  // Size calcTextSize(String text, TextStyle style) {
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: text, style: style),
  //     textDirection: TextDirection.ltr,
  //     //textScaleFactor: MediaQuery.of(context).textScaleFactor,
  //     textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
  //   )..layout();
  //   return textPainter.size;
  // }

  setup() {
    positionAnimation =
        CurveTween(curve: Curves.linear).animate(animationController);

    animationController.addListener(() {
      RenderBox box =
          emptyContainerKey.currentContext?.findRenderObject() as RenderBox;
      Offset position =
          box.localToGlobal(Offset.zero); //this is global position
      keyXPos = position.dx;
      keyYPos = position.dy;
      sizeAnimation = emptyContainerKey.currentContext!.size!.width;
      scrollHeight = emptyContainerKey.currentContext!.size!.height;
      counterR += 3;
      counterG += 2;
      counterB += 1;
      scrollTextStyle = TextStyle(
        color: Color.fromRGBO(
            100 - (counterR % 100), counterG % 100, counterB % 256, 1.0),
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        letterSpacing: 3,
        wordSpacing: 3,
      );

      keyYPos += positionAnimation.value * 30;
    });
    stackedWidgets.add(widgetAnimationsScroll());
  }
}
