import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/5

class Day5P1Solver extends AoCSolver {
  final String? filePath;

  Day5P1Solver(super.input, [this.filePath]);

  bool _hasThreeVowels(String line) {
    return line.split('').where((char) => 'aeiou'.contains(char)).length >= 3;
  }

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString() ?? getStringSync(filePath!);
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }
      var inputLines = inputData.split('\n');

      RegExp secondFilter = RegExp(r'(.)\1');
      RegExp thirdFilter = RegExp(r'ab|cd|pq|xy');
      int goodLines = 0;

      for (var line in inputLines) {
        if (_hasThreeVowels(line) &&
            secondFilter.hasMatch(line) &&
            !thirdFilter.hasMatch(line)) {
          goodLines += 1;
        }
      }

      return Right('Day5P1Solver: $goodLines');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day5P2Solver extends AoCSolver {
  final String? filePath;

  Day5P2Solver(super.input, [this.filePath]);

  bool _hasTwoLettersRepeatedWithoutOverlap(String line) {
    for (int pairStartIdx = 0; pairStartIdx < line.length - 1; pairStartIdx++) {
      String currentPair = line.substring(pairStartIdx, pairStartIdx + 2);

      for (int comparisonIdx = pairStartIdx + 2;
          comparisonIdx < line.length - 1;
          comparisonIdx++) {
        String comparisonPair =
            line.substring(comparisonIdx, comparisonIdx + 2);

        if (currentPair == comparisonPair) {
          return true;
        }
      }
    }
    return false;
  }

  bool _hasOneLetterGapRepeat(String line) {
    for (int charIdx = 0; charIdx < line.length - 2; charIdx++) {
      if (line[charIdx] == line[charIdx + 2]) {
        return true;
      }
    }
    return false;
  }

  bool _meetsBothConditions(String line) {
    return _hasTwoLettersRepeatedWithoutOverlap(line) &&
        _hasOneLetterGapRepeat(line);
  }

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString() ?? getStringSync(filePath!);
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }
      var inputLines = inputData.split('\n');
      int goodLines = 0;

      for (var line in inputLines) {
        if (_meetsBothConditions(line)) {
          goodLines++;
        }
      }

      return Right('Day5P2Solver: $goodLines');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
