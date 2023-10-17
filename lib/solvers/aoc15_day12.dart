import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/12

/// Sum values in the json tree
int sumValues(Object? jsonItem) {
  if (jsonItem is int) {
    return jsonItem;
  } else if (jsonItem is Map<String, Object?>) {
    return jsonItem.values
        .map<int>((value) => sumValues(value))
        .fold(0, (a, b) => a + b);
  } else if (jsonItem is List<Object?>) {
    return jsonItem
        .map<int>((value) => sumValues(value))
        .fold(0, (a, b) => a + b);
  } else {
    return 0; // Ignore other types
  }
}

/// Sum values without any object that has a value 'red'
int sumValuesWithoutRed(Object? jsonItem) {
  if (jsonItem is int) {
    return jsonItem;
  } else if (jsonItem is Map<String, Object?>) {
    if (jsonItem.containsValue('red')) {
      return 0; // Ignore this entire object if it has a value 'red'
    }
    return jsonItem.values
        .map<int>((value) => sumValuesWithoutRed(value))
        .fold(0, (a, b) => a + b);
  } else if (jsonItem is List<Object?>) {
    return jsonItem
        .map<int>((value) => sumValuesWithoutRed(value))
        .fold(0, (a, b) => a + b);
  } else {
    return 0; // Ignore other types
  }
}

/// This could be done with a simple regex instead of parsing the json tree.
class Day12P1Solver extends AoCSolver {
  final String? filePath;

  Day12P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      var json = jsonDecode(inputData) as Map<String, Object?>;
      var sum = sumValues(json);

      return Right('Day12P1Solver: $sum');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

/// This could be done with a simple regex instead of parsing the json tree.
class Day12P2Solver extends AoCSolver {
  final String? filePath;

  Day12P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      var json = jsonDecode(inputData) as Map<String, Object?>;

      var sum = sumValuesWithoutRed(json);
      return Right('Day12P2Solver: $sum');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
