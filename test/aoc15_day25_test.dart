import 'package:test/test.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/solvers/aoc15_day25.dart';

// TODO: Convert this to use the data library
void main() {
  group('Day25P1Solver', () {
    test('computes the grid code for custom input', () {
      StringBuffer buffer =
          StringBuffer('Enter the code at row 420, column 69.');
      var solver = Day25P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day25P1Solver: 463101');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day25P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isLeft(), true);
    });

    test('computes the grid code for actual input', () {
      StringBuffer actualInput =
          StringBuffer(getStringSync('data/aoc2015_day25_input.txt'));
      var solver = Day25P1Solver(actualInput, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day25P1Solver: 2650453');
    });
  });

  group('Day25P2Solver', () {
    test('computes the ideal quantum entanglement for custom input, 4 groups',
        () {
      StringBuffer buffer = StringBuffer('HO HO HO Merry christmas ');
      var solver = Day25P2Solver(buffer, null, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day25P2Solver: ⭐⭐⭐⭐⭐ x 10');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day25P2Solver(buffer, null, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the ideal quantum entanglement for actual input, 4 groups',
        () {
      final input = StringBuffer(getStringSync('data/aoc2015_day25_input.txt'));
      var solver = Day25P2Solver(input, null, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day25P2Solver: ⭐⭐⭐⭐⭐ x 10');
    });
  });
}
