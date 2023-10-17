import 'dart:io' show Directory, File;

import 'package:logging/logging.dart';
import 'package:dart_noob/util/output_manager.dart';
import 'package:dart_noob/util/sink_manager.dart';

class LoggerManager {
  final String name;
  final String? logLevel;
  final String? logFile;
  final SinkManager sinkManager;
  final OutputManager outputManager;
  Logger? _internalLogger;

  LoggerManager({
    this.logLevel,
    this.logFile,
    required this.name,
    required this.sinkManager,
    required this.outputManager,
  }) {
    if (logFile != null) {
      _setupLogger();
    }
  }

  Logger? get log => _internalLogger;

  void _handleLogRecord(LogRecord record) {
    final time = record.time.toUtc().toIso8601String();
    final level = record.level.name;
    final logMessage = '$time - $level - ${record.message}';

    sinkManager.logSink?.writeln(logMessage);
  }

  void _setLogLevel() {
    final level = Level.LEVELS.firstWhere(
      (l) => l.name == logLevel?.toUpperCase(),
      orElse: () => Level.INFO,
    );
    Logger.root.level = level;
  }

  void _setupLogFile() {
    // Create the directory for the log file if it doesn't exist
    File log = File(logFile!);
    Directory dir = log.parent;
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    // Initialize log sink
    sinkManager.initializeLogSink(logFile!);

    String infoMsg = 'Log: $logFile';
    outputManager.writeOutput(infoMsg);
    _internalLogger?.info(infoMsg); // Use optional chaining
  }

  void _setupLogger() {
    _internalLogger = Logger(name);
    Logger.root.onRecord.listen(_handleLogRecord);
    _setLogLevel();
    _setupLogFile();
  }
}
