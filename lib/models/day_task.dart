import 'package:dartz/dartz.dart';

typedef SolveFunction = Future<Either<String, int>> Function(
    String? input, StringBuffer? inputBuffer);

class SolverTask {
  final String inputKey;
  final SolveFunction solveFunction;
  final String functionName;

  SolverTask(this.inputKey, this.solveFunction, this.functionName);

  Future<Either<String, int>> execute(
      String? input, StringBuffer? inputBuffer) {
    return solveFunction(inputKey, null);
  }
}
