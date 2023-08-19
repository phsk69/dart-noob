import 'dart:io';

class FileContent {
  final List<String> characters;
  final int length;

  FileContent(this.characters, this.length);
}

class FileReader {
  final String filepath;

  // Constructor
  FileReader(this.filepath);

  // Method to read the file and return the content as a FileContent object
  Future<FileContent> readFile() async {
    try {
      String contents = await File(filepath).readAsString();
      List<String> contentList =
          contents.split(''); // Splitting the string into individual characters
      return FileContent(contentList, contentList.length);
    } catch (e) {
      throw 'Error reading the file: $e';
    }
  }
}
