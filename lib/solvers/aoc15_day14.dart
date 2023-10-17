import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/14

/// Class to represent a reindeer
class Reindeer {
  final String name;
  final int speed;
  final int flyTime;
  final int restTime;

  // Additional properties
  int distance = 0; // Updated distance after every second
  int points = 0; // Accumulated points during the race
  int timeInCurrentState = 0; // Time spent flying or resting
  bool isFlying = true; // Initial state is flying

  Reindeer({
    required this.name,
    required this.speed,
    required this.flyTime,
    required this.restTime,
  });

  // You might add methods here to encapsulate behaviors, such as updating state
  void updateStateAndDistance() {
    // Increment timeInCurrentState
    timeInCurrentState++;

    // Update distance if reindeer is flying
    if (isFlying) {
      distance += speed;
    }

    // Check and update state if needed
    if (isFlying && timeInCurrentState >= flyTime) {
      // Start resting
      isFlying = false;
      timeInCurrentState = 0; // Reset timer
    } else if (!isFlying && timeInCurrentState >= restTime) {
      // Start flying
      isFlying = true;
      timeInCurrentState = 0; // Reset timer
    }
  }
}

class Day14P1Solver extends AoCSolver {
  final String? filePath;

  Day14P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      final pattern = RegExp(
          r'(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds\.');

      List<Reindeer> reindeers = [];

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        final match = pattern.firstMatch(line);
        if (match != null) {
          reindeers.add(Reindeer(
              name: match.group(1)!,
              speed: int.parse(match.group(2)!),
              flyTime: int.parse(match.group(3)!),
              restTime: int.parse(match.group(4)!)));
        }
      }

      var resultList = <int>[];

      for (var reindeer in reindeers) {
        var distanceCovered = 0;
        var time = 0;
        var isFlying = true;
        var timeLeft = reindeer.flyTime;

        while (time < 2503) {
          if (isFlying) {
            distanceCovered += reindeer.speed;
          }

          time++;
          timeLeft--;

          if (timeLeft == 0) {
            isFlying = !isFlying;
            timeLeft = isFlying ? reindeer.flyTime : reindeer.restTime;
          }
        }
        resultList.add(distanceCovered);
      }

      return Right('Day14P1Solver: ${resultList.reduce(max)}');
    } catch (e) {
      var errorMsg = 'Day14P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day14P2Solver extends AoCSolver {
  final String? filePath;

  Day14P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      final pattern = RegExp(
          r'(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds\.');

      List<Reindeer> reindeers = [];

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        final match = pattern.firstMatch(line);
        if (match != null) {
          reindeers.add(Reindeer(
              name: match.group(1)!,
              speed: int.parse(match.group(2)!),
              flyTime: int.parse(match.group(3)!),
              restTime: int.parse(match.group(4)!)));
        }
      }

      int totalRaceTime = 2503;
      for (int time = 0; time < totalRaceTime; time++) {
        // Update each reindeer's state and distance at this second.
        for (var reindeer in reindeers) {
          reindeer.updateStateAndDistance();
        }

        int maxDistance = reindeers.map((r) => r.distance).reduce(max);

        for (var reindeer in reindeers) {
          if (reindeer.distance == maxDistance) {
            reindeer.points += 1;
          }
        }
      }

      return Right(
          'Day14P2Solver: ${reindeers.map((x) => x.points).reduce(max)}');
    } catch (e) {
      var errorMsg = 'Day14P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
