import 'package:dart_noob/models/day_task.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';

const Map<String, String> inputMap = {
  '15day1': 'data/aoc2015_day1_input',
  '15day2': 'data/aoc2015_day2_input',
  '15day3': 'data/aoc2015_day3_input',
  '15day4': 'data/aoc2015_day4_input',
  '15day5': 'data/aoc2015_day5_input',
};

final List<SolverTask> defaultTaskList = [
  SolverTask(inputMap['15day1'] ?? '', solveAoc15D1P1, 'solveAoc15D1P1'),
  SolverTask(inputMap['15day1'] ?? '', solveAoc15D1P2, 'solveAoc15D1P2'),
];
