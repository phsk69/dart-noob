import 'dart:io';
import 'package:dart_noob/models/day_task.dart';
import 'package:dart_noob/config/task_list.dart';
import 'package:dart_noob/config/input_map.dart';
import 'package:dart_noob/util/benchmarks.dart';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('workers', abbr: 'w', help: 'Specify amount of workers')
    ..addFlag('bench', abbr: 'b', negatable: false, help: 'Run benchmarks');

  var args = parser.parse(arguments);
  int workers = int.tryParse(args['workers'] as String? ?? '') ?? 4;

  if (args['bench'] as bool) {
    await benchRunner(inputMap, workers);
  } else {
    // Get unique keys from tasks list
    var uniqueKeys = {
      ...dayTaskList.map((t) => t.inputKey),
    };

    for (var key in uniqueKeys) {
      // Execute tasks for the current key
      for (var task in dayTaskList.where((t) => t.inputKey == key)) {
        await _executeTask(task, inputMap, workers);
      }
    }
  }

  exit(0);
}

Future<void> _executeTask(
    DayTask task, Map<String, String> inputMap, int workerCount) async {
  try {
    var stopwatch = Stopwatch()..start();
    var inputPath = inputMap[task.inputKey] ?? '';

    // Use is keyword to check the type of task and then execute accordingly
    if (task is StringDayTask) {
      var result = await task.taskFunction(inputPath);
      stopwatch.stop();
      print('${task.name}: $result (Time: ${stopwatch.elapsed})');
    } else if (task is StringAndIntDayTask) {
      var result = await task.taskFunction(inputPath, workerCount);
      stopwatch.stop();
      print('${task.name}: $result (Time: ${stopwatch.elapsed})');
    }
  } catch (e) {
    print('Error executing ${task.name}: $e');
  }
}
