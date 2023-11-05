import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day11.dart';

// TODO: Convert this to use the data library
void main() {
  group('Day11P1Solver', () {
    test('generates the next password for a given input', () {
      StringBuffer buffer = StringBuffer('abcdefgh');
      var solver = Day11P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day11P1Solver: abcdffaa');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day11P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('generates the next password from file input', () {
      var solver = Day11P1Solver(null, 'data/aoc2015_day11_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day11P1Solver: hxbxxyzz');
    });
  });

  group('Day11P2Solver', () {
    test('generates the second next password for a given input', () {
      StringBuffer buffer = StringBuffer('abcdefgh');
      var solver = Day11P2Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day11P2Solver: abcdffbb');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day11P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('generates the second next password from file input', () {
      var solver = Day11P2Solver(null, 'data/aoc2015_day11_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      // Adjust the expected output accordingly
      expect(result.getOrElse(() => ''), 'Day11P2Solver: hxcaabcc');
    });
  });
}
