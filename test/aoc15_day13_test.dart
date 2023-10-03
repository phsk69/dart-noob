import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day13.dart';

void main() {
  group('Day13P1Solver', () {
    test('computes the maximum total change in happiness', () {
      StringBuffer buffer = StringBuffer(
          'Alice would gain 54 happiness units by sitting next to Bob.\n'
          'Alice would lose 79 happiness units by sitting next to Carol.\n'
          'Alice would lose 2 happiness units by sitting next to David.\n'
          'Bob would gain 83 happiness units by sitting next to Alice.\n'
          'Bob would lose 7 happiness units by sitting next to Carol.\n'
          'Bob would lose 63 happiness units by sitting next to David.\n'
          'Carol would lose 62 happiness units by sitting next to Alice.\n'
          'Carol would gain 60 happiness units by sitting next to Bob.\n'
          'Carol would gain 55 happiness units by sitting next to David.\n'
          'David would gain 46 happiness units by sitting next to Alice.\n'
          'David would lose 7 happiness units by sitting next to Bob.\n'
          'David would gain 41 happiness units by sitting next to Carol.');
      var solver = Day13P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day13P1Solver: 330');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day13P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the happiness from file input', () {
      var solver = Day13P1Solver(null, 'data/aoc2015_day13_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day13P1Solver: 733');
    });
  });

  group('Day13P2Solver', () {
    test('computes the maximum total change in happiness including yourself',
        () {
      StringBuffer buffer = StringBuffer(
          'Alice would gain 54 happiness units by sitting next to Bob.\n'
          'Alice would lose 79 happiness units by sitting next to Carol.\n'
          'Alice would lose 2 happiness units by sitting next to David.\n'
          'Bob would gain 83 happiness units by sitting next to Alice.\n'
          'Bob would lose 7 happiness units by sitting next to Carol.\n'
          'Bob would lose 63 happiness units by sitting next to David.\n'
          'Carol would lose 62 happiness units by sitting next to Alice.\n'
          'Carol would gain 60 happiness units by sitting next to Bob.\n'
          'Carol would gain 55 happiness units by sitting next to David.\n'
          'David would gain 46 happiness units by sitting next to Alice.\n'
          'David would lose 7 happiness units by sitting next to Bob.\n'
          'David would gain 41 happiness units by sitting next to Carol.');

      var solver = Day13P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day13P2Solver: 286');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day13P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the happiness from file input', () {
      var solver = Day13P2Solver(null, 'data/aoc2015_day13_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day13P2Solver: 725');
    });
  });
}
