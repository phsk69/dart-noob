import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day9.dart';

void main() {
  group('Day9P1Solver', () {
    test('computes shortest distance for a given input', () {
      StringBuffer buffer = StringBuffer('London to Dublin = 464\n'
          'London to Belfast = 518\n'
          'Dublin to Belfast = 141\n');
      var solver = Day9P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day9P1Solver: 605');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day9P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes shortest distance from file input', () {
      var solver = Day9P1Solver(null, 'data/aoc2015_day9_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day9P1Solver: 251');
    });
  });

  group('Day9P2Solver', () {
    test('computes longest distance for a given input', () {
      StringBuffer buffer = StringBuffer('London to Dublin = 464\n'
          'London to Belfast = 518\n'
          'Dublin to Belfast = 141\n');
      var solver = Day9P2Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day9P2Solver: 982');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day9P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    // Similar test for file inputs for Day9P2Solver
    test('computes longest distance from file input', () {
      var solver = Day9P2Solver(null, 'data/aoc2015_day9_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day9P2Solver: 898');
    });
  });
}
