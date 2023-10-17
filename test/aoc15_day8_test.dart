import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day8.dart';

void main() {
  group('Day8P1Solver', () {
    test('computes correct difference for a given input', () {
      StringBuffer buffer = StringBuffer('"\n'
          '"abc"\n'
          '"aaa\\"aaa"\n'
          '"\\x27"\n');
      var solver = Day8P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day8P1Solver: 11');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day8P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct difference from file input', () {
      var solver = Day8P1Solver(null, 'data/aoc2015_day8_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day8P1Solver: 1342');
    });
  });

  group('Day8P2Solver', () {
    test('computes correct difference for a given input', () {
      StringBuffer buffer = StringBuffer('"\n'
          '"abc"\n'
          '"aaa\\"aaa"\n'
          '"\\x27"\n');
      var solver = Day8P2Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day8P2Solver: 18');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer(''); // Empty data
      var solver = Day8P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct difference from file input', () {
      var solver = Day8P2Solver(null, 'data/aoc2015_day8_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day8P2Solver: 2074');
    });
  });
}
