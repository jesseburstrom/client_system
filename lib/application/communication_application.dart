part of "../main.dart";

extension CommunicationApplication on Application {
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
        gameType = data["gameType"];
        nrPlayers = data["nrPlayers"];
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
        if (myPlayerId == playerToMove && gameDices.unityDices) {
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
}
