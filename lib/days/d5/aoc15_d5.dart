import 'package:dart_noob/util/file_stuff.dart';

Future<int> solveAoc15D5P1(String inputPath) async {
  return await NaughtyFilter(inputPath).filterStreamed();
}

class NaughtyFilter {
  final String inputPath;

  NaughtyFilter(this.inputPath);

  bool hasThreeVowels(String line) {
    return line.split('').where((char) => 'aeiou'.contains(char)).length >= 3;
  }

  Future<int> filterStreamed() async {
    RegExp secondFilter = RegExp(r'(.)\1');
    RegExp thirdFilter = RegExp(r'ab|cd|pq|xy');
    int goodLines = 0;

    await for (var line in streamLinesFromFile(inputPath)) {
      if (hasThreeVowels(line) &&
          secondFilter.hasMatch(line) &&
          !thirdFilter.hasMatch(line)) {
        goodLines += 1;
      }
    }
    return goodLines;
  }
}
