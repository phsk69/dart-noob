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
    StringBuffer stdinBuffer = StringBuffer();
    if (args.isEmpty) {
      await runAllSolverTasks(defaultTaskList);
      await closeResources();
      exit(0);
    }

    final cliArgsManager = CliArgsManager(args);

    var sigTermSubscription = ProcessSignal.sigterm.watch().listen(handleExit);
    var sigIntSubscription = ProcessSignal.sigint.watch().listen(handleExit);

    LoggerManager(
      logLevel: cliArgsManager.logLevel,
      logFile: cliArgsManager.logFile,
    );

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
        outputSink = file.openWrite();
      } catch (e) {
        String errorMsg = 'Failed to open output file: $e';
        outputManager.writeError(errorMsg);
        log.severe(errorMsg);
        return;
      }
    }
    
    readStdinIfAvailable(stdinBuffer);

    var inputState = determineInputState(cliArgsManager.inputFile, stdinBuffer);

    if (inputState == InputState.invalid) {
      await sigTermSubscription.cancel();
      await sigIntSubscription.cancel();
      await closeResources();
      exit(1);
    }
    if (cliArgsManager.mode == null && inputState != InputState.invalid) {
      if (inputState == InputState.fileInput) {
        String errorMsg = 'Mode not specified with an input file provided.';
        outputManager.writeError(errorMsg);
        log.severe(errorMsg);
        await sigTermSubscription.cancel();
        await sigIntSubscription.cancel();
        return;
      }

      String infoMsg = 'No mode specified, running all default tasks';
      outputManager.writeOutput(infoMsg);
      log.info(infoMsg);

      await runAllSolverTasks(defaultTaskList);
      await closeResources();
      log.fine('Running all default tasks completed.');
      exit(0);
    }

    var solvers = <Future<Either<String, int>> Function(
        String?, Stream<List<int>>?, StringBuffer?)>[];
    var funcNames = <String>[];

    if (inputState != InputState.invalid) {
      switch (cliArgsManager.mode) {
        case 'd1':
          outputManager.writeOutput('Mode: Day 1');
          solvers.add(solveAoc15D1P1);
          funcNames.add('solveAoc15D1P1');
          solvers.add(solveAoc15D1P2);
          funcNames.add('solveAoc15D1P2');
          break;
        default:
          String errorMsg = 'Invalid mode';
          outputManager.writeOutput(errorMsg);
          log.severe(errorMsg);
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

InputState determineInputState(String? fileInput, StringBuffer stdinBuffer) {
  if (fileInput != null && stdinBuffer.isEmpty) {
    String infoMsg = 'Input: $fileInput';
    outputManager.writeOutput(infoMsg);
    log.info(infoMsg);
    return InputState.fileInput;
  }

  if (stdinBuffer.isNotEmpty && fileInput == null) {
    String infoMsg = 'Input: stdin';
    outputManager.writeOutput(infoMsg);
    log.info(infoMsg);
    return InputState.stdinInput;
  }

  if (fileInput == null && stdinBuffer.isEmpty) {
    String infoMsg = 'Input: default';
    outputManager.writeOutput(infoMsg);
    log.info(infoMsg);
    return InputState.noInput;
  }

  if (fileInput != null && stdinBuffer.isNotEmpty) {
    String errorMsg =
        'Both stdin and input file provided. Please provide only one form of input.';
    outputManager.writeError(errorMsg);
    log.severe(errorMsg);
    return InputState.invalid;
  }

  String errorMsg = 'Input: Invalid input state';
  outputManager.writeError(errorMsg);
  log.severe(errorMsg);
  return InputState.invalid;
}

Future<void> handleExit(ProcessSignal signal) async {
  log.info('Received ${signal.toString()} signal. Exiting...');
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

Future<void> readStdinIfAvailable(StringBuffer buffer) async {
  await for (var data in stdin) {
    buffer.write(utf8.decode(data));
  }
}

final Completer<void> stdinCompleter = Completer<void>();

Future<void> closeResources() async {
  if (logSink != null) {
    await logSink?.flush();
    await logSink?.close();
  }

  if (outputSink != null) {
    await outputSink?.flush();
    await outputSink?.close();
  }
}

Future<void> handleExitWithError(String errorMsg) async {
  outputManager.writeError(errorMsg);

  await closeResources();

  log.severe(errorMsg);
  exit(1);
}

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
    String infoMsg = 'Log: $logFile';
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
