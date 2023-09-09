import 'dart:async';
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
final outputManager = OutputManager();

IOSink? outputSink;
IOSink? logSink;

void main(List<String> args) async {
  try {
    final cliArgsManager = CliArgsManager(args);

    LoggerManager(
      logLevel: cliArgsManager.logLevel,
      logFile: cliArgsManager.logFile,
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
            outputManager.writeError(errorMsg);
            log.severe(errorMsg);
            return;
          }
        }
        String infoMsg = 'Using $outputFile as output file';
        outputManager.writeError(infoMsg);
        log.info(infoMsg);
        outputSink = await file.openWrite();
      } catch (e) {
        String errorMsg = 'Failed to open output file: $e';
        outputManager.writeError(errorMsg);
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
  OutputManager outputManager = OutputManager();
  eitherResult.fold(
    (left) {
      String leftMsg = '$funcName: $left';
      outputManager.writeError(leftMsg);
      log.severe(leftMsg);
    },
    (right) {
      String rightMsg = '$funcName: $right';
      outputManager.writeOutput('$funcName: $right');
      log.info(rightMsg);
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
  await logSink?.flush();
  await logSink?.close();
  await outputSink?.flush();
  await outputSink?.close();
}

void handleExitWithError(String errorMsg) {
  OutputManager outputManager = OutputManager();
  outputManager.writeError(errorMsg);

  closeResources().then((_) {
    exit(1);
  }).catchError((err) {
    outputManager.writeError('Failed to close resources properly: $err');
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
  String? get logFile => _parsedArgs['logFile'] as String?;
  String? get logLevel => _parsedArgs['logLevel'] as String?;
  String? get mode => _parsedArgs['mode'] as String?;
}

class OutputManager {
  void writeOutput(String message) {
    if (outputSink != null) {
      outputSink!.writeln(message);
      stdout.writeln(message);
    } else {
      stdout.writeln(message);
    }
  }

  void writeError(String message) {
    if (outputSink != null) {
      outputSink!.writeln(message);
      stderr.writeln(message);
    } else {
      stderr.writeln(message);
    }
  }
}

class LoggerManager {
  final String? logLevel;
  final String? logFile;

  LoggerManager({this.logLevel, this.logFile}) {
    _setupLogger();
  }

  void _handleLogRecord(LogRecord record) {
    final logMessage =
        '${record.time.toUtc().toIso8601String()} - ${record.level.name} - ${record.message}';
    if (logSink != null) {
      logSink?.writeln(logMessage);
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
    String infoMsg = 'Using $logFile as log file';
    outputManager.writeOutput(infoMsg);
    log.info(infoMsg);
  }

  void _setupLogger() {
    Logger.root.onRecord.listen(_handleLogRecord);

    if (logLevel != null) {
      _setLogLevel();
    }

    if (logFile != null) {
      _setupLogFile();
    }
  }
}
