import 'package:test/test.dart';
import 'package:dart_noob/aoc15_d2.dart';

void main() {
  group('solveAocD2P1', () {
    test('checks aoc d2 p1 for correctness', () {
      const int expected = 1606483;
      expect(() async {
        var d1P1 = await solveAocD2P1(['data/aoc2015_day2_input']);
        expect(d1P1, expected);
      }, returnsNormally);
    });
  });
}
