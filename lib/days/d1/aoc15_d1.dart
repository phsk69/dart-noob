import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart'; // Assuming this is where getInputContent is defined

// Function for the first problem
Future<Either<String, int>> solveAoc15D1P1(String? input,
    Stream<List<int>>? inputStream, StringBuffer? inputBuffer) async {
  try {
    final result = await getInputContent(input, inputStream, inputBuffer);

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
Future<Either<String, int>> solveAoc15D1P2(String? input,
    Stream<List<int>>? inputStream, StringBuffer? inputBuffer) async {
  try {
    final result = await getInputContent(input, inputStream, inputBuffer);

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
