part of "../main.dart";

extension DicesWidget on Dices {
  Widget widgetDices(double width, double height) {
    // First always start unity and hide if only 2D
    // Get best 16:9 fit
    var left = 0.0, top = 0.0, w = width, h = height, ratio = 16 / 9;
    if (width / height < ratio) {
      h = width / ratio;
      top = (height - h) / 2;
    } else {
      w = height * ratio;
      left = (width - w) / 2;
    }
    if (!unityDices[0]) {
      left = screenWidth;
      top = screenHeight;
    }

    if (unityDices[0]) {
      Widget widgetUnity = Positioned(
          left: left,
          top: top,
          child: SizedBox(
              width: w,
              height: h,
              child: UnityWidget(
                borderRadius: BorderRadius.zero,
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
                //onUnitySceneLoaded: onUnitySceneLoaded,
                fullscreen: false,
              )));

      return SizedBox(
          width: width, height: height, child: Stack(children: [widgetUnity]));
    }

    var orientationPortrait = (screenHeight > screenWidth) ? 1 : 0;
    double diceWidthHeight;

    left = 0;
    top = 0;
    var listings = <Widget>[];
    //listings.add(widgetUnity);

    // Spread dices evenly and place roll dice button under or at the side of.
    // The number 3.5 is assuming spacing is half dice 2 dices plus spacing between and around
    // Scaling 2 * NrDices instead of optimal (3*NrDices+1)/2 is to group dices more in portrait mode
    // Min 60 is to prevent too large dices
    if (orientationPortrait == 1) {
      diceWidthHeight = width / (2 * nrDices);
      left =
          diceWidthHeight / 2 + (width - diceWidthHeight * (2 * nrDices)) / 2;
      top = min(diceWidthHeight / 2,
          diceWidthHeight / 2 + (height - diceWidthHeight * 3.5) / 2);
    } else {
      diceWidthHeight = height / (2 * nrDices);
      left = diceWidthHeight / 2;
      top =
          diceWidthHeight / 2 + (height - diceWidthHeight * (2 * nrDices)) / 2;
    }

    for (var i = 0; i < nrDices; i++) {
      listings.add(
        Positioned(
            left: left + 2 * diceWidthHeight * i * orientationPortrait,
            top: top + 2 * diceWidthHeight * i * (1 - orientationPortrait),
            child: Container(
              width: diceWidthHeight,
              height: diceWidthHeight,
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.3)),
              child: Image.asset(diceRef[i]),
            )),
      );
      listings.add(Positioned(
        left: left + 2 * diceWidthHeight * i * orientationPortrait,
        top: top + 2 * diceWidthHeight * i * (1 - orientationPortrait),
        child: GestureDetector(
            onTap: () {
              holdDice(i);
              pages._stateMain();
            },
            child: Container(
              width: diceWidthHeight,
              height: diceWidthHeight,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(holdDiceOpacity[i])),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  holdDiceText[i],
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                  ),
                  //fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                //),
              ),
            )),
      ));
    }

    // Roll button
    listings.add(AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? widget) {
        final tmp = Listener(
            onPointerDown: (e) {
              if (!callbackCheckPlayerToMove()) {
                return;
              }
              if (rollDices()) {
                animationController.forward();
                pages._stateMain();
              }
            },
            child: Container(
              width: diceWidthHeight * (1 - sizeAnimation.value / 2),
              height: diceWidthHeight * (1 - sizeAnimation.value / 2),
              decoration: const BoxDecoration(color: Colors.red),
              child: Image.asset("assets/images/roll.jpg",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity),
            ));
        return Positioned(
          left: left +
              diceWidthHeight * (sizeAnimation.value / 4) +
              (nrDices - 1) * diceWidthHeight * orientationPortrait +
              1.5 * diceWidthHeight * (1 - orientationPortrait),
          top: top +
              diceWidthHeight * (sizeAnimation.value / 4) +
              1.5 * diceWidthHeight * orientationPortrait +
              (nrDices - 1) * diceWidthHeight * (1 - orientationPortrait),
          child: tmp,
        );
      },
    ));

    return SizedBox(
        width: width, height: height, child: Stack(children: listings));
  }

  List<Widget> widgetColorChangeOverlay(BuildContext context, Function state) {
    return <Widget>[
      widgetCheckbox(state, sendTransparencyChangedToUnity, transparency_,
          unityTransparent),
      widgetCheckbox(
          state, sendLightMotionChangedToUnity, lightMotion_, unityLightMotion),
      widgetSlider(context, state, sendColorsToUnity, red_, unityColors, 0),
      widgetSlider(context, state, sendColorsToUnity, green_, unityColors, 1),
      widgetSlider(context, state, sendColorsToUnity, blue_, unityColors, 2),
      widgetSlider(
          context, state, sendColorsToUnity, transparency_, unityColors, 3)
    ];
  }

  Widget widgetWrapCCOverlay(BuildContext context, Function state) {
    if (unityColorChangeOverlay[0]) {
      return Positioned(
          left: 0,
          top: 380,
          child: Container(
              color: Colors.white,
              width: 250,
              height: 150,
              child: ListView(
                  children: widgetColorChangeOverlay(context, state))));
    } else {
      return Container();
    }
  }
}
