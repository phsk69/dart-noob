import 'dart:io';
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/util/output_manager.dart';
import 'package:dart_noob/util/sink_manager.dart';

Future<void> handleExitWithError(String errorMsg, SinkManager sinkManager,
    Logger? logger, OutputManager outputManager) async {
  outputManager.writeError(errorMsg);

  await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);

  logger?.severe(errorMsg);
  exit(1);
}

Future<void> handleCloseResources(IOSink? logSink, IOSink outputSink) async {
  await logSink?.flush();
  await logSink?.close();

  await outputSink.flush();
  await outputSink.close();
}

void handleEitherResult(Either<String, int> eitherResult, String funcName,
    SinkManager sinkManager, Logger? logger, OutputManager outputManager) {
  eitherResult.fold(
    (left) {
      String leftMsg = '$funcName: $left';
      outputManager.writeError(leftMsg);
      logger?.severe(leftMsg);
    },
    (right) {
      String rightMsg = '$funcName: $right';
      outputManager.writeOutput('$funcName: $right');
      logger?.info(rightMsg);
    },
  );
}

class SignalHandler {
  final SinkManager sinkManager;
  final OutputManager outputManager;
  final Logger? logger;
  late StreamSubscription<ProcessSignal> sigTermSubscription;
  late StreamSubscription<ProcessSignal> sigIntSubscription;

  SignalHandler(
      {required this.sinkManager,
      required this.outputManager,
      required this.logger}) {
    sigTermSubscription =
        ProcessSignal.sigterm.watch().listen((signal) => handleExit(signal));
    sigIntSubscription =
        ProcessSignal.sigint.watch().listen((signal) => handleExit(signal));
  }

  Future<void> handleExit(ProcessSignal signal) async {
    String infoMsg = 'Received ${signal.toString()} signal. Exiting...';
    outputManager.writeOutput(infoMsg);
    logger?.info(infoMsg);

    await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);
    exit(0);
  }
}
