import 'package:dart_noob/aoc15_d1.dart';
import 'package:dart_noob/aoc15_d2.dart';
import 'package:dart_noob/benchmarks.dart';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('day', abbr: 'd', help: 'Specify the day to run')
    ..addOption('input', abbr: 'i', help: 'Specify path to puzzle input')
    ..addFlag('bench', abbr: 'b', negatable: false, help: 'Run benchmarks');

  var args = parser.parse(arguments);

  String? day = args['day'] as String?;
  String? input = args['input'] as String?;

  if (args['bench'] as bool) {
    if (input != null) {
      await benchRunner(input);
    }
    return;
  }

  if (input != null) {
    if (day == '1') {
      var inputData = await getInputByLine(input);

      var d1P1 = await solveAocD1P1(inputData);
      if (d1P1 is int) {
        print('Day 1 part 1: $d1P1');
      }
      var d1P2 = await solveAocD1P2(inputData);
      if (d1P2 is int) {
        print('Day 1 part 2: $d1P2');
      }
    }

    if (day == '2') {
      var inputData = await getParsedList(input);

      var d2P1HomeBrew = await solveAocD2P1HomeBrew(inputData);
      if (d2P1HomeBrew is int) {
        print('Day 2 part 1 - homebrew: $d2P1HomeBrew');
      }

      var d2P1CoPilot = await solveAocD2P1HomeBrew(inputData);
      if (d2P1CoPilot is int) {
        print('Day 2 part 1 - Copilot: $d2P1CoPilot');
      }
    }
  }
  return;
}
