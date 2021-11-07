part of "../main.dart";

class Highscore extends LanguagesHighscore with AnimationsHighscore {
  Highscore() {
    setupAnimation();
    loadHighscoresFromFile();
    languagesSetup();
    //loadHighscoresFromServer();
  }

  ///// Internal variables
  var highscoreText = List.filled(10, "Yatzy", growable: true);
  var highscoreValue = List.filled(10, 200, growable: true);
  var fileHighscore = "highscores.json";

  Future loadAndUpdateHighscoresFromServer() async {
    try {
      var serverResponse = await net.mainMakeGetHighscores();
      if (serverResponse.statusCode == 200) {
        var serverBody = jsonDecode(serverResponse.body);
        setHighscores(serverBody);
        globalSetState();
        print("Highscores loaded from server");
        await fileHandler.saveFile(serverBody, fileHighscore);
      } else {
        print("Error getting highscores1");
      }
    } catch (e) {
      print("Error getting highscores2");
    }
  }

  Future loadHighscoresFromFile() async {
    try {
      var highscores = await fileHandler.readFile(fileHighscore);
      print("highscores loaded from file");
      setHighscores(highscores);
    } catch (e) {
      print("Cannot load highscorefile");
    }
  }

  Future updateHighscore(String name, int score) async {
    try {
      var serverResponse = await net.mainMakeUpdateHighscores(name, score);
      if (serverResponse.statusCode == 200) {
        var serverBody = jsonDecode(serverResponse.body);
        setHighscores(serverBody);
        globalSetState();
        fileHandler.saveFile(serverBody, fileHighscore);
      } else {
        print("Error getting highscores");
      }
    } catch (e) {
      print("Error getting highscores onUpdate");
    }
  }

  void setHighscores(List<dynamic> highscores) {
    for (var i = 0; i < highscores.length; i++) {
      highscoreText[i] = highscores[i]["name"];
      highscoreValue[i] = highscores[i]["score"];
    }
  }
}
