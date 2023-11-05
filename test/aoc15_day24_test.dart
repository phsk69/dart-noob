import 'package:test/test.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/solvers/aoc15_day24.dart';

void main() {
  group('Day24P1Solver', () {
    test('computes the ideal quantum entanglement for custom input, 3 groups',
        () {
      StringBuffer buffer = StringBuffer('1\n2\n3\n5\n7\n13\n17\n19\n23\n29');
      var solver = Day24P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day24P1Solver: 609');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day24P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isLeft(), true);
    });

    test('computes the ideal quantum entanglement for actual input, 3 groups',
        () {
      StringBuffer actualInput =
          StringBuffer(getStringSync('data/aoc2015_day24_input.txt'));
      var solver = Day24P1Solver(actualInput, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day24P1Solver: 10723906903');
    });
  });

  group('Day24P2Solver', () {
    test('computes the ideal quantum entanglement for custom input, 4 groups',
        () {
      StringBuffer buffer =
          StringBuffer('1\n2\n3\n5\n7\n13\n17\n19\n23\n29\n31\n37\n41\n43');
      var solver = Day24P2Solver(buffer, null, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day24P2Solver: 989');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day24P2Solver(buffer, null, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the ideal quantum entanglement for actual input, 4 groups',
        () {
      final input = StringBuffer(getStringSync('data/aoc2015_day24_input.txt'));
      var solver = Day24P2Solver(input, null, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day24P2Solver: 74850409');
    });
  });
}
