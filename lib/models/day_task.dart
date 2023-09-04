import 'package:dartz/dartz.dart';
import 'package:dart_noob/types/functions.dart';

/// Base model for tasks from aoc
/// Takes a name
/// Optionally an inputKey (name of key in default task list)
/// Optionally a Stdin stream
abstract class DayTask<T> {
  final String name;
  final String? inputKey;
  final Stream<List<int>>? stdinStream;

  DayTask(this.name, [this.inputKey, this.stdinStream]);
}

/// Extension to handle functions with a single string parameter
class StringDayTask extends DayTask<String> {
  final StringTaskReturnString taskFunction;

  StringDayTask(String name,
      {String? inputKey,
      required this.taskFunction,
      Stream<List<int>>? stdinStream})
      : super(name, inputKey, stdinStream);
}

/// Extension to handle functions with string and int parameters
class StringAndIntDayTask extends DayTask<String> {
  final StringAndIntTaskReturnString taskFunction;

  StringAndIntDayTask(String name,
      {String? inputKey,
      required this.taskFunction,
      Stream<List<int>>? stdinStream})
      : super(name, inputKey, stdinStream);
}

//
abstract class DayTaskResult<Either> {
  final Either result;
  DayTaskResult(this.result);
}

class StringResult extends DayTaskResult<Either<String, String>> {
  StringResult(Either<String, String> result) : super(result);
}

class IntResult extends DayTaskResult<Either<String, int>> {
  IntResult(Either<String, int> result) : super(result);
}

class BigIntResult extends DayTaskResult<Either<String, BigInt>> {
  BigIntResult(Either<String, BigInt> result) : super(result);
}
