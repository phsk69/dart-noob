import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/25

List<int> parseD25Input(String d25Input) {
  final pattern =
      RegExp(r'\d+'); // This regular expression matches one or more digits.
  final matches = pattern.allMatches(d25Input);

  if (matches.length > 2) {
    throw FormatException('Found more than two integers in the input.');
  }

  return matches.map((match) => int.parse(match.group(0)!)).toList();
}

int findCode(int row, int col) {
  const int startCode = 20151125;
  const int multiplier = 252533;
  const int divisor = 33554393;

  // Determine which diagonal the code is on
  int diagNum = row + col - 1;

  // Calculate position on the paper
  int position = (diagNum * (diagNum - 1)) ~/ 2 + col;

  // Generate the code the required number of times
  int code = startCode;
  for (int i = 1; i < position; i++) {
    code = (code * multiplier) % divisor;
  }

  return code;
}

class Day25P1Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day25P1Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      final position = parseD25Input(inputData);
      final code = findCode(position[0], position[1]);
      return Right('Day25P1Solver: $code');
    } catch (e) {
      var errorMsg = 'Day25P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day25P2Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day25P2Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      return Right('Day25P2Solver: ⭐⭐⭐⭐⭐ x 10');
    } catch (e) {
      var errorMsg = 'Day25P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
