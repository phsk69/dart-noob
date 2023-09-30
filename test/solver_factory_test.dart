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
    test('creates solvers for mode d6', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d6', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day6P1Solver, true);
      expect(solvers[1] is Day6P2Solver, true);
    });

    test('creates solvers for mode d7', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d7', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day7P1Solver, true);
      expect(solvers[1] is Day7P2Solver, true);
    });

    test('creates solvers for mode d8', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d8', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day8P1Solver, true);
      expect(solvers[1] is Day8P2Solver, true);
    });

    test('creates solvers for mode d9', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d9', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day9P1Solver, true);
      expect(solvers[1] is Day9P2Solver, true);
    });
    test('creates solvers for mode d10', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d10', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day10P1Solver, true);
      expect(solvers[1] is Day10P2Solver, true);
    });

    test('creates solvers for mode d11', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d11', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day11P1Solver, true);
      expect(solvers[1] is Day11P2Solver, true);
    });
  });
}
