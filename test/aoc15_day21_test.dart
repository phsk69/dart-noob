import 'package:test/test.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/solvers/aoc15_day21.dart';

void main() {
  group('Day21P1Solver', () {
    test('computes the lowest cost to beat le boss with custom input', () {
      StringBuffer buffer = StringBuffer('Hit Points: 69\nDamage: 4\nArmor: 2');
      var solver = Day21P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day21P1Solver: 10');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day21P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the lowest cost to beat le boss with file input', () {
      final input = StringBuffer(getStringSync('data/aoc2015_day21_input.txt'));
      var solver = Day21P1Solver(input, null);
      var result = solver.solve();
      //print(result);
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day21P1Solver: 111');
    });
  });

  group('Day21P2Solver', () {
    test('computes the highest cost to to lose with custom input', () {
      StringBuffer buffer = StringBuffer('Hit Points: 69\nDamage: 4\nArmor: 2');
      var solver = Day21P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day21P2Solver: 28');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day21P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the highest cost to to lose with file input', () {
      final input = StringBuffer(getStringSync('data/aoc2015_day21_input.txt'));
      var solver = Day21P2Solver(input, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day21P2Solver: 188');
    });
  });
}
