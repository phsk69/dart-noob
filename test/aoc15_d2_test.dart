import 'package:test/test.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p1.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p2.dart';

// https://adventofcode.com/2015/day/2

void main() {
  group('aoc15_d2_p1', () {
    const String inputPath = 'data/aoc2015_day2_input';
    const int expected = 1606483;
    test('checks aoc d2 p1 copilot for correctness', () async {
      var result = await solveAoc15D2P1CoPilot(inputPath);
      expect(result, expected);
    });

    test('checks aoc d2 p1 listoflists for correctness', () async {
      var result = await solveAoc15D2P1ListOfLists(inputPath);
      expect(result, expected);
    });

    test('checks aoc d2 p1 functional listoflists for correctness', () async {
      var result = await solveAoc15D2P1FunctionalListOfLists(inputPath);
      expect(result, expected);
    });

    test('checks aoc d2 p1 functional strings for correctness', () async {
      var result = await solveAoc15D2P1FunctionalFromStrings(inputPath);
      expect(result, expected);
    });

    test('checks aoc d2 p1 parallel for correctness', () async {
      var result = await solveAoc15D2P1Parallel(inputPath, 2);
      expect(result, expected);
    });
  });
  group('aoc15_d2_p2', () {
    const String inputPath = 'data/aoc2015_day2_input';
    const int expected = 3842356;
    test('checks aoc d2 p2 ListOfLists for correctness', () async {
      var result = await solveAoc15D2P2ListOfLists(inputPath);
      expect(result, expected);
    });
  });
}
