import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:dart_noob/config/default_tasks.dart';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/models/day_task.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';

// TODO: The default mode now doesnt close properly

enum InputState {
  fileInput,
  stdinInput,
  noInput,
  invalid,
}

final log = Logger('CLI');

IOSink? outputSink;
IOSink? logSink;

void main(List<String> args) async {
  // Unified log listening setup
  Logger.root.onRecord.listen((record) {
    final logMessage =
        '${record.level.name}: ${record.time}: ${record.message}';

    // Write log messages to stdout
    stdout.writeln(logMessage);

    // Write log messages to a file if specified
    if (logSink != null) {
      logSink?.writeln(logMessage);
    }
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

  var sigTermSubscription = ProcessSignal.sigterm.watch().listen(handleExit);
  var sigIntSubscription = ProcessSignal.sigint.watch().listen(handleExit);

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
    logSink = file.openWrite();
    log.info('Using $logFile as log file');
  }

  if (parsedArgs['output'] != null) {
    final outputFile = parsedArgs['output'];
    final file = File(outputFile);

    try {
      if (await file.exists()) {
        final stat = await file.stat();
        if (stat.type == FileSystemEntityType.directory) {
          log.severe('Cannot write to a directory: $outputFile');
          return;
        }
      }
      log.info('Using $outputFile as output file');
      outputSink = file.openWrite();
    } catch (e) {
      log.severe('Failed to open output file: $e');
      return;
    }
  }

  final stdinBuffer = StringBuffer();

  var inputState = determineInputState(
    parsedArgs['inputfile'] as String?,
    !stdin.hasTerminal,
  );

  if (inputState == InputState.invalid) {
    log.severe('Both stdin and file input are defined. Choose one.');
    exit(1);
  }

  if (parsedArgs['mode'] == null) {
    log.info('No mode specified, running all default tasks.');
    await runAllSolverTasks(defaultTaskList);

    // Close resources here too
    await closeResources();

    log.info('Running all default tasks completed.');

    exit(0); // Explicitly exit the program
  }

  // With this new block to read from stdin in the background:
  if (inputState == InputState.stdinInput && !stdin.hasTerminal) {
    readStdin(stdinBuffer); // Start reading stdin in the background
  }

  if (inputState == InputState.stdinInput && !stdin.hasTerminal) {
    await stdinCompleter.future;
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
      break;
  }

  String? fileInput =
      inputState == InputState.fileInput ? parsedArgs['inputfile'] : null;
  StringBuffer? stdinInputBuffer =
      inputState == InputState.stdinInput ? stdinBuffer : null;

  for (var i = 0; i < solvers.length; i++) {
    log.info('${funcNames[i]} starting');
    await runSolver(solvers[i], funcNames[i], fileInput, stdinInputBuffer);
    log.info('${funcNames[i]} completed');
  }

  // Explicitly cancel the signal subscriptions
  await sigTermSubscription.cancel();
  await sigIntSubscription.cancel();

  // Flush and close logSink and outputSink before exiting
  await closeResources();
  exit(0);
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

Future<void> handleExit(ProcessSignal signal) async {
  if (outputSink != null) {
    await outputSink!.flush();
    await outputSink!.close();
  }

  if (logSink != null) {
    await logSink!.flush();
    await logSink!.close();
  }

  exit(0);
}

void handleEitherResult(Either<String, int> eitherResult, String funcName) {
  eitherResult.fold(
    (left) {
      log.severe('$funcName: $left');
      outputSink?.writeln('$funcName - $left');
    },
    (right) {
      log.info('$funcName result: $right');
      outputSink?.writeln('$funcName result: $right');
    },
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

final Completer<void> stdinCompleter = Completer<void>();

Future<void> readStdin(StringBuffer buffer) async {
  await for (var line
      in stdin.transform(utf8.decoder).transform(LineSplitter())) {
    buffer.write("$line\n");
  }
  stdinCompleter.complete(); // notify that stdin reading is done
}

Future<void> closeResources() async {
  await logSink?.flush();
  await logSink?.close();
  await outputSink?.flush();
  await outputSink?.close();
}
