import 'package:dart_noob/models/day_task.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p1.dart';
import 'package:dart_noob/days/d2/aoc15_d2_p2.dart';
import 'package:dart_noob/days/d3/aoc15_d3.dart';
import 'package:dart_noob/days/d4/aoc15_d4.dart';
import 'package:dart_noob/days/d5/aoc15_d5.dart';

final List<DayTask> defaultDayTaskList = [
  StringDayTask('solveAoc15D1P1', '15day1', solveAoc15D1P1),
  StringDayTask('solveAoc15D1P2', '15day1', solveAoc15D1P2),
  StringDayTask('solveAoc15D2P1CoPilot', '15day2', solveAoc15D2P1CoPilot),
  StringDayTask(
      'solveAoc15D2P1ListOfLists', '15day2', solveAoc15D2P1ListOfLists),
  StringDayTask('solveAoc15D2P1FunctionalListOfLists', '15day2',
      solveAoc15D2P1FunctionalListOfLists),
  StringDayTask('solveAoc15D2P1FunctionalFromStrings', '15day2',
      solveAoc15D2P1FunctionalFromStrings),
  StringDayTask(
      'solveAoc15D2P2ListOfLists', '15day2', solveAoc15D2P2ListOfLists),
  StringAndIntDayTask(
      'solveAoc15D2P1Parallel', '15day2', solveAoc15D2P1Parallel),
  StringDayTask('solveAoc15D3P1', '15day3', solveAoc15D3P1),
  StringDayTask('solveAoc15D3P2', '15day3', solveAoc15D3P2),
  StringDayTask('solveAoc15D4P1', '15day4', solveAoc15D4P1),
  StringDayTask('solveAoc15D4P2', '15day4', solveAoc15D4P2),
  StringDayTask('solveAoc15D5P1', '15day5', solveAoc15D5P1),
  StringDayTask('solveAoc15D5P2', '15day5', solveAoc15D5P2),
];
