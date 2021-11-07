part of "../main.dart";

class UnityMessage {
  UnityMessage(this.action);

  UnityMessage.reset(this.nrDices, this.nrThrows) {
    action = "reset";
  }

  UnityMessage.start() {
    action = "start";
  }

  UnityMessage.updateDices(this.dices) {
    action = "setProperty";
    property = "Dices";
  }

  UnityMessage.updateColors(this.unityColors) {
    action = "setProperty";
    property = "Color";
  }

  UnityMessage.changeBool(this.property, this.flag) {
    action = "setProperty";
  }

  UnityMessage.fromJson(Map<String, dynamic> json)
      : action = json["action"],
        nrDices = json["nrDices"],
        nrThrows = json["nrThrows"],
        property = json["property"],
        unityColors = json["colors"],
        flag = json["flag"],
        dices = json["Dices"];

  Map<String, dynamic> toJson() => {
        "action": action,
        "nrDices": nrDices,
        "nrThrows": nrThrows,
        "property": property,
        "colors": unityColors,
        "bool": flag,
        "Dices": dices,
      };

  var action = "";
  var property = "";
  var dices = [];
  var unityColors = [0.6, 0.7, 0.8, 0.1];
  var flag = true;
  var nrDices = 5;
  var nrThrows = 3;
}

class Dices extends LanguagesDices with AnimationsRollDices {
  Dices(Function updateDiceValues, Function unityCreated,
      Function checkPlayerToMove) {
    setupAnimation();
    callbackUpdateDiceValues = updateDiceValues;
    callbackUnityCreated = unityCreated;
    callbackCheckPlayerToMove = checkPlayerToMove;
  }

  var holdDices = [], holdDiceText = [], holdDiceOpacity = [];

  var randomNumberGenerator = Random();
  var nrRolls = 0;
  var nrDices = 5;
  var diceValue = List.filled(5, 0);
  var diceRef = [
    "assets/images/empty.jpg",
    "assets/images/empty.jpg",
    "assets/images/empty.jpg",
    "assets/images/empty.jpg",
    "assets/images/empty.jpg"
  ];
  var diceFile = [
    "empty.jpg",
    "1.jpg",
    "2.jpg",
    "3.jpg",
    "4.jpg",
    "5.jpg",
    "6.jpg"
  ];

  late Function callbackUpdateDiceValues;
  late Function callbackUnityCreated;
  late Function callbackCheckPlayerToMove;
  late UnityWidgetController unityWidgetController;
  var unityCreated = false;
  var unityColors = [0.6, 0.7, 0.8, 0.1];
  var unityDices = [false];
  var unityTransparent = [true];
  var unityLightMotion = [true];
  var unityColorChangeOverlay = [false];

  clearDices() {
    diceValue = List.filled(nrDices, 0);
    holdDices = List.filled(nrDices, false);
    holdDiceText = List.filled(nrDices, "");
    holdDiceOpacity = List.filled(nrDices, 0.0);
    diceRef = List.filled(nrDices, "assets/images/empty.jpg");
    nrRolls = 0;
  }

  initDices(int nrDices) {
    if (unityCreated) {
      sendResetToUnity();
    }
    nrDices = nrDices;
    diceValue = List.filled(nrDices, 0);
    holdDices = List.filled(nrDices, false);
    holdDiceText = List.filled(nrDices, "");
    holdDiceOpacity = List.filled(nrDices, 0.0);
    diceRef = List.filled(nrDices, "assets/images/empty.jpg");
    nrRolls = 0;
  }

  holdDice(int dice) {
    if (nrRolls > 0 && nrRolls < 3) {
      holdDices[dice] = !holdDices[dice];
      if (holdDices[dice]) {
        holdDiceText[dice] = hold_;
        holdDiceOpacity[dice] = 0.7;
      } else {
        holdDiceText[dice] = "";
        holdDiceOpacity[dice] = 0.0;
      }
    }
  }

  updateDiceImages() {
    if (unityDices[0]) {
      sendDicesToUnity();
    } else {
      for (var i = 0; i < nrDices; i++) {
        diceRef[i] = "assets/images/" + diceFile[diceValue[i]];
      }
    }
  }

  bool rollDices() {
    if (nrRolls < 3) {
      nrRolls += 1;
      for (var i = 0; i < nrDices; i++) {
        if (!holdDices[i]) {
          diceValue[i] = randomNumberGenerator.nextInt(6) + 1;
          diceRef[i] = "assets/images/" + diceFile[diceValue[i]];
        } else {
          if (nrRolls == 3) {
            holdDices[i] = false;
            holdDiceText[i] = "";
            holdDiceOpacity[i] = 0.0;
          }
        }
      }
      callbackUpdateDiceValues();

      return true;
    }
    return false;
  }

  void sendResetToUnity() {
    UnityMessage msg = UnityMessage.reset(nrDices, 3);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  void sendStartToUnity() {
    UnityMessage msg = UnityMessage.start();

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  void sendDicesToUnity() {
    var msg = UnityMessage.updateDices(diceValue);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  void sendColorsToUnity() {
    var msg = UnityMessage.updateColors(unityColors);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  void sendTransparencyChangedToUnity() {
    var msg = UnityMessage.changeBool("Transparency", unityTransparent[0]);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  void sendLightMotionChangedToUnity() {
    var msg = UnityMessage.changeBool("LightMotion", unityLightMotion[0]);

    var json = jsonEncode(msg.toJson());
    print(json);
    unityWidgetController.postMessage(
      "GameManager",
      "flutterMessage",
      json,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    var msg = message.toString();
    print("Received message from unity: $msg");
    try {
      var _json = jsonDecode(msg);
      print(_json);
      if (_json["action"] == "results") {
        diceValue = _json["diceResult"].cast<int>();
        print(diceValue);
        callbackUpdateDiceValues();

        globalSetState();
      }
    } catch (e) {
      print("Error decoding Unity message");
    }
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    unityWidgetController = controller;
    unityCreated = true;
    sendResetToUnity();
    callbackUnityCreated();

    print("Unity Created");
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print("Received scene loaded from unity: ${sceneInfo.name}");
    print(
        "Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}");
  }
}
