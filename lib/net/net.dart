part of '../main.dart';

class Net {
  late Socket socketConnection;

  sendDices(List<int> dices, int gameId, List<dynamic> playerIds) {
    socketConnection.emit(
      "sendDices",
      {
        "id": playerIds,
        "diceValue": dices,
        "gameId": gameId,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  sendSelection(int player, int cell, List<int> dices, int gameId,
      List<dynamic> playersIds) {
    socketConnection.emit(
      "sendSelection",
      {
        "id": playersIds,
        "player": player,
        "cell": cell,
        "diceValue": dices,
        "gameId": gameId,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  sendRequestGame(String gameType, int nrPlayers) {
    socketConnection.emit(
      "sendRequestGame",
      {
        "id": [socketConnection.id],
        "gameType": gameType,
        "nrPlayers": nrPlayers,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  sendJoinGame(var gameID) {
    socketConnection.emit(
      "sendJoinGame",
      {
        "id": socketConnection.id,
        "gameID": gameID,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  sendJoinedGameOK(var gameID) {
    socketConnection.emit(
      "sendJoinedGameOK",
      {
        "id": socketConnection.id,
        "gameID": gameID,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Listen to all message events from connected users
  onSelection(var data) {
    print('selection');
    print(data);
    if (data['id'] != socketConnection.id) {
      print('Got Selection');
      application.gameDices.diceValue = data['diceValue'].cast<int>();
      application.updateDiceValues();
      application.calcNewSums(data['player'], data['cell']);
      globalSetState();
      if (application.myPlayerId == application.playerToMove &&
          application.gameDices.unityDices[0]) {
        application.gameDices.sendStartToUnity();
      }
    }
  }

  onDices(var data) {
    print("onDices");
    print(data['diceValue']);
    application.gameDices.diceValue = data['diceValue'].cast<int>();
    application.updateDiceValues();
    application.gameDices.updateDiceImages();
    globalSetState();
  }

  onJoinGame(var data) {
    // Send join request affirmation
    //sendJoinedGameOK(data['gameID']);
    // Start game
  }

  onGameStart(var data) {
    print('onGameStart');
    data = Map<String, dynamic>.from(data);
    print(data);
    application.myPlayerId = data['id'].indexOf(socketConnection.id);
    application.gameId = data['gameId'];
    application.playerIds = data['id'];
    print("start game");
    gameRequest.startGame(data['gameType'], data['nrPlayers']);
  }

  onRequestGame(var data) {
    print('onRequestGame');

    data = List<dynamic>.from(data);

    print(data);
    print(data.length);
    gameRequest.games = data;
    gameRequest.state();
  }

  onGameAborted(var data) {
    print('onGameAborted');
    data = Map<String, dynamic>.from(data);
    print(data);
    gameStarted = false;
    pages.navigateToSelectPageR(globalContext);
  }

  connectToServer() {
    try {
      // Configure socket transports must be sepecified
      socketConnection = io(localhostIO, <String, dynamic>{
        'transports': ['websocket'],
      });

      // Handle socket events
      socketConnection.on('onGameAborted', onGameAborted);
      socketConnection.on('onSelection', onSelection);
      socketConnection.on('onDices', onDices);
      socketConnection.on('onRequestGame', onRequestGame);
      socketConnection.on('onGameStart', onGameStart);
      socketConnection.on('onJoinGame', onJoinGame);
      socketConnection.on(
          'connect', (_) => print('connect: ${socketConnection.id}'));
      socketConnection.on('disconnect', (_) => print('disconnect'));
      socketConnection.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  // Send update of user's typing status
  sendTyping(bool typing) {
    socketConnection.emit("typing", {
      "id": socketConnection.id,
      "typing": typing,
    });
  }

  // Listen to update of typing status from connected users
  handleTyping(var data) {
    print(data);
  }

  // HTTP functions
  Future mainMakeGetHighscores() async {
    var response = await post(Uri.parse(localhost + '/getTopHighscores'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    return response;
  }

  Future mainMakeUpdateHighscores(name, score) async {
    var response = await post(Uri.parse(localhost + '/updateHighscores'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'serverName': name,
          'serverScore': score.toString()
          //'Authorization': authenticate.Jwt
        }));

    return response;
  }

  Future mainLogin(String userName, String password) async {
    var response = await post(Uri.parse(localhost + '/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'serverUserName': userName,
          'serverPassword': password,
        }));

    return response;
  }

  Future mainSignup(String userName, String password) async {
    var response = await post(Uri.parse(localhost + '/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'serverUserName': userName,
          'serverPassword': password,
        }));

    return response;
  }
}
