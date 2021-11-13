part of "../main.dart";

class Net {
  late Socket socketConnection;
  late Function callbackOnClientMsg;
  late Function callbackOnServerMsg;
  late WebSocketChannel webSocketChannel;
  var isWebSocketChannel = true;
  var socketConnectionId = "";

  sendToClients(Map<String, dynamic> msg) {
    msg["timestamp"] = DateTime.now().millisecondsSinceEpoch;
    if (isWebSocketChannel) {
      msg["messageType"] = "sendToClients";
      webSocketChannel.sink.add(jsonEncode(msg));
    } else {
      socketConnection.emit(
        "sendToClients",
        msg,
      );
    }
  }

  sendToServer(Map<String, dynamic> msg) async {
    msg["timestamp"] = DateTime.now().millisecondsSinceEpoch;
    if (isWebSocketChannel) {
      msg["messageType"] = "sendToServer";
      webSocketChannel.sink.add(jsonEncode(msg));
    } else {
      socketConnection.emit(
        "sendToServer",
        msg,
      );
    }
  }

  onClientMsg(var data) {
    callbackOnClientMsg(data);
  }

  onServerMsg(var data) {
    callbackOnServerMsg(data);
  }

  listenStream(message) {
    var data = jsonDecode(message);
    print(data);
    switch (data["messageType"]) {
      case "onServerMsg":
        callbackOnServerMsg(data);
        break;
      case "onClientMsg":
        callbackOnClientMsg(data);
        break;
    }
  }

  connectToServer() async {
    print("connectToServer");
    if (isWebSocketChannel) {
      try {
        webSocketChannel = WebSocketChannel.connect(Uri.parse(localhostIOWSC));
        webSocketChannel.stream.listen(listenStream);
      } catch (e) {
        print("error");
        print(e.toString());
      }
    } else {
      try {
        // Configure socket, transports must be sepecified
        socketConnection = io(localhostIO, <String, dynamic>{
          "transports": ["websocket"],
        });
        socketConnectionId = socketConnection.id!;
        socketConnection.on("onClientMsg", onClientMsg);
        socketConnection.on("onServerMsg", onServerMsg);
        socketConnection.on("disconnect", (_) => print("disconnect"));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // Http
  Future mainMakeGetHighscores() async {
    var response = await post(Uri.parse(localhost + "/getTopHighscores"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        });

    return response;
  }

  Future mainMakeUpdateHighscores(name, score) async {
    var response = await post(Uri.parse(localhost + "/updateHighscores"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "serverName": name,
          "serverScore": score.toString()
          //"Authorization": authenticate.Jwt
        }));

    return response;
  }

  Future mainLogin(String userName, String password) async {
    var response = await post(Uri.parse(localhost + "/login"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "serverUserName": userName,
          "serverPassword": password,
        }));

    return response;
  }

  Future mainSignup(String userName, String password) async {
    var response = await post(Uri.parse(localhost + "/signup"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "serverUserName": userName,
          "serverPassword": password,
        }));

    return response;
  }
}
