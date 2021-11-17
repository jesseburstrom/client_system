part of "../main.dart";

class Net {
  // Set to true for ASP .NET server with websocket and false for NodeJS server with socket.io
  var isWebSocketChannel = true;
  var socketConnectionId = "";

  late Socket socketConnection;
  late Function callbackOnClientMsg;
  late Function callbackOnServerMsg;
  late WebSocketChannel webSocketChannel;

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
        webSocketChannel = WebSocketChannel.connect(Uri.parse(localhostNETIO));
        webSocketChannel.stream.listen(listenStream);
      } catch (e) {
        print("error");
        print(e.toString());
      }
    } else {
      try {
        // Configure socket, transports must be specified
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

  Future getDB(String route, int count) async {
    dynamic response;

    if (isWebSocketChannel) {
      response = await get(
          Uri.parse(localhostNET + route + "?count=" + count.toString()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer " + authenticate.jwt,
          });
    } else {
      response = await get(
          Uri.parse(localhost + route + "?count=" + count.toString()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
    }

    return response;
  }

  Future postDB(String route, Map<String, dynamic> json, int count) async {
    dynamic response;

    if (isWebSocketChannel) {
      response = await post(
          Uri.parse(localhostNET + route + "?count=" + count.toString()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer " + authenticate.jwt,
          },
          body: jsonEncode(json));
    } else {
      response = await post(
          Uri.parse(localhost + route + "?count=" + count.toString()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(json));
    }

    return response;
  }

  Future deleteDB(String route, int id) async {
    dynamic response;

    if (isWebSocketChannel) {
      response = await delete(
          Uri.parse(localhostNET + route + "?id=" + id.toString()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer " + authenticate.jwt,
          });
    } else {
      response = await delete(
          Uri.parse(localhost + route + "?id=" + id.toString()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
    }

    return response;
  }

  Future deleteUser(String route, String email) async {
    dynamic response;

    if (isWebSocketChannel) {
      response = await delete(
          Uri.parse(localhostNET + route + "?email=" + email),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer " + authenticate.jwt,
          });
    } else {
      response = await delete(Uri.parse(localhost + route + "?email=" + email),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
    }

    return response;
  }

  Future login(String userName, String password) async {
    var host = isWebSocketChannel ? localhostNET : localhost;
    var response = await post(Uri.parse(host + "/Login"),
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
    var host = isWebSocketChannel ? localhostNET : localhost;
    var response = await post(Uri.parse(host + "/Signup"),
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
