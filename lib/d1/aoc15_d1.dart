import 'package:dart_noob/util/file_stuff.dart';

// https://adventofcode.com/2015

getInputString(String inputPath) async {
  return await FileReader(inputPath).readFile();
}

solveAocD1P1(List<String> content) {
  var i = 0;

  for (var element in content) {
    switch (element) {
      case '(':
        i++;
        break;
      case ')':
        i--;
        break;
    }
  }
  return i;
}

solveAocD1P2(List<String> content) {
  var floor = 0;
  const int basement = -1;
  var firstBasementPos = 0;

  for (var idx = 0; idx < content.length; idx++) {
    var element = content[idx];
    switch (element) {
      case '(':
        floor++;
        break;
      case ')':
        floor--;
        if (floor == basement) {
          firstBasementPos = idx + 1;
          return firstBasementPos;
        }
        break;
    }
  }
}
