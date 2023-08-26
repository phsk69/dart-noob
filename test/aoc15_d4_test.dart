import 'package:test/test.dart';
import 'package:dart_noob/days/d4/aoc15_d4.dart';

void main() {
  group('solveAocD4', () {
    const String input = 'data/aoc2015_day4_input';
    test('checks aoc d4 p1 for correctness', () async {
      BigInt expected = BigInt.from(254575);
      var result = await solveAocD4P1(input);
      expect(result, expected);
    });
  });
}
