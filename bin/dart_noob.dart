import 'package:dart_noob/aoc15_d1.dart';
import 'package:dart_noob/aoc15_d2.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Please provide a file path.');
    return;
  }
  if (arguments[1] == '1') {
    var d1P1 = await solveAocD1P1(arguments);
    if (d1P1 is int) {
      print('Day 1 part 1: $d1P1');
    }
    var d1P2 = await solveAocD1P2(arguments);
    if (d1P2 is int) {
      print('Day 1 part 2: $d1P2');
    }
  }
  if (arguments[1] == '2') {
    var d2P1 = await solveAocD2P1CoPilot(arguments);
    if (d2P1 is int) {
      print('Day 2 part 1 - copilot: $d2P1');
    }
  }
  if (arguments[1] == 'test') {
    await solveAocD2P1HomeBrew(arguments);
    //if (d2P1 is int) {
    //  print('Day 2 part 1 homebrew: $d2P1');
    //}
  }
}
