import 'dart:io';

class FileReader {
  final String filepath;

  FileReader(this.filepath);

  Future<List<String>> readFile() async {
    try {
      String contents = await File(filepath).readAsString();
      List<String> contentList =
          contents.split('');
      return contentList;
    } catch (e) {
      throw 'Error reading the file: $e';
    }
  }

  Future<List<String>> readFileByLine() async {
    try {
      List<String> lines = await File(filepath).readAsLines();
      return lines;
    } catch (e) {
      throw 'Error reading the file by line: $e';
    }
  }
}
