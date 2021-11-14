part of "../main.dart";

class tmp {}

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
        print("Connected!");
        socketConnection.on("onClientMsg", onClientMsg);
        socketConnection.on("onServerMsg", onServerMsg);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // Http

  Future getDb(String route) async {
    dynamic response;

    if (isWebSocketChannel) {
      response =
          await get(Uri.parse(localhostNET + route), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer ' + authenticate.jwt,
      });
    } else {
      response =
          await get(Uri.parse(localhost + route), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      });
    }

    return response;
  }

  Future postDb(String route, Map<String, dynamic> json) async {
    dynamic response;

    if (isWebSocketChannel) {
      response = await post(Uri.parse(localhostNET + route),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': 'Bearer ' + authenticate.jwt,
          },
          body: jsonEncode(json));
    } else {
      response = await post(Uri.parse(localhost + route),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(json));
    }

    return response;
  }

  Future login(String userName, String password) async {
    var host = isWebSocketChannel ? localhostNET : localhost;
    var response = await post(Uri.parse(host + "/login"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": userName,
          "password": password,
        }));

    return response;
  }

  Future signup(String userName, String password) async {
    var response = await post(Uri.parse(localhost + "/signup"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": userName,
          "password": password,
        }));

    return response;
  }
}
