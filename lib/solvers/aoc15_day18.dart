import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/18

/// Parses the input data into a list of of list of strings.
List<List<String>> parseD18Input(String inputData) {
  var grid = <List<String>>[];
  for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
    grid.add(line.split(''));
  }
  return grid;
}

List<String> getNeighbors(int x, int y, List<List<String>> grid) {
  List<String> neighbors = [];
  // Define all potential relative neighbor positions.
  List<List<int>> possibleOffsets = [
    [-1, -1],
    [0, -1],
    [1, -1],
    [-1, 0],
    [1, 0],
    [-1, 1],
    [0, 1],
    [1, 1]
  ];

  // Iterate through possibleOffsets and check if they correspond to a valid position in grid.
  for (var offset in possibleOffsets) {
    int newX = x + offset[0];
    int newY = y + offset[1];
    if (newX >= 0 && newY >= 0 && newX < grid.length && newY < grid[0].length) {
      neighbors.add(grid[newX][newY]);
    }
  }
  return neighbors;
}

String getNextState(int x, int y, List<List<String>> grid) {
  List<String> neighbors = getNeighbors(x, y, grid);
  int onCount = neighbors.where((neighbor) => neighbor == '#').length;

  // Apply rules for next state.
  if (grid[x][y] == '#' && (onCount < 2 || onCount > 3)) {
    return '.'; // Light turns off
  } else if (grid[x][y] == '.' && onCount == 3) {
    return '#'; // Light turns on
  }
  return grid[x][y]; // State remains the same
}

List<List<String>> performStep(List<List<String>> grid) {
  List<List<String>> newGrid = List.generate(grid.length,
      (i) => List.generate(grid[i].length, (j) => '.', growable: false),
      growable: false);

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      newGrid[x][y] = getNextState(x, y, grid);
    }
  }

  return newGrid;
}

// Parse the new grid, count the number of lights that are on.
int countLightsOn(List<List<String>> grid) {
  var lightsOn = 0;
  for (var row in grid) {
    lightsOn += row.where((light) => light == '#').length;
  }
  return lightsOn;
}

class Day18P1Solver extends AoCSolver {
  final String? filePath;

  Day18P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      var grid = parseD18Input(inputData);

      for (int i = 0; i < 100; i++) {
        grid = performStep(grid);
      }

      var lightsOn = countLightsOn(grid);

      return Right('Day18P1Solver: $lightsOn');
    } catch (e) {
      var errorMsg = 'Day18P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day18P2Solver extends AoCSolver {
  final String? filePath;

  Day18P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      return Right('Day18P2Solver: placeholder');
    } catch (e) {
      var errorMsg = 'Day18P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
