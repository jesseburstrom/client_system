part of "../main.dart";

class Dices extends LanguagesDices with AnimationsRollDices, InputItems {
  Dices(Function updateDiceValues, Function unityCreated,
      Function checkPlayerToMove) {
    languagesSetup();
    setupAnimation();
    callbackUpdateDiceValues = updateDiceValues;
    callbackUnityCreated = unityCreated;
    callbackCheckPlayerToMove = checkPlayerToMove;
  }

  var holdDices = [], holdDiceText = [], holdDiceOpacity = [];

  var randomNumberGenerator = Random();
  var nrRolls = 0;
  var nrTotalRolls = 3;
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
  var unityDices = false;
  var unityTransparent = true;
  var unityLightMotion = true;
  var unityColorChangeOverlay = false;

  clearDices() {
    diceValue = List.filled(nrDices, 0);
    holdDices = List.filled(nrDices, false);
    holdDiceText = List.filled(nrDices, "");
    holdDiceOpacity = List.filled(nrDices, 0.0);
    diceRef = List.filled(nrDices, "assets/images/empty.jpg");
    nrRolls = 0;
  }

  initDices(int nrdices) {
    if (unityCreated) {
      sendResetToUnity();
    }
    nrDices = nrdices;
    diceValue = List.filled(nrDices, 0);
    holdDices = List.filled(nrDices, false);
    holdDiceText = List.filled(nrDices, "");
    holdDiceOpacity = List.filled(nrDices, 0.0);
    diceRef = List.filled(nrDices, "assets/images/empty.jpg");
    nrRolls = 0;
  }

  holdDice(int dice) {
    if (nrRolls > 0 && nrRolls < nrTotalRolls) {
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
    if (unityDices) {
      sendDicesToUnity();
    } else {
      for (var i = 0; i < nrDices; i++) {
        diceRef[i] = "assets/images/" + diceFile[diceValue[i]];
      }
    }
  }

  bool rollDices() {
    if (nrRolls < nrTotalRolls) {
      nrRolls += 1;
      for (var i = 0; i < nrDices; i++) {
        if (!holdDices[i]) {
          diceValue[i] = randomNumberGenerator.nextInt(6) + 1;
          diceRef[i] = "assets/images/" + diceFile[diceValue[i]];
        } else {
          if (nrRolls == nrTotalRolls) {
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
}
