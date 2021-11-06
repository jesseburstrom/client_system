part of '../main.dart';

class AnimationsHighscore {
  var animationController = AnimationController(
      vsync: _MainAppHandlerState(),
      duration: const Duration(milliseconds: 3000));
  late Animation<double> loopAnimation;

  setupAnimation() {
    loopAnimation =
        CurveTween(curve: Curves.easeInSine).animate(animationController);

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }
}
