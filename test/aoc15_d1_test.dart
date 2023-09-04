import 'package:test/test.dart';
import 'package:dartz/dartz.dart'; // Make sure to import dartz for the Either type
import 'package:dart_noob/days/d1/aoc15_d1.dart';
import 'package:dart_noob/util/file_stuff.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  group('solveAoc15D1', () {
    const String inputPath = 'data/aoc2015_day1_input';

    test('checks aoc 15 d1 p1 for correctness', () async {
      const int expected = 280;

      // Get the result as an Either
      Either<String, int> resultEither = await solveAoc15D1P1(inputPath, null);

      // Assert that the result is a Right, and extract the actual value
      resultEither.fold(
          (l) => fail(
              "Expected a Right but got a Left: $l"), // Fail the test if there's an error (Left)
          (r) => expect(
              r, expected) // Expect the value if everything is fine (Right)
          );
    });
    test('Test solveAoc15D1P1 with simulated stdin', () async {
      final String inputPath = 'data/aoc2015_day1_input';

      final inputData = await getFileAsString(inputPath);
      final expectedOutput = 280;

      final controller = StreamController<List<int>>();

      // Add your inputData to the stream
      controller.add(utf8.encode(inputData));

      // Close the StreamController to simulate end of stream
      controller.close();

      // Pass the stream from the StreamController as inputStream to your function
      final result = await solveAoc15D1P1(null, controller.stream);

      // Validate your result
      expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        expectedOutput,
      );
    });
    // Test with inputPath
    test('checks aoc 15 d1 p2 for correctness with inputPath', () async {
      const int expected = 1797;
      final d1P2 = await solveAoc15D1P2(inputPath, null);
      expect(
        d1P2.fold(
          (l) => l,
          (r) => r,
        ),
        expected,
      );
    });

// Test with mock stream
    test('checks aoc 15 d1 p2 for correctness with mock stream', () async {
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
      final d1P2 = await solveAoc15D1P2(null, mockStdinStream);

      // Validate your result
      expect(
        d1P2.fold(
          (l) => l,
          (r) => r,
        ),
        expected,
      );
    });
  });
}
