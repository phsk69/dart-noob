import 'package:test/test.dart';
import 'package:dartz/dartz.dart'; // Make sure to import dartz for the Either type
import 'package:dart_noob/days/d1/aoc15_d1.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  group('Solve AOC 2015 D1', () {
    const String inputPath = 'data/aoc2015_day1_input';

    test('Test solveAoc15D1P1 with input path', () async {
      const int expected = 280;

      // Get the result as an Either
      Either<String, int> resultEither =
          await solveAoc15D1P1(inputPath, null, null);

      // Assert that the result is a Right, and extract the actual value
      resultEither.fold((l) => fail("Expected a Right but got a Left: $l"),
          (r) => expect(r, expected));
    });
    test('Test solveAoc15D1P1 with mock stream', () async {
      final String inputPath = 'data/aoc2015_day1_input';

      final inputData = await getFileAsString(inputPath);
      final expectedOutput = 280;

      final controller = StreamController<List<int>>();

      controller.add(utf8.encode(inputData));

      controller.close();

      final result = await solveAoc15D1P1(null, controller.stream, null);

      expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        expectedOutput,
      );
    });
    // Test with StringBuffer
    test('Test solveAoc15D1P1 with StringBuffer', () async {
      final String inputPath = 'data/aoc2015_day1_input';

      final inputData = await getStringBuffer(inputPath);
      final expectedOutput = 280;

      final result = await solveAoc15D1P1(null, null, inputData);

      expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        expectedOutput,
      );
    });
    // Test with inputPath
    test('Test solveAoc15D1P2 with inputPath', () async {
      const int expected = 1797;
      final d1P2 = await solveAoc15D1P2(inputPath, null, null);
      expect(
        d1P2.fold(
          (l) => l,
          (r) => r,
        ),
        expected,
      );
    });

// Test with mock stream
    test('Test solveAoc15D1P2 with mock stream', () async {
      const int expected = 1797;

      // Read the actual file content
      final inputData = await getFileAsString(inputPath);

      // Create a StreamController
      final controller = StreamController<List<int>>();

      // Your Stream<List<int>> is controller.stream
      final mockStdinStream = controller.stream;

      // Add your inputData to the stream
      controller.add(utf8.encode(inputData));

      // Close the StreamController to simulate end of stream
      controller.close();

      // Call your function and capture the output
      final d1P2 = await solveAoc15D1P2(null, mockStdinStream, null);

      // Validate your result
      expect(
        d1P2.fold(
          (l) => l,
          (r) => r,
        ),
        expected,
      );
    });
    // Test with StringBuffer
    test('Test solveAoc15D1P2 with StringBuffer', () async {
      final String inputPath = 'data/aoc2015_day1_input';

      final inputData = await getStringBuffer(inputPath);
      final expectedOutput = 1797;

      final result = await solveAoc15D1P2(null, null, inputData);

      expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        expectedOutput,
      );
    });
  });
}
