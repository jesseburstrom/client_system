part of "../main.dart";

extension AnimationsApplication on Application {
  // Animation properties

  animateBoard() {
    for (var i = 0; i < players + 1; i++) {
      cellAnimationControllers[i][0].forward();
    }
  }

  setupAnimation(int nrPlayers, int maxNrPlayers, int maxTotalFields) {
    players = nrPlayers;
    for (Duration d in animationDurations) {
      animationControllers.add(AnimationController(
        vsync: _PageMainState(),
        duration: d,
      ));
    }

    animationControllers[0].addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationControllers[0].reverse();
      }
    });

    for (var i = 0; i < maxNrPlayers + 1; i++) {
      var tmp = <AnimationController>[];
      for (var j = 0; j < maxTotalFields; j++) {
        tmp.add(AnimationController(
          vsync: _PageMainState(),
          duration: const Duration(milliseconds: 500),
        ));
      }
      cellAnimationControllers.add(tmp);
    }

    for (var i = 0; i < maxNrPlayers + 1; i++) {
      var tmp = <Animation>[];
      for (var j = 0; j < maxTotalFields; j++) {
        tmp.add(CurveTween(curve: Curves.easeInSine)
            .animate(cellAnimationControllers[i][j]));
      }
      cellAnimation.add(tmp);
    }

    for (var i = 0; i < maxNrPlayers + 1; i++) {
      for (var j = 0; j < maxTotalFields; j++) {
        cellAnimationControllers[i][j].addListener(() {
          boardXAnimationPos[i][j] = cellAnimation[i][j].value * 100.0;
          if ((j < maxTotalFields - 1) && cellAnimation[i][j].value > 0.02) {
            if (!cellAnimationControllers[i][j + 1].isAnimating) {
              cellAnimationControllers[i][j + 1].forward();
            }
          }
        });
        cellAnimationControllers[i][j]
            .addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            cellAnimationControllers[i][j].reverse();
          }
        });
      }
    }
  }
}
