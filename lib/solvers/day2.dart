import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/2

// List of list of integers thing
class Day2P1Solver extends AoCSolver {
  final String? filePath;

  Day2P1Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      List<List<int>> content;

      if (input != null) {
        content = content = parseInputToDimList(input, filePath);
      } else if (filePath != null) {
        content = getParsedListSync(filePath!);
      } else {
        return Left("No input provided.");
      }

      var totalPaper = 0;

      for (var list in content) {
        var l = list[0];
        var w = list[1];
        var h = list[2];

        var side1 = l * w;
        var side2 = w * h;
        var side3 = h * l;

        var smallestSide =
            [side1, side2, side3].reduce((a, b) => a < b ? a : b);
        var paper = 2 * side1 + 2 * side2 + 2 * side3 + smallestSide;
        totalPaper += paper;
      }

      return Right('solveAoc15D2P1: $totalPaper');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day2P2Solver extends AoCSolver {
  final String? filePath;

  Day2P2Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      List<List<int>> content;

      if (input != null) {
        content = parseInputToDimList(input, filePath);
      } else if (filePath != null) {
        content = getParsedListSync(
            filePath!); // Assuming you have getParsedListSync from earlier
      } else {
        return Left("No input provided.");
      }

      var totalRibbon = 0;

      for (var box in content) {
        box.sort(); // Sorting the dimensions

        var ribbonSum = 2 * (box[0] + box[1]);
        var bowSum = box[0] * box[1] * box[2];

        totalRibbon += ribbonSum + bowSum;
      }

      return Right('solveAoc15D2P2: $totalRibbon');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
