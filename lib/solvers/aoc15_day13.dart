import 'package:dartz/dartz.dart';
import 'package:trotter/trotter.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/13

class Day13P1Solver extends AoCSolver {
  final String? filePath;

  Day13P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      List<List<Object>> guests = [];

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        List<String> words = line.split(' ');
        if (words.length == 11) {
          var guestName = words[0];
          var happinessChange =
              words[2] == "lose" ? -int.parse(words[3]) : int.parse(words[3]);
          var neighborName = words[10].substring(0, words[10].length - 1);

          guests.add([guestName, happinessChange, neighborName]);
        }
      }

      var allNames = guests.map((g) => g[0] as String).toSet().toList();
      var maxHappiness = getMaxHappiness(allNames, guests, []);

      return Right('Day13P2Solver: $maxHappiness');
    } catch (e) {
      return Left(e.toString());
    }
  }

  int getMaxHappiness(List<String> names, List<List<Object>> relationships,
      List<String> currentArrangement) {
    if (names.isEmpty) {
      return calculateHappinessForArrangement(
          currentArrangement, relationships);
    }

    int maxHappiness = 0;

    for (var name in names) {
      var newNames = List.of(names)..remove(name);
      var newArrangement = List.of(currentArrangement)..add(name);
      var currentHappiness =
          getMaxHappiness(newNames, relationships, newArrangement);
      if (currentHappiness > maxHappiness) {
        maxHappiness = currentHappiness;
      }
    }

    return maxHappiness;
  }

  int calculateHappinessForArrangement(
      List<String> arrangement, List<List<Object>> relationships) {
    int happiness = 0;
    for (var i = 0; i < arrangement.length; i++) {
      var currentGuest = arrangement[i];
      var leftNeighbor =
          arrangement[(i - 1 + arrangement.length) % arrangement.length];
      var rightNeighbor = arrangement[(i + 1) % arrangement.length];

      happiness += relationships.firstWhere(
          (r) => r[0] == currentGuest && r[2] == leftNeighbor)[1] as int;
      happiness += relationships.firstWhere(
          (r) => r[0] == currentGuest && r[2] == rightNeighbor)[1] as int;
    }
    return happiness;
  }
}

class Day13P2Solver extends AoCSolver {
  final String? filePath;

  Day13P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      return Right('Day13P2Solver: placeholder');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
