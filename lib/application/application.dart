part of "../main.dart";

// cannot have typedef inside class
typedef YatzyFunctions = int Function();

class Application extends LanguagesApplication with AnimationsApplication {
  Application() {
    gameDices = Dices(callbackDiceUpdateDiceValues, callbackDiceUnityCreated,
        callbackDiceCheckPlayerToMove);
    languagesSetup();
    setup();
    setupAnimation(nrPlayers, maxNrPlayers, maxTotalFields);
    //net.connectToServer();

    net.callbackOnClientMsg = callbackOnClientMsg;
    net.callbackOnServerMsg = callbackOnServerMsg;
  }

  // "Ordinary" , "Mini", "Maxi"
  var gameType = "Ordinary";

  // Used by animation
  var maxNrPlayers = 4;
  var maxTotalFields = 23;

  // Socket game
  var gameId = -1;
  var playerIds = [];

  var totalFields = 18;
  var nrPlayers = 1;
  var bonusSum = 63;
  var bonusAmount = 50;
  var myPlayerId = -1;
  var playerToMove = 0;

  var boardXPos = [],
      boardYPos = [],
      boardWidth = [],
      boardHeight = [],
      boardXAnimationPos = [],
      boardYAnimationPos = [],
      cellValue = [],
      fixedCell = [],
      appText = [],
      appColors = [],
      focusStatus = [];

  var listenerKey = GlobalKey();

  /*
  var _cellKeys = [];
  for (int i = 0; i < NrPlayers + 1; i++) {
  List<GlobalKey> tmp = [];
  for (int j = 0; j < TotalFields; j++) {
  tmp.add(new GlobalKey());
  }
  _cellKeys.add(tmp);
  }
   */

  late Dices gameDices;

  late List<YatzyFunctions> yatzyFunctions;

  navigateToPage(BuildContext context, [bool replace = true]) {
    pages.navigateToMainPage(
        context,
        {
          "page": widgetScaffold,
          "postFrameCallback": startAnimations,
          "dispose": animationsScroll.animationController.stop
        },
        replace);
  }

  callbackOnServerMsg(var data) {
    print("onServerMsg");
    print(data);
    switch (data["action"]) {
      case "onGetId":
        print("onGetId");
        data = Map<String, dynamic>.from(data);
        net.socketConnectionId = data["id"];
        break;
      case "onGameStart":
        data = Map<String, dynamic>.from(data);
        myPlayerId = data["playerIds"].indexOf(net.socketConnectionId);
        print(data["playerIds"]);
        print(net.socketConnectionId);
        print("myPlayerID: " + myPlayerId.toString());
        gameId = data["gameId"];
        playerIds = data["playerIds"];
        print("start game");
        applicationSettings.startGame(data["gameType"], data["nrPlayers"]);
        break;
      case "onRequestGames":
        print("onRequestGames");
        data = List<dynamic>.from(data["Games"]);
        print(data);
        applicationSettings.games = data;
        pages._state();

        break;
      case "onGameAborted":
        print("onGameAborted");
        data = Map<String, dynamic>.from(data["game"]);
        applicationStarted = false;
        applicationSettings.navigateToPage(pages._contextMain);
        break;
    }
  }

  updateChat(String text) async {
    chat.messages.add(ChatMessage(text, "receiver"));
    pages._stateMain();
    await Future.delayed(const Duration(milliseconds: 100), () {});
    chat.scrollController.animateTo(
        chat.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
  }

  callbackOnClientMsg(var data) {
    print("onClientMsg");
    print(data);
    switch (data["action"]) {
      case "sendSelection":
        gameDices.diceValue = data["diceValue"].cast<int>();
        updateDiceValues();
        calcNewSums(data["player"], data["cell"]);
        pages._stateMain();
        if (myPlayerId == playerToMove && gameDices.unityDices[0]) {
          gameDices.sendStartToUnity();
        }
        break;
      case "sendDices":
        print("onDices");
        data = Map<String, dynamic>.from(data);
        print(data["diceValue"]);
        gameDices.diceValue = data["diceValue"].cast<int>();
        updateDiceValues();
        gameDices.nrRolls += 1;
        gameDices.updateDiceImages();
        pages._stateMain();
        break;
      case "chatMessage":
        print("chatMessage");
        print(data["chatMessage"]);
        updateChat(data["chatMessage"]);
        break;
    }
  }

  bool callbackDiceCheckPlayerToMove() {
    return playerToMove == myPlayerId;
  }

  callbackDiceUnityCreated() {
    if (myPlayerId == playerToMove) {
      gameDices.sendStartToUnity();
    }
  }

  callbackDiceUpdateDiceValues() {
    updateDiceValues();
    Map<String, dynamic> msg = {};
    msg["action"] = "sendDices";
    msg["gameId"] = gameId;
    msg["playerIds"] = playerIds;
    msg["diceValue"] = gameDices.diceValue;

    print(msg);
    net.sendToClients(msg);
  }

  updateDiceValues() {
    clearFocus();
    for (var i = 0; i < totalFields; i++) {
      if (!fixedCell[playerToMove][i]) {
        cellValue[playerToMove][i] = yatzyFunctions[i]();
        appText[playerToMove + 1][i] = cellValue[playerToMove][i].toString();
      }
    }
  }

  setAppText() {
    if (gameType == "Mini") {
      appText[0] = [
        ones_,
        twos_,
        threes_,
        fours_,
        fives_,
        sixes_,
        sum_,
        bonus_ + " (" + bonusAmount.toString() + ")",
        pair_,
        twoPairs_,
        threeOfKind_,
        smallStraight_,
        middleStraight_,
        largeStraight_,
        chance_,
        yatzy_,
        totalSum_
      ];
    } else if (gameType == "Maxi") {
      appText[0] = [
        ones_,
        twos_,
        threes_,
        fours_,
        fives_,
        sixes_,
        sum_,
        bonus_ + " (" + bonusAmount.toString() + ")",
        pair_,
        twoPairs_,
        threePairs_,
        threeOfKind_,
        fourOfKind_,
        fiveOfKind_,
        smallStraight_,
        largeStraight_,
        fullStraight_,
        house32_,
        house33_,
        house24_,
        chance_,
        maxiYatzy_,
        totalSum_
      ];
    } else {
      appText[0] = [
        ones_,
        twos_,
        threes_,
        fours_,
        fives_,
        sixes_,
        sum_,
        bonus_ + " (" + bonusAmount.toString() + ")",
        pair_,
        twoPairs_,
        threeOfKind_,
        fourOfKind_,
        house_,
        smallStraight_,
        largeStraight_,
        chance_,
        yatzy_,
        totalSum_
      ];
    }
  }

  setup() {
    playerToMove = 0;

    if (gameType == "Mini") {
      totalFields = 17;
      gameDices.initDices(4);
      bonusSum = 50;
      bonusAmount = 25;

      yatzyFunctions =
          [calcOnes, calcTwos, calcThrees, calcFours, calcFives, calcSixes] +
              [
                zero,
                zero,
                calcPair,
                calcTwoPairs,
                calcThreeOfKind,
                calcSmallLadder,
                calcMiddleLadder,
                calcLargeLadder,
                calcChance,
                calcYatzy,
                zero
              ];
    } else if (gameType == "Maxi") {
      totalFields = 23;
      gameDices.initDices(6);
      bonusSum = 84;
      bonusAmount = 100;

      yatzyFunctions =
          [calcOnes, calcTwos, calcThrees, calcFours, calcFives, calcSixes] +
              [
                zero,
                zero,
                calcPair,
                calcTwoPairs,
                calcThreePairs,
                calcThreeOfKind,
                calcFourOfKind,
                calcFiveOfKind,
                calcSmallLadder,
                calcLargeLadder,
                calcFullLadder,
                calcHouse,
                calcVilla,
                calcTower,
                calcChance,
                calcYatzy,
                zero
              ];
    } else {
      totalFields = 18;
      gameDices.initDices(5);
      bonusSum = 63;
      bonusAmount = 50;

      yatzyFunctions =
          [calcOnes, calcTwos, calcThrees, calcFours, calcFives, calcSixes] +
              [
                zero,
                zero,
                calcPair,
                calcTwoPairs,
                calcThreeOfKind,
                calcFourOfKind,
                calcHouse,
                calcSmallLadder,
                calcLargeLadder,
                calcChance,
                calcYatzy,
                zero
              ];
    }

    appText = [];
    for (var i = 0; i < nrPlayers + 1; i++) {
      appText.add(List.filled(6, "") +
          List.filled(1, "0") +
          List.filled(1, (-bonusSum).toString()) +
          List.filled(totalFields - 9, "") +
          List.filled(1, "0"));
    }
    setAppText();

    boardXPos = [List.filled(maxTotalFields, 0.0)];
    boardYPos = [List.filled(maxTotalFields, 0.0)];
    boardWidth = [List.filled(maxTotalFields, 0.0)];
    boardHeight = [List.filled(maxTotalFields, 0.0)];
    boardXAnimationPos = [List.filled(maxTotalFields, 0.0)];
    boardYAnimationPos = [List.filled(maxTotalFields, 0.0)];
    for (var i = 0; i < maxNrPlayers; i++) {
      boardXPos.add(List.filled(maxTotalFields, 0.0));
      boardYPos.add(List.filled(maxTotalFields, 0.0));
      boardWidth.add(List.filled(maxTotalFields, 0.0));
      boardHeight.add(List.filled(maxTotalFields, 0.0));
      boardXAnimationPos.add(List.filled(maxTotalFields, 0.0));
      boardYAnimationPos.add(List.filled(maxTotalFields, 0.0));
    }
    clearFocus();
    fixedCell = [];
    cellValue = [];
    appColors = [
      List.filled(6, Colors.white.withOpacity(0.3)) +
          List.filled(2, Colors.blueAccent.withOpacity(0.8)) +
          List.filled(totalFields - 9, Colors.white.withOpacity(0.3)) +
          List.filled(1, Colors.blueAccent.withOpacity(0.8))
    ];
    for (var i = 0; i < nrPlayers; i++) {
      fixedCell.add(List.filled(6, false) +
          [true, true] +
          List.filled(totalFields - 9, false) +
          [true]);
      if (i == playerToMove) {
        appColors.add(List.filled(6, Colors.greenAccent.withOpacity(0.3)) +
            List.filled(2, Colors.blue.withOpacity(0.3)) +
            List.filled(totalFields - 9, Colors.greenAccent.withOpacity(0.3)) +
            List.filled(1, Colors.blue.withOpacity(0.3)));
      } else {
        appColors.add(List.filled(6, Colors.grey.withOpacity(0.3)) +
            List.filled(2, Colors.blue.withOpacity(0.3)) +
            List.filled(totalFields - 9, Colors.grey.withOpacity(0.3)) +
            List.filled(1, Colors.blue.withOpacity(0.3)));
      }
      cellValue.add(List.filled(totalFields, -1));
    }
    if (gameDices.unityCreated) {
      gameDices.sendResetToUnity();
      if (application.myPlayerId == application.playerToMove) {
        application.gameDices.sendStartToUnity();
      }
    }
  }
}
