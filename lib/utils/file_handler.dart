import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHandler {
  // Make a method to write to a file
  void writeToFile(String content) {
    getApplicationDocumentsDirectory().then((directory) {
      File file = File("${directory.path}/output.txt");
      file.writeAsString(content);
    });
  }

  // Make a method to read from a file
  Future<String?> readFromFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    File file = File("${directory.path}/output.txt");
    if (!file.existsSync()) file.createSync();
    print("Aan het lezen");
    String content = await file.readAsString();
    return content;
  }
}
