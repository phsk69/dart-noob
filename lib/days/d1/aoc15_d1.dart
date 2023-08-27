import 'package:dart_noob/util/file_stuff.dart';

// https://adventofcode.com/2015/day/1

Future<int> solveAoc15D1P1(String input) async {
  var content = await getInputString(input);
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

Future<int> solveAoc15D1P2(String input) async {
  var floor = 0;
  const int basement = -1;
  var firstBasementPos = 0;
  var content = await getInputString(input);
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
  throw Exception("Never reached the basement");
}
