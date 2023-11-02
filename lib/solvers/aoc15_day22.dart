import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/22

parseD22Input(String d22Input) {
  var lines = d22Input.split('\n');
  var bossStats = lines.map((e) => int.parse(e.split(': ')[1])).toList();

  return bossStats;
}

class Entity {
  int hitPoints;
  int armor;
  int mana;

  Entity({required this.hitPoints, this.armor = 0, this.mana = 0});
}

class Spell {
  final String name;
  final int cost;
  final int damage;
  final int healing;
  final int armorEffect;
  final int manaEffect;
  final int duration;

  Spell(
      {required this.name,
      required this.cost,
      this.damage = 0,
      this.healing = 0,
      this.armorEffect = 0,
      this.manaEffect = 0,
      this.duration = 0});
}

List<Spell> allSpells = [
  Spell(name: 'Magic Missile', cost: 53, damage: 4),
  Spell(name: 'Drain', cost: 73, damage: 2, healing: 2),
  Spell(name: 'Shield', cost: 113, armorEffect: 7, duration: 6),
  Spell(name: 'Poison', cost: 173, damage: 3, duration: 6),
  Spell(name: 'Recharge', cost: 229, manaEffect: 101, duration: 5)
];

int simulateBattle(
    Entity player, List<int> bossStats, List<Spell> spellSequence) {
  Entity boss = Entity(hitPoints: bossStats[0], armor: bossStats[1]);
  int totalManaSpent = 0;

  // This is a simple simulation for now, you might need to expand upon this
  for (var spell in spellSequence) {
    totalManaSpent += spell.cost;
    player.mana -= spell.cost;

    // Player casts spell
    player.hitPoints += spell.healing;
    boss.hitPoints -= spell.damage;
    player.mana += spell.manaEffect;

    // TODO: Implement duration effects like Shield, Poison, Recharge

    if (player.hitPoints <= 0) return -1; // Player lost
    if (boss.hitPoints <= 0) return totalManaSpent; // Player won

    // Boss attacks
    int damage = bossStats[2] - player.armor;
    if (damage < 1) damage = 1;
    player.hitPoints -= damage;

    if (player.hitPoints <= 0) return -1; // Player lost
    if (boss.hitPoints <= 0) return totalManaSpent; // Player won
  }

  return -1; // Default: Player lost
}

class Day22P1Solver extends AoCSolver {
  final String? filePath;

  Day22P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      final bossStats = parseD22Input(inputData);

      return Right('Day22P1Solver: $bossStats');
    } catch (e) {
      var errorMsg = 'Day22P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day22P2Solver extends AoCSolver {
  final String? filePath;

  Day22P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      final bossStats = parseD22Input(inputData);

      return Right('Day22P2Solver: $bossStats');
    } catch (e) {
      var errorMsg = 'Day22P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
