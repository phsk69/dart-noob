import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day16.dart';

void main() {
  group('Day16P1Solver', () {
    test('computes the correct aunt ID for example input', () {
      StringBuffer buffer =
          StringBuffer('Sue 1: cars: 9, akitas: 3, goldfish: 0\n'
              'Sue 2: akitas: 9, children: 3, samoyeds: 9\n'
              'Sue 1337: vizslas: 0, cats: 7, akitas: 0\n');
      var solver = Day16P1Solver(buffer, null);

      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day16P1Solver: 1337');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day16P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });
    test('computes the correct aunt given p1 conditions', () {
      var solver = Day16P1Solver(null, 'data/aoc2015_day16_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day16P1Solver: 40');
    });
  });

  group('Day16P2Solver', () {
    test('computes the correct aunt ID for example input with retroencabulator',
        () {
      StringBuffer buffer =
          StringBuffer('Sue 1: cars: 9, akitas: 3, goldfish: 0\n'
              'Sue 2: akitas: 9, children: 3, samoyeds: 9\n'
              'Sue 420: cars: 2, pomeranians: 1, samoyeds: 2\n');
      var solver = Day16P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day16P2Solver: 420');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day16P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });
    test('computes the correct aunt given with retroencabulator', () {
      var solver = Day16P2Solver(null, 'data/aoc2015_day16_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day16P2Solver: 241');
    });
  });
}
