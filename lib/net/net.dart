part of '../main.dart';

class Net {
  late Socket socketConnection;

  // 'action' : String tells server meaning of message
  sendToClients(Map<String, dynamic> msg) {
    msg["timestamp"] = DateTime.now().millisecondsSinceEpoch;
    socketConnection.emit(
      "sendToClients",
      msg,
    );
  }

  sendRequestGame(String gameType, int nrPlayers) {
    socketConnection.emit(
      "sendRequestGame",
      {
        "playerIds": [socketConnection.id],
        "gameType": gameType,
        "nrPlayers": nrPlayers,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  onSelection(var data) {
    print('selection');
    print(data);
    application.gameDices.diceValue = data['diceValue'].cast<int>();
    application.updateDiceValues();
    application.calcNewSums(data['player'], data['cell']);
    globalSetState();
    if (application.myPlayerId == application.playerToMove &&
        application.gameDices.unityDices[0]) {
      application.gameDices.sendStartToUnity();
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

  onGameStart(var data) {
    print('onGameStart');
    data = Map<String, dynamic>.from(data);
    print(data);
    application.myPlayerId = data['playerIds'].indexOf(socketConnection.id);
    application.gameId = data['gameId'];
    application.playerIds = data['playerIds'];
    print("start game");
    gameRequest.startGame(data['gameType'], data['nrPlayers']);
  }

  // Recieve gamelist updates
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
      // Configure socket, transports must be sepecified
      socketConnection = io(localhostIO, <String, dynamic>{
        'transports': ['websocket'],
      });

      socketConnection.on('onGameAborted', onGameAborted);
      socketConnection.on('onSelection', onSelection);
      socketConnection.on('onDices', onDices);
      socketConnection.on('onRequestGame', onRequestGame);
      socketConnection.on('onGameStart', onGameStart);
      socketConnection.on('disconnect', (_) => print('disconnect'));
    } catch (e) {
      print(e.toString());
    }
  }

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
