part of "../main.dart";

class Net {
  late Socket socketConnection;
  late Function callbackOnClientMsg;
  late Function callbackOnServerMsg;

  // "action" : String tells server meaning of message
  sendToClients(Map<String, dynamic> msg) {
    msg["timestamp"] = DateTime.now().millisecondsSinceEpoch;
    socketConnection.emit(
      "sendToClients",
      msg,
    );
  }

  sendToServer(Map<String, dynamic> msg) {
    msg["timestamp"] = DateTime.now().millisecondsSinceEpoch;
    socketConnection.emit(
      "sendToServer",
      msg,
    );
  }

  onClientMsg(var data) {
    callbackOnClientMsg(data);
  }

  onServerMsg(var data) {
    callbackOnServerMsg(data);
  }

  connectToServer() {
    try {
      // Configure socket, transports must be sepecified
      socketConnection = io(localhostIO, <String, dynamic>{
        "transports": ["websocket"],
      });

      socketConnection.on("onClientMsg", onClientMsg);
      socketConnection.on("onServerMsg", onServerMsg);
      socketConnection.on("disconnect", (_) => print("disconnect"));
    } catch (e) {
      print(e.toString());
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
