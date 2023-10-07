import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/15

/// Class to represent an ingredient
class Ingredient {
  final String name;
  final int capacity;
  final int durability;
  final int flavor;
  final int texture;
  final int calories;

  Ingredient({
    required this.name,
    required this.capacity,
    required this.durability,
    required this.flavor,
    required this.texture,
    required this.calories,
  });
}

class Day15P1Solver extends AoCSolver {
  final String? filePath;

  Day15P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      var ingredients = <Ingredient>[];

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        var tokens = line.split(' ');

        ingredients.add(Ingredient(
          name: tokens[0].substring(0, tokens[0].length - 1),
          capacity: int.parse(tokens[2].substring(0, tokens[2].length - 1)),
          durability: int.parse(tokens[4].substring(0, tokens[4].length - 1)),
          flavor: int.parse(tokens[6].substring(0, tokens[6].length - 1)),
          texture: int.parse(tokens[8].substring(0, tokens[8].length - 1)),
          calories: int.parse(tokens[10]),
        ));
      }
  
      var totalTeaspoons = 100;
      var mixtures = <List<int>>[];
      for (var i = 0; i <= totalTeaspoons; i++) {
        for (var j = 0; j <= totalTeaspoons - i; j++) {
          for (var k = 0; k <= totalTeaspoons - i - j; k++) {
            for (var l = 0; l <= totalTeaspoons - i - j - k; l++) {
              if (i + j + k + l == totalTeaspoons) {
                mixtures.add([i, j, k, l]);
              }
            }
          }
        }
      }

      var scores = <int>[];
      for (var mixture in mixtures) {
        var capacity = 0;
        var durability = 0;
        var flavor = 0;
        var texture = 0;

        for (var i = 0; i < mixture.length; i++) {
          capacity += mixture[i] * ingredients[i].capacity;
          durability += mixture[i] * ingredients[i].durability;
          flavor += mixture[i] * ingredients[i].flavor;
          texture += mixture[i] * ingredients[i].texture;
        }

        capacity = capacity < 0 ? 0 : capacity;
        durability = durability < 0 ? 0 : durability;
        flavor = flavor < 0 ? 0 : flavor;
        texture = texture < 0 ? 0 : texture;

        scores.add(capacity * durability * flavor * texture);
      }

      var maxScore = 0;
      for (var score in scores) {
        if (score > maxScore) {
          maxScore = score;
        }
      }

      return Right('Day15P1Solver: $maxScore');
    } catch (e) {
      var errorMsg = 'Day15P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day15P2Solver extends AoCSolver {
  final String? filePath;

  Day15P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      return Right('Day15P2Solver: placeholder');
    } catch (e) {
      var errorMsg = 'Day15P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
