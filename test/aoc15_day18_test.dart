import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day18.dart';

void main() {
  group('Day18P1Solver', () {
    test('computes the correct light count with provided input', () {
      StringBuffer buffer = StringBuffer(
          '.....\n...##\n..###\n.....\n..........\n...##\n..###\n.....\n.....');
      var solver = Day18P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day18P1Solver: 4');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day18P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the correct light count with input file', () {
      var solver = Day18P1Solver(null, 'data/aoc2015_day18_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day18P1Solver: 768');
    });
  });
  group('Day18P2Solver', () {
    test('computes the correct light count with provided input', () {
      StringBuffer buffer = StringBuffer(
          '.....\n...##\n..###\n.....\n..........\n...##\n..###\n.....\n.....');
      var solver = Day18P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day18P2Solver: 10');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day18P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the correct light count with input file', () {
      var solver = Day18P2Solver(null, 'data/aoc2015_day18_input.txt');

      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day18P2Solver: 781');
    });
  });
}
