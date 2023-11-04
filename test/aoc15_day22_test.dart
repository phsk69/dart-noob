import 'package:test/test.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/solvers/aoc15_day22.dart';

void main() {
  group('Day22P1Solver', () {
    setUp(() {
      minManaSpentToWin =
          1 << 30; // Reinitialize this variable before each test
    });
    test('computes the lowest cost to beat le boss with custom input', () {
      StringBuffer buffer = StringBuffer('Hit Points: 69\nDamage: 10');
      var solver = Day22P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day22P1Solver: 1771');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day22P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isLeft(), true);
    });

    test('computes the lowest cost to beat le boss with file input', () {
      StringBuffer actualInput =
          StringBuffer(getStringSync('data/aoc2015_day22_input.txt'));
      var solver = Day22P1Solver(actualInput, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day22P1Solver: 1824');
    });
  });
/*
  group('Day22P2Solver', () {
    test('computes the highest cost to to lose with custom input', () {
      StringBuffer buffer = StringBuffer('Hit Points: 69\nDamage: 4\nArmor: 2');
      var solver = Day22P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day22P2Solver: 1824');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day22P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the highest cost to to lose with file input', () {
      final input = StringBuffer(getStringSync('data/aoc2015_day22_input.txt'));
      var solver = Day22P2Solver(input, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day22P2Solver: 188');
    });
  });
  */
}
