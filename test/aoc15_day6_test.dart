import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day6.dart'; // Adjust this import path

// TODO: Convert this to use the data library
void main() {
  group('Day6P1Solver', () {
    test('computes correct number of lights turned on from given input', () {
      StringBuffer buffer = StringBuffer(
          'toggle 0,0 through 999,0\n' // Adjust this sample data as needed
          'turn on 0,0 through 999,0\n'
          'turn off 500,0 through 999,0\n');
      var solver = Day6P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''),
          'Day6P1Solver: 500'); // This is a hypothetical result
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer(''); // Empty data
      var solver = Day6P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct number of lights turned on from file input', () {
      var solver = Day6P1Solver(null, 'data/aoc2015_day6_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      // Replace 'PLACEHOLDER' with the expected result from your input file
      expect(result.getOrElse(() => ''), 'Day6P1Solver: 543903');
    });
  });

  group('Day6P2Solver', () {
    test('computes correct total brightness from given input', () {
      StringBuffer buffer = StringBuffer('toggle 0,0 through 999,0\n'
          'turn on 0,0 through 999,0\n'
          'turn off 500,0 through 999,0\n');
      var solver = Day6P2Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);

      expect(result.getOrElse(() => ''), 'Day6P2Solver: 2500');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer(''); // Empty data
      var solver = Day6P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct total brightness from file input', () {
      var solver = Day6P2Solver(null, 'data/aoc2015_day6_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day6P2Solver: 14687245');
    });
  });
}
