import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day7.dart'; // Adjust this import path to match your structure

// TODO: Convert this to use the data library
void main() {
  group('Day7P1Solver', () {
    test('computes correct value for wire "a" from given input', () {
      StringBuffer buffer = StringBuffer('123 -> x\n'
          '456 -> y\n'
          'x AND y -> d\n'
          'x OR y -> e\n'
          'x LSHIFT 2 -> f\n'
          'y RSHIFT 2 -> g\n'
          'NOT x -> h\n'
          'NOT y -> i\n'
          'e -> a\n');
      var solver = Day7P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''),
          'Day7P1Solver: 507'); // This should now return the value of wire 'a'
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer(''); // Empty data
      var solver = Day7P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct value for wire "a" from file input', () {
      var solver = Day7P1Solver(null, 'data/aoc2015_day7_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      // Replace 'PLACEHOLDER' with the expected result from your input file
      expect(result.getOrElse(() => ''), 'Day7P1Solver: 3176');
    });
  });

  group('Day7P2Solver', () {
    test('computes correct value for wire "a" from given input for Part 2', () {
      StringBuffer buffer = StringBuffer('123 -> x\n'
          '456 -> y\n'
          'x AND y -> d\n'
          'x OR y -> e\n'
          'x LSHIFT 2 -> f\n'
          'y RSHIFT 2 -> g\n'
          'NOT x -> h\n'
          'NOT y -> i\n'
          'e -> a\n'); // You can modify this input if needed
      var solver = Day7P2Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day7P2Solver: 507');
    });

    test('returns error when input is empty for Part 2', () {
      StringBuffer buffer = StringBuffer(''); // Empty data
      var solver = Day7P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct value for wire "a" from file input for Part 2', () {
      var solver = Day7P2Solver(null, 'data/aoc2015_day7_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day7P2Solver: 14710');
    });
  });
}
