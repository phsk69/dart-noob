import 'package:dart_noob/util/file_stuff.dart';
import 'package:dartz/dartz.dart';

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
