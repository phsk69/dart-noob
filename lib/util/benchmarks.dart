import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p1.dart';

class CoPilotBenchmark extends BenchmarkBase {
  final String content;

  CoPilotBenchmark(this.content) : super("solveAoc15D2P1CoPilot - Copilot");

  @override
  void run() {
    solveAoc15D2P1CoPilot(content);
  }
}

class ListOfListsBenchmark extends BenchmarkBase {
  final String content;

  ListOfListsBenchmark(this.content)
      : super("solveAoc15D2P1ListOfLists - Chatgpt");

  @override
  void run() {
    solveAoc15D2P1ListOfLists(content);
  }
}

class ListOfListsFunctional extends BenchmarkBase {
  final String content;

  ListOfListsFunctional(this.content)
      : super("solveAoc15D2P1FunctionalListOfLists - Chatgpt");

  @override
  void run() {
    solveAoc15D2P1FunctionalListOfLists(content);
  }
}

class ListOfStringsFunctional extends BenchmarkBase {
  final String content;

  ListOfStringsFunctional(this.content)
      : super("solveAoc15D2P1FunctionalFromStrings - Chatgpt");

  @override
  void run() {
    solveAoc15D2P1FunctionalFromStrings(content);
  }
}

class ListOfListsParallel extends BenchmarkBase {
  final String content;
  final int workers;

  ListOfListsParallel(this.content, this.workers)
      : super("solveAoc15D2P1Parallel - Chatgpt");

  @override
  void run() async {
    await solveAoc15D2P1Parallel(content, workers);
  }
}

benchRunner(Map inputMap, int workers) async {
  var inputPath = inputMap['15day2'];
  CoPilotBenchmark(inputPath).report();
  ListOfListsBenchmark(inputPath).report();
  ListOfListsFunctional(inputPath).report();
  ListOfStringsFunctional(inputPath).report();
  ListOfListsParallel(inputPath, workers).report();
}
