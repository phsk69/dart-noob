import 'package:test/test.dart';
import 'package:dart_noob/factories/solver_factory.dart';
import 'package:dart_noob/solvers/solvers.dart';

void main() {
  group('SolverFactory', () {
    test('returns error for unknown mode', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('unknown_mode', buffer);

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), 'Unknown mode: unknown_mode');
    });

    test('creates solvers for mode d1', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d1', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day1P1Solver, true);
      expect(solvers[1] is Day1P2Solver, true);
    });

    test('creates solvers for mode d2', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d2', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day2P1Solver, true);
      expect(solvers[1] is Day2P2Solver, true);
    });

    test('creates solvers for mode d3', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d3', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day3P1Solver, true);
      expect(solvers[1] is Day3P2Solver, true);
    });

    test('creates solvers for mode d4', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d4', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day4P1Solver, true);
      expect(solvers[1] is Day4P2Solver, true);
    });

    test('creates solvers for mode d5', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d5', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day5P1Solver, true);
      expect(solvers[1] is Day5P2Solver, true);
    });
  });
}
