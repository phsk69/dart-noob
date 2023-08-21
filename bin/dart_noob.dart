import 'package:dart_noob/aoc15_d1.dart';
import 'package:dart_noob/aoc15_d2.dart';
import 'package:dart_noob/benchmarks.dart';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('day', abbr: 'd', help: 'Specify the day to run')
    ..addOption('input', abbr: 'i', help: 'Specify path to puzzle input')
    ..addOption('workers', abbr: 'w', help: 'Specify amount of workes')
    ..addFlag('bench', abbr: 'b', negatable: false, help: 'Run benchmarks');

  var args = parser.parse(arguments);

  String? day = args['day'] as String?;
  String? input = args['input'] as String?;
  int workers = int.tryParse(args['workers'] as String? ?? '') ?? 4;

  if (input != null) {
    if (args['bench'] as bool) {
      await benchRunner(input, workers);
      return;
    }

    if (day == '1') {
      var inputData = await getInputByLine(input);

      var stopwatch = Stopwatch()..start();
      var d1P1 = await solveAocD1P1(inputData);
      stopwatch.stop();
      if (d1P1 is int) {
        print('D1P1: $d1P1 (Time: ${stopwatch.elapsedMicroseconds} us)');
      }

      stopwatch.reset();
      stopwatch.start();
      var d1P2 = await solveAocD1P2(inputData);
      stopwatch.stop();
      if (d1P2 is int) {
        print('D1P2: $d1P2 (Time: ${stopwatch.elapsedMicroseconds} us)');
      }
    }

    if (day == '2') {
      var inputDataCopilot = await getInputByLine(input);
      var stopwatch = Stopwatch()..start();
      var d2P1Copilot = await solveAocD2P1CoPilot(inputDataCopilot);
      stopwatch.stop();
      if (d2P1Copilot is int) {
        print(
            'D2P1 - Copilot result: $d2P1Copilot (Time: ${stopwatch.elapsedMicroseconds} us)');
      }

      var inputData = await getParsedList(input);
      stopwatch.reset();
      stopwatch.start();
      var d2P1HomeBrew = await solveAocD2P1HomeBrew(inputData);
      stopwatch.stop();
      if (d2P1HomeBrew is int) {
        print(
            'D2P1 - homebrew parallel result: $d2P1HomeBrew (Time: ${stopwatch.elapsedMicroseconds} us)');
      }

      stopwatch.reset();
      stopwatch.start();
      var d2P1HomeBrewP =
          await solveAocD2P1HomeBrewParallel(inputData, workers);
      stopwatch.stop();
      print(
          'D2P1 - homebrew parallel result: $d2P1HomeBrewP (Time: ${stopwatch.elapsedMicroseconds} us, workers: $workers)');
    }
    return;
  }
}
