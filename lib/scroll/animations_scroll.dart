part of "../main.dart";

class AnimationsScroll extends LanguagesAnimationsScroll {
  AnimationsScroll() {
    languagesSetup();
    setup();
  }

  var sizeAnimation = 350.0;
  var scrollHeight = 200.0;
  var keyXPos = 0.0, keyYPos = 0.0;

  var emptyContainerKey = GlobalKey();

  var animationController = AnimationController(
      vsync: _PageMainState(), duration: const Duration(seconds: 1));

  late Animation<double> positionAnimation;

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

      keyYPos += positionAnimation.value * 30;
    });
    stackedWidgets.add(widgetAnimationsScroll());
  }
}
