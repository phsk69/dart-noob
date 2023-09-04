import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:dart_noob/config/default_tasks.dart';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/models/day_task.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';

enum InputState {
  fileInput,
  stdinInput,
  noInput,
  invalid,
}

final log = Logger('CLI');

void main(List<String> args) async {
  // Initialize logging at the very beginning
  final log = Logger('CLI');

  Logger.root.level =
      Level.ALL; // By default, set it to ALL, you can adjust this
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final parser = ArgParser()
    ..addOption('inputfile',
        abbr: 'i', help: 'Specify the path of the input file')
    ..addOption('errorlog', abbr: 'e', help: 'Specify the file to write errors')
    ..addOption('output', abbr: 'o', help: 'Specify the file to write output')
    ..addOption('logfile', abbr: 'l', help: 'Specify the file to log messages')
    ..addOption('loglevel',
        abbr: 'v',
        help: 'Specify the logging level (default is INFO)',
        allowed: ['ALL', 'OFF', 'FINE', 'INFO', 'WARNING', 'SEVERE', 'SHOUT'])
    ..addOption('mode', abbr: 'm', help: 'Mode of operation');

  ArgResults parsedArgs;

  try {
    parsedArgs = parser.parse(args);
  } catch (e) {
    log.severe('Argument parsing failed: $e');
    return;
  }

  if (parsedArgs['loglevel'] != null) {
    final logLevel = Level.LEVELS.firstWhere(
      (l) => l.name == parsedArgs['loglevel'].toUpperCase(),
      orElse: () => Level.INFO,
    );
    Logger.root.level = logLevel;
  }

  if (parsedArgs['logfile'] != null) {
    final logFile = parsedArgs['logfile'];
    final file = File(logFile);
    final sink = file.openWrite();
    Logger.root.onRecord.listen((record) {
      sink.write('${record.level.name}: ${record.time}: ${record.message}\n');
    });
    ProcessSignal.sigterm.watch().listen((_) => sink.close());
    ProcessSignal.sigint.watch().listen((_) => sink.close());
  }

  final stdinBuffer = StringBuffer();

  var inputState = determineInputState(
    parsedArgs['inputfile'] as String?,
    !stdin.hasTerminal,
  );

  if (inputState == InputState.invalid) {
    log.severe('Both stdin and file input are defined. Choose one.');
    return;
  }

  if (parsedArgs['mode'] == null) {
    log.info('No mode specified, running all default tasks.');
    await runAllSolverTasks(defaultTaskList);
    return;
  }

  if (inputState == InputState.stdinInput) {
    await for (var line
        in stdin.transform(utf8.decoder).transform(LineSplitter())) {
      stdinBuffer.write("$line\n");
    }
  }

  var solvers = <Future<Either<String, int>> Function(
      String?, Stream<List<int>>?, StringBuffer?)>[];
  var funcNames = <String>[];

  switch (parsedArgs['mode']) {
    case 'd1':
      solvers.add(solveAoc15D1P1);
      funcNames.add('solveAoc15D1P1');
      solvers.add(solveAoc15D1P2);
      funcNames.add('solveAoc15D1P2');
      break;
    default:
      log.severe('Invalid mode');
      return;
  }

  String? fileInput =
      inputState == InputState.fileInput ? parsedArgs['inputfile'] : null;
  StringBuffer? stdinInputBuffer =
      inputState == InputState.stdinInput ? stdinBuffer : null;

  for (var i = 0; i < solvers.length; i++) {
    await runSolver(solvers[i], funcNames[i], fileInput, stdinInputBuffer);
  }
}

InputState determineInputState(String? fileInput, bool isStdinDefined) {
  if (fileInput != null && !isStdinDefined) {
    return InputState.fileInput;
  }
  if (isStdinDefined && fileInput == null) {
    return InputState.stdinInput;
  }
  if (fileInput == null && !isStdinDefined) {
    return InputState.noInput;
  }
  return InputState.invalid;
}

void handleEitherResult(Either<String, int> eitherResult, String funcName) {
  eitherResult.fold(
    (left) => log.severe('$funcName - $left'),
    (right) => log.info('$funcName - $right'),
  );
}

Future<Either<String, void>> runSolver(
  Future<Either<String, int>> Function(
          String?, Stream<List<int>>?, StringBuffer?)
      solver,
  String funcName,
  String? fileInput,
  StringBuffer? stdinBuffer,
) async {
  if (stdinBuffer == null && fileInput == null) {
    return Left('Both fileInput and stdinBuffer cannot be null.');
  }

  late Either<String, int> eitherResult;

  if (stdinBuffer != null) {
    eitherResult = await solver(null, null, stdinBuffer);
  } else if (fileInput != null) {
    eitherResult = await solver(fileInput, null, null);
  }

  handleEitherResult(eitherResult, funcName);
  return Right(null);
}

Future<void> runAllSolverTasks(List<SolverTask> tasks) async {
  for (var task in tasks) {
    try {
      final eitherResult = await task.execute(null, null,
          StringBuffer()); // TODO: Why do we need to pass an empty object? Do we actually handle that?
      handleEitherResult(eitherResult, task.functionName);
    } catch (e) {
      log.severe('${task.functionName} - Failed to execute task: $e');
    }
  }
}
