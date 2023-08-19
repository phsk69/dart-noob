import 'package:test/test.dart';
import 'package:dart_noob/aoc15_d1.dart';

void main() {
  group('solveAocD1P1', () {
    test('checks aoc d1 p1 for correctness', () {
      const int expected = 280;
      expect(() async {
        var d1P1 = await solveAocD1P1(['data/aoc2015_day1_input']);
        expect(d1P1, expected);
      }, returnsNormally);
    });
  });
  group('solveAocD1P2', () {
    test('checks aoc d1 p2 for correctness', () {
      const int expected = 1797;
      expect(() async {
        var d1P1 = await solveAocD1P2(['data/aoc2015_day1_input']);
        expect(d1P1, expected);
      }, returnsNormally);
    });
  });
}
