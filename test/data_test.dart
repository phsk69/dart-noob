import 'package:test/test.dart';
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
  // TODO: Implement the rest of the tests
}
