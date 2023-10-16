import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day20.dart';

// TODO: Convert the static buffers to files by buffering the input files via string_stuff

void main() {
  group('Day20P1Solver', () {
    test('computes the correct house number with provided input', () {
      StringBuffer buffer = StringBuffer('120');
      var solver = Day20P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day20P1Solver: 6');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day20P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the correct house number with input file', () {
      StringBuffer buffer = StringBuffer('34000000');
      // not using file input for this due to some radix bug
      var solver = Day20P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day20P1Solver: 786240');
    });
  });

  group('Day20P2Solver', () {
    test('computes the correct house number with provided input', () {
      StringBuffer buffer = StringBuffer('150');
      var solver = Day20P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day20P2Solver: 8');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day20P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the correct house number with input file', () {
      StringBuffer buffer = StringBuffer('34000000');
      // not using file input for this due to some radix bug
      var solver = Day20P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day20P2Solver: 831600');
    });
  });
}
