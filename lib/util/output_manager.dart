import 'dart:io';
import 'package:dart_noob/util/sink_manager.dart';

class OutputManager {
  final SinkManager sinkManager;
  final String? outputFile;

  OutputManager(this.sinkManager, this.outputFile) {
    if (outputFile != null) {
      sinkManager.initializeOutputSink(outputFile!);
    }
  }

  void writeOutput(String message) {
    // If an outputFile is defined, use the outputSink from sinkManager
    if (outputFile != null) {
      sinkManager.outputSink.writeln(message);
    }

    // We always want to write the output to stdout as per your requirement.
    stdout.writeln(message);
  }

  void writeError(String message) {
    // If an outputFile is defined, use the outputSink from sinkManager
    if (outputFile != null) {
      sinkManager.outputSink.writeln(message);
    }

    // We always want to write the error to stderr as per your requirement.
    stderr.writeln(message);
  }
}
