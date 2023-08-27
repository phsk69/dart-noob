import 'package:dart_noob/util/file_stuff.dart';

// https://adventofcode.com/2015/day/5

Future<int> solveAoc15D5P1(String inputPath) async {
  return await NaughtyFilter(inputPath).filterStreamedP1();
}

Future<bool> solveAoc15D5P2(String inputPath) async {
  return await NaughtyFilter(inputPath).filterStreamedP2();
}

/// Takes an inputPath and does weird stuff to filter the input strings
/// Using stream to get the file info instead of loading it all into mem.
class NaughtyFilter {
  final String inputPath;

  NaughtyFilter(this.inputPath);

  bool _hasThreeVowels(String line) {
    return line.split('').where((char) => 'aeiou'.contains(char)).length >= 3;
  }

  // TODO: Don't continue until you understand this logic
  void _findRepeatedPairsWithoutOverlap(String line) {
    for (int i = 0; i < line.length - 1; i++) {
      String currentPair =
          line.substring(i, i + 2); // Get current pair of characters

      // Check the rest of the string for this pair without overlap
      // We start the inner loop from i+2 to ensure there's no overlap
      for (int j = i + 2; j < line.length - 1; j++) {
        String nextPair = line.substring(j, j + 2);

        if (currentPair == nextPair) {
          print('Line: $line');
          print('Current Pair: $currentPair');
          print('Found another pair at position: $j which is: $nextPair');
        }
      }
    }
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

  Future<bool> filterStreamedP2() async {
    await for (var line in streamLinesFromFile(inputPath)) {
      _findRepeatedPairsWithoutOverlap(line);
    }
    return true;
  }
}
