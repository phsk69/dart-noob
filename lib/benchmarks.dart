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

benchRunner(String inputPath) async {
  final homebrewContent = await getParsedList(inputPath);
  final copilotContent = await getInputByLine(inputPath);
  CoPilotBenchmark(copilotContent).report();
  HomeBrewBenchmark(homebrewContent).report();
}
