import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/8

class Day8P1Solver extends AoCSolver {
  final String? filePath;

  Day8P1Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }
      var outerDiff = 0;

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        var codeLength = line.length;

        var memLength = 0;

        for (int i = 0; i < line.length; i++) {
          var char = line[i];
          if (char == '\\') {
            if (i + 1 < line.length) {
              var nextChar = line[i + 1];

              if (nextChar == '\\') {
                memLength += 1;
                i++;
              } else if (nextChar == '\"') {
                memLength += 1;
                i++;
              } else if (nextChar == 'x' && (i + 3) < line.length) {
                var firstHexChar = line[i + 2];
                var secondHexChar = line[i + 3];

                if (isValidHexChar(firstHexChar) &&
                    isValidHexChar(secondHexChar)) {
                  memLength += 1;
                  i += 3;
                }
              }
            }
          } else {
            if (char != '\"') {
              memLength += 1;
            }
          }
        }
        outerDiff += codeLength - memLength;
      }
      return Right('Day8P1Solver: $outerDiff');
    } catch (e) {
      return Left(e.toString());
    }
  }

  bool isValidHexChar(String char) {
    int codeUnit = char.codeUnitAt(0);
    return (codeUnit >= '0'.codeUnitAt(0) && codeUnit <= '9'.codeUnitAt(0)) ||
        (codeUnit >= 'a'.codeUnitAt(0) && codeUnit <= 'f'.codeUnitAt(0)) ||
        (codeUnit >= 'A'.codeUnitAt(0) && codeUnit <= 'F'.codeUnitAt(0));
  }
}
