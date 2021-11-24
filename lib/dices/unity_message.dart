part of "../main.dart";

class UnityMessage {
  UnityMessage(this.action);

  UnityMessage.reset(this.nrDices, this.nrThrows) {
    action = "reset";
  }

  UnityMessage.start() {
    action = "start";
  }

  UnityMessage.updateDices(this.dices) {
    action = "setProperty";
    property = "Dices";
  }

  UnityMessage.updateColors(this.unityColors) {
    action = "setProperty";
    property = "Color";
  }

  UnityMessage.changeBool(this.property, this.flag) {
    action = "setProperty";
  }

  UnityMessage.fromJson(Map<String, dynamic> json)
      : action = json["action"],
        nrDices = json["nrDices"],
        nrThrows = json["nrThrows"],
        property = json["property"],
        unityColors = json["colors"],
        flag = json["flag"],
        dices = json["Dices"];

  Map<String, dynamic> toJson() => {
        "action": action,
        "nrDices": nrDices,
        "nrThrows": nrThrows,
        "property": property,
        "colors": unityColors,
        "bool": flag,
        "Dices": dices,
      };

  var action = "";
  var property = "";
  var dices = [];
  var unityColors = [0.6, 0.7, 0.8, 0.1];
  var flag = true;
  var nrDices = 5;
  var nrThrows = 3;
}
