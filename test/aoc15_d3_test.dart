import 'package:test/test.dart';
import 'package:dart_noob/days/d3/aoc15_d3.dart';

// https://adventofcode.com/2015/day/3

void main() {
  group('solveAoc15D', () {
    const String input = 'data/aoc2015_day3_input';

    test('checks aoc d3 p1 for correctness', () async {
      const int expected = 2572;
      var result = await solveAoc15D3P1(input);
      expect(result, expected);
    });

    test('checks aoc d3 p2 for correctness', () async {
      const int expected = 2631;
      var result = await solveAoc15D3P2(input);
      expect(result, expected);
    });
  });
}
