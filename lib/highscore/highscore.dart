part of "../main.dart";

class Highscore extends LanguagesHighscore with AnimationsHighscore {
  Highscore() {
    setupAnimation();
    loadHighscoreFromFile();
    languagesSetup();
  }

  List<dynamic> highscores = [];

  var fileHighscore = "highscores.json";

  Future loadHighscoreFromServer() async {
    try {
      //await net.postDb("/updateHighscore", {"name": "Jesse", "score": 275});
      var serverResponse = await net.getDb("/getTopScores");
      if (serverResponse.statusCode == 200) {
        highscores = jsonDecode(serverResponse.body);
        globalSetState();
        print("Highscores loaded from server");
        await fileHandler.saveFile(highscores, fileHighscore);
      } else {
        print("Error getting highscores1");
      }
    } catch (e) {
      print("Error getting highscores2");
    }
  }

  Future loadHighscoreFromFile() async {
    try {
      highscores = await fileHandler.readFile(fileHighscore);
      print("highscore loaded from file");
    } catch (e) {
      print("Cannot load highscorefile");
    }
  }

  Future updateHighscore(String name, int score) async {
    try {
      var serverResponse =
          await net.postDb("/updateHighscore", {"name": name, "score": score});
      if (serverResponse.statusCode == 200) {
        highscores = jsonDecode(serverResponse.body);
        globalSetState();
        fileHandler.saveFile(highscores, fileHighscore);
      } else {
        print("Error getting highscores");
      }
    } catch (e) {
      print("Error getting highscores onUpdate");
    }
  }

// void setHighscores(List<dynamic> highscores) {
//   for (var i = 0; i < highscores.length; i++) {
//     highscoreText[i] = highscores[i]["name"];
//     highscoreValue[i] = highscores[i]["score"];
//   }
// }
}
