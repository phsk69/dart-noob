import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day1.dart';

// TODO: Convert this to use the data library
void main() {
  group('Day1P1Solver', () {
    test('computes correct floor from given input', () {
      StringBuffer buffer = StringBuffer('((())');
      var solver = Day1P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day1P1Solver: 1');
    });

    test('computes correct floor from file input', () {
      var solver = Day1P1Solver(null, 'data/aoc2015_day1_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day1P1Solver: 280');
    });
  });

  group('Day1P2Solver', () {
    test('computes position where Santa first enters the basement', () {
      StringBuffer buffer = StringBuffer('())');
      var solver = Day1P2Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day1P2Solver: 3');
    });

    test('returns error when Santa never reaches the basement', () {
      StringBuffer buffer = StringBuffer('(((');
      var solver = Day1P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), 'Never reached the basement');
    });

    // New test for file fallback
    test(
        'computes position where Santa first enters the basement from file input',
        () {
      var solver = Day1P2Solver(null, 'data/aoc2015_day1_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day1P2Solver: 1797');
    });
  });
}
