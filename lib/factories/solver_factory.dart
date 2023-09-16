import 'package:dartz/dartz.dart';
import 'package:dart_noob/solvers/day1_solvers.dart';

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
      default:
        return Left("Unknown mode: $mode");
    }
  }
}
