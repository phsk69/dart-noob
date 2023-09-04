import 'dart:convert';
import 'package:dart_noob/util/file_stuff.dart';
import 'package:dartz/dartz.dart';

// Function to get input content as a String
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

// Function for the first problem
Future<Either<String, int>> solveAoc15D1P1(
    String? input, Stream<List<int>>? inputStream) async {
  try {
    final result = await getInputContent(input, inputStream);

    return result.fold((l) => Left(l), (content) {
      var i = 0;
      for (var element in content.split('')) {
        switch (element) {
          case '(':
            i++;
            break;
          case ')':
            i--;
            break;
        }
      }
      return Right(i);
    });
  } catch (e) {
    return Left(e.toString());
  }
}

// Function for the second problem
Future<Either<String, int>> solveAoc15D1P2(
    String? input, Stream<List<int>>? inputStream) async {
  try {
    final result = await getInputContent(input, inputStream);

    return result.fold((l) => Left(l), (content) {
      var floor = 0;
      const int basement = -1;
      var firstBasementPos = 0;

      for (var idx = 0; idx < content.length; idx++) {
        var element = content[idx];
        switch (element) {
          case '(':
            floor++;
            break;
          case ')':
            floor--;
            if (floor == basement) {
              firstBasementPos = idx + 1;
              return Right(firstBasementPos);
            }
            break;
        }
      }
      return Left("Never reached the basement");
    });
  } catch (e) {
    return Left(e.toString());
  }
}
