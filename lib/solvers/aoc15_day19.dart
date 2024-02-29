import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/19

parseD19Input(String stuff) {
  var linesList = stuff.split('\n');
  var replacements = <String, List<String>>{};
  var molecule = '';

  for (var line in linesList) {
    if (line.contains('=>')) {
      var parts = line.split(' => ');
      var key = parts[0];
      var value = parts[1];

      if (replacements.containsKey(key)) {
        replacements[key]!.add(value);
      } else {
        replacements[key] = [value];
      }
    } else if (line.isNotEmpty) {
      molecule = line;
    }
  }

  return [replacements, molecule];
}

class Day19P1Solver extends AoCSolver {
  final String? filePath;

  Day19P1Solver(super.input, this.filePath);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      var parsedInput = parseD19Input(inputData);

      var replacements = parsedInput[0] as Map<String, List<String>>;
      var molecule = parsedInput[1] as String;

      var newMolecules = <String>{};

      for (var key in replacements.keys) {
        var keyIndex = molecule.indexOf(key);
        while (keyIndex != -1) {
          for (var value in replacements[key]!) {
            var newMolecule =
                molecule.replaceRange(keyIndex, keyIndex + key.length, value);
            newMolecules.add(newMolecule);
          }
          keyIndex = molecule.indexOf(key, keyIndex + 1);
        }
      }

      return Right('Day19P1Solver: ${newMolecules.length}');
    } catch (e) {
      var errorMsg = 'Day19P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day19P2Solver extends AoCSolver {
  final String? filePath;

  Day19P2Solver(super.input, this.filePath);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      var parsedInput = parseD19Input(inputData);

      var replacements = parsedInput[0] as Map<String, List<String>>;

      var reversedReplacements = <String, String>{};

      for (var key in replacements.keys) {
        for (var value in replacements[key]!) {
          reversedReplacements[value] = key;
        }
      }

      var molecule = parsedInput[1] as String;

      var steps = 0;

      while (molecule != 'e') {
        var found = false;
        for (var key in reversedReplacements.keys) {
          if (molecule.contains(key)) {
            molecule = molecule.replaceFirst(key, reversedReplacements[key]!);
            steps++;
            found = true;
            break;
          }
        }
        if (!found) {
          return Left('Day19P2Solver: No replacement found');
        }
      }

      return Right('Day19P2Solver: $steps');
    } catch (e) {
      var errorMsg = 'Day19P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
