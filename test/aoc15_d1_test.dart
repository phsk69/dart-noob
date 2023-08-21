import 'package:test/test.dart';
import 'package:dart_noob/aoc15_d1.dart';

void main() {
  group('solveAocD1', () {
    test('checks aoc d1 p1 for correctness', () async {
      const int expected = 280;
      var input = await getInputString('data/aoc2015_day1_input');
      var result = solveAocD1P1(input);
      expect(result, expected);
    });

    test('checks aoc d1 p2 for correctness', () async {
      const int expected = 1797;
      var input = await getInputString('data/aoc2015_day1_input');
      var d1P2 = solveAocD1P2(input);
      expect(d1P2, expected);
    });
  });
}
