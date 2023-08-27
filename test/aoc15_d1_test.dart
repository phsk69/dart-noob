import 'package:test/test.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';

// https://adventofcode.com/2015/day/1

void main() {
  group('solveAoc15D1', () {
    const String input = 'data/aoc2015_day1_input';
    test('checks aoc 15 d1 p1 for correctness', () async {
      const int expected = 280;
      var result = await solveAoc15D1P1(input);
      expect(result, expected);
    });

    test('checks aoc 15 d1 p2 for correctness', () async {
      const int expected = 1797;
      var d1P2 = await solveAoc15D1P2(input);
      expect(d1P2, expected);
    });
  });
}
