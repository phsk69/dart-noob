import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/file_stuff.dart';
import 'dart:convert';

Future<Either<String, String>> getInputContent(
    String? input, Stream<List<int>>? inputStream) async {
  if (input == null && inputStream == null) {
    return Left("Both input and inputStream cannot be null.");
  }

  if (input != null && inputStream != null) {
    return Left("Only one source of input is allowed.");
  }

  if (input != null) {
    var content = await getFileAsString(input);
    return Right(content);
  } else if (inputStream != null) {
    var content = StringBuffer();
    await for (var line in inputStream
        .transform(utf8.decoder)
        .transform(const LineSplitter())) {
      content.writeln(line);
    }
    return Right(content.toString());
  }

  return Left("No valid input provided.");
}
