import 'package:dartz/dartz.dart';
import 'package:dart_noob/solvers/solvers.dart';

abstract class AoCSolver {
  final StringBuffer? input;

  AoCSolver(this.input);

  Either<String, String> solve();
}

class SolverFactory {
  static Either<String, List<AoCSolver>> create(
      String mode, StringBuffer? input,
      [String? filePath]) {
    switch (mode) {
      case 'd1':
        return Right(
            [Day1P1Solver(input, filePath), Day1P2Solver(input, filePath)]);
      case 'd2':
        return Right(
            [Day2P1Solver(input, filePath), Day2P2Solver(input, filePath)]);
      case 'd3':
        return Right(
            [Day3P1Solver(input, filePath), Day3P2Solver(input, filePath)]);
      case 'd4':
        return Right(
            [Day4P1Solver(input, filePath), Day4P2Solver(input, filePath)]);
      case 'd5':
        return Right(
            [Day5P1Solver(input, filePath), Day5P2Solver(input, filePath)]);
      case 'd6':
        return Right(
            [Day6P1Solver(input, filePath), Day6P2Solver(input, filePath)]);
      case 'd7':
        return Right(
            [Day7P1Solver(input, filePath), Day7P2Solver(input, filePath)]);
      case 'd8':
        return Right(
            [Day8P1Solver(input, filePath), Day8P2Solver(input, filePath)]);
      case 'd9':
        return Right(
            [Day9P1Solver(input, filePath), Day9P2Solver(input, filePath)]);
      case 'd10':
        return Right([
          Day10P1Solver(input, filePath),
          Day10P2Solver(input, filePath),
        ]);
      case 'd11':
        return Right([
          Day11P1Solver(input, filePath),
          Day11P2Solver(input, filePath),
        ]);
      default:
        return Left("Unknown mode: $mode");
    }
  }
}
