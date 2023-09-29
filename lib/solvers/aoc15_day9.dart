import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/9

/// Recursive voodoo magic to get all permutations of a list of locations
List<List<String>> _getPermutations(List<String> locations) {
  if (locations.length == 1) return [locations];
  var permutations = <List<String>>[];

  for (var i = 0; i < locations.length; i++) {
    var currentLocation = locations[i];
    var remainingLocations = List<String>.from(locations)..removeAt(i);
    for (var permutation in _getPermutations(remainingLocations)) {
      permutations.add([currentLocation, ...permutation]);
    }
  }
  return permutations;
}

class Day9P1Solver extends AoCSolver {
  final String? filePath;

  Day9P1Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      var locations = <String>{};
      var distanceMap = <String, int>{};

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        var route = line.split(' ');
        var source = route[0];
        var destination = route[2];
        var distance = int.parse(route[4]);

        locations.add(source);
        locations.add(destination);

        // Store distance between source and destination in both directions (since the distance is symmetric)
        distanceMap['$source-$destination'] = distance;
        distanceMap['$destination-$source'] = distance;
      }

      var allPermutations = _getPermutations(locations.toList());
      var shortestDistance = double.infinity;

      for (var permutation in allPermutations) {
        var distance = 0;
        for (var i = 0; i < permutation.length - 1; i++) {
          distance +=
              distanceMap['${permutation[i]}-${permutation[i + 1]}'] ?? 0;
        }
        if (distance < shortestDistance) {
          shortestDistance = distance.toDouble();
        }
      }

      return Right('Day9P1Solver: ${shortestDistance.toInt()}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day9P2Solver extends AoCSolver {
  final String? filePath;

  Day9P2Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      var locations = <String>{};
      var distanceMap = <String, int>{};

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        var route = line.split(' ');
        var source = route[0];
        var destination = route[2];
        var distance = int.parse(route[4]);

        locations.add(source);
        locations.add(destination);

        // Store distance between source and destination in both directions (since the distance is symmetric)
        distanceMap['$source-$destination'] = distance;
        distanceMap['$destination-$source'] = distance;
      }

      var allPermutations = _getPermutations(locations.toList());
      var longestDistance =
          double.negativeInfinity; // Change #1: Initialize to negative infinity

      for (var permutation in allPermutations) {
        var distance = 0;
        for (var i = 0; i < permutation.length - 1; i++) {
          distance +=
              distanceMap['${permutation[i]}-${permutation[i + 1]}'] ?? 0;
        }
        if (distance > longestDistance) {
          // Change #2: Update when distance is greater
          longestDistance = distance.toDouble();
        }
      }

      return Right('Day9P2Solver: ${longestDistance.toInt()}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
