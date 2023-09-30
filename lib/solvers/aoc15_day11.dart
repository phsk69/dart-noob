import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/10

/// Increments a string, treating it like a number with characters instead of digits.
String _incrementString(String input) {
  var charList = input.split('');
  for (int i = charList.length - 1; i >= 0; i--) {
    if (charList[i] == 'z') {
      charList[i] = 'a';
    } else {
      charList[i] = String.fromCharCode(charList[i].codeUnitAt(0) + 1);
      break;
    }
  }
  return charList.join('');
}

/// Checks if a string contains at least one increasing straight of three characters.
bool _hasStraight(String input) {
  for (int i = 0; i < input.length - 2; i++) {
    if (input.codeUnitAt(i) == input.codeUnitAt(i + 1) - 1 &&
        input.codeUnitAt(i + 1) == input.codeUnitAt(i + 2) - 1) {
      return true;
    }
  }
  return false;
}

class Day11P1Solver extends AoCSolver {
  final String? filePath;
  final String? currentPassword; // Added this optional parameter

  Day11P1Solver(StringBuffer? input, [this.filePath, this.currentPassword])
      : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = currentPassword ??
          (input?.toString().trim() ?? getStringSync(filePath!).trim());

      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      // The three forbidden letters
      var forbidden = ['i', 'o', 'l'];
      for (var letter in forbidden) {
        if (inputData.contains(letter)) {
          inputData = inputData.replaceAll(
              letter, String.fromCharCode(letter.codeUnitAt(0) + 1));
          var idx = inputData.indexOf(letter);
          for (int i = idx + 1; i < inputData.length; i++) {
            inputData = inputData.replaceRange(i, i + 1, 'a');
          }
        }
      }

      // Generating the next valid password
      while (true) {
        inputData = _incrementString(inputData);

        if (forbidden.any((char) => inputData.contains(char))) {
          continue;
        }

        if (!_hasStraight(inputData)) {
          continue;
        }

        var pairs = RegExp(r'(\w)\1')
            .allMatches(inputData)
            .map((match) => match.group(1))
            .toSet();
        if (pairs.length < 2) {
          continue;
        }

        break; // Found the valid password
      }

      return Right('Day11P1Solver: $inputData');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day11P2Solver extends AoCSolver {
  final String? filePath;

  Day11P2Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();

      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      // Use Day11P1Solver to get the first next valid password
      var firstSolver = Day11P1Solver(StringBuffer(inputData), filePath);
      var firstPasswordResult = firstSolver.solve();

      String firstPassword;
      if (firstPasswordResult.isRight()) {
        firstPassword = firstPasswordResult.getOrElse(() => '');
        // Extracting the right value and cleaning up the prefix
        firstPassword = firstPassword.replaceAll('Day11P1Solver: ', '');
      } else {
        return Left('Failed to get the first password.');
      }

      // Use Day11P1Solver again to get the next valid password
      var secondSolver = Day11P1Solver(null, null, firstPassword);
      var secondPasswordResult = secondSolver.solve();

      if (secondPasswordResult.isRight()) {
        var secondPassword = secondPasswordResult
            .getOrElse(() => '')
            .replaceAll('Day11P1Solver: ', '');
        return Right('Day11P2Solver: $secondPassword');
      } else {
        return Left('Failed to get the second password.');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
