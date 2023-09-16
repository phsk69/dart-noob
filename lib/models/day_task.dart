import 'package:dartz/dartz.dart';

typedef SolveFunction = Either<String, String> Function(
    String? input, StringBuffer? inputBuffer);

class SolverTask {
  final String inputKey;a
  final SolveFunction solveFunction;
  final String functionName;

  SolverTask(this.inputKey, this.solveFunction, this.functionName);

  Future<Either<String, int>> execute(
      String? input, StringBuffer? inputBuffer) {
    return solveFunction(inputKey, null);
  }
}
