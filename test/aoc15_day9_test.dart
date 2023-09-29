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

    // You can have similar tests for file inputs as you did for the Day8P1Solver
    test('computes shortest distance from file input', () {
      var solver = Day9P1Solver(
          null, 'data/aoc2015_day9_input.txt'); // Path to your test input file

      var result = solver.solve();

      expect(result.isRight(), true);
      // Update the following assertion based on the expected result from your test file.
      expect(result.getOrElse(() => ''), 'Day9P1Solver: 251');
    });
  });

  // If you have a Day9P2Solver, you can add tests for it in a similar manner
}
