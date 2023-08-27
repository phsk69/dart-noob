import 'package:test/test.dart';
import 'package:dart_noob/days/d4/aoc15_d4.dart';

// https://adventofcode.com/2015/day/4

void main() {
  group('solveAoc15D4', () {
    const String input = 'data/aoc2015_day4_input';
    test('checks aoc d4 p1 for correctness', () async {
      BigInt expected = BigInt.from(254575);
      var result = await solveAoc15D4P1(input);
      expect(result, expected);
    });

    test('checks aoc d4 p2 for correctness', () async {
      BigInt expected = BigInt.from(1038736);
      var result = await solveAoc15D4P2(input);
      expect(result, expected);
    });
  });
}
