import 'package:test/test.dart';
import 'package:dart_noob/aoc15_d2.dart';

void main() {
  group('aoc15_d2', () {
    test('checks aoc d2 p1 copilot for correctness', () {
      const int expected = 1606483;
      expect(() async {
        var d1P1 = await solveAocD2P1CoPilot(['data/aoc2015_day2_input']);
        expect(d1P1, expected);
      }, returnsNormally);
    });
    test('checks aoc d2 p1 homebrew for correctness', () {
      const int expected = 1606483;
      expect(() async {
        var d1P1 = await solveAocD2P1HomeBrew(['data/aoc2015_day2_input']);
        expect(d1P1, expected);
      }, returnsNormally);
    });
  });
}
