import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day14.dart';

// TODO: Convert this to use the data library
void main() {
  group('Day14P1Solver', () {
    test('computes the maximum distance a reindeer can travel', () {
      StringBuffer buffer = StringBuffer(
          'Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.\n'
          'Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.');
      var solver = Day14P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day14P1Solver: 2660');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day14P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the maximum distance from file input', () {
      var solver = Day14P1Solver(null, 'data/aoc2015_day14_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day14P1Solver: 2696');
    });
  });

  group('Day14P2Solver', () {
    test('computes the maximum points a reindeer can get', () {
      StringBuffer buffer = StringBuffer(
          'Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.\n'
          'Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.');
      var solver = Day14P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day14P2Solver: 1564');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day14P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the maximum points from file input', () {
      var solver = Day14P2Solver(null, 'data/aoc2015_day14_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day14P2Solver: 1084');
    });
  });
}
