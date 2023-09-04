import 'dart:io';
import 'dart:convert';
import 'package:dartz/dartz.dart';

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

Stream<String> streamLinesFromFile(String inputPath) async* {
  final file = File(inputPath);
  await for (var line
      in file.openRead().transform(utf8.decoder).transform(LineSplitter())) {
    yield line;
  }
}

/// Function to get input content as a String
Future<Either<String, String>> getInputContent(String? input,
    Stream<List<int>>? inputStream, StringBuffer? inputBuffer) async {
  if (input == null && inputStream == null && inputBuffer == null) {
    return Left("All input sources cannot be null.");
  }

  if ((input != null && inputStream != null) ||
      (inputBuffer != null && inputStream != null) ||
      (input != null && inputBuffer != null)) {
    return Left("Only one source of input is allowed.");
  }

  if (input != null) {
    var content = await getFileAsString(
        input); // Your existing function to get the file as a string
    return Right(content);
  } else if (inputStream != null) {
    var content = StringBuffer();
    await for (var line in inputStream
        .transform(utf8.decoder)
        .transform(const LineSplitter())) {
      content.writeln(line);
    }
    return Right(content.toString());
  } else if (inputBuffer != null) {
    return Right(inputBuffer.toString());
  }

  return Left("No valid input provided.");
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
