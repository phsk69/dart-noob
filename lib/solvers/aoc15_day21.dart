import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/21

Map<String, int> parseD21Input(String d21Input) {
  var lines = d21Input.split('\n');
  var bossStats = lines.map((e) => int.parse(e.split(': ')[1])).toList();

  return {
    'bossHitPoints': bossStats[0],
    'bossDamage': bossStats[1],
    'bossArmor': bossStats[2],
  };
}

class Character {
  final int hitPoints;
  final int damage;
  final int armor;

  Character(this.hitPoints, this.damage, this.armor);

  Character copyWith({int? hitPoints, int? damage, int? armor}) {
    return Character(
      hitPoints ?? this.hitPoints,
      damage ?? this.damage,
      armor ?? this.armor,
    );
  }
}

class Item {
  final String name;
  final int cost;
  final int damage;
  final int armor;

  Item(this.name, this.cost, this.damage, this.armor);
}

List<Item> weapons = [
  Item('Dagger', 8, 4, 0),
  Item('Shortsword', 10, 5, 0),
  Item('Warhammer', 25, 6, 0),
  Item('Longsword', 40, 7, 0),
  Item('Greataxe', 74, 8, 0),
  Item('NoWeapon', 0, 0, 0),
];

List<Item> armors = [
  Item('Leather', 13, 0, 1),
  Item('Chainmail', 31, 0, 2),
  Item('Splintmail', 53, 0, 3),
  Item('Bandedmail', 75, 0, 4),
  Item('Platemail', 102, 0, 5),
  Item('NoArmor', 0, 0, 0),
];

List<Item> rings = [
  Item('Damage +1', 25, 1, 0),
  Item('Damage +2', 50, 2, 0),
  Item('Damage +3', 100, 3, 0),
  Item('Defense +1', 20, 0, 1),
  Item('Defense +2', 40, 0, 2),
  Item('Defense +3', 80, 0, 3),
  Item('NoRing', 0, 0, 0),
];

class Day21P1Solver extends AoCSolver {
  final String? filePath;

  Day21P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      // Assume inputData to be "BossHitPoints BossDamage BossArmor".
      var bossStats = parseD21Input(inputData);

      var boss = Character(bossStats['bossHitPoints']!,
          bossStats['bossDamage']!, bossStats['bossArmor']!);

      var player = Character(100, 0, 0);

      var minGoldToWin = findMinGoldToWin(player, boss, weapons, armors, rings);

      return Right('Day21P1Solver: $minGoldToWin');
    } catch (e) {
      var errorMsg = 'Day21P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }

  int findMinGoldToWin(Character player, Character boss, List<Item> weapons,
      List<Item> armors, List<Item> rings) {
    int minGold = 999999; // Arbitrarily large starting value.

    for (var weapon in weapons) {
      for (var armor in armors) {
        // Loop through even if no armor is used.
        for (var ring1 in rings) {
          for (var ring2 in rings) {
            if (ring1 != ring2 || (ring1.cost == 0 && ring2.cost == 0)) {
              // Ensure rings are different or both not used.
              var totalCost =
                  weapon.cost + armor.cost + ring1.cost + ring2.cost;
              var playerWithItems = player.copyWith(
                damage:
                    player.damage + weapon.damage + ring1.damage + ring2.damage,
                armor: player.armor + armor.armor + ring1.armor + ring2.armor,
              );

              if (doesPlayerWin(playerWithItems, boss) && totalCost < minGold) {
                print(
                    "Winning combination: ${weapon.name}, ${armor.name}, ${ring1.name}, ${ring2.name} => cost: $totalCost");

                minGold = totalCost;
              }
            }
          }
        }
      }
    }

    return minGold;
  }

  bool doesPlayerWin(Character player, Character boss) {
    // Calculate how many turns it takes to defeat each character.
    var turnsToDefeatPlayer = (player.hitPoints +
            (boss.damage - player.armor).clamp(1, boss.damage)) ~/
        boss.damage;
    var turnsToDefeatBoss = (boss.hitPoints +
            (player.damage - boss.armor).clamp(1, player.damage)) ~/
        player.damage;

    // Player wins if they can defeat the boss in fewer or equal turns.
    return turnsToDefeatBoss <= turnsToDefeatPlayer;
  }
}

class Day21P2Solver extends AoCSolver {
  final String? filePath;

  Day21P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      return Right('Day21P2Solver: placeholder');
    } catch (e) {
      var errorMsg = 'Day21P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
