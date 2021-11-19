part of "../main.dart";

// cannot have typedef inside class
typedef YatzyFunctions = int Function();

class Application extends LanguagesApplication with InputItems {
  Application() {
    gameDices = Dices(callbackUpdateDiceValues, callbackUnityCreated,
        callbackCheckPlayerToMove);
    languagesSetup();
    setup();
    animation.setupAnimation(nrPlayers, maxNrPlayers, maxTotalFields);
    net.setCallbacks(callbackOnClientMsg, callbackOnServerMsg);
    net.connectToServer();
    gameTypeS = [gameType];
    nrPlayersS = [nrPlayers];
  }

  var gameTypeS = <String>[];
  var nrPlayersS = <int>[];
  var games = [];
  var onSettingsPage = true;
  var tabController = TabController(length: 2, vsync: _PageDynamicState());

  var animation = AnimationsApplication();

  // Application properties
  // "Ordinary" , "Mini", "Maxi"
  var gameType = "Ordinary";
  var nrPlayers = 1;

  // Used by animation
  var maxNrPlayers = 4;
  var maxTotalFields = 23;

  // Socket game
  var gameId = -1;
  var playerIds = [];

  var totalFields = 18;
  var bonusSum = 63;
  var bonusAmount = 50;
  var myPlayerId = -1;
  var playerToMove = 0;

  var boardXPos = [],
      boardYPos = [],
      boardWidth = [],
      boardHeight = [],
      cellValue = [],
      fixedCell = [],
      appText = [],
      appColors = [],
      focusStatus = [];

  var listenerKey = GlobalKey();
  late Dices gameDices;
  late List<YatzyFunctions> yatzyFunctions;

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

  navigateToSettings(BuildContext context, [bool replace = true]) {
    pages.navigateToDynamicPage(
        context, {"page": widgetScaffoldSettings}, replace);
  }

  callbackOnServerMsg(var data) {
    print("onServerMsg");
    print(data);
    switch (data["action"]) {
      case "onGetId":
        data = Map<String, dynamic>.from(data);
        net.socketConnectionId = data["id"];
        break;
      case "onGameStart":
        data = Map<String, dynamic>.from(data);
        myPlayerId = data["playerIds"].indexOf(net.socketConnectionId);
        print(net.socketConnectionId);
        print("myPlayerID: " + myPlayerId.toString());
        gameId = data["gameId"];
        playerIds = data["playerIds"];
        setup();
        userName = userNames[myPlayerId];
        applicationStarted = true;
        onSettingsPage = true;
        navigateToApp(pages._context);
        break;
      case "onRequestGames":
        print("onRequestGames");
        data = List<dynamic>.from(data["Games"]);
        games = data;
        pages._state();
        break;
      case "onGameAborted":
        print("onGameAborted");
        data = Map<String, dynamic>.from(data["game"]);
        applicationStarted = false;
        navigateToSettings(pages._contextMain);
        break;
    }
  }

  chatCallbackOnSubmitted(String text) {
    pages._stateMain();
    Map<String, dynamic> msg = {};
    msg["chatMessage"] = userName + ": " + text;
    msg["action"] = "chatMessage";
    msg["playerIds"] = playerIds;
    print(msg);
    net.sendToClients(msg);
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
        data = Map<String, dynamic>.from(data);
        gameDices.diceValue = data["diceValue"].cast<int>();
        updateDiceValues();
        gameDices.nrRolls += 1;
        gameDices.updateDiceImages();
        pages._stateMain();
        break;
      case "chatMessage":
        updateChat(data["chatMessage"]);
        break;
    }
  }

  postFrameCallback(BuildContext context) async {
    await highscore.loadHighscoreFromServer();
    pages._stateMain();
    animationsScroll.animationController.repeat(reverse: true);
  }

  navigateToApp(BuildContext context, [bool replace = true]) {
    pages.navigateToMainPage(
        context,
        {
          "page": widgetScaffold,
          "postFrameCallback": postFrameCallback,
          "dispose": animationsScroll.animationController.stop
        },
        replace);
  }

  bool callbackCheckPlayerToMove() {
    return playerToMove == myPlayerId;
  }

  callbackUnityCreated() {
    if (myPlayerId == playerToMove) {
      gameDices.sendStartToUnity();
    }
  }

  callbackUpdateDiceValues() {
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
    pages._stateMain();
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
    animation.boardXAnimationPos = [List.filled(maxTotalFields, 0.0)];
    animation.boardYAnimationPos = [List.filled(maxTotalFields, 0.0)];
    for (var i = 0; i < maxNrPlayers; i++) {
      boardXPos.add(List.filled(maxTotalFields, 0.0));
      boardYPos.add(List.filled(maxTotalFields, 0.0));
      boardWidth.add(List.filled(maxTotalFields, 0.0));
      boardHeight.add(List.filled(maxTotalFields, 0.0));
      animation.boardXAnimationPos.add(List.filled(maxTotalFields, 0.0));
      animation.boardYAnimationPos.add(List.filled(maxTotalFields, 0.0));
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
      if (myPlayerId == playerToMove) {
        gameDices.sendStartToUnity();
      }
    }
  }
}
