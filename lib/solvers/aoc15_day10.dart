import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/10

/// Look and say sequence
String _lookAndSay(String input) {
  var result = StringBuffer();
  int index = 0;

  while (index < input.length) {
    var count = 1;
    var currentDigit = input[index];

    while (index + 1 < input.length && input[index + 1] == currentDigit) {
      index++;
      count++;
    }

    result
      ..write(count)
      ..write(currentDigit);
    index++;
  }

  return result.toString();
}

class Day10P1Solver extends AoCSolver {
  final String? filePath;

  Day10P1Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      for (var i = 0; i < 40; i++) {
        inputData = _lookAndSay(inputData);
      }

      return Right('Day10P1Solver: ${inputData.length}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day10P2Solver extends AoCSolver {
  final String? filePath;

  Day10P2Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      for (var i = 0; i < 50; i++) {
        inputData = _lookAndSay(inputData);
      }

      return Right('Day10P2Solver: ${inputData.length}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
