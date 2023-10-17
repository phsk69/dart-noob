import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day17.dart';

void main() {
  group('Day17P1Solver', () {
    test('computes the count of combinations of p1 with random input', () {
      StringBuffer buffer = StringBuffer(
          '43\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n');
      var solver = Day17P1Solver(buffer, null);

      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day17P1Solver: 207');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day17P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });
    test('computes the count of combinations of p1 with provided input', () {
      var solver = Day17P1Solver(null, 'data/aoc2015_day17_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day17P1Solver: 1638');
    });
  });

  group('Day17P2Solver', () {
    test('computes the count of combinations of p2 with random input', () {
      StringBuffer buffer =
          StringBuffer('43\n18\n13\n\n33\n44\n52\n61\n17\n28\n39\n12\n11');
      var solver = Day17P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day17P2Solver: 6');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day17P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });
    test('computes the count of combinations of p2 with provided input', () {
      var solver = Day17P2Solver(null, 'data/aoc2015_day17_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day17P2Solver: 17');
    });
  });
}
