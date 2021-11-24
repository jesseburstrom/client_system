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
      //await net.postDb("/updateHighscore", {"name": "Jesse", "score": 281}, 20);
      //var result = await net.deleteDb("/Delete", "eric.burstrom@gmail.com");
      //print(result.body);
      var serverResponse = await net.getDB("/GetTopScores?count=20");
      if (serverResponse.statusCode == 200) {
        highscores = jsonDecode(serverResponse.body);
        print("Highscores loaded from server");
        await fileHandler.saveFile(highscores, fileHighscore);
      } else {
        print("Error getting highscores1");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future loadHighscoreFromFile() async {
    try {
      highscores = await fileHandler.readFile(fileHighscore);
      print("highscore loaded from file");
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateHighscore(String name, int score) async {
    try {
      await net
          .postDB("/UpdateAndReturnHighscore", {"name": name, "score": score});
      var serverResponse = await net.getDB("/GetTopScores?count=20");
      if (serverResponse.statusCode == 200) {
        highscores = jsonDecode(serverResponse.body);
        fileHandler.saveFile(highscores, fileHighscore);
      } else {
        print("Error getting highscores");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
