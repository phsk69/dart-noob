import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day15.dart';

void main() {
  group('Day15P1Solver', () {
    test('computes the optimal score for ingredient mixtures', () {
      StringBuffer buffer = StringBuffer(
          'Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8\n'
          'Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3');
      var solver = Day15P1Solver(buffer, null);

      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day15P1Solver: 62842880');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day15P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the optimal score from file input', () {
      var solver = Day15P1Solver(null, 'data/aoc2015_day15_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day15P1Solver: 21367368');
    });
  });

  group('Day15P2Solver', () {
    test('computes the optimal score for 500-calorie ingredient mixtures', () {
      StringBuffer buffer = StringBuffer(
          'Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8\n'
          'Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3');
      var solver = Day15P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day15P2Solver: 57600000');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day15P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the optimal score from file input', () {
      var solver = Day15P2Solver(null, 'data/aoc2015_day15_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day15P2Solver: 1766400');
    });
  });
}
