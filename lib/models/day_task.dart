// TODO: Make this lib type safe, might need additional extensions

/// Base model for tasks from aoc
/// Takes a name, and inputKey at this level
abstract class DayTask {
  final String name;
  final String inputKey;

  DayTask(this.name, this.inputKey);
}

/// Extension to handle functions with a single string parameter
class StringDayTask extends DayTask {
  final Future Function(String input) taskFunction;

  StringDayTask(String name, String inputKey, this.taskFunction)
      : super(name, inputKey);
}

/// Extension to handle functions with string and int parameters
class StringAndIntDayTask extends DayTask {
  final Future Function(String input, int count) taskFunction;

  StringAndIntDayTask(String name, String inputKey, this.taskFunction)
      : super(name, inputKey);
}
