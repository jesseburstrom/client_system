part of "../main.dart";

extension AnimationsScrollWidget on AnimationsScroll {
  Widget widgetEmptyContainer(double width, double height) {
    return SizedBox(key: emptyContainerKey, width: width, height: height);
  }

  Widget widgetAnimationsScroll() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? widget) {
          List<String> text = scrollText_.split(".");
          List<AnimatedText> animatedTexts = [];
          for (String s in text) {
            animatedTexts.add(FadeAnimatedText(s));
          }

          return Positioned(
              left: keyXPos,
              top: keyYPos,
              child: SizedBox(
                  width: sizeAnimation,
                  height: scrollHeight,
                  child: FittedBox(
                    child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: animatedTexts,
                          repeatForever: true,
                        )),
                  )));
        });
  }
}
