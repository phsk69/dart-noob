import 'dart:io';

// helpers
Future<List<String>> getInputByLine(String inputPath) async {
  return await FileReader(inputPath).readFileByLine();
}

Future<List<List<int>>> getParsedList(String inputPath) async {
  return await FileReader(inputPath).parseFileListInt();
}

Future<List<String>> getInputString(String inputPath) async {
  return await FileReader(inputPath).splitFileStringToList();
}

Future<String> getFileAsString(String inputPath) async {
  return await FileReader(inputPath).readStringFromFile();
}

class FileReader {
  final String filepath;

  FileReader(this.filepath);

  Future<List<String>> splitFileStringToList() async {
    try {
      String contents = await File(filepath).readAsString();
      List<String> contentList = contents.split('');
      return contentList;
    } catch (e) {
      throw 'readFile: $e';
    }
  }

  Future<String> readStringFromFile() async {
    try {
      String contents = await File(filepath).readAsString();
      return contents;
    } catch (e) {
      throw 'readFile: $e';
    }
  }

  Future<List<String>> readFileByLine() async {
    try {
      List<String> lines = await File(filepath).readAsLines();
      return lines;
    } catch (e) {
      throw 'readFileByLine: $e';
    }
  }

  Future<List<List<int>>> parseFileListInt() async {
    List<List<int>> dimensionsList = [];
    try {
      List<String> lines = await File(filepath).readAsLines();

      for (var line in lines) {
        List<int> dimensions =
            line.split('x').map((e) => int.parse(e)).toList();

        dimensionsList.add(dimensions);
      }

      return dimensionsList;
    } catch (e) {
      throw 'parseFileListInt: $e';
    }
  }
}
