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

    test('creates solvers for mode default', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('default', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 8);
      expect(solvers[0] is Day1P1Solver, true);
      expect(solvers[1] is Day1P2Solver, true);
      expect(solvers[2] is Day2P1Solver, true);
      expect(solvers[3] is Day2P2Solver, true);
      expect(solvers[4] is Day3P1Solver, true);
      expect(solvers[5] is Day3P2Solver, true);
      expect(solvers[6] is Day4P1Solver, true);
      expect(solvers[7] is Day4P2Solver, true);
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

    test('creates solvers for mode d12', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d12', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day12P1Solver, true);
      expect(solvers[1] is Day12P2Solver, true);
    });

    test('creates solvers for mode d13', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d13', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day13P1Solver, true);
      expect(solvers[1] is Day13P2Solver, true);
    });

    test('creates solvers for mode d14', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d14', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day14P1Solver, true);
      expect(solvers[1] is Day14P2Solver, true);
    });

    test('creates solvers for mode d15', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d15', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day15P1Solver, true);
      expect(solvers[1] is Day15P2Solver, true);
    });

    test('creates solvers for mode d16', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d16', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day16P1Solver, true);
      expect(solvers[1] is Day16P2Solver, true);
    });

    test('creates solvers for mode d17', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d17', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day17P1Solver, true);
      expect(solvers[1] is Day17P2Solver, true);
    });

    test('creates solvers for mode d18', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d18', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day18P1Solver, true);
      expect(solvers[1] is Day18P2Solver, true);
    });

    test('creates solvers for mode d19', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d19', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day19P1Solver, true);
      expect(solvers[1] is Day19P2Solver, true);
    });

    test('creates solvers for mode d20', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d20', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day20P1Solver, true);
      expect(solvers[1] is Day20P2Solver, true);
    });

    test('creates solvers for mode d21', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d21', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day21P1Solver, true);
      expect(solvers[1] is Day21P2Solver, true);
    });

    test('creates solvers for mode d22', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d22', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day22P1Solver, true);
      expect(solvers[1] is Day22P2Solver, true);
    });

    test('creates solvers for mode d23', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d23', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day23P1Solver, true);
      expect(solvers[1] is Day23P2Solver, true);
    });

    test('creates solvers for mode d24', () {
      StringBuffer buffer = StringBuffer('Any test string');
      var result = SolverFactory.create('d24', buffer);

      expect(result.isRight(), true);
      List<AoCSolver> solvers = result.getOrElse(() => []);
      expect(solvers.length, 2);
      expect(solvers[0] is Day24P1Solver, true);
      expect(solvers[1] is Day24P2Solver, true);
    });
  });
}
