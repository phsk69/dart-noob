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
}
