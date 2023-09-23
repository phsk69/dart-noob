import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day5.dart'; // Adjust this import path

void main() {
  group('Day5P1Solver', () {
    test('computes correct number of good strings from given input', () {
      StringBuffer buffer = StringBuffer(
          'ugknbfddgicrmopn\naaa\njchzalrnumimnmhp\nhaegwjzuvuyypxyu\n');
      var solver = Day5P1Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''), 'solveAoc15D5P1: 2');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer(''); // Empty data
      var solver = Day5P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct number of good strings from file input', () {
      var solver = Day5P1Solver(null, 'data/aoc2015_day5_input.txt');

      var result = solver.solve();

      // Replace this with the expected result from your input file
      expect(result.getOrElse(() => ''), 'solveAoc15D5P1: 238');
    });
  });

  group('Day5P2Solver', () {
    test('computes correct number of good strings for p2 from given input', () {
      StringBuffer buffer = StringBuffer(
          'qjhvhtzxzqqjkmpb\nxxyxx\nuurcxstgmygtbstg\nieodomkazucvgmuy\n');
      var solver = Day5P2Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''), 'solveAoc15D5P2: 2');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day5P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test(
        'computes correct number of good strings for new rules from file input',
        () {
      var solver = Day5P2Solver(null, 'data/aoc2015_day5_input.txt');

      var result = solver.solve();

      // Replace this with the expected result from your input file
      expect(result.getOrElse(() => ''), 'solveAoc15D5P2: 69');
    });
  });
}
