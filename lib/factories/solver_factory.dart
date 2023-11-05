import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/solvers/solvers.dart';
import 'package:dart_noob/data/input_bucket.dart';

abstract class AoCSolver {
  final StringBuffer? input;

  AoCSolver(this.input);

  Either<String, String> solve();
}

class SolverFactory {
  static Either<String, List<AoCSolver>> create(
    String mode,
    StringBuffer? input, [
    String? filePath,
    Logger? logger,
  ]) {
    switch (mode) {
      case 'default': // default mode not case
        return Right([
          Day1P1Solver(day1Input),
          Day1P2Solver(day1Input),
          Day2P1Solver(day2Input),
          Day2P2Solver(day2Input),
          Day3P1Solver(day3Input),
          Day3P2Solver(day3Input),
          Day4P1Solver(day4Input),
          Day4P2Solver(day4Input),
          Day5P1Solver(day5Input),
          Day5P2Solver(day5Input),
          Day6P1Solver(day6Input),
          Day6P2Solver(day6Input),
          Day7P1Solver(day7Input),
          Day7P2Solver(day7Input),
          Day8P1Solver(day8Input),
          Day8P2Solver(day8Input),
          Day9P1Solver(day9Input),
          Day9P2Solver(day9Input),
          Day10P1Solver(day10Input),
          Day10P2Solver(day10Input),
          Day11P1Solver(day11Input),
          Day11P2Solver(day11Input),
          Day12P1Solver(day12Input, filePath),
          Day12P2Solver(day12Input, filePath),
          Day13P1Solver(day13Input, filePath),
          Day13P2Solver(day13Input, filePath),
          Day14P1Solver(day14Input, filePath),
          Day14P2Solver(day14Input, filePath),
          Day15P1Solver(day15Input, filePath),
          Day15P2Solver(day15Input, filePath),
          Day16P1Solver(day16Input, filePath),
          Day16P2Solver(day16Input, filePath),
          Day17P1Solver(day17Input, filePath),
          Day17P2Solver(day17Input, filePath),
          Day18P1Solver(day18Input, filePath),
          Day18P2Solver(day18Input, filePath),
          Day19P1Solver(day19Input, filePath),
          Day19P2Solver(day19Input, filePath),
          Day20P1Solver(day20Input, filePath),
          Day20P2Solver(day20Input, filePath),
          Day21P1Solver(day21Input, filePath),
          Day21P2Solver(day21Input, filePath),
          Day22P1Solver(day22Input, filePath, logger),
          Day22P2Solver(day22Input, filePath, logger),
          Day23P1Solver(day23Input, filePath, logger),
          Day23P2Solver(day23Input, filePath, logger),
          Day24P1Solver(day24Input, filePath, logger),
          Day24P2Solver(day24Input, filePath, logger),
          Day25P1Solver(day25Input, filePath, logger),
          Day25P2Solver(day25Input, filePath, logger),
        ]);
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
      case 'd22':
        return Right([
          Day22P1Solver(input, filePath, logger),
          Day22P2Solver(input, filePath, logger),
        ]);
      case 'd23':
        return Right([
          Day23P1Solver(input, filePath, logger),
          Day23P2Solver(input, filePath, logger),
        ]);
      case 'd24':
        return Right([
          Day24P1Solver(input, filePath, logger),
          Day24P2Solver(input, filePath, logger),
        ]);
      case 'd25':
        return Right([
          Day25P1Solver(input, filePath, logger),
          Day25P2Solver(input, filePath, logger),
        ]);
      default:
        return Left("Unknown mode: $mode");
    }
  }
}
