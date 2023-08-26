import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p1.dart';
import 'package:dart_noob/util/file_stuff.dart';

class CoPilotBenchmark extends BenchmarkBase {
  final List<String> content;

  CoPilotBenchmark(this.content) : super("String splitter - Copilot");

  @override
  void run() {
    solveAocD2P1CoPilot(content);
  }
}

class ListOfListsBenchmark extends BenchmarkBase {
  final List<List<int>> content;

  ListOfListsBenchmark(this.content) : super("ListOfListsBenchmark - Chatgpt");

  @override
  void run() {
    solveAocD2P1ListOfLists(content);
  }
}

class ListOfListsFunctional extends BenchmarkBase {
  final List<List<int>> content;

  ListOfListsFunctional(this.content)
      : super("ListOfListsFunctional - Chatgpt");

  @override
  void run() {
    solveAocD2P1FunctionalListOfLists(content);
  }
}

class ListOfStringsFunctional extends BenchmarkBase {
  final List<String> content;

  ListOfStringsFunctional(this.content)
      : super("ListOfStringsFunctional - Chatgpt");

  @override
  void run() {
    solveAocD2P1FunctionalFromStrings(content);
  }
}

class ListOfListsParallel extends BenchmarkBase {
  final List<List<int>> content;
  final int workers;

  ListOfListsParallel(this.content, this.workers)
      : super("ListOfListsParallel - Chatgpt");

  @override
  void run() async {
    await solveAocD2P1Parallel(content, workers);
  }
}

benchRunner(String inputPath, int workers) async {
  final listOfListsContent = await getParsedList(inputPath);
  final listOfStringsContent = await getInputByLine(inputPath);
  CoPilotBenchmark(listOfStringsContent).report();
  ListOfListsBenchmark(listOfListsContent).report();
  ListOfListsFunctional(listOfListsContent).report();
  ListOfStringsFunctional(listOfStringsContent).report();
  // TODO: This still does not exit when completed.
  // ListOfListsParallel(listOfListsContent, workers).report();
}
