import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day12.dart';

void main() {
  group('Day12P1Solver', () {
    test('computes the sum of all values in JSON', () {
      StringBuffer buffer =
          StringBuffer('{"a": 1, "b": {"c": 2}, "d": [3, 4]}');
      var solver = Day12P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day12P1Solver: 10');
    });

    test('ignores empty JSON input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day12P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the sum from file input', () {
      var solver = Day12P1Solver(null, 'data/aoc2015_day12_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day12P1Solver: 119433');
    });
  });

  group('Day12P2Solver', () {
    test('computes the sum of all values in JSON without "red"', () {
      StringBuffer buffer =
          StringBuffer('{"a": 1, "b": "red", "c": [1, "red", {"d": "red"}]}');
      var solver = Day12P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day12P2Solver: 0');
    });

    test('ignores empty JSON input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day12P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the sum from file input', () {
      var solver = Day12P2Solver(null, 'data/aoc2015_day12_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day12P2Solver: 68466');
    });
  });
}
