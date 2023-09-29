import 'dart:io' show File, IOSink, stdout;

class SinkManager {
  IOSink? _logSink;
  IOSink? _outputSink;

  IOSink? get logSink =>
      _logSink; // Made logSink optional as per your requirements

  IOSink get outputSink => _outputSink ?? stdout;

  void initializeLogSink(String path) {
    _logSink = File(path).openWrite();
  }

  void initializeOutputSink(String path) {
    _outputSink = File(path).openWrite();
  }
}
