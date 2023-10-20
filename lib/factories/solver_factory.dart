import 'package:dartz/dartz.dart';
import 'package:dart_noob/solvers/solvers.dart';
import 'package:dart_noob/data/input_bucket.dart';

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
      case 'd12':
        return Right([
          Day12P1Solver(input, filePath),
          Day12P2Solver(input, filePath),
        ]);
      case 'd13':
        return Right([
          Day13P1Solver(input, filePath),
          Day13P2Solver(input, filePath),
        ]);
      case 'd14':
        return Right([
          Day14P1Solver(input, filePath),
          Day14P2Solver(input, filePath),
        ]);
      case 'd15':
        return Right([
          Day15P1Solver(input, filePath),
          Day15P2Solver(input, filePath),
        ]);
      case 'd16':
        return Right([
          Day16P1Solver(input, filePath),
          Day16P2Solver(input, filePath),
        ]);
      case 'd17':
        return Right([
          Day17P1Solver(input, filePath),
          Day17P2Solver(input, filePath),
        ]);
      case 'd18':
        return Right([
          Day18P1Solver(input, filePath),
          Day18P2Solver(input, filePath),
        ]);
      case 'd19':
        return Right([
          Day19P1Solver(input, filePath),
          Day19P2Solver(input, filePath),
        ]);
      case 'd20':
        return Right([
          Day20P1Solver(input, filePath),
          Day20P2Solver(input, filePath),
        ]);
      case 'd21':
        return Right([
          Day21P1Solver(input, filePath),
          Day21P2Solver(input, filePath),
        ]);
      case 'default':
        return Right([
          Day1P1Solver(day1Input),
          Day1P2Solver(day1Input),
          /*
          Day2P1Solver(input, filePath),
          Day2P2Solver(input, filePath),
          Day3P1Solver(input, filePath),
          Day3P2Solver(input, filePath),
          Day4P1Solver(input, filePath),
          Day4P2Solver(input, filePath),
          Day5P1Solver(input, filePath),
          Day5P2Solver(input, filePath),
          Day6P1Solver(input, filePath),
          Day6P2Solver(input, filePath),
          Day7P1Solver(input, filePath),
          Day7P2Solver(input, filePath),
          Day8P1Solver(input, filePath),
          Day8P2Solver(input, filePath),
          Day9P1Solver(input, filePath),
          Day9P2Solver(input, filePath),
          Day10P1Solver(input, filePath),
          Day10P2Solver(input, filePath),
          Day11P1Solver(input, filePath),
          Day11P2Solver(input, filePath),
          Day12P1Solver(input, filePath),
          Day12P2Solver(input, filePath),
          Day13P1Solver(input, filePath),
          Day13P2Solver(input, filePath),
          Day14P1Solver(input, filePath),
          Day14P2Solver(input, filePath),
          Day15P1Solver(input, filePath),
          Day15P2Solver(input, filePath),
          Day16P1Solver(input, filePath),
          Day16P2Solver(input, filePath),
          Day17P1Solver(input, filePath),
          Day17P2Solver(input, filePath),
          Day18P1Solver(input, filePath),
          Day18P2Solver(input, filePath),
          Day19P1Solver(input, filePath),
          Day19P2Solver(input, filePath),
          Day20P1Solver(input, filePath),
          Day20P2Solver(input, filePath),
          Day21P1Solver(input, filePath),
          Day21P2Solver(input, filePath),
          */
        ]);
      default:
        return Left("Unknown mode: $mode");
    }
  }
}
