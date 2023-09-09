import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:collection';
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

IOSink? outputSink;
IOSink? logSink;
IOSink? errorSink;

void main(List<String> args) async {
  try {
    final cliArgsManager = CliArgsManager(args);

    LoggerManager(
      logLevel: cliArgsManager.logLevel,
      logFile: cliArgsManager.logFile,
      errorFile: cliArgsManager.errorFile,
    );

    var sigTermSubscription = ProcessSignal.sigterm.watch().listen(handleExit);
    var sigIntSubscription = ProcessSignal.sigint.watch().listen(handleExit);

    if (cliArgsManager.outputFile != null) {
      final outputFile = cliArgsManager.outputFile!;
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
      cliArgsManager.inputFile,
      !stdin.hasTerminal,
    );

    if (inputState == InputState.invalid) {
      handleExitWithError('Both stdin and file input are defined. Choose one.');
    }

    if (cliArgsManager.mode == null && inputState != InputState.invalid) {
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
    if (inputState != InputState.invalid) {
      switch (cliArgsManager.mode) {
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
          inputState == InputState.fileInput ? cliArgsManager.inputFile : null;
      StringBuffer? stdinInputBuffer =
          inputState == InputState.stdinInput ? stdinBuffer : null;

      for (var i = 0; i < solvers.length; i++) {
        log.info('${funcNames[i]} starting');
        await runSolver(solvers[i], funcNames[i], fileInput, stdinInputBuffer);
        log.fine('${funcNames[i]} completed');
      }
    }
    // Explicitly cancel the signal subscriptions
    await sigTermSubscription.cancel();
    await sigIntSubscription.cancel();
    await closeResources();
    exit(0);
  } catch (e) {
    handleExitWithError('Fatal error encountered: $e');
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
      if (errorSink != null) {
        errorSink?.writeln('$funcName: $left');
      }
      if (Logger.root.level == Level.OFF) {
        stderr.writeln('$funcName: $left');
      }
    },
    (right) {
      log.info('$funcName: $right');
      outputSink?.writeln('$funcName: $right');
      if (Logger.root.level == Level.OFF) {
        stdout.writeln('$funcName: $right');
      }
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
      handleExitWithError('${task.functionName} - Failed to execute task: $e');
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
  await Future.wait(
      LoggerManager()._writeQueue); // wait for all log writes to complete
  await logSink?.flush();
  await logSink?.close();
  await outputSink?.flush();
  await outputSink?.close();
}

void handleExitWithError(String errorMsg) {
  log.severe(errorMsg);

  closeResources().then((_) {
    exit(1);
  }).catchError((err) {
    stderr.writeln('Failed to close resources properly: $err');
    exit(1);
  });
}

// Refactoring

class CliArgsManager {
  final List<String> args;

  late ArgResults _parsedArgs;

  CliArgsManager(this.args) {
    _initializeParser();
  }

  void _initializeParser() {
    final parser = ArgParser()
      ..addOption('inputFile',
          abbr: 'i', help: 'Specify the path of the input file')
      ..addOption('outputFile',
          abbr: 'o', help: 'Specify the file to write output')
      ..addOption('errorFile',
          abbr: 'e', help: 'Specify the file to write error messages')
      ..addOption('logFile',
          abbr: 'l', help: 'Specify the file to log messages')
      ..addOption('logLevel',
          abbr: 'v',
          help: 'Specify the logging level (default is INFO)',
          allowed: ['ALL', 'OFF', 'FINE', 'INFO', 'WARNING', 'SEVERE', 'SHOUT'])
      ..addOption('mode', abbr: 'm', help: 'Mode of operation');

    try {
      _parsedArgs = parser.parse(args);
    } catch (e) {
      handleExitWithError('Argument parsing failed: $e');
    }
  }

  String? get inputFile => _parsedArgs['inputFile'] as String?;
  String? get outputFile => _parsedArgs['outputFile'] as String?;
  String? get errorFile => _parsedArgs['errorFile'] as String?;
  String? get logFile => _parsedArgs['logFile'] as String?;
  String? get logLevel => _parsedArgs['logLevel'] as String?;
  String? get mode => _parsedArgs['mode'] as String?;
}

class LoggerManager {
  final String? logLevel;
  final String? logFile;
  final String? errorFile;

  LoggerManager({this.logLevel, this.logFile, this.errorFile}) {
    _setupLogger();
  }

  final _writeQueue = Queue<Future<void>>();

  void _trackWrite(IOSink sink, String message) {
    final completer = Completer<void>();

    try {
      sink.writeln(message);
      // If you want to ensure it's immediately written, you can flush
      sink.flush().then((_) {
        completer.complete();
      });
    } catch (e) {
      completer.completeError(e);
    }

    _writeQueue.addLast(completer.future);
  }

  void _handleLogRecord(LogRecord record) {
    final logMessage =
        '${record.time.toUtc().toIso8601String()} - ${record.level.name} - ${record.message}';

    // Log level is OFF
    if (Logger.root.level == Level.OFF) {
      if (record.level == Level.SEVERE) {
        stderr.writeln(logMessage);
      } else {
        stdout.writeln(logMessage);
      }
    } else {
      // For all other log levels, print to stdout
      stdout.writeln(logMessage);
    }

    // Always write logs to the log file if defined
    if (logSink != null) {
      _trackWrite(logSink!, logMessage);
    }

    // Always write SEVERE errors to the error file if defined
    if (record.level == Level.SEVERE && errorSink != null) {
      _trackWrite(errorSink!, logMessage);
    }
  }

  void _setLogLevel() {
    final level = Level.LEVELS.firstWhere(
      (l) => l.name == logLevel!.toUpperCase(),
      orElse: () => Level.INFO,
    );
    Logger.root.level = level;
  }

  void _setupLogFile() {
    final file = File(logFile!);
    logSink = file.openWrite();
    log.info('Using $logFile as log file');
  }

  void _setupErrorFile() {
    final file = File(errorFile!);
    errorSink = file.openWrite();
    log.info('Using $errorFile as error log file');
  }

  void _setupLogger() {
    Logger.root.onRecord.listen(_handleLogRecord);

    if (logLevel != null) {
      _setLogLevel();
    }

    if (logFile != null) {
      _setupLogFile();
    }

    if (errorFile != null) {
      _setupErrorFile();
    }
  }
}
