class StringDayTask {
  final String name;
  final String inputKey;
  final Future Function(String input) taskFunction;

  StringDayTask(this.name, this.inputKey, this.taskFunction);
}

class StringAndIntDayTask {
  final String name;
  final String inputKey;
  final Future Function(String input, int count) taskFunction;

  StringAndIntDayTask(this.name, this.inputKey, this.taskFunction);
}