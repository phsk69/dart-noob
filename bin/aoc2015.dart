import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:dart_noob/util/output_manager.dart';
import 'package:dart_noob/util/logger_manager.dart';
import 'package:dart_noob/util/cli_args_manager.dart';
import 'package:dart_noob/util/handlers.dart';
import 'package:dart_noob/util/sink_manager.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

Future<void> main(List<String> args) async {
  final cliArgsManager = CliArgsManager(args);
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

  StringBuffer? inputBuffer;

  if (inputFile != null) {
    String infoMsg = 'Input: $inputFile';
    outputManager.writeOutput(infoMsg);
    logger?.info(infoMsg);
    inputBuffer = await getStringBuffer(inputFile);
  }

  if (mode != null && inputFile != null && inputBuffer != null) {
    final solversResult = SolverFactory.create(mode, inputBuffer);

    solversResult.fold((error) {
      outputManager.writeError(error);
      logger?.severe(error);
    }, (solvers) {
      for (var solver in solvers) {
        final result = solver.solve();
        result.fold((l) {
          // Handle the left side (error)
          outputManager.writeError(l);
          logger?.severe(l);
        }, (r) {
          // Handle the right side (success)
          outputManager.writeOutput(r);
          logger?.info(r);
        });
      }
    });
  } else {
    String invalidModeOrInputMsg = 'Mode or input file path not supported';
    outputManager.writeError(invalidModeOrInputMsg);
    logger?.severe(invalidModeOrInputMsg);
  }

  await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);
  exit(0);
}
