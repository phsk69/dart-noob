import 'dart:async';
import 'dart:io';

//import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
//import 'package:dart_noob/models/day_task.dart';
//import 'package:dart_noob/config/default_tasks.dart';
import 'package:dart_noob/util/output_manager.dart';
import 'package:dart_noob/util/logger_manager.dart';
import 'package:dart_noob/util/cli_args_manager.dart';
import 'package:dart_noob/util/handlers.dart';
import 'package:dart_noob/util/sink_manager.dart';
//import 'package:dart_noob/days/d1/aoc15_d1.dart';

Future<void> main(List<String> args) async {
  final sinkManager = SinkManager();

  // Step 1: Initialize CliArgsManager without logger
  final cliArgsManager = CliArgsManager(args, sinkManager);
  final inputFile = cliArgsManager.inputFile;
  final outputFile = cliArgsManager.outputFile;
  final logFile = cliArgsManager.logFile;
  final logLevel = cliArgsManager.logLevel;
  final mode = cliArgsManager.mode;

  // Step 2 init stuff after args ar parsed, set things anew
  final outputManager = OutputManager(sinkManager, outputFile);

  cliArgsManager.setOutputManager(outputManager);

  var loggerManager = LoggerManager(
    name: 'AOC2015',
    logFile: logFile,
    logLevel: logLevel,
    sinkManager: sinkManager,
    outputManager: outputManager,
  );

//TODO: Do we really need this, the arg parsing might just have to use stdout/stderr
  Logger? logger;

  if (logFile != null) {
    logger = loggerManager.log;
    if (logger != null) {
      cliArgsManager.setLogger(logger);
    }
  }

  SignalHandler(sinkManager: sinkManager, logger: logger);

  if (mode != null && inputFile != null) {
    switch (mode) {
      case 'd1':
        outputManager.writeOutput(inputFile);
        break;
      default:
        outputManager.writeError('Unknown mode: $mode');
    }
  } else {
    outputManager.writeError('Mode or input file path not supported');
  }

  await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);
  exit(0);
}
