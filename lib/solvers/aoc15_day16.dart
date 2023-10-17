import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/16

/// Class to represent the aunts
class Sue {
  final int id;
  final Map<String, int> compounds;

  Sue({
    required this.id,
    required this.compounds,
  });
}

// create a compare map
const compareMap = <String, int>{
  'children': 3,
  'cats': 7,
  'samoyeds': 2,
  'pomeranians': 3,
  'akitas': 0,
  'vizslas': 0,
  'goldfish': 5,
  'trees': 3,
  'cars': 2,
  'perfumes': 1,
};

p1ExactAuntMatch(Sue sue) {
  var match = true;
  for (var compound in sue.compounds.entries) {
    if (compareMap[compound.key] != compound.value) {
      match = false;
      break;
    }
  }
  return match;
}

p2ExactAuntMatch(Sue sue) {
  var match = true;
  for (var compound in sue.compounds.entries) {
    // Adding null check here
    var compareValue = compareMap[compound.key];
    if (compareValue == null) {
      match = false;
      break;
    }

    if (compound.key == 'cats' || compound.key == 'trees') {
      if (compareValue >= compound.value) {
        match = false;
        break;
      }
    } else if (compound.key == 'pomeranians' || compound.key == 'goldfish') {
      if (compareValue <= compound.value) {
        match = false;
        break;
      }
    } else if (compareValue != compound.value) {
      match = false;
      break;
    }
  }
  return match;
}

List<Sue> parseD16Input(String inputData) {
  var aunts = <Sue>[];

  for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
    var tokens = line.split(': ');

    // Ensure the line is correctly formatted.
    if (tokens.length < 2) {
      throw 'parseInput: Invalid input format.';
    }

    var id = int.parse(tokens[0].split(' ')[1]);

    var compoundsMap = <String, int>{};
    var compoundsTokens = tokens.sublist(1).join(': ').split(', ');

    // Extracting compounds and their values
    for (var compoundToken in compoundsTokens) {
      var compoundDetails = compoundToken.split(': ');
      compoundsMap[compoundDetails[0]] = int.parse(compoundDetails[1]);
    }

    aunts.add(Sue(id: id, compounds: compoundsMap));
  }
  return aunts;
}

class Day16P1Solver extends AoCSolver {
  final String? filePath;

  Day16P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      var aunts = parseD16Input(inputData);

      var matchingAunt = 0;

      for (var aunt in aunts) {
        // only add exact matches of compounds
        var result = p1ExactAuntMatch(aunt);
        if (result == null) {
          return Left('Day16P1Solver: No matching aunts found.');
        }

        if (result) {
          matchingAunt = aunt.id;
        }
      }

      return Right('Day16P1Solver: $matchingAunt');
    } catch (e) {
      var errorMsg = 'Day16P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day16P2Solver extends AoCSolver {
  final String? filePath;

  Day16P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      var aunts = parseD16Input(inputData);

      var matchingAunt = 0;

      for (var aunt in aunts) {
        // only add exact matches of compounds
        var result = p2ExactAuntMatch(aunt);
        if (result == null) {
          return Left('Day16P1Solver: No matching aunts found.');
        }

        if (result) {
          matchingAunt = aunt.id;
        }
      }

      return Right('Day16P2Solver: $matchingAunt');
    } catch (e) {
      var errorMsg = 'Day16P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
