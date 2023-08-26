import 'dart:io';
import 'package:dart_noob/util/file_stuff.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p1.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p2.dart';
import 'package:dart_noob/days/d3/aoc15_d3.dart';
import 'package:dart_noob/benchmark/benchmarks.dart';
import 'package:args/args.dart';

// https://adventofcode.com/2015

void main(List<String> arguments) async {
  try {
    final parser = ArgParser()
      ..addOption('day', abbr: 'd', help: 'Specify the day to run')
      ..addOption('input', abbr: 'i', help: 'Specify path to puzzle input')
      ..addOption('workers', abbr: 'w', help: 'Specify amount of workers')
      ..addFlag('bench', abbr: 'b', negatable: false, help: 'Run benchmarks');

    var args = parser.parse(arguments);

    String? day = args['day'] as String? ?? '3';
    String? input = args['input'] as String? ?? 'data/aoc2015_day3_input';
    int workers = int.tryParse(args['workers'] as String? ?? '') ?? 4;
    if (args['bench'] as bool) {
      await benchRunner(input, workers);
    }

    if (day == '1') {
      var inputData = await getInputString(input);

      var stopwatch = Stopwatch()..start();
      var d1P1 = await solveAocD1P1(inputData);
      stopwatch.stop();
      print('D1P1: $d1P1 (Time: ${stopwatch.elapsedMicroseconds} us)');
      stopwatch.reset();

      stopwatch.start();
      var d1P2 = await solveAocD1P2(inputData);
      stopwatch.stop();
      print('D1P2: $d1P2 (Time: ${stopwatch.elapsedMicroseconds} us)');
    }

    if (day == '2') {
      var listOfStringsContent = await getInputByLine(input);

      var stopwatch = Stopwatch()..start();
      var d2P1Copilot = solveAocD2P1CoPilot(listOfStringsContent);
      stopwatch.stop();
      print('D2P1 - String splitter - Copilot result: $d2P1Copilot '
          '(Time: ${stopwatch.elapsedMicroseconds} us)');

      var listOfListsContent = await getParsedList(input);
      stopwatch.reset();

      stopwatch.start();
      var d2P1ListOfLists = solveAocD2P1ListOfLists(listOfListsContent);
      stopwatch.stop();
      print('D2P1 - ListOfLists - Chatgpt/copilot - same arithmetic '
          'as String splitter: '
          '$d2P1ListOfLists (Time: ${stopwatch.elapsedMicroseconds} us)');
      stopwatch.reset();

      stopwatch.start();
      var d2P1ListOfStrings =
          solveAocD2P1FunctionalFromStrings(listOfStringsContent);
      stopwatch.stop();
      print('D2P1 - ListOfStrings - Chatgpt/copilot - same arithmetic '
          'as String splitter: '
          '$d2P1ListOfStrings (Time: ${stopwatch.elapsedMicroseconds} us)');
      stopwatch.reset();

      stopwatch.start();
      var d2P1Functional =
          solveAocD2P1FunctionalListOfLists(listOfListsContent);
      stopwatch.stop();
      print('D2P1 - ListOfLists - Chatgpt - functional result: '
          '$d2P1Functional (Time: ${stopwatch.elapsedMicroseconds} us)');
      stopwatch.reset();

      stopwatch.start();
      var d2P1Parallel =
          await solveAocD2P1Parallel(listOfListsContent, workers);
      stopwatch.stop();
      print('D2P1 - ListOfLists & parallel - Chatgpt result: $d2P1Parallel '
          '(Time: ${stopwatch.elapsedMicroseconds} us, workers: $workers)');
      stopwatch.reset();

      stopwatch.start();
      var d2P2ListOfLists = await solveAocD2P2ListOfLists(input);
      stopwatch.stop();
      print('D2P2 - ListOfLists - Homemade result: $d2P2ListOfLists '
          '(Time: ${stopwatch.elapsedMicroseconds} us)');
    }

    if (day == '3') {
      var stopwatch = Stopwatch()..start();
      var d3P1 = await solveAocD3P1(input);

      stopwatch.stop();

      print(
          'D3P1: $d3P1 - Homebrew (Time: ${stopwatch.elapsedMicroseconds} us)');

      stopwatch.reset();

      stopwatch.start();
      var d3P2 = await solveAocD3P2(input);

      stopwatch.stop();

      print(
          'D3P2: $d3P2 - Homebrew (Time: ${stopwatch.elapsedMicroseconds} us)');
      stopwatch.reset();
    }

    exit(0);
  } catch (e) {
    print('Main: $e');
  }
}
