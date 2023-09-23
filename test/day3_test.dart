import 'package:test/test.dart';
import 'package:dart_noob/solvers/day3.dart'; // Make sure to adjust the import path

void main() {
  group('Day3P1Solver', () {
    test('computes correct houses visited from given input', () {
      StringBuffer buffer = StringBuffer('^>v<'); // Example data
      var solver = Day3P1Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''),
          'solveAoc15D3P1: 4'); // Expecting 4 unique houses visited
    });

    test('returns error when input is malformed', () {
      StringBuffer buffer =
          StringBuffer('^>v<a'); // Malformed data (contains an 'a')
      var solver = Day3P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct houses visited from file input', () {
      var solver = Day3P1Solver(null, 'data/aoc2015_day3_input.txt');

      var result = solver.solve();

      // Replace this with the expected result from your input file
      expect(result.getOrElse(() => ''), 'solveAoc15D3P1: 2572');
    });
  });

  group('Day3P2Solver', () {
    test(
        'computes correct houses visited by Santa and Robo-Santa from given input',
        () {
      StringBuffer buffer = StringBuffer('^v^v^v^v^v'); // Example data
      var solver = Day3P2Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''),
          'solveAoc15D3P2: 11'); // Expecting 11 unique houses visited
    });

    test('returns error when input is malformed', () {
      StringBuffer buffer =
          StringBuffer('^v^v^v^v^va'); // Malformed data (contains an 'a')
      var solver = Day3P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test(
        'computes correct houses visited by Santa and Robo-Santa from file input',
        () {
      var solver = Day3P2Solver(null, 'data/aoc2015_day3_input.txt');

      var result = solver.solve();

      // Replace this with the expected result from your input file
      expect(result.getOrElse(() => ''), 'solveAoc15D3P2: 2631');
    });
  });
}
