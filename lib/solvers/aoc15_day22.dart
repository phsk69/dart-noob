import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/22

List<int> parseD22Input(String d22Input) {
  var lines = d22Input.split('\n');
  var bossStats = lines.map((e) => int.parse(e.split(': ')[1])).toList();

  return bossStats;
}

class Spell {
  final String name;
  final int cost, damage, heal, armor, mana, duration;

  Spell(this.name, this.cost, this.damage, this.heal, this.armor, this.mana,
      this.duration);
}

class Game {
  int playerHp, playerMana, bossHp, bossDamage;
  int shieldTimer = 0, poisonTimer = 0, rechargeTimer = 0;
  int manaSpent = 0;

  Game(this.playerHp, this.playerMana, this.bossHp, this.bossDamage);

  Game.clone(Game other)
      : playerHp = other.playerHp,
        playerMana = other.playerMana,
        bossHp = other.bossHp,
        bossDamage = other.bossDamage,
        shieldTimer = other.shieldTimer,
        poisonTimer = other.poisonTimer,
        rechargeTimer = other.rechargeTimer,
        manaSpent = other.manaSpent;

  int armor() => shieldTimer > 0 ? 7 : 0;

  void applyEffects() {
    if (shieldTimer > 0) shieldTimer--;
    if (poisonTimer > 0) {
      bossHp -= 3;
      poisonTimer--;
    }
    if (rechargeTimer > 0) {
      playerMana += 101;
      rechargeTimer--;
    }
  }

  bool canCastSpell(Spell spell) {
    if (playerMana < spell.cost) return false;
    switch (spell.name) {
      case 'Shield':
        return shieldTimer == 0;
      case 'Poison':
        return poisonTimer == 0;
      case 'Recharge':
        return rechargeTimer == 0;
      default:
        return true;
    }
  }
}

final spells = [
  Spell('Magic Missile', 53, 4, 0, 0, 0, 0),
  Spell('Drain', 73, 2, 2, 0, 0, 0),
  Spell('Shield', 113, 0, 0, 7, 0, 6),
  Spell('Poison', 173, 0, 0, 0, 0, 6),
  Spell('Recharge', 229, 0, 0, 0, 101, 5),
];

enum GameMode { normal, hard }

// TODO: Logging inconsistent, logs p1 answer in p2, and nobody wins in the log.
class GameSimulator {
  final Logger? logger;
  int minManaSpentToWin = 1 << 30;

  GameSimulator(this.logger);

  void playTurn(Game game, bool playerTurn, Logger? logger,
      [GameMode mode = GameMode.normal]) {
    Game clonedGame = Game.clone(game);

    // If we've already spent too much mana in this game, just return.
    if (clonedGame.manaSpent > minManaSpentToWin) {
      logger
          ?.info('Aborting this branch due to already high mana expenditure.');
      return;
    }

    // 1. Apply effects at the start of each turn.
    clonedGame.applyEffects();

    // 2. Check for hard mode: Deduct 1 HP from player at the start of their turn
    if (playerTurn && mode == GameMode.hard) {
      clonedGame.playerHp -= 1;
      if (clonedGame.playerHp <= 0) {
        logger?.info('Player defeated due to hard mode.');
        return;
      }
      logger?.info(
          'Player loses 1 HP from hard mode. Player HP: ${clonedGame.playerHp}');
    }

    logger?.info(
        'After effects: Player HP: ${clonedGame.playerHp}, Player Mana: ${clonedGame.playerMana}, Boss HP: ${clonedGame.bossHp}');

    // 3. Check if the boss has been defeated by effects before any other action.
    if (clonedGame.bossHp <= 0) {
      if (clonedGame.manaSpent < minManaSpentToWin) {
        minManaSpentToWin = clonedGame.manaSpent;
        logger?.info(
            'Boss defeated by effects. Total mana spent: $minManaSpentToWin');
      }
      return;
    }

    if (playerTurn) {
      logger?.info('--- Player\'s Turn ---');
      bool canCastAnySpell = false;

      for (final spell in spells) {
        if (!clonedGame.canCastSpell(spell)) {
          logger?.info(
              'Cannot cast ${spell.name} due to insufficient mana or an existing effect.');
          continue;
        }

        canCastAnySpell = true;
        logger?.info('Casting ${spell.name}.');

        Game next = Game.clone(clonedGame);
        next.manaSpent += spell.cost;
        next.playerMana -= spell.cost;

        switch (spell.name) {
          case 'Magic Missile':
            next.bossHp -= spell.damage;
            break;
          case 'Drain':
            next.bossHp -= spell.damage;
            next.playerHp += spell.heal;
            break;
          case 'Shield':
            next.shieldTimer = spell.duration;
            break;
          case 'Poison':
            next.poisonTimer = spell.duration;
            break;
          case 'Recharge':
            next.rechargeTimer = spell.duration;
            break;
        }

        logger?.info(
            'After ${spell.name}: Player HP: ${next.playerHp}, Player Mana: ${next.playerMana}, Boss HP: ${next.bossHp}');

        if (next.bossHp <= 0 && next.manaSpent < minManaSpentToWin) {
          minManaSpentToWin = next.manaSpent;
          logger?.info(
              'Boss defeated by ${spell.name}. Total mana spent: $minManaSpentToWin');
          return;
        }

        playTurn(next, false, logger, mode);
      }

      if (!canCastAnySpell) {
        logger?.info(
            'Player unable to cast any spells this turn. Player is defeated.');
        return; // Player loses if no spells can be cast
      }
    } else {
      logger?.info('--- Boss\'s Turn ---');
      int damage = clonedGame.bossDamage - clonedGame.armor();
      clonedGame.playerHp -= damage > 0 ? damage : 1;

      logger?.info(
          'Boss deals $damage damage. Player HP after damage: ${clonedGame.playerHp}. Boss HP remains: ${clonedGame.bossHp}');

      if (clonedGame.playerHp <= 0) {
        logger?.info('Player defeated by boss attack.');
        return;
      }

      playTurn(clonedGame, true, logger, mode);
    }
  }
}

// Define the player stats
const playerHp = 50;
const playerMana = 500;

class Day22P1Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day22P1Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      final bossStats = parseD22Input(inputData);
      final game = Game(playerHp, playerMana, bossStats[0], bossStats[1]);
      final simulator = GameSimulator(logger);
      simulator.playTurn(game, true, logger);
      return Right('Day22P1Solver: ${simulator.minManaSpentToWin}');
    } catch (e) {
      var errorMsg = 'Day22P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day22P2Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day22P2Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      final bossStats = parseD22Input(inputData);
      final game = Game(playerHp, playerMana, bossStats[0], bossStats[1]);
      final simulator = GameSimulator(logger);
      simulator.playTurn(game, true, logger, GameMode.hard);

      return Right('Day22P2Solver: ${simulator.minManaSpentToWin}');
    } catch (e) {
      var errorMsg = 'Day22P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
