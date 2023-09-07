import 'package:dart_noob/util/string_stuff.dart';

// https://adventofcode.com/2015/day/5

Future<int> solveAoc15D5P1(String inputPath) async {
  return await NaughtyFilter(inputPath).filterStreamedP1();
}

Future<int> solveAoc15D5P2(String inputPath) async {
  return await NaughtyFilter(inputPath).filterStreamedP2();
}

class NaughtyFilter {
  final String inputPath;

  NaughtyFilter(this.inputPath);

  bool _hasThreeVowels(String line) {
    return line.split('').where((char) => 'aeiou'.contains(char)).length >= 3;
  }

  bool _hasTwoLettersRepeatedWithoutOverlap(String line) {
    for (int pairStartIdx = 0; pairStartIdx < line.length - 1; pairStartIdx++) {
      String currentPair = line.substring(pairStartIdx, pairStartIdx + 2);

      for (int comparisonIdx = pairStartIdx + 2;
          comparisonIdx < line.length - 1;
          comparisonIdx++) {
        String comparisonPair =
            line.substring(comparisonIdx, comparisonIdx + 2);

        if (currentPair == comparisonPair) {
          return true;
        }
      }
    }
    return false;
  }

  bool _hasOneLetterGapRepeat(String line) {
    for (int charIdx = 0; charIdx < line.length - 2; charIdx++) {
      if (line[charIdx] == line[charIdx + 2]) {
        return true;
      }
    }
    return false;
  }

  bool _meetsBothConditions(String line) {
    return _hasTwoLettersRepeatedWithoutOverlap(line) &&
        _hasOneLetterGapRepeat(line);
  }

  Future<int> filterStreamedP1() async {
    RegExp secondFilter = RegExp(r'(.)\1');
    RegExp thirdFilter = RegExp(r'ab|cd|pq|xy');
    int goodLines = 0;

    await for (var line in streamLinesFromFile(inputPath)) {
      if (_hasThreeVowels(line) &&
          secondFilter.hasMatch(line) &&
          !thirdFilter.hasMatch(line)) {
        goodLines += 1;
      }
    }
    return goodLines;
  }

  Future<int> filterStreamedP2() async {
    int goodLines = 0;

    await for (var line in streamLinesFromFile(inputPath)) {
      if (_meetsBothConditions(line)) {
        goodLines++;
      }
    }
    return goodLines;
  }
}
