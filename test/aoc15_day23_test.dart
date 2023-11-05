import 'package:test/test.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/solvers/aoc15_day23.dart';

// TODO: Convert this to use the data library
void main() {
  group('Day23P1Solver', () {
    test('computes the value of register b given a custom input', () {
      StringBuffer buffer =
          StringBuffer('jio b, +16\ninc b\ntpl b\njie b, +4\njmp +2\nhlf b\n');
      var solver = Day23P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day23P1Solver: 3');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day23P1Solver(buffer, null, null);
      var result = solver.solve();
      expect(result.isLeft(), true);
    });

    test('computes the value of register b given the actual input', () {
      StringBuffer actualInput =
          StringBuffer(getStringSync('data/aoc2015_day23_input.txt'));
      var solver = Day23P1Solver(actualInput, null, null);
      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day23P1Solver: 170');
    });
  });

  group('Day23P2Solver', () {
    test('computes the value of register b given a custom input', () {
      StringBuffer buffer = StringBuffer(
          'jio b, +16\ninc b\ntpl b\njie b, +4\njmp +2\nhlf b\ntpl b');
      var solver = Day23P2Solver(buffer, null, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day23P2Solver: 9');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day23P2Solver(buffer, null, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the value of register b given the actual input', () {
      final input = StringBuffer(getStringSync('data/aoc2015_day23_input.txt'));
      var solver = Day23P2Solver(input, null, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day23P2Solver: 247');
    });
  });
}
