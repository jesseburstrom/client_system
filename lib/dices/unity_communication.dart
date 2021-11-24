part of "../main.dart";

extension UnityCommunication on Dices {
  sendResetToUnity() {
    UnityMessage msg = UnityMessage.reset(nrDices, nrTotalRolls);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  sendStartToUnity() {
    UnityMessage msg = UnityMessage.start();

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  sendDicesToUnity() {
    var msg = UnityMessage.updateDices(diceValue);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  sendColorsToUnity() {
    var msg = UnityMessage.updateColors(unityColors);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  sendTransparencyChangedToUnity() {
    var msg = UnityMessage.changeBool("Transparency", unityTransparent);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  sendLightMotionChangedToUnity() {
    var msg = UnityMessage.changeBool("LightMotion", unityLightMotion);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  // Communication from Unity to Flutter
  onUnityMessage(message) {
    var msg = message.toString();
    print("Received message from unity: $msg");
    try {
      var _json = jsonDecode(msg);
      print(_json);
      if (_json["action"] == "results") {
        diceValue = _json["diceResult"].cast<int>();
        print(diceValue);
        callbackUpdateDiceValues();
        nrRolls += 1;
      }
    } catch (e) {
      print("Error decoding Unity message");
    }
  }

  // Callback that connects the created controller to the unity controller
  onUnityCreated(controller) {
    unityWidgetController = controller;
    unityCreated = true;
    sendResetToUnity();
    callbackUnityCreated();

    print("Unity Created");
  }

  // Communication from Unity when new scene is loaded to Flutter
  onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print("Received scene loaded from unity: ${sceneInfo.name}");
    print(
        "Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}");
  }
}
