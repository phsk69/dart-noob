import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/21

List<int> parseD21Input(String d21Input) {
  var lines = d21Input.split('\n');
  var bossStats = lines.map((e) => int.parse(e.split(': ')[1])).toList();

  return bossStats;
}

const playerStats = [100, 0, 0];

class Item {
  final String name;
  final int cost;
  final int damage;
  final int armor;
  Item(this.name, this.cost, this.damage, this.armor);
}

final weapons = [
  Item('Dagger', 8, 4, 0),
  Item('Shortsword', 10, 5, 0),
  Item('Warhammer', 25, 6, 0),
  Item('Longsword', 40, 7, 0),
  Item('Greataxe', 74, 8, 0),
];

final armors = [
  Item('Leather', 13, 0, 1),
  Item('Chainmail', 31, 0, 2),
  Item('Splintmail', 53, 0, 3),
  Item('Bandedmail', 75, 0, 4),
  Item('Platemail', 102, 0, 5),
  Item('NoArmor', 0, 0, 0), // No armor option
];

final rings = [
  Item('Damage +1', 25, 1, 0),
  Item('Damage +2', 50, 2, 0),
  Item('Damage +3', 100, 3, 0),
  Item('Defense +1', 20, 0, 1),
  Item('Defense +2', 40, 0, 2),
  Item('Defense +3', 80, 0, 3),
  Item('NoRing', 0, 0, 0), // No ring option
];

bool doesPlayerWin(List<int> player, List<int> boss) {
  int playerDamage = max(1, player[1] - boss[2]);
  int bossDamage = max(1, boss[1] - player[2]);

  int playerTurnsToWin = (boss[0] + playerDamage - 1) ~/ playerDamage;
  int bossTurnsToWin = (player[0] + bossDamage - 1) ~/ bossDamage;

  return playerTurnsToWin <= bossTurnsToWin;
}

class Day21P1Solver extends AoCSolver {
  final String? filePath;

  Day21P1Solver(super.input, this.filePath);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      final bossStats = parseD21Input(inputData);

      int minCostToWin = 1 << 30; // A large integer to represent infinity.

      for (var weapon in weapons) {
        for (var armor in armors) {
          for (var ring1 in rings) {
            for (var ring2 in rings) {
              if (ring1.name == ring2.name && ring1.name != 'NoRing') {
                continue;
              }

              int totalCost =
                  weapon.cost + armor.cost + ring1.cost + ring2.cost;
              int playerDamage = weapon.damage + ring1.damage + ring2.damage;
              int playerArmor = armor.armor + ring1.armor + ring2.armor;

              if (doesPlayerWin(
                  [playerStats[0], playerDamage, playerArmor], bossStats)) {
                if (totalCost < minCostToWin) {
                  minCostToWin = totalCost;
                }
              }
            }
          }
        }
      }
      return Right('Day21P1Solver: $minCostToWin');
    } catch (e) {
      var errorMsg = 'Day21P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day21P2Solver extends AoCSolver {
  final String? filePath;

  Day21P2Solver(super.input, this.filePath);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      final bossStats = parseD21Input(inputData);

      int maxCostToLose = 0;

      for (var weapon in weapons) {
        for (var armor in armors) {
          for (var ring1 in rings) {
            for (var ring2 in rings) {
              if (ring1.name == ring2.name && ring1.name != 'NoRing') {
                continue;
              }

              int totalCost =
                  weapon.cost + armor.cost + ring1.cost + ring2.cost;
              int playerDamage = weapon.damage + ring1.damage + ring2.damage;
              int playerArmor = armor.armor + ring1.armor + ring2.armor;

              if (!doesPlayerWin(
                  [playerStats[0], playerDamage, playerArmor], bossStats)) {
                if (totalCost > maxCostToLose) {
                  maxCostToLose = totalCost;
                }
              }
            }
          }
        }
      }
      return Right('Day21P2Solver: $maxCostToLose');
    } catch (e) {
      var errorMsg = 'Day21P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
