import 'package:test/test.dart';
import 'package:dart_noob/factories/solver_factory.dart';
import 'package:dart_noob/solvers/day1.dart';

void main() {
  group('Day1P1Solver', () {
    test('computes correct floor from given input', () {
      StringBuffer buffer = StringBuffer('((())');
      var solver = Day1P1Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''), 'solveAoc15D1P1: 1');
    });

    // New test for file fallback
    test('computes correct floor from file input', () {
      var solver = Day1P1Solver(null, 'data/aoc2015_day1_input');

      var result = solver.solve();

      // The expectation here would depend on the contents of the file
      expect(result.getOrElse(() => ''), 'solveAoc15D1P1: 280');
    });
  });

  group('Day1P2Solver', () {
    test('computes position where Santa first enters the basement', () {
      StringBuffer buffer = StringBuffer('())');
      var solver = Day1P2Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''), 'solveAoc15D1P2: 3');
    });

    test('returns error when Santa never reaches the basement', () {
      StringBuffer buffer = StringBuffer('(((');
      var solver = Day1P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), 'Never reached the basement');
    });

    // New test for file fallback
    test(
        'computes position where Santa first enters the basement from file input',
        () {
      var solver = Day1P2Solver(null, 'data/aoc2015_day1_input');

      var result = solver.solve();

      // The expectation here would depend on the contents of the file
      expect(result.getOrElse(() => ''), 'solveAoc15D1P2: 1797');
    });
  });

  group('SolverFactory', () {
    test('creates solvers for mode d1', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d1', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day1P1Solver, true);
      expect(solvers[1] is Day1P2Solver, true);
    });

    test('returns error for unknown mode', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('unknown_mode', buffer);

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), 'Unknown mode: unknown_mode');
    });
  });
}
