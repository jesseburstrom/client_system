part of "../main.dart";

class AnimationsRollDices {
  var animationController = AnimationController(
      vsync: _PageMainState(),
      duration: const Duration(milliseconds: 300));
  late Animation<double> sizeAnimation;

  setupAnimation() {
    sizeAnimation =
        CurveTween(curve: Curves.easeInSine).animate(animationController);

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });
  }
}
