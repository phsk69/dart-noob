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
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/days/d1/aoc15_d1.dart';

Future<void> main(List<String> args) async {
  // Research where in the stack we are when we do the following:
  final cliArgsManager = CliArgsManager(args);
  // Because it gives unhandled exception when arguments are not supported
  final inputFile = cliArgsManager.inputFile;
  final outputFile = cliArgsManager.outputFile;
  final logFile = cliArgsManager.logFile;
  final logLevel = cliArgsManager.logLevel;
  final mode = cliArgsManager.mode;

  final sinkManager = SinkManager();
  final outputManager = OutputManager(sinkManager, outputFile);

  var loggerManager = LoggerManager(
    name: 'AOC2015',
    logFile: logFile,
    logLevel: logLevel,
    sinkManager: sinkManager,
    outputManager: outputManager,
  );

  final Logger? logger = loggerManager.log;

  SignalHandler(
      sinkManager: sinkManager, logger: logger, outputManager: outputManager);

  logger?.info('Starting AOC2015');

  StringBuffer? inputBuffer;

  if (inputFile != null) {
    String infoMsg = 'Input: $inputFile';
    outputManager.writeOutput(infoMsg);
    logger?.info(infoMsg);
    inputBuffer = await getStringBuffer(inputFile);
  }

  if (mode != null && inputFile != null && inputBuffer != null) {
    switch (mode) {
      case 'd1':
        // Get the either result from solveAoc15D1P1
        final result = solveAoc15D1P1(inputBuffer);

        result.fold((l) {
          // Handle the left side (error)
          outputManager.writeError(l);
          logger?.severe(l);
        }, (r) {
          // Handle the right side (success)
          outputManager.writeOutput(r);
          logger?.info(r);
        });
        break;
      default:
        String errorMsg = 'Unknown mode: $mode';
        outputManager.writeError(errorMsg);
        logger?.severe(errorMsg);
        break;
    }
  } else {
    String invalidModeOrInputMsg = 'Mode or input file path not supported';
    outputManager.writeError(invalidModeOrInputMsg);
    logger?.severe(invalidModeOrInputMsg);
  }

  await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);
  exit(0);
}
