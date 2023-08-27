import 'package:test/test.dart';
import 'package:dart_noob/days/d5/aoc15_d5.dart';

void main() {
  group('solveAocD5', () {
    const String input = 'data/aoc2015_day5_input';
    test('checks aoc d5 p1 for correctness', () async {
      int expected = 238;
      var result = await solveAocD5P1(input);
      expect(result, expected);
    });
    /*
    test('checks aoc d5 p2 for correctness', () async {
      BigInt expected = BigInt.from(1038736);
      var result = await solveAocD4P2(input);
      expect(result, expected);
    });
  */
  });
}
