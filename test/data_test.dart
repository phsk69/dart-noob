import 'package:test/test.dart';
import 'dart:convert';
import 'package:dart_noob/data/input_bucket.dart';

/// Tests for input data for the default mode
void main() {
  group('Day01', () {
    test('Day 01 input is not empty', () {
      expect(day1Input.toString().isNotEmpty, true);
    });
    test('Day 01 input has expected length', () {
      expect(day1Input.length, 7000);
    });
    test('Day 01 input contains only ( or ) characters', () {
      // This regex checks for any character that is NOT ( or )
      var regex = RegExp(r'[^()]+');
      expect(regex.hasMatch(day1Input.toString()), false);
    });
  });
  group('Day 02', () {
    test('Day 02 input is not empty', () {
      expect(day2Input.toString().isNotEmpty, true);
    });
    test('Day 02 input has expected length', () {
      expect(day2Input.length, 8120);
    });
    test('Day 02 input contains properly formatted lines', () {
      // This regex checks if a string matches the pattern numberxnumberxnumber
      var regex = RegExp(r'^\d{1,2}x\d{1,2}x\d{1,2}$');
      for (var line in day2Input.toString().split('\n')) {
        expect(regex.hasMatch(line.trim()), true);
      }
    });
  });
  group('Day 03', () {
    test('Day 03 input is not empty', () {
      expect(day3Input.toString().isNotEmpty, true);
    });
    test('Day 03 input has expected length', () {
      expect(day3Input.length, 8192);
    });
    test('Day 03 input contains only <, >, v, or ^ characters', () {
      // This regex checks for any character that is NOT one of <, >, v, or ^
      var regex = RegExp(r'[^<>v^]+');
      expect(regex.hasMatch(day3Input.toString()), false);
    });
  });
  group('Day 04', () {
    test('Day 04 input is not empty', () {
      expect(day4Input.toString().isNotEmpty, true);
    });
    test('Day 04 input has expected length', () {
      expect(day4Input.length, 8);
    });
    // The verification of input format is not relevant for this day
    // because the input is a 'seed' for a password generator
  });
  group('Day 05', () {
    test('Day 05 input is not empty', () {
      expect(day5Input.toString().isNotEmpty, true);
    });
    test('Day 05 input has expected length', () {
      expect(day5Input.length, 16999);
    });
    test('Day 05 input contains only alphabetical characters', () {
      var regex = RegExp(r'[^a-zA-Z]+');

      var lines = day5Input.toString().split('\n');
      for (var line in lines) {
        expect(regex.hasMatch(line), false);
      }
    });
  });
  group('Day 06', () {
    test('Day 06 input is not empty', () {
      expect(day6Input.toString().isNotEmpty, true);
    });
    test('Day 06 input has expected length', () {
      expect(day6Input.length, 9546);
    });
    test('Day 06 input adheres to the specified formats', () {
      var regex =
          RegExp(r'^(turn off|turn on|toggle) \d+,\d+ through \d+,\d+$');

      var lines = day6Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          // to skip any potential empty lines
          expect(regex.hasMatch(line), true);
        }
      }
    });
  });
  group('Day 07', () {
    test('Day 07 input is not empty', () {
      expect(day7Input.toString().isNotEmpty, true);
    });
    test('Day 07 input has expected length', () {
      expect(day7Input.length, 5303);
    });
    test('Day 07 input adheres to the specified formats', () {
      var regex = RegExp(r'^(NOT \w+ -> \w+|'
          r'\w+ (AND|OR|LSHIFT|RSHIFT) \w+ -> \w+|'
          r'\d+ -> \w+|'
          r'\w+ -> \w+)$');

      var lines = day7Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 07', () {
    test('Day 07 input is not empty', () {
      expect(day7Input.toString().isNotEmpty, true);
    });
    test('Day 07 input has expected length', () {
      expect(day7Input.length, 5303);
    });
    test('Day 07 input adheres to the specified formats', () {
      var regex = RegExp(r'^(NOT \w+ -> \w+|'
          r'\w+ (AND|OR|LSHIFT|RSHIFT) \w+ -> \w+|'
          r'\d+ -> \w+|'
          r'\w+ -> \w+)$');

      var lines = day7Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 08', () {
    test('Day 08 input is not empty', () {
      expect(day8Input.toString().isNotEmpty, true);
    });
    test('Day 08 input has expected length', () {
      expect(day8Input.length, 5759);
    });
    // The format was impossible to verify with a regex due to how escaping works in Dart test
  });
  group('Day 09', () {
    test('Day 09 input is not empty', () {
      expect(day9Input.toString().isNotEmpty, true);
    });
    test('Day 09 input has expected length', () {
      expect(day9Input.length, 717);
    });
    test('Day 09 input adheres to the specified formats', () {
      var regex = RegExp(r'^\w+ to \w+ = \d+$');

      var lines = day9Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 10', () {
    test('Day 10 input is not empty', () {
      expect(day10Input.toString().isNotEmpty, true);
    });
    test('Day 10 input has expected length', () {
      expect(day10Input.length, 10);
    });
    test('Day 10 input adheres to the specified formats', () {
      var regex = RegExp(r'^\d{10}$');

      var lines = day10Input.toString().split('\n');
      expect(lines.length, 1, reason: 'Input should have only one line');
      var line = lines[0].trim();
      expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
    });
  });
  group('Day 11', () {
    test('Day 11 input is not empty', () {
      expect(day11Input.toString().isNotEmpty, true);
    });
    test('Day 11 input has expected length', () {
      expect(day11Input.length, 8);
    });
    test('Day 11 input adheres to the specified formats', () {
      var regex = RegExp(r'^[a-zA-Z]+$');

      var lines = day11Input.toString().split('\n');
      expect(lines.length, 1, reason: 'Input should have only one line');
      var line = lines[0].trim();
      expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
    });
  });
  group('Day 12', () {
    test('Day 12 input is not empty', () {
      expect(day12Input.toString().isNotEmpty, true);
    });
    test('Day 12 input has expected length', () {
      expect(day12Input.length, 27277);
    });
    test('Day 12 input adheres to the specified formats', () {
      var lines = day12Input.toString().split('\n');

      // Check that the string is only one line long
      expect(lines.length, 1, reason: 'Input should have only one line');

      try {
        // Try to parse the string as JSON
        json.decode(day12Input.toString());
      } catch (e) {
        fail('Invalid JSON format: $e');
      }
    });
  });
  group('Day 13', () {
    test('Day 13 input is not empty', () {
      expect(day13Input.toString().isNotEmpty, true);
    });
    test('Day 13 input has expected length', () {
      expect(day13Input.length, 3468);
    });
    test('Day 13 input adheres to the specified formats', () {
      var regex = RegExp(
          r'^\w+ would (gain|lose) \d+ happiness units by sitting next to \w+\.$');

      var lines = day13Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 14', () {
    test('Day 14 input is not empty', () {
      expect(day14Input.toString().isNotEmpty, true);
    });
    test('Day 14 input has expected length', () {
      expect(day14Input.length, 664);
    });
    test('Day 14 input adheres to the specified formats', () {
      var regex = RegExp(
          r'^\w+ can fly \d+ km/s for \d+ seconds, but then must rest for \d+ seconds\.$');

      var lines = day14Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 15', () {
    test('Day 15 input is not empty', () {
      expect(day15Input.toString().isNotEmpty, true);
    });
    test('Day 15 input has expected length', () {
      expect(day15Input.length, 278);
    });
    test('Day 15 input adheres to the specified formats', () {
      var regex = RegExp(
          r'^\w+: capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)$');

      var lines = day15Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 16', () {
    test('Day 16 input is not empty', () {
      expect(day16Input.toString().isNotEmpty, true);
    });
    test('Day 16 input has expected length', () {
      expect(day16Input.length, 21627);
    });
    test('Day 16 input adheres to the specified formats', () {
      var regex = RegExp(
          r'^Sue \d+: ((children|cats|samoyeds|pomeranians|akitas|vizslas|goldfish|trees|cars|perfumes): \d+(, )?)+$');

      var lines = day16Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 17', () {
    test('Day 17 input is not empty', () {
      expect(day17Input.toString().isNotEmpty, true);
    });
    test('Day 17 input has expected length', () {
      expect(day17Input.length, 54);
    });
    test('Day 17 input adheres to the specified formats', () {
      var regex = RegExp(r'^\d+$'); // Matches one or more digits

      var lines = day17Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 18', () {
    test('Day 18 input is not empty', () {
      expect(day18Input.toString().isNotEmpty, true);
    });
    test('Day 18 input has expected length', () {
      expect(day18Input.length, 10099);
    });
    test('Day 18 input adheres to the specified formats', () {
      var regex = RegExp(r'^[#.]+$'); // Matches sequences of '#' and '.'

      var lines = day18Input.toString().split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
        }
      }
    });
  });
  group('Day 19', () {
    test('Day 19 input is not empty', () {
      expect(day19Input.toString().isNotEmpty, true);
    });
    test('Day 19 input has expected length', () {
      expect(day19Input.length, 967);
    });
    test('Day 19 input adheres to the specified formats', () {
      var replacementRegex = RegExp(r'^[eA-Z][a-z]* => ([A-Z][a-z]*)+$');
      var moleculeRegex = RegExp(r'^([A-Z][a-z]*)+$');

      var lines = day19Input.toString().split('\n');
      for (var i = 0; i < lines.length; i++) {
        var line = lines[i].trim();
        if (line.isNotEmpty) {
          if (i < lines.length - 1) {
            expect(replacementRegex.hasMatch(line), true,
                reason: 'Failed on replacement line: $line');
          } else {
            expect(moleculeRegex.hasMatch(line), true,
                reason: 'Failed on molecule line: $line');
          }
        }
      }
    });
  });
  group('Day 20', () {
    test('Day 20 input is not empty', () {
      expect(day20Input.toString().isNotEmpty, true);
    });
    test('Day 20 input has expected length', () {
      expect(day20Input.length, 8);
    });
    test('Day 20 input adheres to the specified formats', () {
      var regex = RegExp(r'^\d+$');

      var lines = day20Input.toString().split('\n');
      expect(lines.length, 1, reason: 'Input should have only one line');
      var line = lines[0].trim();
      expect(regex.hasMatch(line), true, reason: 'Failed on line: $line');
    });
  });
  group('Day 21', () {
    test('Day 21 input is not empty', () {
      expect(day21Input.toString().isNotEmpty, true);
    });
    test('Day 21 input has expected length', () {
      expect(day21Input.length, 34);
    });
    test('Day 21 input adheres to the specified formats', () {
      var hitPointsRegex = RegExp(r'^Hit Points: \d+$');
      var damageRegex = RegExp(r'^Damage: \d+$');
      var armorRegex = RegExp(r'^Armor: \d+$');

      var lines = day21Input.toString().split('\n');
      expect(lines.length, 3, reason: 'Input should have exactly three lines');

      var hitPointsLine = lines[0].trim();
      var damageLine = lines[1].trim();
      var armorLine = lines[2].trim();

      expect(hitPointsRegex.hasMatch(hitPointsLine), true,
          reason: 'Failed on hit points line: $hitPointsLine');
      expect(damageRegex.hasMatch(damageLine), true,
          reason: 'Failed on damage line: $damageLine');
      expect(armorRegex.hasMatch(armorLine), true,
          reason: 'Failed on armor line: $armorLine');
    });
  });
  group('Day 22', () {
    test('Day 22 input is not empty', () {
      expect(day22Input.toString().isNotEmpty, true);
    });
    test('Day 22 input has expected length', () {
      expect(day22Input.length, 25);
    });
    test('Day 22 input adheres to the specified formats', () {
      var hitPointsRegex = RegExp(r'^Hit Points: \d+$');
      var damageRegex = RegExp(r'^Damage: \d+$');

      var lines = day22Input.toString().split('\n');
      expect(lines.length, 2, reason: 'Input should have exactly three lines');

      var hitPointsLine = lines[0].trim();
      var damageLine = lines[1].trim();

      expect(hitPointsRegex.hasMatch(hitPointsLine), true,
          reason: 'Failed on hit points line: $hitPointsLine');
      expect(damageRegex.hasMatch(damageLine), true,
          reason: 'Failed on damage line: $damageLine');
    });
  });
  group('Day 23', () {
    test('Day 23 input is not empty', () {
      expect(day23Input.toString().isNotEmpty, true);
    });
    test('Day 23 input has expected length', () {
      expect(day23Input.length, 292);
    });
    test('Day 23 input adheres to the specified formats', () {
      var regex = RegExp(
          r'^(jio|jie) [ab], [+-]\d+|^(jmp) [+-]\d+|^(inc|tpl|hlf) [ab]$');

      var lines = day23Input.toString().split('\n');
      for (var line in lines) {
        var trimmedLine = line.trim();
        if (trimmedLine.isNotEmpty) {
          expect(regex.hasMatch(trimmedLine), true,
              reason: 'Failed on line: $trimmedLine');
        }
      }
    });
  });
  group('Day 24', () {
    test('Day 24 input is not empty', () {
      expect(day24Input.toString().isNotEmpty, true);
    });
    test('Day 24 input has expected length', () {
      expect(day24Input.length, 86);
    });
    test('Day 24 input adheres to the specified formats', () {
      var regex = RegExp(
          r'^-?\d+$'); // Matches optional negative sign followed by one or more digits

      var lines = day24Input.toString().split('\n');
      for (var line in lines) {
        var trimmedLine = line.trim();
        if (trimmedLine.isNotEmpty) {
          expect(regex.hasMatch(trimmedLine), true,
              reason: 'Failed on line: $trimmedLine');
        }
      }
    });
  });
  group('Day 25', () {
    test('Day 25 input is not empty', () {
      expect(day25Input.toString().isNotEmpty, true);
    });
    test('Day 25 input has expected length', () {
      expect(day25Input.length, 98);
    });
    test('Day 25 input adheres to the specified formats', () {
      var regex = RegExp(
          r'^To continue, please consult the code grid in the manual\.  Enter the code at row (\d+), column (\d+)\.$');

      var lines = day25Input.toString().split('\n');

      // Ensure only one line
      expect(lines.length, 1, reason: 'Input should have only one line');

      var trimmedLine = lines[0].trim();

      // Ensure the format matches
      expect(regex.hasMatch(trimmedLine), true,
          reason: 'Failed on line: $trimmedLine');

      // Extract the numbers
      var match = regex.firstMatch(trimmedLine);
      if (match != null) {
        var row = match.group(1);
        var column = match.group(2);
        // Verify we got exactly two numbers
        expect(row != null && column != null, true,
            reason: 'Did not capture two numbers from the line: $trimmedLine');
      }
    });
  });
  // TODO: Implement the rest of the tests
}
