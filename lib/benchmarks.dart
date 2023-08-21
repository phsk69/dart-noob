import 'aoc15_d2.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

class CoPilotBenchmark extends BenchmarkBase {
  final List<String> content;

  CoPilotBenchmark(this.content) : super("CoPilot");

  @override
  void run() {
    solveAocD2P1CoPilot(content);
  }
}

class HomeBrewBenchmark extends BenchmarkBase {
  final List<List<int>> content;

  HomeBrewBenchmark(this.content) : super("HomeBrew");

  @override
  void run() {
    solveAocD2P1HomeBrew(content);
  }
}

class HomeBrewParallelBenchmark extends BenchmarkBase {
  final List<List<int>> content;
  final int workers;

  HomeBrewParallelBenchmark(this.content, this.workers)
      : super("HomeBrewParallel");

  @override
  void run() {
    solveAocD2P1HomeBrewParallel(content, workers);
  }
}

benchRunner(String inputPath, int workers) async {
  final homebrewContent = await getParsedList(inputPath);
  final copilotContent = await getInputByLine(inputPath);
  CoPilotBenchmark(copilotContent).report();
  HomeBrewBenchmark(homebrewContent).report();
  //TODO: The benchmark thing does not exit the pool workers correctly
  //HomeBrewParallelBenchmark(homebrewContent, workers).report();
}
