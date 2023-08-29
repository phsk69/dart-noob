import 'package:test/test.dart';
import 'package:dart_noob/days/d5/aoc15_d5.dart';

// https://adventofcode.com/2015/day/5

void main() {
  group('solveAoc15D5', () {
    const String input = 'data/aoc2015_day5_input';
    test('checks aoc 15 d5 p1 for correctness', () async {
      int expected = 238;
      var result = await solveAoc15D5P1(input);
      expect(result, expected);
    });

    test('checks aoc 15 d5 p2 for correctness', () async {
      int expected = 69;
      var result = await solveAoc15D5P2(input);
      expect(result, expected);
    });
  });
}
