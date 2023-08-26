import 'package:test/test.dart';
import 'package:dart_noob/util/file_stuff.dart';
import 'package:dart_noob/days/d3/aoc15_d3.dart';

void main() {
  group('solveAocD3', () {
    test('checks aoc d3 p1 for correctness', () async {
      const int expected = 2572;
      var result = await solveAocD3P1('data/aoc2015_day3_input');
      expect(result, expected);
    });

    test('checks aoc d3 p2 for correctness', () async {
      const int expected = 2631;
      var result = await solveAocD3P2('data/aoc2015_day3_input');
      expect(result, expected);
    });
  });
}
