part of "../main.dart";

class FileHandler {
  Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile(String fileName) async {
    final path = await localPath();
    print(path);
    return File("$path/" + fileName);
  }

  Future readFileAsBytes(String fileName) async {
    try {
      //audio.data = await rootBundle.load("assets/blipp.mp3");

      // print(contents.length);
      //
      // return contents;
    } catch (e) {
      // If encountering an error, return 0
      print("no file");
      rethrow;
    }
  }

  Future readFile(String fileName) async {
    try {
      final file = await localFile(fileName);
      var contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      // If encountering an error, return 0
      print("no file");
      rethrow;
    }
  }

//Future<File> writeFile(Map<String, dynamic> _json, fileName) async {
  Future<void> saveFile(var _json, fileName) async {
    //fileFileName = fileName;
    try {
      final file = await localFile(fileName);
      var _jsonString = jsonEncode(_json);
      // Write the file
      file.writeAsString(_jsonString);
    } catch (e) {
      print("error writing file");
    }
  }
}
