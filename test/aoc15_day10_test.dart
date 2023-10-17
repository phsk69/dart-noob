import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day10.dart';

void main() {
  group('Day10P1Solver', () {
    test('computes sequence length after 40 iterations for a given input', () {
      StringBuffer buffer = StringBuffer('1');
      var solver = Day10P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day10P1Solver: 82350');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day10P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes sequence length from file input after 40 iterations', () {
      var solver = Day10P1Solver(null, 'data/aoc2015_day10_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day10P1Solver: 252594');
    });
  });

  group('Day10P2Solver', () {
    test('computes sequence length after 50 iterations for a given input', () {
      StringBuffer buffer = StringBuffer('1');
      var solver = Day10P2Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day10P2Solver: 1166642');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day10P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes sequence length from file input after 50 iterations', () {
      var solver = Day10P2Solver(null, 'data/aoc2015_day10_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day10P2Solver: 3579328');
    });
  });
}
