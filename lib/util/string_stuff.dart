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

/// Streams the lines from a file to a string buffer
Future<StringBuffer> getStringBuffer(String inputPath) async {
  return await FileReader(inputPath).readFileToStringBuffer();
}

Stream<String> streamLinesFromFile(String inputPath) async* {
  final file = File(inputPath);
  await for (var line
      in file.openRead().transform(utf8.decoder).transform(LineSplitter())) {
    yield line;
  }
}

Either<String, String> getInputContent(StringBuffer? inputBuffer) {
  if (inputBuffer == null) {
    return Left("InputBuffer cannot be null.");
  }

  return Right(inputBuffer.toString());
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

  Future<StringBuffer> readFileToStringBuffer() async {
    StringBuffer buffer = StringBuffer();
    final file = File(filepath);

    // Check if the file exists before proceeding.
    if (await file.exists()) {
      Stream<List<int>> inputStream = file.openRead();

      // Decode the stream of bytes to a stream of lines
      final lines =
          inputStream.transform(Utf8Decoder()).transform(LineSplitter());

      try {
        await for (var line in lines) {
          buffer.writeln(line);
        }
      } catch (e) {
        throw 'An error occurred while reading from the file: $e';
      }
    } else {
      throw 'The file at path $filepath does not exist.';
    }

    return buffer;
  }
}
