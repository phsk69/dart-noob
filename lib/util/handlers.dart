import 'dart:io';
import 'dart:async';
import 'package:logging/logging.dart';
import 'package:dart_noob/util/output_manager.dart';
import 'package:dart_noob/util/sink_manager.dart';

Future<void> handleExitWithError(
    String errorMsg,
    SinkManager sinkManager,
    Logger? logger,
    OutputManager outputManager,
    void Function(int) exitFunction) async {
  outputManager.writeError(errorMsg);

  await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);

  logger?.severe(errorMsg);
  exitFunction(1);
}

Future<void> handleCloseResources(IOSink? logSink, IOSink outputSink) async {
  await logSink?.flush();
  await logSink?.close();

  await outputSink.flush();
  await outputSink.close();
}

class SignalHandler {
  final SinkManager sinkManager;
  final OutputManager outputManager;
  final Logger? logger;
  Function(ProcessSignal)? handleExitFunction;

  late StreamSubscription<ProcessSignal> sigTermSubscription;
  late StreamSubscription<ProcessSignal> sigIntSubscription;

  SignalHandler({
    required this.sinkManager,
    required this.outputManager,
    required this.logger,
    Function(ProcessSignal)? handleExitFunction,
  }) {
    this.handleExitFunction = handleExitFunction ?? handleExit;

    sigTermSubscription = watchSignal(ProcessSignal.sigterm)
        .listen((signal) => this.handleExitFunction!(signal));

    sigIntSubscription = watchSignal(ProcessSignal.sigint)
        .listen((signal) => this.handleExitFunction!(signal));
  }

  Stream<ProcessSignal> watchSignal(ProcessSignal signal) {
    return signal.watch();
  }

  Future<void> handleExit(ProcessSignal signal) async {
    String infoMsg = 'Received ${signal.toString()} signal. Exiting...';
    outputManager.writeOutput(infoMsg);
    logger?.info(infoMsg);

    await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);
    exit(0);
  }
}
