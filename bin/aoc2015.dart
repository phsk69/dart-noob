import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:dart_noob/config/default_tasks.dart';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/models/day_task.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';

// TODO: test all modes and inputs again, and then commit before refactoring.

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
  try {
    // Unified log listening setup
    Logger.root.onRecord.listen((record) {
      final logMessage =
          '${record.time.toIso8601String()} - ${record.level.name} - ${record.message}';

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
      ..addOption('output', abbr: 'o', help: 'Specify the file to write output')
      ..addOption('logfile',
          abbr: 'l', help: 'Specify the file to log messages')
      ..addOption('loglevel',
          abbr: 'v',
          help: 'Specify the logging level (default is INFO)',
          allowed: ['ALL', 'OFF', 'FINE', 'INFO', 'WARNING', 'SEVERE', 'SHOUT'])
      ..addOption('mode', abbr: 'm', help: 'Mode of operation');

    ArgResults parsedArgs;

    try {
      parsedArgs = parser.parse(args);
    } catch (e) {
      String errorMsg = 'Argument parsing failed: $e';
      log.severe(errorMsg);

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
            String errorMsg = 'Cannot write to a directory: $outputFile';
            log.severe(errorMsg);

            return;
          }
        }
        log.info('Using $outputFile as output file');
        outputSink = file.openWrite();
      } catch (e) {
        String errorMsg = 'Failed to open output file: $e';
        log.severe(errorMsg);

        return;
      }
    }

    final stdinBuffer = StringBuffer();

    var inputState = determineInputState(
      parsedArgs['inputfile'] as String?,
      !stdin.hasTerminal,
    );

    if (inputState == InputState.invalid) {
      String errorMsg = 'Both stdin and file input are defined. Choose one.';
      log.severe(errorMsg);

      await closeResources();

      exit(1);
    }

    if (parsedArgs['mode'] == null) {
      log.info('No mode specified, running all default tasks.');
      await runAllSolverTasks(defaultTaskList);

      await closeResources();

      log.fine('Running all default tasks completed.');

      exit(0);
    }

    // This was a way of loading in the stdin without waiting or blocking
    if (inputState == InputState.stdinInput && !stdin.hasTerminal) {
      readStdin(stdinBuffer);
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

      log.fine('${funcNames[i]} completed');
    }

    // Explicitly cancel the signal subscriptions
    await sigTermSubscription.cancel();
    await sigIntSubscription.cancel();

    await closeResources();

    exit(0);
  } catch (error, stackTrace) {
    await closeResources();
    log.severe('Fatal error encountered: $error', error, stackTrace);
    await closeResources();

    exit(1);
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

Future<void> handleExit(ProcessSignal signal) async {
  await closeResources();
  exit(0);
}

void handleEitherResult(Either<String, int> eitherResult, String funcName) {
  eitherResult.fold(
    (left) {
      log.severe('$funcName: $left');
    },
    (right) {
      log.info('$funcName: $right');
      outputSink?.writeln('$funcName: $right');
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
      // TODO: Why do we need to pass an empty object? Do we actually handle that?
      final eitherResult = await task.execute(null, null, StringBuffer());
      handleEitherResult(eitherResult, task.functionName);
    } catch (e) {
      String errorMsg = '${task.functionName} - Failed to execute task: $e';
      log.severe(errorMsg);

      await closeResources();

      exit(1);
    }
  }
}

final Completer<void> stdinCompleter = Completer<void>();

Future<void> readStdin(StringBuffer buffer) async {
  await for (var line
      in stdin.transform(utf8.decoder).transform(LineSplitter())) {
    buffer.write("$line\n");
  }
  stdinCompleter.complete();
}

Future<void> closeResources() async {
  await logSink?.flush();
  await logSink?.close();
  await outputSink?.flush();
  await outputSink?.close();
}
